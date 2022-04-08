package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chiseltest._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
//import chiseltest.internal.{VerilatorBackendAnnotation, WriteVcdAnnotation}
import firrtl.options.TargetDirAnnotation
import org.scalatest.FreeSpec

class ScratchPadBankTest extends FreeSpec with ChiselScalatestTester {
  implicit val p = new GEMM4444Config()
  "Simple test for ScratchPadBank" in {
    val annos = Seq(
      TargetDirAnnotation("test_run_dir"),
      //      VerilatorBackendAnnotation,
      WriteVcdAnnotation,
    )

    def do_read(c: ScratchPadBank, addr: UInt, en: Bool) = {
      c.io.read.req.valid.poke(en)
      c.io.read.req.bits.id.poke(addr(0).asUInt())
      c.io.read.req.bits.addr.poke(addr)
    }

    def do_write(c: ScratchPadBank, addr: UInt, data: UInt, en: Bool): Unit ={
      c.io.write.en.poke(en)
      c.io.write.addr.poke(addr)
      c.io.write.data.poke(data)
      c.io.write.mask.poke(0xffff.U)
    }

    RawTester.test(new ScratchPadBank(16, 128), annos){c =>
      Array.range(0, 16).foreach((i) => {
        do_write(c, i.U, (0x80 + i).U, true.B)
        c.clock.step(1)
      })

      do_write(c, 0.U, 0.U, false.B)
      c.clock.step(1)

      do_read(c, 0.U, true.B)
      c.clock.step(1)

      do_read(c, 1.U, true.B)
      c.clock.step(1)

      do_read(c, 2.U, true.B)
      c.clock.step(1)

      c.io.read.resp.ready.poke(true.B)
      c.clock.step(3)

      c.io.read.resp.ready.poke(false.B)
      c.clock.step(5)

      c.io.read.resp.ready.poke(true.B)
      do_read(c, 8.U, true.B)
      c.clock.step(1)

      do_read(c, 9.U, true.B)
      c.clock.step(1)


      c.clock.step(5)

    }
  }
}

object ScratchPadBackLaunch extends App{
  implicit val p = new GEMM4444Config()
  (new ChiselStage).execute(
    Array(
      "-X", "verilog",
      "--target-dir", "test_run_dir"
      //      "--help"
    ),
    Seq(ChiselGeneratorAnnotation(() => new ScratchPadBank(128, 8)))
  )
}

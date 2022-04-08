package cpu

import chisel3._
import chisel3.util._
import chiseltest._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
//import chiseltest.internal.{VerilatorBackendAnnotation, WriteVcdAnnotation}
import cpu.ooo.Multiplier
import firrtl.options.TargetDirAnnotation
import org.scalatest.FreeSpec

class MultiplierTest extends FreeSpec with ChiselScalatestTester {
  implicit val p = new DRAM3SimConfig
  "Simple test for multiplier" in {
    val annos = Seq(
      TargetDirAnnotation("test_run_dir"),
      //      VerilatorBackendAnnotation,
      WriteVcdAnnotation,
    )

    RawTester.test(new Multiplier, annos){c =>
      c.io.in.valid.poke(true.B)
      c.io.in.bits.src(0).poke(0xff.U)
      c.io.in.bits.src(1).poke(0x100.U)
      c.clock.step(10)

      c.io.in.bits.src(1).poke(0x1000.U)
      c.io.out.ready.poke(true.B)
      c.clock.step(1)

      c.io.out.ready.poke(false.B)
      c.clock.step(10)

      c.io.out.ready.poke(true.B)
      c.clock.step(3)

      c.io.out.ready.poke(false.B)
      c.clock.step(10)
    }
  }
}

object MultiplierLaunch extends App{
  implicit val p = new DRAM3SimConfig
  (new ChiselStage).execute(
    Array(
      "-X", "verilog",
      "--target-dir", "test_run_dir"
      //      "--help"
    ),
    Seq(ChiselGeneratorAnnotation(() => new Multiplier))
  )
}
package cpu

import chisel3._
import chisel3.util._
import chiseltest._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import chiseltest.internal.{VerilatorBackendAnnotation, WriteVcdAnnotation}
import cpu.ooo.{Divider, Multiplier}
import firrtl.options.TargetDirAnnotation
import org.scalatest.FreeSpec

class DividerTest extends FreeSpec with ChiselScalatestTester {
  implicit val p = new DRAM3SimConfig
  "Simple test for divider" in {
    val annos = Seq(
      TargetDirAnnotation("test_run_dir"),
      //      VerilatorBackendAnnotation,
      WriteVcdAnnotation,
    )

    RawTester.test(new Divider, annos){c =>
      c.io.in.valid.poke(true.B)
      c.io.in.bits.src(0).poke(0x0.U)
      c.io.in.bits.src(1).poke(0x3.U)
      c.io.in.bits.ctrl.sign.poke(false.B)
      c.io.in.bits.ctrl.isW.poke(true.B)
      c.io.in.bits.ctrl.isHi.poke(false.B)
      c.io.kill.poke(false.B)

      c.clock.step(10)

      c.io.in.bits.ctrl.isHi.poke(true.B)
      c.io.out.ready.poke(true.B)

      c.clock.step(10)
    }
  }
}

object DividerLaunch extends App{
  implicit val p = new DRAM3SimConfig
  (new ChiselStage).execute(
    Array(
      "-X", "verilog",
      "--target-dir", "test_run_dir"
      //      "--help"
    ),
    Seq(ChiselGeneratorAnnotation(() => new Divider))
  )
}

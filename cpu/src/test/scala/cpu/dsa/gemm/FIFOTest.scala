package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chiseltest._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import chiseltest.internal.{VerilatorBackendAnnotation, WriteVcdAnnotation}
import firrtl.options.TargetDirAnnotation
import org.scalatest.FreeSpec

class FIFOTest extends FreeSpec with ChiselScalatestTester {
  "Simple test for FIFO inW < outW" in {
    val annos = Seq(
      TargetDirAnnotation("test_run_dir"),
      //      VerilatorBackendAnnotation,
      WriteVcdAnnotation,
    )
    RawTester.test(new FIFOw2w(8, 4, 4), annos){c=>
      c.io.enq.valid.poke(true.B)
      c.io.enq.bits.poke(0x1a.U)
      c.clock.step(10)


      c.io.enq.valid.poke(false.B)
      c.io.deq.ready.poke(true.B)
      c.clock.step(10)
    }
  }

  "Simple test for FIFO outW < inW" in {
    val annos = Seq(
      TargetDirAnnotation("test_run_dir"),
      //      VerilatorBackendAnnotation,
      WriteVcdAnnotation,
    )
    RawTester.test(new FIFOw2w(4, 8, 4), annos){c=>
      c.io.enq.valid.poke(true.B)
      c.io.enq.bits.poke(0xa.U)
      c.clock.step(10)


      c.io.enq.valid.poke(false.B)
      c.io.deq.ready.poke(true.B)
      c.clock.step(10)
    }
  }
}

object FIFOLaunch extends App{
  implicit val p = new GEMM4444Config()
  (new ChiselStage).execute(
    Array(
      "-X", "verilog",
      "--target-dir", "test_run_dir"
      //      "--help"
    ),
    Seq(ChiselGeneratorAnnotation(() => new FIFOw2w(8, 4, 4)))
  )
}

object FIFOLaunch2 extends App{
  implicit val p = new GEMM4444Config()
  (new ChiselStage).execute(
    Array(
      "-X", "verilog",
      "--target-dir", "test_run_dir"
      //      "--help"
    ),
    Seq(ChiselGeneratorAnnotation(() => new FIFOw2w(4, 8, 4)))
  )
}

package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chiseltest._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import chiseltest.internal.{VerilatorBackendAnnotation, WriteVcdAnnotation}
import firrtl.options.TargetDirAnnotation
import org.scalatest.FreeSpec

class TransposeTest extends FreeSpec with ChiselScalatestTester {
  implicit val p = new GEMM4444Config()

  def poke_in[T <: Data](m: Transpose[T], data: T) = {
    m.io.in.valid.poke(true.B)
    m.io.in.bits.foreach(_.poke(data))
  }

  def clear_poke_in[T <: Data](m: Transpose[T], data: T) = {
    m.io.in.valid.poke(false.B)
    m.io.in.bits.foreach(_.poke(data))
  }

  "Simple test for Transpose" in {
    val annos = Seq(
      TargetDirAnnotation("test_run_dir"),
//      VerilatorBackendAnnotation,
      WriteVcdAnnotation,
    )
    RawTester.test(new Transpose(UInt(8.W)), annos){c =>
      Array.range(0, 16, 1).foreach((i)=>{
        poke_in(c, i.U)
        c.clock.step(1)
      })

      c.clock.step(10)

      c.io.out.ready.poke(true.B)

      c.clock.step(32)

    }
  }
}

object TransposeLaunch extends App{
  implicit val p = new GEMM4444Config()
  (new ChiselStage).execute(
    Array(
      "-X", "verilog",
      "--target-dir", "test_run_dir"
//      "--help"
    ),
    Seq(ChiselGeneratorAnnotation(() => new Transpose(UInt(8.W))))
  )
}

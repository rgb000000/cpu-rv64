package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chiseltest._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import org.scalatest.FreeSpec

class DelayMeshTest extends FreeSpec with ChiselScalatestTester {

  implicit val p = new GEMM4444Config()

  "Simple Test for DelayMeshTest" in {
    test(new DelayMesh(UInt(8.W), UInt(8.W), UInt(16.W))) {c =>

    }

  }
}

object DelayMeshLaunch extends App{
  implicit val p = new GEMM4444Config()
  (new ChiselStage).execute(
    Array(
      "-X", "verilog",
      "--target-dir", "test_run_dir"
    ),
    Seq(ChiselGeneratorAnnotation(() => new DelayMesh(UInt(8.W), UInt(8.W), UInt(16.W))))
  )
}

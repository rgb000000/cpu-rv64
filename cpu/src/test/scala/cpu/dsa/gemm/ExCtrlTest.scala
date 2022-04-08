package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chiseltest._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
//import chiseltest.internal.{VerilatorBackendAnnotation, WriteVcdAnnotation}
import firrtl.options.TargetDirAnnotation
import org.scalatest.FreeSpec

class ExCtrlTest {

}

object ExCtrlLaunch extends App{
  implicit val p = new GEMM4444Config()
  (new ChiselStage).execute(
    Array(
      "-X", "verilog",
      "--target-dir", "test_run_dir"
      //      "--help"
    ),
    Seq(ChiselGeneratorAnnotation(() => new Ex(128, 128, 4)))
  )
}

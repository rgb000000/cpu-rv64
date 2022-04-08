package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chiseltest._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
//import chiseltest.internal.{VerilatorBackendAnnotation, WriteVcdAnnotation}
import cpu.DRAM3SimConfig
import firrtl.options.TargetDirAnnotation
import org.scalatest.FreeSpec

class DMATest {

}

object DMALaunch extends App{
  implicit val p = (new DRAM3SimConfig) ++ (new GEMM4444Config())
  (new ChiselStage).execute(
    Array(
      "-X", "verilog",
      "--target-dir", "test_run_dir"
      //      "--help"
    ),
    Seq(ChiselGeneratorAnnotation(() => new DMA(48, 128, 4)))
  )
}

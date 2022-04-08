package cpu

import chisel3._
import chisel3.util._
import chiseltest._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import cpu.dsa.gemm.GEMM4444Config
import cpu.ooo.{PTW, TLB, MMU}
import firrtl.options.TargetDirAnnotation

object PTWLaunch extends App{
  implicit val p = (new DRAM3SimConfig) ++ (new GEMM4444Config())

  (new ChiselStage).execute(
    Array(
      "-X", "verilog",
      "--target-dir", "test_run_dir"
      //      "--help"
    ),
    Seq(ChiselGeneratorAnnotation(() => new MMU))
  )
  println("generate ptw!")


//  (new ChiselStage).execute(
//    Array(
//      "-X", "verilog",
//      "--target-dir", "test_run_dir"
//      //      "--help"
//    ),
//    Seq(ChiselGeneratorAnnotation(() => new PTW(2)))
//  )
//  println("generate ptw!")
//
//  (new ChiselStage).execute(
//    Array(
//      "-X", "verilog",
//      "--target-dir", "test_run_dir"
//      //      "--help"
//    ),
//    Seq(ChiselGeneratorAnnotation(() => new TLB(true, 2)))
//  )
//  println("generate itlb!")
//
//  (new ChiselStage).execute(
//    Array(
//      "-X", "verilog",
//      "--target-dir", "test_run_dir"
//      //      "--help"
//    ),
//    Seq(ChiselGeneratorAnnotation(() => new TLB(false, 2)))
//  )
//  println("generate dtlb!")
}

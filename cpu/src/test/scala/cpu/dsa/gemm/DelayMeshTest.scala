package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chiseltest._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
//import chiseltest.internal.{VerilatorBackendAnnotation, WriteVcdAnnotation}
import org.scalatest.FreeSpec
import firrtl.options.TargetDirAnnotation

class DelayMeshTest extends FreeSpec with ChiselScalatestTester {

  implicit val p = new GEMM4444Config()

  def poke_req[T1 <: Data](m: DelayMesh[T1], mode: UInt): Unit = {
    m.io.req.valid.poke(true.B)
    m.io.req.bits.ctrl.foreach(_.foreach(pe => {
      pe.dataflow.poke(0.U)   // only implement OS(0.U)
      pe.mode.poke(mode)
    }))
  }

  def clear_poke_req[T1 <: Data](m: DelayMesh[T1]): Unit = {
    m.io.req.valid.poke(false.B)
    m.io.req.bits.ctrl.foreach(_.foreach(pe => {
      pe.dataflow.poke(0.U)   // only implement OS(0.U)
      pe.mode.poke(0.U)
    }))
  }

  def poke_d[T1 <: Data](m: DelayMesh[T1], value: T1): Unit ={
    m.io.d_in.valid.poke(true.B)
    m.io.d_in.bits.foreach(_.foreach(e => e.poke(value)))
  }

  def clear_poke_d[T1 <: Data](m: DelayMesh[T1], value: T1): Unit ={
    m.io.d_in.valid.poke(false.B)
    m.io.d_in.bits.foreach(_.foreach(e => e.poke(value)))
  }

  def poke_a[T1 <: Data](m: DelayMesh[T1], value: T1) = {
    m.io.a_in.valid.poke(true.B)
    m.io.a_in.bits.foreach(_.foreach(e => e.poke(value)))
  }

  def clear_poke_a[T1 <: Data](m: DelayMesh[T1], value: T1) = {
    m.io.a_in.valid.poke(false.B)
    m.io.a_in.bits.foreach(_.foreach(e => e.poke(value)))
  }

  def poke_b[T1 <: Data](m: DelayMesh[T1], value: T1) = {
    m.io.b_in.valid.poke(true.B)
    m.io.b_in.bits.foreach(_.foreach(e => e.poke(value)))
  }

  def clear_poke_b[T1 <: Data](m: DelayMesh[T1], value: T1) = {
    m.io.b_in.valid.poke(false.B)
    m.io.b_in.bits.foreach(_.foreach(e => e.poke(value)))
  }

  "Simple Test for DelayMeshTest" in {
    val annos = Seq(
      TargetDirAnnotation("test_run_dir"),
//    VerilatorBackendAnnotation,
      WriteVcdAnnotation,
    )
    RawTester.test(new DelayMesh(UInt(8.W), UInt(8.W), UInt(16.W)), annos){c =>
      poke_req(c, 1.U)
      c.clock.step(1)
      clear_poke_req(c)
      poke_d(c, 4.U)
      c.clock.step(32)

      poke_req(c, 2.U)
      c.clock.step(1)
      clear_poke_req(c)
      poke_a(c, 1.U)
      poke_b(c, 1.U)
      c.clock.step(16)

      poke_a(c, 0.U)
      poke_b(c, 0.U)
      c.clock.step(1)
      clear_poke_a(c, 0.U)
      clear_poke_b(c, 0.U)
      c.clock.step(15)


    }
  }
}

object DelayMeshLaunch extends App{
  implicit val p = new GEMM4444Config()
  (new ChiselStage).execute(
    Array(
      "-X", "verilog",
      "--target-dir", "test_run_dir",
      "--help"
    ),
    Seq(ChiselGeneratorAnnotation(() => new DelayMesh(UInt(8.W), UInt(8.W), UInt(16.W))))
  )
}

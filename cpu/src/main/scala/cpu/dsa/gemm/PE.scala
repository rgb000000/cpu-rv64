package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class PEControl() extends Bundle{
  val dataflow = UInt(1.W) // os, ws
  val mode = UInt(2.W)    // idle, preload, run, out
}

class PEIO[T<:Data](inType: T, outType: T) extends Bundle{
  val a_in = Input(inType)
  val b_in = Input(outType)
  val d_in = Input(outType)

  val a_out = Output(inType)
  val b_out = Output(outType)
  val c_out = Output(outType)

  val ctrl_in = Input(new PEControl)
  val ctrl_out = Output(new PEControl)

  override def cloneType = new PEIO(inType, outType).asInstanceOf[this.type]
}


class PE[T<:Data:Arithmetic](inType: T, outType: T, accType: T)(implicit ev: Arithmetic[T]) extends Module with GEMMConstant {
  val io = IO(new PEIO(inType, outType))

  dontTouch(io.c_out)

  import ev._

  io.a_out := io.a_in
  io.b_out := io.b_in

  io.ctrl_out := io.ctrl_in

  val reg = RegInit(0.U.asTypeOf(accType))

  io.c_out := reg

  when(io.ctrl_in.mode === M_PRELOAD){
    // preload d
    reg := io.d_in
  }.elsewhen(io.ctrl_in.mode === M_RUN){
    reg := reg.mac(io.a_in, io.b_in)
  }.otherwise{
    reg := reg
  }
}

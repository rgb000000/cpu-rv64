package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

import difftest._

class PRFile(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    // read port
    val raddr1 = Input(UInt(log2Ceil(64).W))
    val raddr2 = Input(UInt(log2Ceil(64).W))
    val rdata1 = Output(UInt(p(XLen).W))
    val rdata2 = Output(UInt(p(XLen).W))

    // writer port
    val wen = Input(Bool())
    val waddr = Input(UInt(log2Ceil(64).W))
    val wdata = Input(UInt(p(XLen).W))

    val trap_code = if (p(Difftest)) Some(Output(UInt(p(XLen).W))) else None
  })

  val registers = RegInit(VecInit(Seq.fill(64)(0.asUInt(p(XLen).W))))

  io.rdata1 := Mux(io.raddr1.orR() === 0.U, 0.U, Mux(io.wen & io.waddr === io.raddr1, io.wdata, registers(io.raddr1)))
  io.rdata2 := Mux(io.raddr2.orR() === 0.U, 0.U, Mux(io.wen & io.waddr === io.raddr2, io.wdata, registers(io.raddr2)))

  when(io.wen === 1.U & io.waddr.orR() =/= 0.U){
    registers(io.waddr) := io.wdata
  }

}

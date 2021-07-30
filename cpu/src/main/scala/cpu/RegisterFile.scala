package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class RegisterFile(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    // read port
    val raddr1 = Input(UInt(log2Ceil(32).W))
    val raddr2 = Input(UInt(log2Ceil(32).W))
    val rdata1 = Output(UInt(p(XLen).W))
    val rdata2 = Output(UInt(p(XLen).W))

    // writer port
    val wen = Input(Bool())
    val waddr = Input(UInt(log2Ceil(32).W))
    val wdata = Input(UInt(p(XLen).W))
  })

  val registers = Mem(32, UInt(p(XLen).W))

  io.rdata1 := Mux(io.raddr1.orR() === 0.U, 0.U, registers.read(io.raddr1))
  io.rdata2 := Mux(io.raddr2.orR() === 0.U, 0.U, registers.read(io.raddr2))

  when(io.wen === 1.U & io.waddr.orR() =/= 0.U){
    registers.write(io.waddr, io.wdata)
  }
}

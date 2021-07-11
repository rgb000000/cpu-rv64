package cpu

import chipsalliance.rocketchip.config._
import chisel3._
import chisel3.util._

class RegisterFile(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    // read port
    val radd1 = Input(UInt(log2Ceil(32).W))
    val radd2 = Input(UInt(log2Ceil(32).W))
    val rdata1 = Output(UInt(p(XLen).W))
    val rdata2 = Output(UInt(p(XLen).W))

    // writer port
    val wen = Input(Bool())
    val waddr = Input(UInt(log2Ceil(32).W))
    val wdata = Input(UInt(p(XLen).W))
  })

  val registers = Mem(32, UInt(p(XLen).W))

  io.rdata1 := Mux(io.radd1.orR() === 0.U, 0.U, registers.read(io.radd1))
  io.rdata2 := Mux(io.radd2.orR() === 0.U, 0.U, registers.read(io.radd2))

  when(io.wen === 1.U & io.waddr.orR() =/= 0.U){
    registers.write(io.waddr, io.wdata)
  }
}

class ID (implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val inst = Input(UInt(32.W))
    val pc = Input(UInt(32.W))

    val rs1 = Output(UInt(p(XLen).W))
    val rs2 = Output(UInt(p(XLen).W))
  })

  val regs = Module(new RegisterFile)

  val rd_addr = WireInit(io.inst(11, 7))
  val rs1_addr = WireInit(io.inst(19, 15))
  val rs2_addr = WireInit(io.inst(24, 20))

  regs.io.radd1 := rs1_addr
  regs.io.radd2 := rs2_addr

  val rs1 = RegNext(regs.io.rdata1)
  val rs2 = RegNext(regs.io.rdata2)

  io.rs1 := rs1
  io.rs2 := rs2
}

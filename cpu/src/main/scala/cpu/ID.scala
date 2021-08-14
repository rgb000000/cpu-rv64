package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import Control._

class ImmGen (implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val inst = Input(UInt(p(XLen).W))
    val sel = Input(UInt(3.W))
    val out = Output(UInt(p(XLen).W))
  })

  val Iimm = Wire(SInt(64.W))
  val Simm = Wire(SInt(64.W))
  val Bimm = Wire(SInt(64.W))
  val Uimm = Wire(SInt(64.W))
  val Jimm = Wire(SInt(64.W))
  val Zimm = Wire(SInt(64.W))

  Iimm := io.inst(31, 20).asSInt()
  Simm := Cat(io.inst(31, 25), io.inst(11,7)).asSInt
  Bimm := Cat(io.inst(31), io.inst(7), io.inst(30, 25), io.inst(11, 8), 0.U(1.W)).asSInt
  Uimm := Cat(io.inst(31, 12), 0.U(12.W)).asSInt
  Jimm := Cat(io.inst(31), io.inst(19, 12), io.inst(20), io.inst(30, 25), io.inst(24, 21), 0.U(1.W)).asSInt
  Zimm := io.inst(19, 15).zext

  io.out := MuxLookup(io.sel, Iimm & (-2.S), Seq(
    IMM_I -> Iimm,
    IMM_S -> Simm,
    IMM_B -> Bimm,
    IMM_U -> Uimm,
    IMM_J -> Jimm,
    IMM_Z -> Zimm
  )).asUInt()
}

class ID (implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val inst = Input(UInt(32.W))

    val rd_addr = Output(UInt(5.W))
    val rs1_addr = Output(UInt(5.W))
    val rs2_addr = Output(UInt(5.W))

    val imm_sel = Input(UInt(3.W))
    val imm = Output(UInt(p(XLen).W))
  })

  io.rd_addr := WireInit(io.inst(11, 7))
  io.rs1_addr := WireInit(io.inst(19, 15))
  io.rs2_addr := WireInit(io.inst(24, 20))



  val immgen = Module(new ImmGen)
  immgen.io.inst := io.inst
  immgen.io.sel := io.imm_sel
  io.imm := immgen.io.out
}

package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class DataPath(implicit p: Parameters) extends Module {
  val io = IO(new Bundle{

  })

  import Control._

  val ifet = Module(new IF)
  val id = Module(new ID)
  val ex = Module(new EX)
//  val mem = Module(new MEM)
//  val wb = Module(new WB)

  val regs = Module(new RegisterFile)
  val ctrl = Module(new Control)

  val i_mem = SyncReadMem(32, UInt(32.W))

  // fetch
  ifet.io.inst_in.bits := i_mem.read(ifet.io.pc.bits)
  ifet.io.inst_in.valid := RegNext(ifet.io.pc.valid)

  // decode
  ctrl.io.inst := ifet.io.inst_out.bits

  id.io.inst := ifet.io.inst_out.bits
  id.io.imm_sel := ctrl.io.imm_sel
  regs.io.radd1 := id.io.rs1_addr
  regs.io.radd2 := id.io.rs2_addr
  val rd_addr = id.io.rd_addr

  // ex
  val A = WireInit(regs.io.rdata1)
  val B = Mux(ctrl.io.b_sel === B_IMM, id.io.imm, WireInit(regs.io.rdata2))

  ex.io.alu_op := ctrl.io.alu_op
  ex.io.rs1 := A
  ex.io.rs2 := B

  // mem

  //wb
  regs.io.waddr := rd_addr
  regs.io.wdata := ex.io.out
  regs.io.wen := ctrl.io.wen

  dontTouch(regs.io.wdata)
}

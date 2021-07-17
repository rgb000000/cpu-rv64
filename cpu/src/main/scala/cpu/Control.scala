package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import cpu.Control.{default, map}

object Control {

  val N = false.B
  val Y = true.B

  // PC_sel
  val PC_4   = 0.U(2.W)
  val PC_ALU = 1.U(2.W)
  val PC_0   = 2.U(2.W)
  val PC_EPC = 3.U(2.W)

  // A_sel
  val A_XXX  = 0.U(1.W)
  val A_PC   = 0.U(1.W)
  val A_RS1  = 1.U(1.W)


  // B_sel
  val B_XXX  = 0.U(1.W)
  val B_IMM  = 0.U(1.W)
  val B_RS2  = 1.U(1.W)

  // imm_sel
  val IMM_X  = 0.U(3.W)
  val IMM_I  = 1.U(3.W)
  val IMM_S  = 2.U(3.W)
  val IMM_U  = 3.U(3.W)
  val IMM_J  = 4.U(3.W)
  val IMM_B  = 5.U(3.W)
  val IMM_Z  = 6.U(3.W)

  import ISA._
  import ALU._
  //                                                            kill                        wb_en  illegal?
  //            pc_sel  A_sel   B_sel  imm_sel   alu_op   br_type |  st_type ld_type wb_sel  | csr_cmd |
  //              |       |       |     |          |          |   |     |       |       |    |  |      |
  val default =
            List(PC_4, A_XXX,  B_XXX, IMM_X,    ALU_XXX,                                     N)
  val map = Array(
    addi -> List(PC_4, A_RS1,  B_IMM, IMM_I,    ALU_ADD,                                     Y)
  )
}

class ControlIO(implicit p: Parameters) extends Bundle{
  val inst = Input(UInt(32.W))

  val b_sel = Output(UInt(1.W))
  val imm_sel = Output(UInt(3.W))
  val alu_op = Output(UInt(3.W))
  val wen = Output(Bool())
}

class Control(implicit p: Parameters) extends Module{
  val io = IO(new ControlIO)


  val ctrl_signal = ListLookup(io.inst, Control.default, Control.map)

  io.b_sel := ctrl_signal(0)
  io.imm_sel := ctrl_signal(1)
  io.alu_op := ctrl_signal(2)
  io.wen := ctrl_signal(3)


}
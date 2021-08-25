package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

object Control {

  val N = false.B
  val Y = true.B

  // PC_sel
  val PC_4   = 0.U(2.W) // pc += 4
  val PC_ALU = 1.U(2.W) // pc = alu
  val PC_0   = 2.U(2.W) // pc = pc
  val PC_EPC = 3.U(2.W) // pc = epc

  // A_sel
  val A_XXX  = 0.U(1.W) // none
  val A_PC   = 0.U(1.W) // a = pc
  val A_RS1  = 1.U(1.W) // a = rs1


  // B_sel
  val B_XXX  = 0.U(1.W) // none
  val B_IMM  = 0.U(1.W) // b = imm
  val B_RS2  = 1.U(1.W) // b = rs2

  // imm_sel
  val IMM_X  = 0.U(3.W) // none
  val IMM_I  = 1.U(3.W) // I type imm
  val IMM_S  = 2.U(3.W) // S type imm
  val IMM_U  = 3.U(3.W) // U type imm
  val IMM_J  = 4.U(3.W) // J type imm
  val IMM_B  = 5.U(3.W) // B type imm
  val IMM_Z  = 6.U(3.W) // used in CSR

  // br_type
  val BR_XXX = 0.U(3.W) // none
  val BR_LTU = 1.U(3.W) // < unisigned
  val BR_LT  = 2.U(3.W) // <
  val BR_EQ  = 3.U(3.W) // ==
  val BR_GEU = 4.U(3.W) // >= unsigned
  val BR_GE  = 5.U(3.W) // >=
  val BR_NE  = 6.U(3.W) // =/=

  // st_type
  val ST_XXX = 0.U(3.W) // nonoe
  val ST_SD  = 1.U(3.W) // double word (64)
  val ST_SW  = 2.U(3.W) // word        (32)
  val ST_SH  = 3.U(3.W) // half-word   (16)
  val ST_SB  = 4.U(3.W) // byte        ( 8)

  // ld_type
  val LD_XXX = 0.U(3.W) // none
  val LD_LD  = 1.U(3.W) // double word (64)
  val LD_LW  = 2.U(3.W) // word        (32)
  val LD_LH  = 3.U(3.W) // half-word   (16)
  val LD_LB  = 4.U(3.W) // byte        ( 8)
  val LD_LWU = 5.U(3.W) // word unsigned      (32)
  val LD_LHU = 6.U(3.W) // half-word unsigned (16)
  val LD_LBU = 7.U(3.W) // byte unsigned      ( 8)

  // wb_sel
  val WB_ALU = 0.U(2.W) // wb alu
  val WB_MEM = 1.U(2.W) // wb mem
  val WB_PC4 = 2.U(2.W) // wb pc+4
  val WB_CSR = 3.U(2.W) // wb csr

  import ISA._
  import ALU._

  //                                                                  kill                       wb_en  illegal?
  //             pc_sel    A_sel   B_sel  imm_sel  alu_op      br_type |  st_type ld_type wb_sel  | csr_cmd |
  //               |         |       |     |         |           |     |     |       |       |    |  |      |
  val default =
              List(PC_4,   A_XXX,  B_XXX, IMM_X,   ALU_XXX,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, N,        Y)
  val map = Array(
    // R type
    add    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    sub    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SUB,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    sll    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SLL,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    slt    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SLT,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    sltu   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SLTU,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    xor    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_XOR,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    srl    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SRL,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    sra    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SRA,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    or     -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_OR,     BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    and    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AND,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),

    // I type
    jalr   -> List(PC_ALU, A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, Y, ST_XXX, LD_XXX, WB_PC4, Y,        N),
    addi   -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    slti   -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SLT,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    sltiu  -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SLTU,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    xori   -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_XOR,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    ori    -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_OR,     BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    andi   -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_AND,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    lb     -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_LB,  WB_MEM, Y,        N),
    lh     -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_LH,  WB_MEM, Y,        N),
    lw     -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_LW,  WB_MEM, Y,        N),
    lbu    -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_LBU, WB_MEM, Y,        N),
    lhu    -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_LHU, WB_MEM, Y,        N),
    slli   -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SLL,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    srli   -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SRL,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    srai   -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SRA,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    fence  -> List(PC_4,   A_XXX,  B_XXX, IMM_X,   ALU_XXX,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, N,        N),
    fence_i-> List(PC_4,   A_XXX,  B_XXX, IMM_X,   ALU_XXX,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, N,        N),
    ecall  -> List(PC_4,   A_XXX,  B_XXX, IMM_X,   ALU_XXX,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, N,        N),
    ebreak -> List(PC_4,   A_XXX,  B_XXX, IMM_X,   ALU_XXX,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, N,        N),

    // TODO: CSR aspects need to be improved
    csrrw  -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SUB,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    csrrs  -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SUB,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    csrrc  -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SUB,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    csrrwi -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SUB,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    csrrsi -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SUB,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    csrrci -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SUB,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),

    // U type
    lui    -> List(PC_4,   A_RS1,  B_IMM, IMM_U,   ALU_COPY_B, BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    auipc  -> List(PC_4,   A_PC,   B_IMM, IMM_U,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),

    // S type
    sb     -> List(PC_4,   A_RS1,  B_IMM, IMM_S,   ALU_ADD,    BR_XXX, N, ST_SB,  LD_XXX, WB_MEM, N,        N),
    sh     -> List(PC_4,   A_RS1,  B_IMM, IMM_S,   ALU_ADD,    BR_XXX, N, ST_SH,  LD_XXX, WB_MEM, N,        N),
    sw     -> List(PC_4,   A_RS1,  B_IMM, IMM_S,   ALU_ADD,    BR_XXX, N, ST_SW,  LD_XXX, WB_MEM, N,        N),

    // B type
    beq    -> List(PC_4,   A_PC,   B_IMM, IMM_B,   ALU_ADD,    BR_EQ,  N, ST_XXX, LD_XXX, WB_ALU, N,        N),
    bne    -> List(PC_4,   A_PC,   B_IMM, IMM_B,   ALU_ADD,    BR_NE,  N, ST_XXX, LD_XXX, WB_ALU, N,        N),
    blt    -> List(PC_4,   A_PC,   B_IMM, IMM_B,   ALU_ADD,    BR_LT,  N, ST_XXX, LD_XXX, WB_ALU, N,        N),
    bge    -> List(PC_4,   A_PC,   B_IMM, IMM_B,   ALU_ADD,    BR_GE,  N, ST_XXX, LD_XXX, WB_ALU, N,        N),
    bltu   -> List(PC_4,   A_PC,   B_IMM, IMM_B,   ALU_ADD,    BR_LTU, N, ST_XXX, LD_XXX, WB_ALU, N,        N),
    bgeu   -> List(PC_4,   A_PC,   B_IMM, IMM_B,   ALU_ADD,    BR_GEU, N, ST_XXX, LD_XXX, WB_ALU, N,        N),

    // J type
    jal    -> List(PC_ALU, A_PC,   B_IMM, IMM_J,   ALU_ADD,    BR_XXX, Y, ST_XXX, LD_XXX, WB_PC4, Y,        N),

    // rv64
    // R type
    sllw   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SLLW,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    srlw   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SRLW,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    sraw   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SRAW,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    addw   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_ADDW,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    subw   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SUBW,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),

    // I type
    slliw  -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SLLIW,  BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    srliw  -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SRLIW,  BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    sraiw  -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SRAIW,  BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    addiw  -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADDIW,  BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y,        N),
    lwu    -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_LWU, WB_MEM, Y,        N),
    ld     -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_LD,  WB_MEM, Y,        N),

    // S type
    sd     -> List(PC_4,   A_RS1,  B_IMM, IMM_S,   ALU_ADD,    BR_XXX, N, ST_SD,  LD_XXX, WB_ALU, N,        N),
  )
}

class CtrlSignal (implicit p: Parameters) extends Bundle {
  val pc_sel  = Output(UInt(2.W))
  val a_sel   = Output(UInt(1.W))
  val b_sel   = Output(UInt(1.W))
  val imm_sel = Output(UInt(3.W))
  val alu_op  = Output(UInt(5.W))
  val br_type = Output(UInt(3.W))
  val kill    = Output(UInt(1.W))
  val st_type = Output(UInt(3.W))
  val ld_type = Output(UInt(3.W))
  val wb_type = Output(UInt(2.W))
  val wen     = Output(UInt(1.W))
  val illegal = Output(UInt(1.W))
}

class ControlIO(implicit p: Parameters) extends Bundle{
  val inst = Input(UInt(32.W))
  val signal = Output(new CtrlSignal)
}

class Control(implicit p: Parameters) extends Module{
  val io = IO(new ControlIO)

  val ctrl_signal = ListLookup(io.inst, Control.default, Control.map)

  io.signal.pc_sel  := ctrl_signal( 0)
  io.signal.a_sel   := ctrl_signal( 1)
  io.signal.b_sel   := ctrl_signal( 2)
  io.signal.imm_sel := ctrl_signal( 3)
  io.signal.alu_op  := ctrl_signal( 4)
  io.signal.br_type := ctrl_signal( 5)
  io.signal.kill    := ctrl_signal( 6)
  io.signal.st_type := ctrl_signal( 7)
  io.signal.ld_type := ctrl_signal( 8)
  io.signal.wb_type := ctrl_signal( 9)
  io.signal.wen     := ctrl_signal(10)
  // todo: csr_cmd
  io.signal.illegal := ctrl_signal(11)
}
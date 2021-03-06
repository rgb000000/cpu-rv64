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
  val BR_J   = 7.U(3.W) // no-cond jump

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

  // rocc_cmd
  val RoCC_X = 0.U(2.W)
  val RoCC_W = 1.U(2.W)
  val RoCC_R = 2.U(2.W)

  import ISA._
  import ALU._

  //                                                                  kill                       wb_en  illegal?
  //             pc_sel    A_sel   B_sel  imm_sel  alu_op      br_type |  st_type ld_type wb_sel  | csr_cmd | rocc_cmd
  //               |         |       |     |         |           |     |     |       |       |    |  |      |    |
  val default =
              List(PC_4,   A_XXX,  B_XXX, IMM_X,   ALU_XXX,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, N, CSR.N, Y, RoCC_X)
  val map = Array(
    // R type
    add    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    sub    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SUB,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    sll    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SLL,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    slt    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SLT,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    sltu   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SLTU,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    xor    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_XOR,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    srl    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SRL,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    sra    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SRA,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    or     -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_OR,     BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    and    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AND,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),

    // I type
    jalr   -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_J,   N, ST_XXX, LD_XXX, WB_PC4, Y, CSR.N, N, RoCC_X),
    addi   -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    slti   -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SLT,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    sltiu  -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SLTU,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    xori   -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_XOR,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    ori    -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_OR,     BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    andi   -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_AND,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    lb     -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_LB,  WB_MEM, Y, CSR.N, N, RoCC_X),
    lh     -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_LH,  WB_MEM, Y, CSR.N, N, RoCC_X),
    lw     -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_LW,  WB_MEM, Y, CSR.N, N, RoCC_X),
    lbu    -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_LBU, WB_MEM, Y, CSR.N, N, RoCC_X),
    lhu    -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_LHU, WB_MEM, Y, CSR.N, N, RoCC_X),
    slli   -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SLL,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    srli   -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SRL,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    srai   -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SRA,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    fence  -> List(PC_4,   A_XXX,  B_XXX, IMM_X,   ALU_XXX,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, N, CSR.N, N, RoCC_X),
    fence_i-> List(PC_0,   A_XXX,  B_XXX, IMM_X,   ALU_XXX,    BR_XXX, Y, ST_XXX, LD_XXX, WB_ALU, N, CSR.N, N, RoCC_X),
    ecall  -> List(PC_4,   A_XXX,  B_XXX, IMM_X,   ALU_XXX,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, N, CSR.P, N, RoCC_X),
    ebreak -> List(PC_4,   A_XXX,  B_XXX, IMM_X,   ALU_XXX,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, N, CSR.P, N, RoCC_X),
    mret   -> List(PC_EPC, A_XXX,  B_XXX, IMM_X,   ALU_XXX,    BR_XXX, Y, ST_XXX, LD_XXX, WB_ALU, N, CSR.P, N, RoCC_X),
    sret   -> List(PC_EPC, A_XXX,  B_XXX, IMM_X,   ALU_XXX,    BR_XXX, Y, ST_XXX, LD_XXX, WB_ALU, N, CSR.P, N, RoCC_X),
    wfi    -> List(PC_4,   A_XXX,  B_XXX, IMM_X,   ALU_XXX,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, N, CSR.N, N, RoCC_X),
 sfence_vma-> List(PC_4,   A_XXX,  B_XXX, IMM_X,   ALU_XXX,    BR_XXX, Y, ST_XXX, LD_XXX, WB_ALU, N, CSR.P, N, RoCC_X),
    // TODO: CSR aspects need to be improved
    csrrw  -> List(PC_4,   A_RS1,  B_XXX, IMM_X,   ALU_COPY_A, BR_XXX, N, ST_XXX, LD_XXX, WB_CSR, Y, CSR.W, N, RoCC_X),
    csrrs  -> List(PC_4,   A_RS1,  B_XXX, IMM_X,   ALU_COPY_A, BR_XXX, N, ST_XXX, LD_XXX, WB_CSR, Y, CSR.S, N, RoCC_X),
    csrrc  -> List(PC_4,   A_RS1,  B_XXX, IMM_X,   ALU_COPY_A, BR_XXX, N, ST_XXX, LD_XXX, WB_CSR, Y, CSR.C, N, RoCC_X),
    csrrwi -> List(PC_4,   A_XXX,  B_IMM, IMM_Z,   ALU_COPY_B, BR_XXX, N, ST_XXX, LD_XXX, WB_CSR, Y, CSR.W, N, RoCC_X),
    csrrsi -> List(PC_4,   A_XXX,  B_IMM, IMM_Z,   ALU_COPY_B, BR_XXX, N, ST_XXX, LD_XXX, WB_CSR, Y, CSR.S, N, RoCC_X),
    csrrci -> List(PC_4,   A_XXX,  B_IMM, IMM_Z,   ALU_COPY_B, BR_XXX, N, ST_XXX, LD_XXX, WB_CSR, Y, CSR.C, N, RoCC_X),

    // U type
    lui    -> List(PC_4,   A_RS1,  B_IMM, IMM_U,   ALU_COPY_B, BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    auipc  -> List(PC_4,   A_PC,   B_IMM, IMM_U,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),

    // S type
    sb     -> List(PC_4,   A_RS1,  B_RS2, IMM_S,   ALU_ADD,    BR_XXX, N, ST_SB,  LD_XXX, WB_MEM, N, CSR.N, N, RoCC_X),
    sh     -> List(PC_4,   A_RS1,  B_RS2, IMM_S,   ALU_ADD,    BR_XXX, N, ST_SH,  LD_XXX, WB_MEM, N, CSR.N, N, RoCC_X),
    sw     -> List(PC_4,   A_RS1,  B_RS2, IMM_S,   ALU_ADD,    BR_XXX, N, ST_SW,  LD_XXX, WB_MEM, N, CSR.N, N, RoCC_X),
    sd     -> List(PC_4,   A_RS1,  B_RS2, IMM_S,   ALU_ADD,    BR_XXX, N, ST_SD,  LD_XXX, WB_ALU, N, CSR.N, N, RoCC_X),

    // B type
    beq    -> List(PC_4,   A_RS1,  B_RS2, IMM_B,   ALU_ADD,    BR_EQ,  N, ST_XXX, LD_XXX, WB_ALU, N, CSR.N, N, RoCC_X),
    bne    -> List(PC_4,   A_RS1,  B_RS2, IMM_B,   ALU_ADD,    BR_NE,  N, ST_XXX, LD_XXX, WB_ALU, N, CSR.N, N, RoCC_X),
    blt    -> List(PC_4,   A_RS1,  B_RS2, IMM_B,   ALU_ADD,    BR_LT,  N, ST_XXX, LD_XXX, WB_ALU, N, CSR.N, N, RoCC_X),
    bge    -> List(PC_4,   A_RS1,  B_RS2, IMM_B,   ALU_ADD,    BR_GE,  N, ST_XXX, LD_XXX, WB_ALU, N, CSR.N, N, RoCC_X),
    bltu   -> List(PC_4,   A_RS1,  B_RS2, IMM_B,   ALU_ADD,    BR_LTU, N, ST_XXX, LD_XXX, WB_ALU, N, CSR.N, N, RoCC_X),
    bgeu   -> List(PC_4,   A_RS1,  B_RS2, IMM_B,   ALU_ADD,    BR_GEU, N, ST_XXX, LD_XXX, WB_ALU, N, CSR.N, N, RoCC_X),

    // J type
    jal    -> List(PC_4,   A_PC,   B_IMM, IMM_J,   ALU_ADD,    BR_J,   N, ST_XXX, LD_XXX, WB_PC4, Y, CSR.N, N, RoCC_X),

    // rv64
    // R type
    sllw   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SLLW,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    srlw   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SRLW,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    sraw   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SRAW,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    addw   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_ADDW,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    subw   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SUBW,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),

    // I type
    slliw  -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SLLIW,  BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    srliw  -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SRLIW,  BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    sraiw  -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_SRAIW,  BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    addiw  -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADDIW,  BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    lwu    -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_LWU, WB_MEM, Y, CSR.N, N, RoCC_X),
    ld     -> List(PC_4,   A_RS1,  B_IMM, IMM_I,   ALU_ADD,    BR_XXX, N, ST_XXX, LD_LD,  WB_MEM, Y, CSR.N, N, RoCC_X),

    // RV64M all in R type
    mul    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_MUL,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    mulh   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_MULH,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    mulhsu -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_MULHSU, BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    mulhu  -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_MULHU,  BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    mulw   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_MULW,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    div    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_DIV,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    divu   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_DIVU,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    divw   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_DIVW,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    divuw  -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_DIVUW,  BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    rem    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_REM,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    remw   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_REMW,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    remu   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_REMU,   BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    remuw  -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_REMUW,  BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),

    // RV64A all in R type

    amoadd_w  -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOADD_W ,  BR_XXX, N, ST_SW,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amoxor_w  -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOXOR_W ,  BR_XXX, N, ST_SW,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amoor_w   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOOR_W  ,  BR_XXX, N, ST_SW,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amoand_w  -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOAND_W ,  BR_XXX, N, ST_SW,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amomin_w  -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOMIN_W ,  BR_XXX, N, ST_SW,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amomax_w  -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOMAX_W ,  BR_XXX, N, ST_SW,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amominu_w -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOMINU_W,  BR_XXX, N, ST_SW,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amomaxu_w -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOMAXU_W,  BR_XXX, N, ST_SW,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amoswap_w -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOSWAP_W,  BR_XXX, N, ST_SW,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    lr_w      -> List(PC_4,   A_RS1,  B_XXX, IMM_X,   ALU_LR_W     ,  BR_XXX, N, ST_XXX, LD_LW,  WB_ALU, Y, CSR.N, N, RoCC_X),
    sc_w      -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SC_W     ,  BR_XXX, N, ST_SW,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amoadd_d  -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOADD_D ,  BR_XXX, N, ST_SD,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amoxor_d  -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOXOR_D ,  BR_XXX, N, ST_SD,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amoor_d   -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOOR_D  ,  BR_XXX, N, ST_SD,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amoand_d  -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOAND_D ,  BR_XXX, N, ST_SD,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amomin_d  -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOMIN_D ,  BR_XXX, N, ST_SD,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amomax_d  -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOMAX_D ,  BR_XXX, N, ST_SD,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amominu_d -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOMINU_D,  BR_XXX, N, ST_SD,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amomaxu_d -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOMAXU_D,  BR_XXX, N, ST_SD,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    amoswap_d -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_AMOSWAP_D,  BR_XXX, N, ST_SD,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),
    lr_d      -> List(PC_4,   A_RS1,  B_XXX, IMM_X,   ALU_LR_D     ,  BR_XXX, N, ST_XXX, LD_LD,  WB_ALU, Y, CSR.N, N, RoCC_X),
    sc_d      -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_SC_D     ,  BR_XXX, N, ST_SD,  LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_X),

  // custom0
    roccw_rs1_rs2 -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_XXX,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, N, CSR.N, N, RoCC_W),
    roccr_rd_rs1  -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_XXX,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.N, N, RoCC_R),
    rocc_mvin     -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_XXX,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, N, CSR.N, N, RoCC_W),
    rocc_mvout    -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_XXX,    BR_XXX, Y, ST_XXX, LD_XXX, WB_ALU, N, CSR.N, N, RoCC_R),
    gemm_n        -> List(PC_4,   A_RS1,  B_RS2, IMM_X,   ALU_XXX,    BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, N, CSR.N, N, RoCC_W)
  )
}

class CtrlSignal (implicit val p: Parameters) extends Bundle {
  val pc_sel  = Output(UInt(2.W))
  val a_sel   = Output(UInt(1.W))
  val b_sel   = Output(UInt(1.W))
  val imm_sel = Output(UInt(3.W))
  val alu_op  = Output(UInt(6.W))
  val br_type = Output(UInt(3.W))
  val kill    = Output(UInt(1.W))
  val st_type = Output(UInt(3.W))
  val ld_type = Output(UInt(3.W))
  val wb_type = Output(UInt(2.W))
  val wen     = Output(UInt(1.W))
  val csr_cmd = Output(UInt(3.W))
  val illegal = Output(UInt(1.W))
  val rocc_cmd= Output(UInt(2.W))
}

class ControlIO(implicit val p: Parameters) extends Bundle{
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
  io.signal.csr_cmd := ctrl_signal(11)
  io.signal.illegal := ctrl_signal(12)
  io.signal.rocc_cmd:= ctrl_signal(13)
}
package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

object ALU {
  val ALU_ADD    =  0.U(6.W) // +
  val ALU_SUB    =  1.U(6.W) // -
  val ALU_AND    =  2.U(6.W) // &
  val ALU_OR     =  3.U(6.W) // |
  val ALU_XOR    =  4.U(6.W) // ^
  val ALU_SLT    =  5.U(6.W) // <
  val ALU_SLL    =  6.U(6.W) // << logic
  val ALU_SLTU   =  7.U(6.W) // < unsigned
  val ALU_SRL    =  8.U(6.W) // >> logic
  val ALU_SRA    =  9.U(6.W) // >> arithmetic
  val ALU_COPY_A = 10.U(6.W) // rs1
  val ALU_COPY_B = 11.U(6.W) // rs2

  val ALU_SLLW   = 12.U(6.W) // sext((x[rs1]âªx[rs2][4:0])[31:0])
  val ALU_SRLW   = 13.U(6.W) // sext(x[rs1][31:0] â«_ð¢ x[rs2][4:0])
  val ALU_SRAW   = 14.U(6.W) // sext(x[rs1][31:0] â«_ð  x[rs2][4:0])
  val ALU_ADDW   = 15.U(6.W) // sext((x[rs1] + x[rs2])[31:0])
  val ALU_SUBW   = 16.U(6.W) // sext((x[rs1] - x[rs2])[31:0])
  val ALU_SLLIW  = 17.U(6.W) // sext((x[rs1] âª shamt)[31:0])
  val ALU_SRLIW  = 18.U(6.W) // sext(x[rs1][31:0] â«_ð¢ shamt)
  val ALU_SRAIW  = 19.U(6.W) // sext(x[rs1][31:0]â«_ð  shamt)
  val ALU_ADDIW  = 20.U(6.W) // sext((x[rs1] + sext(immediate))[31:0])

  val ALU_XXX    = 21.U(6.W) //

  // ä¸é¢è¿äºå¹¶éALUæä½äº
  val ALU_MUL    = 22.U(6.W)
  val ALU_MULH   = 23.U(6.W)
  val ALU_MULHSU = 24.U(6.W)
  val ALU_MULHU  = 25.U(6.W)
  val ALU_MULW   = 26.U(6.W)
  val ALU_DIV    = 27.U(6.W)
  val ALU_DIVU   = 28.U(6.W)
  val ALU_REM    = 29.U(6.W)
  val ALU_REMU   = 30.U(6.W)
  val ALU_DIVW   = 31.U(6.W)
  val ALU_DIVUW  = 32.U(6.W)
  val ALU_REMW   = 33.U(6.W)
  val ALU_REMUW  = 34.U(6.W)

  val ALU_AMOADD_W   = 35.U(6.W)
  val ALU_AMOXOR_W   = 36.U(6.W)
  val ALU_AMOOR_W    = 37.U(6.W)
  val ALU_AMOAND_W   = 38.U(6.W)
  val ALU_AMOMIN_W   = 39.U(6.W)
  val ALU_AMOMAX_W   = 40.U(6.W)
  val ALU_AMOMINU_W  = 41.U(6.W)
  val ALU_AMOMAXU_W  = 42.U(6.W)
  val ALU_AMOSWAP_W  = 43.U(6.W)
  val ALU_AMOADD_D   = 44.U(6.W)
  val ALU_AMOXOR_D   = 45.U(6.W)
  val ALU_AMOOR_D    = 46.U(6.W)
  val ALU_AMOAND_D   = 47.U(6.W)
  val ALU_AMOMIN_D   = 48.U(6.W)
  val ALU_AMOMAX_D   = 49.U(6.W)
  val ALU_AMOMINU_D  = 50.U(6.W)
  val ALU_AMOMAXU_D  = 51.U(6.W)
  val ALU_AMOSWAP_D  = 52.U(6.W)
  val ALU_LR_W       = 53.U(6.W)
  val ALU_SC_W       = 54.U(6.W)
  val ALU_LR_D       = 55.U(6.W)
  val ALU_SC_D       = 56.U(6.W)

}

class ALU (implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val rs1 = Input(UInt(p(XLen).W))
    val rs2 = Input(UInt(p(XLen).W))
    val alu_op = Input(UInt(5.W))

    val out = Output(UInt(p(XLen).W))
  })

  import ALU._

  val shamt_6 = WireInit(io.rs2(5, 0).asUInt())
  val shamt_5 = WireInit(io.rs2(4, 0).asUInt())

  def uint32_sext_64(x: UInt) = {
//    require(x.getWidth == 32)
    val sign = x(31)
    Cat(Seq.fill(32)(sign) ++ Seq(x)).asUInt()
  }

  val out = Wire(UInt(p(XLen).W))

  out := MuxLookup(io.alu_op, io.rs2, Seq(
    ALU_ADD    -> (io.rs1 + io.rs2),
    ALU_SUB    -> (io.rs1 - io.rs2),
    ALU_SRA    -> (io.rs1.asSInt >> shamt_6).asUInt,
    ALU_SRL    -> (io.rs1 >> shamt_6),
    ALU_SLT    -> (io.rs1.asSInt < io.rs2.asSInt),
    ALU_SLTU   -> (io.rs1 < io.rs2),
    ALU_AND    -> (io.rs1 & io.rs2),
    ALU_OR     -> (io.rs1 | io.rs2),
    ALU_XOR    -> (io.rs1 ^ io.rs2),
    ALU_COPY_A -> io.rs1,
    ALU_COPY_B -> io.rs2,
    ALU_SRLW   -> uint32_sext_64((io.rs1(31, 0).asUInt() >> shamt_5).asUInt()),
    ALU_SRAW   -> uint32_sext_64((io.rs1(31, 0).asSInt() >> shamt_5).asUInt()),
    ALU_SRLIW  -> uint32_sext_64((io.rs1(31, 0).asUInt() >> shamt_6).asUInt()),
    ALU_SRAIW  -> uint32_sext_64((io.rs1(31, 0).asSInt() >> shamt_6).asUInt()),
    ALU_ADDW   -> uint32_sext_64((io.rs1 + io.rs2)(31, 0).asUInt()),
    ALU_SUBW   -> uint32_sext_64((io.rs1 - io.rs2)(31, 0).asUInt()),
    ALU_ADDIW  -> uint32_sext_64((io.rs1 + io.rs2)(31, 0).asUInt()),
    ALU_SLLW   -> uint32_sext_64((io.rs1 << io.rs2(4, 0).asUInt())(31, 0).asUInt()),
    ALU_SLLIW  -> uint32_sext_64((io.rs1 << shamt_6)(31, 0).asUInt()),
    ALU_SLL    -> (io.rs1 << shamt_6)(63, 0),
  ))

  io.out := out
}

class EX(implicit p: Parameters) extends Module {
  val io = IO(new Bundle {
    val rs1 = Input(UInt(p(XLen).W))
    val rs2 = Input(UInt(p(XLen).W))
    val alu_op = Input(UInt(5.W))

    val out = Output(UInt(p(XLen).W))
  })

  val alu = Module(new ALU)

  alu.io.rs1 := io.rs1
  alu.io.rs2 := io.rs2
  alu.io.alu_op := io.alu_op

  io.out := alu.io.out


}

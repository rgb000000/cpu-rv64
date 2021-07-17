package cpu

import chisel3.util.BitPat

// 47(RV32I) + nop
trait RV32I {
  // R type             00     rs2   rs1  000   rd   opcode
  def add  = BitPat("b0000000_?????_?????_000_?????_0110011") // x[rd] = x[rs1] + x[rs2]
  def sub  = BitPat("b0100000_?????_?????_000_?????_0110011") // x[rd] = x[rs1] − x[rs2]
  def sll  = BitPat("b0000000_?????_?????_001_?????_0110011") // x[rd] = x[rs1] ≪ x[rs2]
  def slt  = BitPat("b0000000_?????_?????_010_?????_0110011") // x[rd] = (x[rs1] <_s x[rs2])
  def sltu = BitPat("b0000000_?????_?????_011_?????_0110011") // x[rd] = (x[rs1] <_𝑢 x[rs2])
  def xor  = BitPat("b0000000_?????_?????_100_?????_0110011") // x[rd] = x[rs1] ^ x[rs2]
  def srl  = BitPat("b0000000_?????_?????_101_?????_0110011") // x[rd] = (x[rs1] ≫_u x[rs2])
  def sra  = BitPat("b0100000_?????_?????_101_?????_0110011") // x[rd] = (x[rs1] ≫_𝑠 x[rs2])
  def or   = BitPat("b0000000_?????_?????_110_?????_0110011") // x[rd] = x[rs1] | x[rs2]
  def and  = BitPat("b0000000_?????_?????_111_?????_0110011") // x[rd] = x[rs1] & x[rs2]

  // I type             imm           rs1  000  rd
  def jalr   = BitPat("b????????????_?????_000_?????_1100111") // t=pc+4; pc=(x[rs1]+sext(offset))&~1; x[rd]=t

  def nop    = BitPat("b000000000000_00000_000_00000_0010011") // x[0] = x[0] + 0
  def addi   = BitPat("b????????????_?????_000_?????_0010011") // x[rd] = x[rs1] + sext(immediate)
  def slti   = BitPat("b????????????_?????_010_?????_0010011") // x[rd] = (x[rs1] <_𝑠 sext(immediate))
  def sltiu  = BitPat("b????????????_?????_011_?????_0010011") // x[rd] = (x[rs1] <_𝑢 sext(immediate))
  def xori   = BitPat("b????????????_?????_100_?????_0010011") // x[rd] = x[rs1] ^ sext(immediate)
  def ori    = BitPat("b????????????_?????_110_?????_0010011") // x[rd] = x[rs1] | sext(immediate)
  def andi   = BitPat("b????????????_?????_111_?????_0010011") // x[rd] = x[rs1] & sext(immediate)

  def lb     = BitPat("b????????????_?????_000_?????_0000011") // x[rd] = sext(M[x[rs1] + sext(offset)][7:0])
  def lh     = BitPat("b????????????_?????_001_?????_0000011") // x[rd] = sext(M[x[rs1] + sext(offset)][15:0])
  def lw     = BitPat("b????????????_?????_010_?????_0000011") // x[rd] = sext(M[x[rs1] + sext(offset)][31:0])
  def lbu    = BitPat("b????????????_?????_100_?????_0000011") // x[rd] = M[x[rs1] + sext(offset)][7:0]
  def lhu    = BitPat("b????????????_?????_101_?????_0000011") // x[rd] = M[x[rs1] + sext(offset)][15:0]

  def slli   = BitPat("b0000000?????_?????_001_?????_0010011") // x[rd] = x[rs1] ≪ shamt
  def srli   = BitPat("b0000000?????_?????_101_?????_0010011") // x[rd] = (x[rs1] ≫_𝑢 shamt)
  def srai   = BitPat("b0100000?????_?????_101_?????_0010011") // x[rd] = (x[rs1] ≫_𝑠 shamt)

  def fence  = BitPat("b0000_????_????_00000_000_00000_0001111") // Fence(pred, succ)
  def fence_i= BitPat("b0000_0000_0000_00000_001_00000_0001111") // Fence(Store, Fetch)

  def ecall  = BitPat("b000000000000_00000_000_00000_1110011") // RaiseException(EnvironmentCall)
  def ebreak = BitPat("b000000000001_00000_000_00000_1110011") // RaiseException(Breakpoint)
  //                       csr      rs1/zimm    rd
  def csrrw  = BitPat("b????????????_?????_001_?????_1110011") // t = CSRs[csr]; CSRs[csr] = x[rs1]; x[rd] = t
  def csrrs  = BitPat("b????????????_?????_010_?????_1110011") // t = CSRs[csr]; CSRs[csr] = t | x[rs1]; x[rd] = t
  def csrrc  = BitPat("b????????????_?????_011_?????_1110011") // t = CSRs[csr]; CSRs[csr] = t &~x[rs1]; x[rd] = t
  def csrrwi = BitPat("b????????????_?????_101_?????_1110011") // x[rd] = CSRs[csr]; CSRs[csr] = zimm
  def csrrsi = BitPat("b????????????_?????_110_?????_1110011") // t = CSRs[csr]; CSRs[csr] = t | zimm; x[rd] = t
  def csrrci = BitPat("b????????????_?????_111_?????_1110011") // t = CSRs[csr]; CSRs[csr] = t &~zimm; x[rd] = t


  // U type                     imm           rd
  def lui    = BitPat("b????????????????????_?????_0110111") // x[rd] = sext(immediate[31:12] << 12)
  def auipc  = BitPat("b????????????????????_?????_0110111") // x[rd] = pc + sext(immediate[31:12] << 12)

  // S type             offset   rs2   rs1  000  imm
  def sb     = BitPat("b???????_?????_?????_000_?????_0100011") // M[x[rs1]+sext(offset)] = x[rs2][7:0]
  def sh     = BitPat("b???????_?????_?????_001_?????_0100011") // M[x[rs1]+sext(offset)] = x[rs2][15:0]
  def sw     = BitPat("b???????_?????_?????_010_?????_0100011") // M[x[rs1]+sext(offset)] = x[rs2][31:0]

  // B type               imm    rs2   rs1  000  imm
  def beq    = BitPat("b???????_?????_?????_000_?????_1100011") // if (rs1 == rs2) pc += sext(offset)
  def bne    = BitPat("b???????_?????_?????_001_?????_1100011") // if (rs1 != rs2) pc += sext(offset)
  def blt    = BitPat("b???????_?????_?????_100_?????_1100011") // if (rs1 <_s rs2) pc += sext(offset)
  def bge    = BitPat("b???????_?????_?????_101_?????_1100011") // if (rs1 ≥_s rs2) pc += sext(offset)
  def bltu   = BitPat("b???????_?????_?????_110_?????_1100011") // if (rs1 <_u rs2) pc += sext(offset)
  def bgeu   = BitPat("b???????_?????_?????_111_?????_1100011") // if (rs1 >=_u rs2) pc += sext(offset)

  // J type               imm                 rd
  def jal    = BitPat("b????????????????????_?????_1101111") // x[rd] = pc+4; pc += sext(offset)
}

// 12(RV64I)
trait RV64I extends RV32I {
  // R type               00     rs2   rs1  000   rd   opcode
  def sllw   = BitPat("b0000000_?????_?????_001_?????_0111011") // x[rd] = sext((x[rs1]≪x[rs2][4:0])[31:0])
  def srlw   = BitPat("b0000000_?????_?????_101_?????_0111011") // x[rd] = sext(x[rs1][31:0] ≫_𝑢 x[rs2][4:0])
  def sraw   = BitPat("b0100000_?????_?????_101_?????_0111011") // x[rd] = sext(x[rs1][31:0] ≫_𝑠 x[rs2][4:0])
  def addw   = BitPat("b0000000_?????_?????_000_?????_0111011") // x[rd] = sext((x[rs1] + x[rs2])[31:0])
  def subw   = BitPat("b0100000_?????_?????_000_?????_0111011") // x[rd] = sext((x[rs1] - x[rs2])[31:0])

  // I type                imm        rs1  000  rd
  def slliw  = BitPat("b000000??????_?????_001_?????_0011011") // x[rd] = sext((x[rs1] ≪ shamt)[31:0])
  def srliw  = BitPat("b000000??????_?????_101_?????_0011011") // x[rd] = sext(x[rs1][31:0] ≫_𝑢 shamt)
  def sraiw  = BitPat("b010000??????_?????_101_?????_0011011") // x[rd] = sext(x[rs1][31:0]≫_𝑠 shamt)
  def addiw  = BitPat("b????????????_?????_000_?????_0011011") // x[rd] = sext((x[rs1] + sext(immediate))[31:0])
  //                      offset
  def lwu    = BitPat("b????????????_?????_110_?????_0000011") // x[rd] = M[x[rs1] + sext(offset)][31:0]
  def ld     = BitPat("b????????????_?????_011_?????_0000011") // x[rd] = M[x[rs1] + sext(offset)][63:0]

  // S type             offset   rs2   rs1  000  imm
  def sd     = BitPat("b???????_?????_?????_011_?????_0100011") // M[x[rs1]+sext(offset)=x[rs2][63:0]
}

object ISA extends RV64I {

}
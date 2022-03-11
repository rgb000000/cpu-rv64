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

  def nop    = BitPat("b000000000000_00000_000_00000_0010011") // x[0] = x[0] + 0
  // I type             imm           rs1  000  rd
  def jalr   = BitPat("b????????????_?????_000_?????_1100111") // t=pc+4; pc=(x[rs1]+sext(offset))&~1; x[rd]=t
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
  def slli   = BitPat("b000000_??????_?????_001_?????_0010011") // x[rd] = x[rs1] ≪ shamt
  def srli   = BitPat("b000000_??????_?????_101_?????_0010011") // x[rd] = (x[rs1] ≫_𝑢 shamt)
  def srai   = BitPat("b0100000?????_?????_101_?????_0010011") // x[rd] = (x[rs1] ≫_𝑠 shamt)
  def fence  = BitPat("b0000_????_????_00000_000_00000_0001111") // Fence(pred, succ)
  def fence_i= BitPat("b0000_0000_0000_00000_001_00000_0001111") // Fence(Store, Fetch)

  // U type                     imm           rd
  def lui    = BitPat("b????????????????????_?????_0110111") // x[rd] = sext(immediate[31:12] << 12)
  def auipc  = BitPat("b????????????????????_?????_0010111") // x[rd] = pc + sext(immediate[31:12] << 12)

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

trait RV32M {
  def mul    = BitPat("b0000001??????????000?????0110011")
  def mulh   = BitPat("b0000001??????????001?????0110011")
  def mulhsu = BitPat("b0000001??????????010?????0110011")
  def mulhu  = BitPat("b0000001??????????011?????0110011")
  def div    = BitPat("b0000001??????????100?????0110011")
  def divu   = BitPat("b0000001??????????101?????0110011")
  def rem    = BitPat("b0000001??????????110?????0110011")
  def remu   = BitPat("b0000001??????????111?????0110011")
}

trait RV64M extends RV32M {
  def mulw   = BitPat("b0000001??????????000?????0111011")
  def divw   = BitPat("b0000001??????????100?????0111011")
  def divuw  = BitPat("b0000001??????????101?????0111011")
  def remw   = BitPat("b0000001??????????110?????0111011")
  def remuw  = BitPat("b0000001??????????111?????0111011")
}

trait RVSystem {
  // privilege
  def mret   = BitPat("b001100000010_00000_000_00000_1110011")
  def sret   = BitPat("b000100000010_00000_000_00000_1110011")
  def ecall  = BitPat("b000000000000_00000_000_00000_1110011") // RaiseException(EnvironmentCall)
  def ebreak = BitPat("b000000000001_00000_000_00000_1110011") // RaiseException(Breakpoint)

  //                       csr      rs1/zimm    rd
  def csrrw  = BitPat("b????????????_?????_001_?????_1110011") // t = CSRs[csr]; CSRs[csr] = x[rs1]; x[rd] = t
  def csrrs  = BitPat("b????????????_?????_010_?????_1110011") // t = CSRs[csr]; CSRs[csr] = t | x[rs1]; x[rd] = t
  def csrrc  = BitPat("b????????????_?????_011_?????_1110011") // t = CSRs[csr]; CSRs[csr] = t &~x[rs1]; x[rd] = t
  def csrrwi = BitPat("b????????????_?????_101_?????_1110011") // x[rd] = CSRs[csr]; CSRs[csr] = zimm
  def csrrsi = BitPat("b????????????_?????_110_?????_1110011") // t = CSRs[csr]; CSRs[csr] = t | zimm; x[rd] = t
  def csrrci = BitPat("b????????????_?????_111_?????_1110011") // t = CSRs[csr]; CSRs[csr] = t &~zimm; x[rd] = t
  def wfi    = BitPat("b000100000101_00000_000_00000_1110011") // wait for interrupt
}

trait Custom {
//  def trap   = BitPat("b000000000000_00000_000_00000_1101011") // 6b  trap
//  def putch  = BitPat("b000000000000_00000_000_00000_1111011") // 7b  putch

  //                                            xd xs1 xs2
  //                            funct   rs2   rs1  000  rd    opcode
  // custom-0
  def roccw_rs1_rs2 = BitPat("b00?????_?????_?????_011_?????_0001011") // cmd          acc[rs1] = rs2
  def roccr_rd_rs1  = BitPat("b00?????_?????_?????_110_?????_0001011") // cmd + resp   cpu[rd] = acc[rs1]

  def rocc_mvin     = BitPat("b1000000_?????_?????_011_?????_0001011") // dcache数据move到spad中 spad[rs1] = mem[rs2的值] len固定是16
  def rocc_mvout    = BitPat("b1000001_?????_?????_011_?????_0001011") // spad数据move到dcache中 mem[rs2的值] = spad[rs1] len固定是16
  def gemm_n        = BitPat("b1000010_00000_?????_010_00000_0001011") // gemm_0 1234   gemm_1 5678  由rd最低bit定义n
}

object ISA extends RV64I with RVSystem with Custom with RV64M {

}

// generate by parse-opcode
object Causes {
  val misaligned_fetch = 0x0
  val fetch_access = 0x1
  val illegal_instruction = 0x2
  val breakpoint = 0x3
  val misaligned_load = 0x4
  val load_access = 0x5
  val misaligned_store = 0x6
  val store_access = 0x7
  val user_ecall = 0x8
  val supervisor_ecall = 0x9
  val virtual_supervisor_ecall = 0xa
  val machine_ecall = 0xb
  val fetch_page_fault = 0xc
  val load_page_fault = 0xd
  val store_page_fault = 0xf
  val fetch_guest_page_fault = 0x14
  val load_guest_page_fault = 0x15
  val virtual_instruction = 0x16
  val store_guest_page_fault = 0x17
  val all = {
    val res = collection.mutable.ArrayBuffer[Int]()
    res += misaligned_fetch
    res += fetch_access
    res += illegal_instruction
    res += breakpoint
    res += misaligned_load
    res += load_access
    res += misaligned_store
    res += store_access
    res += user_ecall
    res += supervisor_ecall
    res += virtual_supervisor_ecall
    res += machine_ecall
    res += fetch_page_fault
    res += load_page_fault
    res += store_page_fault
    res += fetch_guest_page_fault
    res += load_guest_page_fault
    res += virtual_instruction
    res += store_guest_page_fault
    res.toArray
  }
}
object CSRs {
  val fflags = 0x1
  val frm = 0x2
  val fcsr = 0x3
  val vstart = 0x8
  val vxsat = 0x9
  val vxrm = 0xa
  val vcsr = 0xf
  val cycle = 0xc00
  val time = 0xc01
  val instret = 0xc02
  val hpmcounter3 = 0xc03
  val hpmcounter4 = 0xc04
  val hpmcounter5 = 0xc05
  val hpmcounter6 = 0xc06
  val hpmcounter7 = 0xc07
  val hpmcounter8 = 0xc08
  val hpmcounter9 = 0xc09
  val hpmcounter10 = 0xc0a
  val hpmcounter11 = 0xc0b
  val hpmcounter12 = 0xc0c
  val hpmcounter13 = 0xc0d
  val hpmcounter14 = 0xc0e
  val hpmcounter15 = 0xc0f
  val hpmcounter16 = 0xc10
  val hpmcounter17 = 0xc11
  val hpmcounter18 = 0xc12
  val hpmcounter19 = 0xc13
  val hpmcounter20 = 0xc14
  val hpmcounter21 = 0xc15
  val hpmcounter22 = 0xc16
  val hpmcounter23 = 0xc17
  val hpmcounter24 = 0xc18
  val hpmcounter25 = 0xc19
  val hpmcounter26 = 0xc1a
  val hpmcounter27 = 0xc1b
  val hpmcounter28 = 0xc1c
  val hpmcounter29 = 0xc1d
  val hpmcounter30 = 0xc1e
  val hpmcounter31 = 0xc1f
  val vl = 0xc20
  val vtype = 0xc21
  val vlenb = 0xc22
  val sstatus = 0x100
  val sedeleg = 0x102
  val sideleg = 0x103
  val sie = 0x104
  val stvec = 0x105
  val scounteren = 0x106
  val sscratch = 0x140
  val sepc = 0x141
  val scause = 0x142
  val stval = 0x143
  val sip = 0x144
  val satp = 0x180
  val vsstatus = 0x200
  val vsie = 0x204
  val vstvec = 0x205
  val vsscratch = 0x240
  val vsepc = 0x241
  val vscause = 0x242
  val vstval = 0x243
  val vsip = 0x244
  val vsatp = 0x280
  val hstatus = 0x600
  val hedeleg = 0x602
  val hideleg = 0x603
  val hie = 0x604
  val htimedelta = 0x605
  val hcounteren = 0x606
  val hgeie = 0x607
  val htval = 0x643
  val hip = 0x644
  val hvip = 0x645
  val htinst = 0x64a
  val hgatp = 0x680
  val hgeip = 0xe12
  val utvt = 0x7
  val unxti = 0x45
  val uintstatus = 0x46
  val uscratchcsw = 0x48
  val uscratchcswl = 0x49
  val stvt = 0x107
  val snxti = 0x145
  val sintstatus = 0x146
  val sscratchcsw = 0x148
  val sscratchcswl = 0x149
  val mtvt = 0x307
  val mnxti = 0x345
  val mintstatus = 0x346
  val mscratchcsw = 0x348
  val mscratchcswl = 0x349
  val mstatus = 0x300
  val misa = 0x301
  val medeleg = 0x302
  val mideleg = 0x303
  val mie = 0x304
  val mtvec = 0x305
  val mcounteren = 0x306
  val mcountinhibit = 0x320
  val mscratch = 0x340
  val mepc = 0x341
  val mcause = 0x342
  val mtval = 0x343
  val mip = 0x344
  val mtinst = 0x34a
  val mtval2 = 0x34b
  val pmpcfg0 = 0x3a0
  val pmpcfg1 = 0x3a1
  val pmpcfg2 = 0x3a2
  val pmpcfg3 = 0x3a3
  val pmpaddr0 = 0x3b0
  val pmpaddr1 = 0x3b1
  val pmpaddr2 = 0x3b2
  val pmpaddr3 = 0x3b3
  val pmpaddr4 = 0x3b4
  val pmpaddr5 = 0x3b5
  val pmpaddr6 = 0x3b6
  val pmpaddr7 = 0x3b7
  val pmpaddr8 = 0x3b8
  val pmpaddr9 = 0x3b9
  val pmpaddr10 = 0x3ba
  val pmpaddr11 = 0x3bb
  val pmpaddr12 = 0x3bc
  val pmpaddr13 = 0x3bd
  val pmpaddr14 = 0x3be
  val pmpaddr15 = 0x3bf
  val tselect = 0x7a0
  val tdata1 = 0x7a1
  val tdata2 = 0x7a2
  val tdata3 = 0x7a3
  val tinfo = 0x7a4
  val tcontrol = 0x7a5
  val mcontext = 0x7a8
  val scontext = 0x7aa
  val dcsr = 0x7b0
  val dpc = 0x7b1
  val dscratch0 = 0x7b2
  val dscratch1 = 0x7b3
  val mcycle = 0xb00
  val minstret = 0xb02
  val mhpmcounter3 = 0xb03
  val mhpmcounter4 = 0xb04
  val mhpmcounter5 = 0xb05
  val mhpmcounter6 = 0xb06
  val mhpmcounter7 = 0xb07
  val mhpmcounter8 = 0xb08
  val mhpmcounter9 = 0xb09
  val mhpmcounter10 = 0xb0a
  val mhpmcounter11 = 0xb0b
  val mhpmcounter12 = 0xb0c
  val mhpmcounter13 = 0xb0d
  val mhpmcounter14 = 0xb0e
  val mhpmcounter15 = 0xb0f
  val mhpmcounter16 = 0xb10
  val mhpmcounter17 = 0xb11
  val mhpmcounter18 = 0xb12
  val mhpmcounter19 = 0xb13
  val mhpmcounter20 = 0xb14
  val mhpmcounter21 = 0xb15
  val mhpmcounter22 = 0xb16
  val mhpmcounter23 = 0xb17
  val mhpmcounter24 = 0xb18
  val mhpmcounter25 = 0xb19
  val mhpmcounter26 = 0xb1a
  val mhpmcounter27 = 0xb1b
  val mhpmcounter28 = 0xb1c
  val mhpmcounter29 = 0xb1d
  val mhpmcounter30 = 0xb1e
  val mhpmcounter31 = 0xb1f
  val mhpmevent3 = 0x323
  val mhpmevent4 = 0x324
  val mhpmevent5 = 0x325
  val mhpmevent6 = 0x326
  val mhpmevent7 = 0x327
  val mhpmevent8 = 0x328
  val mhpmevent9 = 0x329
  val mhpmevent10 = 0x32a
  val mhpmevent11 = 0x32b
  val mhpmevent12 = 0x32c
  val mhpmevent13 = 0x32d
  val mhpmevent14 = 0x32e
  val mhpmevent15 = 0x32f
  val mhpmevent16 = 0x330
  val mhpmevent17 = 0x331
  val mhpmevent18 = 0x332
  val mhpmevent19 = 0x333
  val mhpmevent20 = 0x334
  val mhpmevent21 = 0x335
  val mhpmevent22 = 0x336
  val mhpmevent23 = 0x337
  val mhpmevent24 = 0x338
  val mhpmevent25 = 0x339
  val mhpmevent26 = 0x33a
  val mhpmevent27 = 0x33b
  val mhpmevent28 = 0x33c
  val mhpmevent29 = 0x33d
  val mhpmevent30 = 0x33e
  val mhpmevent31 = 0x33f
  val mvendorid = 0xf11
  val marchid = 0xf12
  val mimpid = 0xf13
  val mhartid = 0xf14
  val mentropy = 0xf15
  val mnoise = 0x7a9
  val htimedeltah = 0x615
  val cycleh = 0xc80
  val timeh = 0xc81
  val instreth = 0xc82
  val hpmcounter3h = 0xc83
  val hpmcounter4h = 0xc84
  val hpmcounter5h = 0xc85
  val hpmcounter6h = 0xc86
  val hpmcounter7h = 0xc87
  val hpmcounter8h = 0xc88
  val hpmcounter9h = 0xc89
  val hpmcounter10h = 0xc8a
  val hpmcounter11h = 0xc8b
  val hpmcounter12h = 0xc8c
  val hpmcounter13h = 0xc8d
  val hpmcounter14h = 0xc8e
  val hpmcounter15h = 0xc8f
  val hpmcounter16h = 0xc90
  val hpmcounter17h = 0xc91
  val hpmcounter18h = 0xc92
  val hpmcounter19h = 0xc93
  val hpmcounter20h = 0xc94
  val hpmcounter21h = 0xc95
  val hpmcounter22h = 0xc96
  val hpmcounter23h = 0xc97
  val hpmcounter24h = 0xc98
  val hpmcounter25h = 0xc99
  val hpmcounter26h = 0xc9a
  val hpmcounter27h = 0xc9b
  val hpmcounter28h = 0xc9c
  val hpmcounter29h = 0xc9d
  val hpmcounter30h = 0xc9e
  val hpmcounter31h = 0xc9f
  val mstatush = 0x310
  val mcycleh = 0xb80
  val minstreth = 0xb82
  val mhpmcounter3h = 0xb83
  val mhpmcounter4h = 0xb84
  val mhpmcounter5h = 0xb85
  val mhpmcounter6h = 0xb86
  val mhpmcounter7h = 0xb87
  val mhpmcounter8h = 0xb88
  val mhpmcounter9h = 0xb89
  val mhpmcounter10h = 0xb8a
  val mhpmcounter11h = 0xb8b
  val mhpmcounter12h = 0xb8c
  val mhpmcounter13h = 0xb8d
  val mhpmcounter14h = 0xb8e
  val mhpmcounter15h = 0xb8f
  val mhpmcounter16h = 0xb90
  val mhpmcounter17h = 0xb91
  val mhpmcounter18h = 0xb92
  val mhpmcounter19h = 0xb93
  val mhpmcounter20h = 0xb94
  val mhpmcounter21h = 0xb95
  val mhpmcounter22h = 0xb96
  val mhpmcounter23h = 0xb97
  val mhpmcounter24h = 0xb98
  val mhpmcounter25h = 0xb99
  val mhpmcounter26h = 0xb9a
  val mhpmcounter27h = 0xb9b
  val mhpmcounter28h = 0xb9c
  val mhpmcounter29h = 0xb9d
  val mhpmcounter30h = 0xb9e
  val mhpmcounter31h = 0xb9f
  val all = {
    val res = collection.mutable.ArrayBuffer[Int]()
    res += fflags
    res += frm
    res += fcsr
    res += vstart
    res += vxsat
    res += vxrm
    res += vcsr
    res += cycle
    res += time
    res += instret
    res += hpmcounter3
    res += hpmcounter4
    res += hpmcounter5
    res += hpmcounter6
    res += hpmcounter7
    res += hpmcounter8
    res += hpmcounter9
    res += hpmcounter10
    res += hpmcounter11
    res += hpmcounter12
    res += hpmcounter13
    res += hpmcounter14
    res += hpmcounter15
    res += hpmcounter16
    res += hpmcounter17
    res += hpmcounter18
    res += hpmcounter19
    res += hpmcounter20
    res += hpmcounter21
    res += hpmcounter22
    res += hpmcounter23
    res += hpmcounter24
    res += hpmcounter25
    res += hpmcounter26
    res += hpmcounter27
    res += hpmcounter28
    res += hpmcounter29
    res += hpmcounter30
    res += hpmcounter31
    res += vl
    res += vtype
    res += vlenb
    res += sstatus
    res += sedeleg
    res += sideleg
    res += sie
    res += stvec
    res += scounteren
    res += sscratch
    res += sepc
    res += scause
    res += stval
    res += sip
    res += satp
    res += vsstatus
    res += vsie
    res += vstvec
    res += vsscratch
    res += vsepc
    res += vscause
    res += vstval
    res += vsip
    res += vsatp
    res += hstatus
    res += hedeleg
    res += hideleg
    res += hie
    res += htimedelta
    res += hcounteren
    res += hgeie
    res += htval
    res += hip
    res += hvip
    res += htinst
    res += hgatp
    res += hgeip
    res += utvt
    res += unxti
    res += uintstatus
    res += uscratchcsw
    res += uscratchcswl
    res += stvt
    res += snxti
    res += sintstatus
    res += sscratchcsw
    res += sscratchcswl
    res += mtvt
    res += mnxti
    res += mintstatus
    res += mscratchcsw
    res += mscratchcswl
    res += mstatus
    res += misa
    res += medeleg
    res += mideleg
    res += mie
    res += mtvec
    res += mcounteren
    res += mcountinhibit
    res += mscratch
    res += mepc
    res += mcause
    res += mtval
    res += mip
    res += mtinst
    res += mtval2
    res += pmpcfg0
    res += pmpcfg1
    res += pmpcfg2
    res += pmpcfg3
    res += pmpaddr0
    res += pmpaddr1
    res += pmpaddr2
    res += pmpaddr3
    res += pmpaddr4
    res += pmpaddr5
    res += pmpaddr6
    res += pmpaddr7
    res += pmpaddr8
    res += pmpaddr9
    res += pmpaddr10
    res += pmpaddr11
    res += pmpaddr12
    res += pmpaddr13
    res += pmpaddr14
    res += pmpaddr15
    res += tselect
    res += tdata1
    res += tdata2
    res += tdata3
    res += tinfo
    res += tcontrol
    res += mcontext
    res += scontext
    res += dcsr
    res += dpc
    res += dscratch0
    res += dscratch1
    res += mcycle
    res += minstret
    res += mhpmcounter3
    res += mhpmcounter4
    res += mhpmcounter5
    res += mhpmcounter6
    res += mhpmcounter7
    res += mhpmcounter8
    res += mhpmcounter9
    res += mhpmcounter10
    res += mhpmcounter11
    res += mhpmcounter12
    res += mhpmcounter13
    res += mhpmcounter14
    res += mhpmcounter15
    res += mhpmcounter16
    res += mhpmcounter17
    res += mhpmcounter18
    res += mhpmcounter19
    res += mhpmcounter20
    res += mhpmcounter21
    res += mhpmcounter22
    res += mhpmcounter23
    res += mhpmcounter24
    res += mhpmcounter25
    res += mhpmcounter26
    res += mhpmcounter27
    res += mhpmcounter28
    res += mhpmcounter29
    res += mhpmcounter30
    res += mhpmcounter31
    res += mhpmevent3
    res += mhpmevent4
    res += mhpmevent5
    res += mhpmevent6
    res += mhpmevent7
    res += mhpmevent8
    res += mhpmevent9
    res += mhpmevent10
    res += mhpmevent11
    res += mhpmevent12
    res += mhpmevent13
    res += mhpmevent14
    res += mhpmevent15
    res += mhpmevent16
    res += mhpmevent17
    res += mhpmevent18
    res += mhpmevent19
    res += mhpmevent20
    res += mhpmevent21
    res += mhpmevent22
    res += mhpmevent23
    res += mhpmevent24
    res += mhpmevent25
    res += mhpmevent26
    res += mhpmevent27
    res += mhpmevent28
    res += mhpmevent29
    res += mhpmevent30
    res += mhpmevent31
    res += mvendorid
    res += marchid
    res += mimpid
    res += mhartid
    res += mentropy
    res += mnoise
    res.toArray
  }
  val all32 = {
    val res = collection.mutable.ArrayBuffer(all:_*)
    res += htimedeltah
    res += cycleh
    res += timeh
    res += instreth
    res += hpmcounter3h
    res += hpmcounter4h
    res += hpmcounter5h
    res += hpmcounter6h
    res += hpmcounter7h
    res += hpmcounter8h
    res += hpmcounter9h
    res += hpmcounter10h
    res += hpmcounter11h
    res += hpmcounter12h
    res += hpmcounter13h
    res += hpmcounter14h
    res += hpmcounter15h
    res += hpmcounter16h
    res += hpmcounter17h
    res += hpmcounter18h
    res += hpmcounter19h
    res += hpmcounter20h
    res += hpmcounter21h
    res += hpmcounter22h
    res += hpmcounter23h
    res += hpmcounter24h
    res += hpmcounter25h
    res += hpmcounter26h
    res += hpmcounter27h
    res += hpmcounter28h
    res += hpmcounter29h
    res += hpmcounter30h
    res += hpmcounter31h
    res += mstatush
    res += mcycleh
    res += minstreth
    res += mhpmcounter3h
    res += mhpmcounter4h
    res += mhpmcounter5h
    res += mhpmcounter6h
    res += mhpmcounter7h
    res += mhpmcounter8h
    res += mhpmcounter9h
    res += mhpmcounter10h
    res += mhpmcounter11h
    res += mhpmcounter12h
    res += mhpmcounter13h
    res += mhpmcounter14h
    res += mhpmcounter15h
    res += mhpmcounter16h
    res += mhpmcounter17h
    res += mhpmcounter18h
    res += mhpmcounter19h
    res += mhpmcounter20h
    res += mhpmcounter21h
    res += mhpmcounter22h
    res += mhpmcounter23h
    res += mhpmcounter24h
    res += mhpmcounter25h
    res += mhpmcounter26h
    res += mhpmcounter27h
    res += mhpmcounter28h
    res += mhpmcounter29h
    res += mhpmcounter30h
    res += mhpmcounter31h
    res.toArray
  }
}

package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import chisel3.util.experimental.BoringUtils
import difftest.{DifftestArchEvent, DifftestCSRState}

object CSR {
  val N = 0.U(3.W) // None
  val W = 1.U(3.W) // Write
  val S = 2.U(3.W) // Set
  val C = 3.U(3.W) // Clear
  val P = 4.U(3.W) // Priviledge

  // Supports machine & user modes
  val PRV_U = 0x0.U(2.W)
  val PRV_M = 0x3.U(2.W)
}

class MStatus (implicit p: Parameters) extends Bundle{
  val prv = UInt(2.W) // not included in mstatus

  val sd    = Bool()        // The  SD  bit  is  read-only  and  is  set  when  either  the  FS  or  XS  bits  encode  a  Dirty  state  (i.e.,SD=((FS==11) OR (XS==11))).  T
  val ZERO0 = UInt((p(XLen)-37).W)
  val sxl   = UInt(2.W)     //
  val uxl   = UInt(2.W)     // The UXL field controls the value of XLEN for U-mode, termedUXLEN, which may differ from thevalue of XLEN for S-mode, termedSXLEN.
  val ZERO1 = UInt(9.W)
  val tsr   = Bool()        // The TSR (Trap SRET) bit supports intercepting the supervisor exception return instruction, SRET.
  val tw    = Bool()        // The TW (Timeout Wait) bit supports intercepting the WFI instruction (see Section 3.2.3).
  val tvm   = Bool()        // The  TVM  (Trap  Virtual  Memory)  bit  supports  intercepting  supervisor  virtual-memory  man-agement  operations.
  val mxr   = Bool()        // The MXR (Make eXecutable Readable) bit modifies the privilege with which loads access virtualmemory.
  val sum   = Bool()        // The SUM (permit Supervisor User Memory access) bit modifies the privilege with which S-modeloads and stores access virtual memory.
  val mprv  = Bool()        // The MPRV (Modify PRiVilege) bit modifies the privilege level at which loads and stores execute inall privilege modes.
  val xs    = UInt(2.W)     // the XS field encodes the status of additional user-mode extensions and associated state.
  val fs    = UInt(2.W)     // The FS field encodes the status of the floating-point unit, includingthe CSRfcsrand floating-point data registersf0–f31
  val mpp   = UInt(2.W)     // xPP
  val ZERO2 = UInt(2.W)
  val spp   = UInt(1.W)     // The xPP fields can only hold privilege modes up to x, so MPP is two bits wide, SPP is one bit wide, and UPP is implicitly zero.

  val mpie  = Bool()        // xPIE holds the value of the interrupt-enable bit active prior to the trap
  val ZERO3 = UInt(1.W)
  val spie  = Bool()        // whether supervisor interrupts were enabled prior to trapping into supervisor mode
  val upie  = Bool()        // whether user-level interruptswere enabled prior to taking a user-level trap

  val mie   = Bool()        // interrupt-enable
  val ZERO4 = UInt(1.W)
  val sie   = Bool()        // interrupt-enable
  val uie   = Bool()        // interrupt-enable
}

class MIE (implicit p: Parameters) extends Bundle {
  val ZERO0 = UInt((p(XLen) - 12).W)
  val meie  = Bool()      // external interrupt enable
  val ZERO1 = UInt(1.W)
  val seie  = Bool()      // external interrupt enabled
  val ueie  = Bool()      // external interrupt enabled
  val mtie  = Bool()      // time interrupt enable
  val ZERO2 = UInt(1.W)
  val stie  = Bool()      // time interrupt enable
  val utie  = Bool()      // time interrupt enable
  val msie  = Bool()      // software interrupt enable
  val ZERO3 = UInt(1.W)
  val ssie  = Bool()      // software interrupt enable
  val usie  = Bool()      // software interrupt enable
}

class MIP (implicit p: Parameters) extends Bundle {
  val ZERO0 = UInt((p(XLen) - 12).W)
  val meip  = Bool()      // externel interrupt pending
  val ZERO1 = UInt(1.W)
  val seip  = Bool()      // externel interrupt pending
  val ueip  = Bool()      // externel interrupt pending
  val mtip  = Bool()      // time interrupt pending
  val ZERO2 = UInt(1.W)
  val stip  = Bool()      // time interrupt pending
  val utip  = Bool()      // time interrupt pending
  val msip  = Bool()      // software interrupt pending
  val ZERO3 = UInt(1.W)
  val ssip  = Bool()      // software interrupt pending
  val usip  = Bool()      // software interrupt pending
}


class CSRIO(implicit p: Parameters) extends Bundle {
  val stall = Input(Bool())
  val cmd = Input(UInt(3.W))
  val in  = Input(UInt(p(XLen).W))
  val out = Output(UInt(p(XLen).W))

  val ctrl_signal = Input(new Bundle{
    val valid   = Bool()
    val pc      = UInt(p(XLen).W)
    val addr    = UInt(p(XLen).W)
    val inst    = UInt(p(XLen).W)
    val illegal = Bool()
    val st_type = UInt(3.W)
    val ld_type = UInt(3.W)
  })

  val pc_check = Input(Bool())
  val expt = Output(Bool())
  val exvec = Output(UInt(p(XLen).W))
  val epc = Output(UInt(p(XLen).W))

  val interrupt = Input(new Bundle {
    val time     = Bool()
    val soft     = Bool()
    val external = Bool()
  })
}

class CSR (implicit p: Parameters) extends Module {
  val io = IO(new CSRIO)

  val csr_addr = Wire(UInt(12.W))
  csr_addr := io.ctrl_signal.inst(31, 20).asUInt()

  val mhardid = 0.U
  val mscratch = Reg(UInt(64.W))

  val mtvec   = RegInit(p(PCEVec).U(p(XLen).W))
  val mepc = Reg(UInt(p(XLen).W))
  val mcause = RegInit(0.U(p(XLen).W))
  val mcycle = RegInit(0.U(p(XLen).W))

  mcycle := mcycle + 1.U

  val reset_mstatus = WireInit(0.U.asTypeOf(new MStatus))
  reset_mstatus.mpp := CSR.PRV_M
  reset_mstatus.prv := CSR.PRV_M
  val mstatus = RegInit(reset_mstatus)

  val mie = RegInit(0.U.asTypeOf(new MIE))
  val mip = WireInit(0.U.asTypeOf(new MIP))
  mip.mtip := io.interrupt.time

  dontTouch(mstatus)
  dontTouch(mie)
  dontTouch(mip)

  val mbadaddr = RegInit(0.U(p(XLen).W))


  val csrFile = Seq(
    BitPat(CSRs.mstatus.U(12.W))  -> mstatus.asUInt(),
    BitPat(CSRs.mtvec.U(12.W))    -> mtvec,
    BitPat(CSRs.mepc.U(12.W))     -> mepc,
    BitPat(CSRs.mcause.U(12.W))   -> mcause,
    BitPat(CSRs.mip.U(12.W))      -> mip.asUInt(),
    BitPat(CSRs.mie.U(12.W))      -> mie.asUInt(),
    BitPat(CSRs.mcycle.U(12.W))   -> mcycle,
    BitPat(CSRs.mhartid.U(12.W))  -> mhardid,
    BitPat(CSRs.mscratch.U(12.W)) -> mscratch
  )

  io.out := Lookup(csr_addr, 0.U, csrFile).asUInt()

  val privValid = csr_addr(9, 8) <= mstatus.prv
  val privInst  = io.cmd === CSR.P      // is privilege inst   wft mret sret
  val isEcall   = privInst && (csr_addr(1, 0).asUInt() === "b00".U) && (csr_addr(9, 8).asUInt() === "b00".U) // is ecall  000000000000
  val isEbreak  = privInst && (csr_addr(1, 0).asUInt() === "b01".U) && (csr_addr(9, 8).asUInt() === "b00".U) // is ebreak 000000000001
  val isMret    = privInst && (csr_addr(1, 0).asUInt() === "b10".U) && (csr_addr(9, 8).asUInt() === "b11".U) // is mret   001100000010
  val isSret    = privInst && (csr_addr(1, 0).asUInt() === "b10".U) && (csr_addr(9, 8).asUInt() === "b01".U) // is sret   000100000010
  val csrValid  = csrFile map (_._1 === csr_addr) reduce (_ || _)   // is csr address valid?
  val csrRO     = csr_addr(11, 10).andR || csr_addr === CSRs.mtvec.U || csr_addr === CSRs.medeleg.U   // read only? csr_addr(11, 10) == 2'b11
  val wen       = (io.cmd === CSR.W) | (io.cmd === CSR.S) | (io.cmd === CSR.C)     // wen
  val wdata     = MuxLookup(io.cmd, 0.U, Seq(
    CSR.W -> io.in,
    CSR.S -> (io.out | io.in),
    CSR.C -> (io.out & (~io.in).asUInt())
  ))

  val time_interrupt_enable = WireInit(mie.mtie & mstatus.mie)
  BoringUtils.addSource(time_interrupt_enable, "time_interrupt_enable")
  val time_interrupt = mip.mtip & time_interrupt_enable

  val iaddrInvalid = io.pc_check && io.ctrl_signal.addr(1)
  val laddrInvalid = MuxLookup(io.ctrl_signal.ld_type, false.B, Seq(
    Control.LD_LW -> io.ctrl_signal.addr(1, 0).orR, Control.LD_LH -> io.ctrl_signal.addr(0), Control.LD_LHU -> io.ctrl_signal.addr(0)))
  val saddrInvalid = MuxLookup(io.ctrl_signal.st_type, false.B, Seq(
    Control.ST_SW -> io.ctrl_signal.addr(1, 0).orR, Control.ST_SH -> io.ctrl_signal.addr(0)))
  io.expt := (io.ctrl_signal.illegal || iaddrInvalid || laddrInvalid || saddrInvalid ||
    (io.cmd(1, 0).orR && (!csrValid || !privValid) && false.B) || (wen && csrRO && false.B) ||
    (privInst && !privValid && false.B) || isEcall || isEbreak || time_interrupt) & io.ctrl_signal.valid
  io.exvec := mtvec
  io.epc  := mepc

  when(!io.stall & io.ctrl_signal.valid) {
    when(io.expt) {
      mepc   := io.ctrl_signal.pc >> 2 << 2
      mcause := Mux(time_interrupt,               (1.U << (p(XLen)-1).U).asUInt() | 7.U,
                Mux(iaddrInvalid,                 Causes.misaligned_fetch.U,
                Mux(laddrInvalid,                 Causes.misaligned_load.U,
                Mux(saddrInvalid,                 Causes.misaligned_store.U,
                Mux(isEcall,                      Causes.user_ecall.U + mstatus.prv,
                Mux(isEbreak,                     Causes.breakpoint.U,
                                                  Causes.illegal_instruction.U))))))
      mstatus.mpie := mstatus.mie
      mstatus.mie := false.B
      when(iaddrInvalid || laddrInvalid || saddrInvalid) { mbadaddr := io.ctrl_signal.addr }
    }
    .elsewhen(isMret) {
      mstatus.mie := mstatus.mpie
      mstatus.mpie := true.B
    }.elsewhen(isSret){
    mstatus.mie := mstatus.mpie
    mstatus.mpie := true.B
    }
    .elsewhen(wen) {
      when(csr_addr === CSRs.mstatus.U) {
        val tmp_mstatus = wdata.asTypeOf(new MStatus)
        mstatus.mie := tmp_mstatus.mie
        mstatus.mpie := tmp_mstatus.mpie
        mstatus.xs := tmp_mstatus.xs
        mstatus.fs := tmp_mstatus.fs
        mstatus.mpp := tmp_mstatus.mpp
        mstatus.sd := tmp_mstatus.xs.andR() | tmp_mstatus.fs.andR()
      }
      .elsewhen(csr_addr === CSRs.mip.U) {
//        val tmp_mip = wdata.asTypeOf(new MIP)
//        mip.mtip := tmp_mip.mtip
//        mip.msip := tmp_mip.msip
      }
      .elsewhen(csr_addr === CSRs.mie.U) {
        val tmp_mie = wdata.asTypeOf(new MIE)
        mie.mtie := tmp_mie.mtie
        mie.msie := tmp_mie.msie
      }
      .elsewhen(csr_addr === CSRs.mepc.U) { mepc := wdata >> 2.U << 2.U }
      .elsewhen(csr_addr === CSRs.mcause.U) { mcause := wdata & (BigInt(1) << (p(XLen)-1) | 0xf).U }
      .elsewhen(csr_addr === CSRs.mtvec.U) { mtvec := wdata}
      .elsewhen(csr_addr === CSRs.mcycle.U){ mcycle := wdata}
      .elsewhen(csr_addr === CSRs.mscratch.U){ mscratch := wdata}
    }
  }

  if (p(Difftest)) {
    val sstatus_mask = ("b1" + "0"*(p(XLen) - 35) + "11" + "0"*12 + "1101111" + "0"*13).U(64.W)
    val sstatus = sstatus_mask & mstatus.asUInt()
    val dcsr = Module(new DifftestCSRState)
    dcsr.io.clock          := clock
    dcsr.io.coreid         := 0.U
    dcsr.io.priviledgeMode := RegNext(Mux(!io.stall, mstatus.prv,       RegEnable(mstatus.prv, !io.stall)))      // RegNext(mstatus.prv, !io.stall)
    dcsr.io.mstatus        := RegNext(Mux(!io.stall, mstatus.asUInt(),  RegEnable(mstatus.asUInt(), !io.stall))) // RegNext(mstatus.asUInt(), !io.stall)
    dcsr.io.mcause         := RegNext(Mux(!io.stall, mcause,            RegEnable(mcause, !io.stall)))           // RegNext(mcause, !io.stall)
    dcsr.io.mepc           := RegNext(Mux(!io.stall, mepc,              RegEnable(mepc, !io.stall)))             // RegNext(mepc, !io.stall)
    dcsr.io.mip            := 0.U // RegNext(Mux(!io.stall, mip.asUInt(),      RegEnable(mip.asUInt(), !io.stall)))     // RegNext(mip.asUInt(), !io.stall)
    dcsr.io.mie            := RegNext(Mux(!io.stall, mie.asUInt(),      RegEnable(mie.asUInt(), !io.stall)))     // RegNext(mie.asUInt(), !io.stall)
    dcsr.io.mtvec          := RegNext(Mux(!io.stall, mtvec,             RegEnable(mtvec, !io.stall)))            // RegNext(mtvec, !io.stall)
    dcsr.io.sstatus        := RegNext(Mux(!io.stall, sstatus,           RegEnable(sstatus, !io.stall))) // 0.U // RegNext(0.U)
    dcsr.io.scause         := 0.U // RegNext(0.U)
    dcsr.io.sepc           := 0.U // RegNext(0.U)
    dcsr.io.satp           := 0.U // RegNext(0.U)
    dcsr.io.mscratch       := RegNext(Mux(!io.stall, mscratch,          RegEnable(mscratch, !io.stall)))
    dcsr.io.sscratch       := 0.U // RegNext(Mux(!io.stall, sstatus,           RegEnable(sstatus, !io.stall))) // 0.U // RegNext(0.U)
    dcsr.io.mideleg        := 0.U // RegNext(0.U)
    dcsr.io.medeleg        := 0.U // RegNext(0.U)
    dcsr.io.mtval          := 0.U // RegNext(0.U)
    dcsr.io.stval          := 0.U // RegNext(0.U)
    dcsr.io.stvec          := 0.U // RRegNextegNext(0.U)

    def change(value: UInt): UInt = {
      Mux(value =/= RegNext(value), value, 0.U)
    }

    val except_reg = RegEnable(io.expt, false.B, !io.stall)
    val time_interrupt_reg = RegEnable(time_interrupt, false.B, !io.stall)

    val dae = Module(new DifftestArchEvent)
    dae.io.clock := clock
    dae.io.coreid := 0.U
    dae.io.intrNO := RegNext(Mux(!io.stall, Mux(except_reg, Mux(time_interrupt_reg, mcause, 0.U), 0.U), 0.U))
    dae.io.cause := RegNext(Mux(!io.stall, Mux(except_reg, Mux(!time_interrupt_reg, mcause, 0.U), 0.U), 0.U))
    dae.io.exceptionPC := RegNext(Mux(!io.stall, RegEnable(io.ctrl_signal.pc, !io.stall), 0.U))
    dae.io.exceptionInst := RegNext(Mux(!io.stall, RegEnable(io.ctrl_signal.inst, !io.stall), 0.U))
  }

}

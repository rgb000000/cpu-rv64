package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import chisel3.util.experimental.BoringUtils
import cpu.CSR.{PRV_M, PRV_U}
import cpu.ooo.ExceptType
import difftest.{DifftestArchEvent, DifftestCSRState}

object CSR {
  val N = 0.U(3.W) // None
  val W = 1.U(3.W) // Write
  val S = 2.U(3.W) // Set
  val C = 3.U(3.W) // Clear
  val P = 4.U(3.W) // Priviledge

  // Supports machine & user modes
  val PRV_U = 0x0.U(2.W)
  val PRV_S = 0x1.U(2.W)
  val PRV_H = 0x2.U(2.W)
  val PRV_M = 0x3.U(2.W)
}

class MStatus (implicit val p: Parameters) extends Bundle{
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

class MIE (implicit val p: Parameters) extends Bundle {
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

class MIP (implicit val p: Parameters) extends Bundle {
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

class SATP (implicit val p: Parameters) extends Bundle {
  val mode = UInt(4.W)
  val asid = UInt(16.W)
  val ppn = UInt(44.W)
}

class CSRIO(implicit val p: Parameters) extends Bundle {
  val stall = Input(Bool())
  val cmd = Input(UInt(3.W))
  val in  = Input(UInt(p(XLen).W))
  val out = Output(UInt(p(XLen).W))

  val ctrl_signal = Input(new Bundle{
    val valid   = Bool()
    val pc      = UInt(p(XLen).W)
    val addr    = UInt(p(XLen).W)
    val inst    = UInt(32.W)
    val illegal = Bool()
    val st_type = UInt(3.W)
    val ld_type = UInt(3.W)
  })

  val pc_check = Input(Bool())
  val has_except = Input(UInt(2.W))
  val except_addr = Input(UInt(64.W))
  val expt = Output(Bool())
  val exvec = Output(UInt(p(XLen).W))
  val epc = Output(UInt(p(XLen).W))
  val w_satp = Output(Bool())  // write satp will flush pipeline
  val is_xret = Output(Bool())

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
  val mscratch = RegInit(0.U(64.W))

  val mtvec   = RegInit(p(PCEVec).U(p(XLen).W))
  val mepc    = RegInit(0.U(p(XLen).W))
  val mcause  = RegInit(0.U(p(XLen).W))
  val mcycle  = RegInit(0.U(p(XLen).W))
  val mtval   = RegInit(0.U(p(XLen).W))

  val stvec   = RegInit(0.U(p(XLen).W))
  val sepc    = RegInit(0.U(p(XLen).W))
  val scause  = RegInit(0.U(p(XLen).W))
  val stval   = RegInit(0.U(p(XLen).W))
  val satp    = RegInit(0.U.asTypeOf(new SATP))
  val sscratch = RegInit(0.U(64.W))

  val medeleg = RegInit(0.U(p(XLen).W))
  val mideleg = RegInit(0.U(p(XLen).W))


  mcycle := mcycle + 1.U

  val reset_mstatus = WireInit(0.U.asTypeOf(new MStatus))
  reset_mstatus.mpp := CSR.PRV_M
  reset_mstatus.prv := CSR.PRV_M
  val mstatus = RegInit(reset_mstatus)

  val mie = RegInit(0.U.asTypeOf(new MIE))
  val mip = WireInit(0.U.asTypeOf(new MIP))

  val ssip = RegInit(false.B)

//  dontTouch(mstatus)
//  dontTouch(mie)
//  dontTouch(mip)

  val mbadaddr = RegInit(0.U(p(XLen).W))

  // boring to tlb to judge vm_enable
  BoringUtils.addSource(mstatus.mprv, "mstatus_mprv")
  BoringUtils.addSource(mstatus.mpp, "mstatus_mpp")
  BoringUtils.addSource(mstatus.sum, "mstatus_sum")
  BoringUtils.addSource(mstatus.mxr, "mstatus_mxr")
  BoringUtils.addSource(mstatus.prv, "cpu_mode")
  BoringUtils.addSource(satp.mode, "satp_mode")
  BoringUtils.addSource(satp.ppn, "satp_ppn")
  BoringUtils.addSource(satp.asid, "satp_asid")

  val sstatus_mask = ("b1" + "0"*(p(XLen) - 35) + "11" + "0"*12 + "1101111" + "0"*4 + "100110011").U(64.W)

  // read csr
  val csrFile = Seq(
    BitPat(CSRs.mstatus.U(12.W))  -> mstatus.asUInt,
    BitPat(CSRs.mtvec.U(12.W))    -> mtvec,
    BitPat(CSRs.mepc.U(12.W))     -> mepc,
    BitPat(CSRs.mcause.U(12.W))   -> mcause,
    BitPat(CSRs.mip.U(12.W))      -> mip.asUInt,
    BitPat(CSRs.mie.U(12.W))      -> mie.asUInt,
    BitPat(CSRs.mcycle.U(12.W))   -> mcycle,
    BitPat(CSRs.mhartid.U(12.W))  -> mhardid,
    BitPat(CSRs.mscratch.U(12.W)) -> mscratch,
    BitPat(CSRs.medeleg.U(12.W))  -> medeleg,
    BitPat(CSRs.medeleg.U(12.W))  -> mideleg,
    BitPat(CSRs.mtval.U(12.W))    -> mtval,
    BitPat(CSRs.stval.U(12.W))    -> stval,
    BitPat(CSRs.stvec.U(12.W))    -> stvec,
    BitPat(CSRs.sepc.U(12.W))     -> sepc,
    BitPat(CSRs.scause.U(12.W))   -> scause,
    BitPat(CSRs.satp.U(12.W))     -> satp.asUInt,
    BitPat(CSRs.sie.U(12.W))      -> (mie.asUInt & 0x333.U),
    BitPat(CSRs.sip.U(12.W))      -> (mip.asUInt & 0x333.U),
    BitPat(CSRs.sstatus.U(12.W))  -> (mstatus.asUInt & sstatus_mask),
    BitPat(CSRs.sscratch.U(12.W)) -> sscratch,
  )
  io.out := Lookup(csr_addr, 0.U, csrFile).asUInt

  val privValid = csr_addr(9, 8) <= mstatus.prv
  val privInst  = io.cmd === CSR.P      // is privilege inst   wft mret sret
  val isEcall   = privInst && (csr_addr(1, 0).asUInt === "b00".U) && (csr_addr(9, 8).asUInt === "b00".U) // is ecall  000000000000
  val isEbreak  = privInst && (csr_addr(1, 0).asUInt === "b01".U) && (csr_addr(9, 8).asUInt === "b00".U) // is ebreak 000000000001
  val isMret    = privInst && (csr_addr(1, 0).asUInt === "b10".U) && (csr_addr(9, 8).asUInt === "b11".U) // is mret   001100000010
  val isSret    = privInst && (csr_addr(1, 0).asUInt === "b10".U) && (csr_addr(9, 8).asUInt === "b01".U) // is sret   000100000010
  val csrValid  = csrFile map (_._1 === csr_addr) reduce (_ || _)   // is csr address valid?
  val csrRO     = csr_addr(11, 10).andR || csr_addr === CSRs.mtvec.U || csr_addr === CSRs.medeleg.U   // read only? csr_addr(11, 10) == 2'b11
  val wen       = (io.cmd === CSR.W) | (io.cmd === CSR.S) | (io.cmd === CSR.C)     // wen
  val wdata     = MuxLookup(io.cmd, 0.U, Seq(
    CSR.W -> io.in,
    CSR.S -> (io.out | io.in),
    CSR.C -> (io.out & (~io.in).asUInt())
  ))

  val m_time_global_enable = Mux(!mideleg(7),
                                      ((mstatus.prv === CSR.PRV_M) & mstatus.mie) | (mstatus.prv < CSR.PRV_M),
                                      ((mstatus.prv === CSR.PRV_S) & mstatus.sie) | (mstatus.prv < CSR.PRV_S))
  val m_soft_global_enable = Mux(!mideleg(3),
                                      ((mstatus.prv === CSR.PRV_M) & mstatus.mie) | (mstatus.prv < CSR.PRV_M),
                                      ((mstatus.prv === CSR.PRV_S) & mstatus.sie) | (mstatus.prv < CSR.PRV_S))
  val m_ext_global_enable  = Mux(!mideleg(11),
                                      ((mstatus.prv === CSR.PRV_M) & mstatus.mie) | (mstatus.prv < CSR.PRV_M),
                                      ((mstatus.prv === CSR.PRV_S) & mstatus.sie) | (mstatus.prv < CSR.PRV_S))

  val s_time_global_enable = Mux(!(mideleg(5) & mstatus.prv < PRV_M),
                                      ((mstatus.prv === CSR.PRV_M) & mstatus.mie) | (mstatus.prv < CSR.PRV_M),
                                      ((mstatus.prv === CSR.PRV_S) & mstatus.sie) | (mstatus.prv < CSR.PRV_S))
  val s_soft_global_enable = Mux(!(mideleg(1) & mstatus.prv < PRV_M),
                                      ((mstatus.prv === CSR.PRV_M) & mstatus.mie) | (mstatus.prv < CSR.PRV_M),
                                      ((mstatus.prv === CSR.PRV_S) & mstatus.sie) | (mstatus.prv < CSR.PRV_S))
  val s_ext_global_enable  = Mux(!(mideleg(9) & mstatus.prv < PRV_M),
                                      ((mstatus.prv === CSR.PRV_M) & mstatus.mie) | (mstatus.prv < CSR.PRV_M),
                                      ((mstatus.prv === CSR.PRV_S) & mstatus.sie) | (mstatus.prv < CSR.PRV_S))

  val m_time_interrupt_enable = WireInit(mie.mtie & m_time_global_enable)
  val s_time_interrupt_enable = WireInit(mie.stie & s_time_global_enable)
  val m_soft_interrupt_enable = WireInit(mie.msie & m_soft_global_enable)
  val s_soft_interrupt_enable = WireInit(mie.ssie & s_soft_global_enable)
  val m_ext_interrupt_enable  = WireInit(mie.meie & m_ext_global_enable)
  val s_ext_interrupt_enable  = WireInit(mie.seie & s_ext_global_enable)

  val mark_time_interrupt = WireInit(m_time_interrupt_enable | s_time_interrupt_enable)
  val mark_soft_interrupt = WireInit(m_soft_interrupt_enable | s_soft_interrupt_enable)
  val mark_ext_interrupt  = WireInit(m_ext_interrupt_enable  | s_ext_interrupt_enable)
  BoringUtils.addSource(mark_time_interrupt, "mark_time_interrupt")
  BoringUtils.addSource(mark_soft_interrupt, "mark_soft_interrupt")
  BoringUtils.addSource(mark_ext_interrupt, "mark_ext_interrupt")

  mip.mtip := io.interrupt.time & m_time_interrupt_enable
  mip.msip := io.interrupt.soft
  mip.meip := io.interrupt.external
  mip.stip := false.B
  mip.ssip := ssip
  mip.seip := io.interrupt.external

  val m_time_interrupt     = mip.mtip & m_time_interrupt_enable
  val m_soft_interrupt     = mip.msip & m_soft_interrupt_enable
  val m_external_interrupt = mip.meip & m_ext_interrupt_enable
  val s_time_interrupt     = mip.stip & s_time_interrupt_enable
  val s_soft_interrupt     = mip.ssip & s_soft_interrupt_enable
  val s_external_interrupt = mip.seip & s_ext_interrupt_enable

  val interrupt = WireInit(Cat(Seq(m_time_interrupt, m_soft_interrupt, m_external_interrupt,
                                   s_time_interrupt, s_soft_interrupt, s_external_interrupt
  )))

  val iaddrInvalid = io.pc_check && io.ctrl_signal.addr(1)            // pc isvalid?
  val laddrInvalid = MuxLookup(io.ctrl_signal.ld_type, false.B, Seq(  // load isvalid?
    Control.LD_LW -> io.ctrl_signal.addr(1, 0).orR,
    Control.LD_LH -> io.ctrl_signal.addr(0),
    Control.LD_LHU -> io.ctrl_signal.addr(0)))
  val saddrInvalid = MuxLookup(io.ctrl_signal.st_type, false.B, Seq(  // store isvalid?
    Control.ST_SW -> io.ctrl_signal.addr(1, 0).orR,
    Control.ST_SH -> io.ctrl_signal.addr(0)))
  io.expt := (io.ctrl_signal.illegal
           || iaddrInvalid
           || laddrInvalid
           || saddrInvalid
           || (io.cmd(1, 0).orR && (!csrValid || !privValid) && false.B)
           || (wen && csrRO && false.B)
           || (privInst && !privValid && false.B)
           || isEcall
           || isEbreak
           || interrupt.orR
           || (io.has_except =/= ExceptType.NO)
    ) & io.ctrl_signal.valid


  when(io.expt & (io.has_except =/= ExceptType.NO) & !interrupt.orR){
    // 有异常 但不是中端，并且有异常
    when(mstatus.prv === PRV_M){
      mtval := io.except_addr
    }.otherwise{
      stval := io.except_addr
    }
  }

  val isInterrupe = interrupt.orR
  val isExcept = io.has_except =/= ExceptType.NO                                             // S   M
  val cause = Mux(m_external_interrupt,             (1.U << (p(XLen)-1).U).asUInt | 11.U, // MuxLookup(mstatus.prv, 11.U, Seq(CSR.PRV_S -> 9.U, CSR.PRV_U -> 8.U)),
              Mux(m_time_interrupt,                 (1.U << (p(XLen)-1).U).asUInt |  7.U, // MuxLookup(mstatus.prv,  7.U, Seq(CSR.PRV_S -> 5.U, CSR.PRV_U -> 4.U)),
              Mux(m_soft_interrupt,                 (1.U << (p(XLen)-1).U).asUInt |  3.U, // MuxLookup(mstatus.prv,  3.U, Seq(CSR.PRV_S -> 1.U, CSR.PRV_U -> 0.U)),
              Mux(s_external_interrupt,             (1.U << (p(XLen)-1).U).asUInt |  9.U, // MuxLookup(mstatus.prv, 11.U, Seq(CSR.PRV_S -> 9.U, CSR.PRV_U -> 8.U)),
              Mux(s_time_interrupt,                 (1.U << (p(XLen)-1).U).asUInt |  5.U, // MuxLookup(mstatus.prv,  7.U, Seq(CSR.PRV_S -> 5.U, CSR.PRV_U -> 4.U)),
              Mux(s_soft_interrupt,                 (1.U << (p(XLen)-1).U).asUInt |  1.U, // MuxLookup(mstatus.prv,  3.U, Seq(CSR.PRV_S -> 1.U, CSR.PRV_U -> 0.U)),
              Mux(iaddrInvalid,                     Causes.misaligned_fetch.U,
              Mux(laddrInvalid,                     Causes.misaligned_load.U,
              Mux(saddrInvalid,                     Causes.misaligned_store.U,
              Mux(isEcall,                          MuxLookup(mstatus.prv, Causes.machine_ecall.U, Seq(CSR.PRV_S -> Causes.supervisor_ecall.U, CSR.PRV_U->Causes.user_ecall.U)),
              Mux(isEbreak,                         Causes.breakpoint.U,
              Mux(io.has_except === ExceptType.IPF, Causes.fetch_page_fault.U,
              Mux(io.has_except === ExceptType.SPF, Causes.store_page_fault.U,
              Mux(io.has_except === ExceptType.LPF, Causes.load_page_fault.U,
                                                    Causes.illegal_instruction.U))))))))))))))

  val deleg = Mux(isInterrupe, mideleg, medeleg)
  val delegS = deleg(cause(3,0)).asBool & (mstatus.prv < PRV_M)

  io.w_satp := !io.stall & io.ctrl_signal.valid & wen & (csr_addr === CSRs.satp.U)
  io.is_xret := !io.stall & io.ctrl_signal.valid & (isMret | isSret)

  io.epc  := Mux(isMret, mepc, sepc)
  io.exvec := Mux(!delegS, mtvec, stvec)

  when(!io.stall & io.ctrl_signal.valid) {
    when(io.expt) {
      // 遇到非法指令就停止
      assert(!io.ctrl_signal.illegal)
      when(delegS){
        // trap S mode
        scause := cause
        sepc   := io.ctrl_signal.pc >> 2 << 2
        mstatus.spp := mstatus.prv
        mstatus.spie := mstatus.sie
        mstatus.sie := false.B
        mstatus.prv := CSR.PRV_S
      }.otherwise{
        // trap M mode
        mcause := cause
        mepc   := io.ctrl_signal.pc >> 2 << 2
        mstatus.mpp := mstatus.prv
        mstatus.mpie := mstatus.mie
        mstatus.mie := false.B
        mstatus.prv := PRV_M
        when(iaddrInvalid || laddrInvalid || saddrInvalid) { mbadaddr := io.ctrl_signal.addr }
      }
    }
    .elsewhen(isMret) {
      mstatus.mie := mstatus.mpie
      mstatus.mpie := true.B
      mstatus.mpp := PRV_U
      mstatus.prv := mstatus.mpp
    }.elsewhen(isSret){
      mstatus.sie := mstatus.spie
      mstatus.spie := true.B
      mstatus.spp := PRV_U
      mstatus.prv := mstatus.spp
    }
    // write csr
    .elsewhen(wen) {
      when(csr_addr === CSRs.mstatus.U) {
        val tmp_mstatus = wdata.asTypeOf(new MStatus)
        mstatus.uie  := tmp_mstatus.uie
        mstatus.sie  := tmp_mstatus.sie
        mstatus.mie  := tmp_mstatus.mie
        mstatus.mpie := tmp_mstatus.mpie
        mstatus.mpp  := tmp_mstatus.mpp
        mstatus.spp  := tmp_mstatus.spp
        mstatus.xs   := tmp_mstatus.xs
        mstatus.fs   := tmp_mstatus.fs
        mstatus.mprv := tmp_mstatus.mprv
        mstatus.sum  := tmp_mstatus.sum
        mstatus.mxr  := tmp_mstatus.mxr
        mstatus.tvm  := tmp_mstatus.tvm
        mstatus.tw   := tmp_mstatus.tw
        mstatus.tsr  := tmp_mstatus.tsr
        mstatus.uxl  := tmp_mstatus.uxl
        mstatus.sxl  := tmp_mstatus.sxl
        mstatus.sd   := tmp_mstatus.xs.andR() | tmp_mstatus.fs.andR()
        // FIXME: add more assign
      }
      when(csr_addr === CSRs.sstatus.U) {
        val tmp_mstatus = wdata.asTypeOf(new MStatus)
        mstatus.sie := tmp_mstatus.sie
        mstatus.spie:= tmp_mstatus.spie
        mstatus.spp := tmp_mstatus.spp
        mstatus.xs  := tmp_mstatus.xs
        mstatus.fs  := tmp_mstatus.fs
        mstatus.sum := tmp_mstatus.sum
        mstatus.mxr := tmp_mstatus.mxr
        mstatus.uxl := tmp_mstatus.uxl
        mstatus.sd  := tmp_mstatus.xs.andR() | tmp_mstatus.fs.andR()
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
        mie.meie := tmp_mie.meie
        mie.stie := tmp_mie.stie
        mie.ssie := tmp_mie.ssie
        mie.seie := tmp_mie.seie
        mie.utie := tmp_mie.utie
        mie.usie := tmp_mie.usie
        mie.ueie := tmp_mie.ueie
      }
      .elsewhen(csr_addr === CSRs.sie.U){
        val tmp_mie = wdata.asTypeOf(new MIE)
        mie.stie := tmp_mie.stie
        mie.ssie := tmp_mie.ssie
        mie.seie := tmp_mie.seie
        mie.utie := tmp_mie.utie
        mie.usie := tmp_mie.usie
        mie.ueie := tmp_mie.ueie
      }
      .elsewhen(csr_addr === CSRs.mepc.U)     { mepc := wdata >> 2.U << 2.U }
      .elsewhen(csr_addr === CSRs.mcause.U)   { mcause := wdata & (BigInt(1) << (p(XLen)-1) | 0xf).U }
      .elsewhen(csr_addr === CSRs.mtvec.U)    { mtvec := wdata}
      .elsewhen(csr_addr === CSRs.mcycle.U)   { mcycle := wdata}
      .elsewhen(csr_addr === CSRs.mscratch.U) { mscratch := wdata}
      .elsewhen(csr_addr === CSRs.medeleg.U)  { medeleg := wdata & "hf3ff".U}
      .elsewhen(csr_addr === CSRs.mideleg.U)  { mideleg := wdata & "h222".U}
      .elsewhen(csr_addr === CSRs.sepc.U)     { sepc := wdata >> 2.U << 2.U }
      .elsewhen(csr_addr === CSRs.scause.U)   { scause := wdata & (BigInt(1) << (p(XLen)-1) | 0xf).U }
      .elsewhen(csr_addr === CSRs.sip.U)      { ssip := wdata(1)}
      .elsewhen(csr_addr === CSRs.mtval.U)    { mtval := wdata}
      .elsewhen(csr_addr === CSRs.stval.U)    { stval := wdata}
      .elsewhen(csr_addr === CSRs.stvec.U)    { stvec := wdata}
      .elsewhen(csr_addr === CSRs.satp.U)     { satp := wdata.asTypeOf(new SATP)}
      .elsewhen(csr_addr === CSRs.sscratch.U) { sscratch := wdata}
    }
  }

  if (p(Difftest)) {
    val sstatus = sstatus_mask & mstatus.asUInt()
    val dcsr = Module(new DifftestCSRState)
    dcsr.io.clock          := clock
    dcsr.io.coreid         := 0.U
    dcsr.io.priviledgeMode := mstatus.prv           // RegNext(Mux(!io.stall, mstatus.prv,       RegEnable(mstatus.prv, !io.stall)))      // RegNext(mstatus.prv, !io.stall)
    dcsr.io.mstatus        := mstatus.asUInt        // RegNext(Mux(!io.stall, mstatus.asUInt(),  RegEnable(mstatus.asUInt(), !io.stall))) // RegNext(mstatus.asUInt(), !io.stall)
    dcsr.io.mcause         := mcause                // RegNext(Mux(!io.stall, mcause,            RegEnable(mcause, !io.stall)))           // RegNext(mcause, !io.stall)
    dcsr.io.mepc           := mepc                  // RegNext(Mux(!io.stall, mepc,              RegEnable(mepc, !io.stall)))             // RegNext(mepc, !io.stall)
    dcsr.io.mip            := (mip.asUInt & 0xf.U)  // RegNext(Mux(!io.stall, mip.asUInt(),      RegEnable(mip.asUInt(), !io.stall)))     // RegNext(mip.asUInt(), !io.stall)
    dcsr.io.mie            := mie.asUInt            // RegNext(Mux(!io.stall, mie.asUInt(),      RegEnable(mie.asUInt(), !io.stall)))     // RegNext(mie.asUInt(), !io.stall)
    dcsr.io.mtvec          := mtvec                 // RegNext(Mux(!io.stall, mtvec,             RegEnable(mtvec, !io.stall)))            // RegNext(mtvec, !io.stall)
    dcsr.io.sstatus        := sstatus               // RegNext(Mux(!io.stall, sstatus,           RegEnable(sstatus, !io.stall))) // 0.U // RegNext(0.U)
    dcsr.io.scause         := scause                // RegNext(0.U)
    dcsr.io.sepc           := sepc                  // RegNext(0.U)
    dcsr.io.satp           := satp.asUInt           // RegNext(0.U)
    dcsr.io.mscratch       := mscratch              // RegNext(Mux(!io.stall, mscratch,          RegEnable(mscratch, !io.stall)))
    dcsr.io.sscratch       := sscratch              // RegNext(Mux(!io.stall, sstatus,           RegEnable(sstatus, !io.stall))) // 0.U // RegNext(0.U)
    dcsr.io.mideleg        := mideleg               // RegNext(0.U)
    dcsr.io.medeleg        := medeleg               // RegNext(0.U)
    dcsr.io.mtval          := mtval                 // RegNext(0.U)
    dcsr.io.stval          := stval                 // RegNext(0.U)
    dcsr.io.stvec          := stvec                 // RRegNextegNext(0.U)

    def change(value: UInt): UInt = {
      Mux(value =/= RegNext(value), value, 0.U)
    }

    val except_reg = RegEnable(io.expt, false.B, !io.stall)
    val time_interrupt_reg = RegEnable(interrupt.orR(), false.B, !io.stall)

    val dae = Module(new DifftestArchEvent)
    dae.io.clock := clock
    dae.io.coreid := 0.U
    dae.io.intrNO        := Mux(except_reg, Mux(time_interrupt_reg, Mux(mstatus.prv === CSR.PRV_M, mcause, scause), 0.U), 0.U)
    dae.io.cause         := Mux(except_reg, Mux(!time_interrupt_reg, Mux(mstatus.prv === CSR.PRV_M, mcause, scause), 0.U), 0.U)
    dae.io.exceptionPC   := RegEnable(io.ctrl_signal.pc, !io.stall)
    dae.io.exceptionInst := RegEnable(io.ctrl_signal.inst, !io.stall)
  }

}

package cpu

import chisel3.{util, _}
import chisel3.util._
import chipsalliance.rocketchip.config._
import chisel3.util.experimental.{BoringUtils, loadMemoryFromFileInline}
import difftest._

class ByPass(implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val ex = Input(new Bundle{
      val isrs1 = Bool()
      val rs1   = UInt(5.W)
      val isrs2 = Bool()
      val rs2   = UInt(5.W)
      val valid = Bool()
    })

    val mem = Input(new Bundle{
      val rd = UInt(5.W)
      val valid = Bool()
    })

    val wb = Input(new Bundle{
      val rd = UInt(5.W)
      val valid = Bool()
    })

    val forwardA = Output(UInt(2.W))    // 00: from register    01: from mem(RegNext(ex alu))   11: from wb
    val forwardB = Output(UInt(2.W))
  })

  when(io.ex.isrs1 & ((io.ex.rs1 === io.mem.rd) & (io.ex.rs1 =/= 0.U)) & io.mem.valid){
    io.forwardA := "b01".U
  }.elsewhen(io.ex.isrs1 & ((io.ex.rs1 === io.wb.rd) & (io.ex.rs1 =/= 0.U)) & io.wb.valid){
    io.forwardA := "b11".U
  }.otherwise{
    io.forwardA := "b00".U
  }

  when(io.ex.isrs2 & ((io.ex.rs2 === io.mem.rd) & (io.ex.rs2 =/= 0.U)) & io.mem.valid){
    io.forwardB := "b01".U
  }.elsewhen(io.ex.isrs2 & (io.ex.rs2 === io.wb.rd) & (io.ex.rs2 =/= 0.U) & io.wb.valid){
    io.forwardB := "b11".U
  }.otherwise{
    io.forwardB := "b00".U
  }
}

class LoadRisk (implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val id = Input(new Bundle{
      val valid = Bool()
      val rs1   = UInt(5.W)
      val rs2   = UInt(5.W)
    })
    val ex = Input(new Bundle{
      val valid  = Bool()
      val isLoad = Bool()
      val rd     = UInt(5.W)
    })
    val stall = Output(Bool())
  })

  when(io.id.valid & io.ex.valid & io.ex.isLoad & ((io.id.rs1 === io.ex.rd) | (io.id.rs2 === io.ex.rd))) {
    io.stall := true.B
  }.otherwise{
    io.stall := false.B
  }
}

class DataPath(implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val icacahe = Flipped(new CacheCPUIO)
    val dcache = Flipped(new CacheCPUIO)

    val control = Flipped(new ControlIO)
    val time_interrupt = Input(Bool())

    val fence_i_do   = Output(Bool())
    val fence_i_done = Input(Bool())
  })

  import Control._

  val ifet = Module(new IF)
  val id = Module(new ID)
  val ex = Module(new EX)
  val mem = Module(new MEM)

  val br = Module(new Branch)

  val regs = Module(new RegisterFile)

  val ctrl = io.control.signal

  val bypass = Module(new ByPass)
  val loadrisk = Module(new LoadRisk)

  val csr = Module(new CSR)
  val csr_except = Wire(Bool())

  // cache not ready
  val stall = !io.icacahe.resp.valid || !io.dcache.resp.valid || !io.dcache.req.ready

  val mem2if_pc_sel = Wire(UInt(2.W))
  val mem2if_pc_alu = Wire(UInt(p(XLen).W))
  val mem_kill = Wire(UInt(1.W))
  val mem_fence_i = Wire(UInt(1.W))
  io.fence_i_do := mem_fence_i

  val time_interrupt_enable = WireInit(false.B)
  val soft_interrupt_enable = WireInit(false.B)
  val external_interrupt_enable = WireInit(false.B)
  BoringUtils.addSink(time_interrupt_enable, "time_interrupt_enable")
  BoringUtils.addSink(soft_interrupt_enable, "soft_interrupt_enable")
  BoringUtils.addSink(external_interrupt_enable, "external_interrupt_enable")

  val soft_int = WireInit(false.B)
  BoringUtils.addSink(soft_int, "soft_int")

  val external_int = WireInit(false.B)
  BoringUtils.addSink(external_int, "external_int")

  // fetch /////////////////////////////////////

  ifet.io.icache <> io.icacahe
  ifet.io.pc_sel := mem2if_pc_sel   // ex_ctrl.asTypeOf(new CtrlSignal).pc_sel
  ifet.io.pc_alu := mem2if_pc_alu   // ex_alu_out
  ifet.io.pc_epc := csr.io.epc // BitPat.bitPatToUInt(ISA.nop)
  ifet.io.stall := stall | loadrisk.io.stall
  val br_taken_from_mem = Wire(Bool())
  val br_isHit_from_mem = Wire(Bool())
  val br_curPC_from_mem = Wire(UInt(32.W))
  val br_infoValid_from_mem = Wire(Bool())
  ifet.io.br_info.valid := br_infoValid_from_mem
  ifet.io.br_info.bits.isTaken := br_taken_from_mem
  ifet.io.br_info.bits.isHit := br_isHit_from_mem
  ifet.io.br_info.bits.cur_pc := br_curPC_from_mem

  ifet.io.kill := mem_kill
  ifet.io.pc_except_entry.valid := csr_except
  ifet.io.pc_except_entry.bits := csr.io.exvec
  ifet.io.fence_i_done := io.fence_i_done

  val if_pc    = RegEnable(ifet.io.out.bits.pc,                           0.U, !stall & !loadrisk.io.stall)
  val if_pTaken= RegEnable(ifet.io.out.bits.pTaken,                       0.U, !stall & !loadrisk.io.stall)
  val if_pPC   = RegEnable(ifet.io.out.bits.pPC,                          0.U, !stall & !loadrisk.io.stall)
  val if_inst  = RegEnable(ifet.io.out.bits.inst,                         0.U, !stall & !loadrisk.io.stall)
  val if_valid = RegEnable(Mux(mem_kill === 1.U, 0.U, ifet.io.out.valid), 0.U, !stall & !loadrisk.io.stall)

  // decode /////////////////////////////////////
  io.control.inst := if_inst // control signal

  id.io.inst := if_inst
  id.io.imm_sel := ctrl.imm_sel

  regs.io.raddr1 := id.io.rs1_addr
  regs.io.raddr2 := id.io.rs2_addr

  loadrisk.io.id.valid := if_valid & !mem_kill
  loadrisk.io.id.rs1 := id.io.rs1_addr
  loadrisk.io.id.rs2 := id.io.rs2_addr

  val id_rs1   = RegEnable(id.io.rs1_addr,                                             0.U, !stall)
  val id_rs2   = RegEnable(id.io.rs2_addr,                                             0.U, !stall)
  val id_rdata1= RegEnable(regs.io.rdata1,                                             0.U, !stall)
  val id_rdata2= RegEnable(regs.io.rdata2,                                             0.U, !stall)
  val id_A     = RegEnable(Mux(ctrl.a_sel === A_PC, if_pc, regs.io.rdata1),            0.U, !stall)
  val id_B     = RegEnable(Mux(ctrl.b_sel === B_IMM, id.io.imm, regs.io.rdata2),       0.U, !stall)
  val id_rd    = RegEnable(id.io.rd_addr,                                              0.U, !stall)
//  val id_ctrl  = RegEnable(ctrl.asUInt(),                                              0.U, !stall)
  val id_inst  = RegEnable(if_inst,                                                    0.U, !stall)
  val id_pc    = RegEnable(if_pc,                                                      0.U, !stall)
  val id_pTaken= RegEnable(if_pTaken,                                                  0.U, !stall)
  val id_pPC   = RegEnable(if_pPC,                                                     0.U, !stall)
  val id_valid = RegEnable(Mux((mem_kill === 1.U) | loadrisk.io.stall, 0.U, if_valid), 0.U, !stall)
  val id_interrupt = RegEnable(Cat(Seq(
    io.time_interrupt & time_interrupt_enable,
    soft_int & soft_interrupt_enable,
    external_int & external_interrupt_enable
  )), 0.U(3.W), !stall)
  val id_ctrl = Map(
    "pc_sel"  -> RegEnable(ctrl.pc_sel,   0.U, !stall),
    "a_sel"   -> RegEnable(ctrl.a_sel,    0.U, !stall),
    "b_sel"   -> RegEnable(ctrl.b_sel,    0.U, !stall),
//    "imm_sel" -> RegEnable(ctrl.imm_sel,  0.U, !stall),
    "alu_op"  -> RegEnable(ctrl.alu_op,   0.U, !stall),
    "br_type" -> RegEnable(ctrl.br_type,  0.U, !stall),
    "kill"    -> RegEnable(ctrl.kill,     0.U, !stall),
    "st_type" -> RegEnable(ctrl.st_type,  0.U, !stall),
    "ld_type" -> RegEnable(ctrl.ld_type,  0.U, !stall),
    "wb_type" -> RegEnable(ctrl.wb_type,  0.U, !stall),
    "wen"     -> RegEnable(ctrl.wen,      0.U, !stall),
    "csr_cmd" -> RegEnable(ctrl.csr_cmd,  0.U, !stall),
    "illegal" -> RegEnable(ctrl.illegal,  0.U, !stall)
  )

  // ex /////////////////////////////////////
  bypass.io.ex.isrs1 := true.B // id_ctrl.asTypeOf(new CtrlSignal).a_sel === A_RS1
  bypass.io.ex.isrs2 := true.B // id_ctrl.asTypeOf(new CtrlSignal).b_sel === B_RS2
  bypass.io.ex.rs1   := id_rs1
  bypass.io.ex.rs2   := id_rs2
  bypass.io.ex.valid := id_valid

  loadrisk.io.ex.valid := id_valid & !mem_kill
  loadrisk.io.ex.rd := id_rd
  loadrisk.io.ex.isLoad := id_ctrl("ld_type").orR() | id_ctrl("csr_cmd")(1,0).orR()

  ex.io.alu_op := id_ctrl("alu_op")

  val bypass_ex_alu_out = Wire(UInt(p(XLen).W))
  val bypass_mem_l_data = Wire(UInt(p(XLen).W))
  ex.io.rs1 := Mux(id_ctrl("a_sel") =/= A_RS1, id_A, MuxLookup(bypass.io.forwardA, id_A, Seq(
    "b00".U -> id_A,
    "b01".U -> bypass_ex_alu_out,
    "b11".U -> bypass_mem_l_data
  )))
  ex.io.rs2 := Mux(id_ctrl("b_sel") =/= B_RS2, id_B, MuxLookup(bypass.io.forwardB, id_B, Seq(
    "b00".U -> id_B,
    "b01".U -> bypass_ex_alu_out,
    "b11".U -> bypass_mem_l_data
  )))

  br.io.rs1 := MuxLookup(bypass.io.forwardA, id_rdata1, Seq(
    "b00".U -> id_rdata1,
    "b01".U -> bypass_ex_alu_out,
    "b11".U -> bypass_mem_l_data
  ))
  br.io.rs2 := MuxLookup(bypass.io.forwardB, id_rdata2, Seq(
    "b00".U -> id_rdata2,
    "b01".U -> bypass_ex_alu_out,
    "b11".U -> bypass_mem_l_data
  ))
  br.io.br_type := Mux(id_valid === 1.U, id_ctrl("br_type"), 0.U)

  val ex_rs1     = RegEnable(id_rs1,                               0.U, !stall)
  val ex_rs2     = RegEnable(id_rs2,                               0.U, !stall)
  val ex_taken   = RegEnable(br.io.taken,                          0.U, !stall)
  val ex_alu_out = RegEnable(ex.io.out,                            0.U, !stall)
  val ex_rdata2  = RegEnable(id_rdata2,                            0.U, !stall)
  val ex_rd      = RegEnable(id_rd,                                0.U, !stall)
  val ex_inst    = RegEnable(id_inst,                              0.U, !stall)
  val ex_pc      = RegEnable(id_pc,                                0.U, !stall)
  val ex_pc4     = RegEnable(id_pc + 4.U,                          0.U, !stall)
  val ex_pTaken  = RegEnable(id_pTaken,                            0.U, !stall)
  val ex_pPC     = RegEnable(id_pPC,                               0.U, !stall)
  val ex_valid   = RegEnable(Mux(mem_kill === 1.U, 0.U, id_valid), 0.U, !stall)
  val ex_interrupt = RegEnable(id_interrupt,                       0.U, !stall)
  val ex_ctrl    = Map(
    "pc_sel"  -> RegEnable(id_ctrl("pc_sel"),   0.U, !stall),
//  "a_sel"   -> RegEnable(id_ctrl("a_sel"),    0.U, !stall),
//  "b_sel"   -> RegEnable(id_ctrl("b_sel"),    0.U, !stall),
//  "imm_sel" -> RegEnable(id_ctrl("imm_sel"),  0.U, !stall),
//  "alu_op"  -> RegEnable(id_ctrl("alu_op"),   0.U, !stall),
    "br_type" -> RegEnable(id_ctrl("br_type"),  0.U, !stall),
    "kill"    -> RegEnable(id_ctrl("kill"),     0.U, !stall),
    "st_type" -> RegEnable(id_ctrl("st_type"),  0.U, !stall),
    "ld_type" -> RegEnable(id_ctrl("ld_type"),  0.U, !stall),
    "wb_type" -> RegEnable(id_ctrl("wb_type"),  0.U, !stall),
    "wen"     -> RegEnable(id_ctrl("wen"),      0.U, !stall),
    "csr_cmd" -> RegEnable(id_ctrl("csr_cmd"),  0.U, !stall),
    "illegal" -> RegEnable(id_ctrl("illegal"),  0.U, !stall)
  )

  bypass_ex_alu_out := MuxLookup(ex_ctrl("wb_type"), ex_alu_out, Seq(
    WB_ALU -> ex_alu_out,
    WB_PC4 -> ex_pc4
  ))

  // mem /////////////////////////////////////

  // branch
  br_taken_from_mem := ex_taken & ex_valid
  br_isHit_from_mem := (((ex_taken === ex_pTaken) & (ex_alu_out === ex_pPC) & ex_taken) | ((ex_taken === ex_pTaken) & (ex_pPC === (ex_pc + 4.U)) & !ex_taken)) & ex_valid   // curPC==pPC? jalr???pc???reg+offset
  br_curPC_from_mem := ex_pc
  br_infoValid_from_mem := ex_valid & ex_ctrl("br_type").orR()


  mem_fence_i := (ex_valid & (ex_inst === ISA.fence_i) & !stall) & !RegNext(ex_valid & (ex_inst === ISA.fence_i) & !stall, false.B)
  ifet.io.fence_pc := ex_pc
  ifet.io.fence_i_do := mem_fence_i

  bypass.io.mem.rd := ex_rd
  bypass.io.mem.valid := ex_valid & ex_ctrl("wen")

  mem.io.dcache <> io.dcache
  // d$ req is sended by ex stage!
  mem.io.ld_type    := id_ctrl("ld_type")
  val mem_wb_interrupt = Wire(Bool())
  mem.io.st_type    := Mux(mem_wb_interrupt, ST_XXX, id_ctrl("st_type"))
  mem.io.s_data     := br.io.rs2
  mem.io.alu_res    := ex.io.out
  mem.io.inst_valid := Mux((mem_kill === 1.U) | (id_interrupt.orR() === 1.U), 0.U, id_valid)
  mem.io.stall      := stall

  if (p(Difftest)) {
    csr.io.stall := stall | (ex_inst === "h0000007b".U)
  } else {
    csr.io.stall := stall
  }
  csr.io.cmd := ex_ctrl("csr_cmd")
  csr.io.in  := ex_alu_out
  csr.io.ctrl_signal.pc := ex_pc
  csr.io.ctrl_signal.addr := ex_alu_out
  csr.io.ctrl_signal.inst := ex_inst
  if(p(Difftest)){
    csr.io.ctrl_signal.illegal := ex_ctrl("illegal") & (ex_inst  =/= "h0000007b".U) & (ex_inst =/= "h0000006b".U)
  }else{
    csr.io.ctrl_signal.illegal := ex_ctrl("illegal")
  }
  csr.io.ctrl_signal.st_type := ex_ctrl("st_type")
  csr.io.ctrl_signal.ld_type := ex_ctrl("ld_type")
  csr.io.ctrl_signal.valid   := ex_valid
  csr.io.pc_check := (ex_ctrl("pc_sel") === PC_ALU) & ex_valid

  csr.io.interrupt.time     := ex_interrupt(2) & ex_valid
  csr.io.interrupt.soft     := ex_interrupt(1) & ex_valid
  csr.io.interrupt.external := ex_interrupt(0) & ex_valid

  val mem_alu_out    = RegEnable(ex_alu_out,        0.U, !stall)
  val mem_l_data     = RegEnable(mem.io.l_data,     0.U.asTypeOf(mem.io.l_data), !stall)
//  val mem_s_complete = RegEnable(mem.io.s_complete, 0.U, !stall)
  val mem_rd         = RegEnable(ex_rd,             0.U, !stall)
  val mem_inst       = RegEnable(ex_inst,           0.U, !stall)
  val mem_pc         = RegEnable(ex_pc,             0.U, !stall)
  val mem_pc4        = RegEnable(ex_pc4,            0.U, !stall)
  val mem_valid_true = RegEnable(ex_valid,          0.U, !stall)
  val mem_csr        = RegEnable(csr.io.out,        0.U, !stall)
  val mem_csr_except  = RegEnable(csr_except,       0.U, !stall)
  val mem_ctrl    = Map(
//    "pc_sel"  -> RegEnable(ex_ctrl("pc_sel"),   0.U, !stall),
//  "a_sel"   -> RegEnable(ex_ctrl("a_sel"),    0.U, !stall),
//  "b_sel"   -> RegEnable(ex_ctrl("b_sel"),    0.U, !stall),
//  "imm_sel" -> RegEnable(ex_ctrl("imm_sel"),  0.U, !stall),
//  "alu_op"  -> RegEnable(ex_ctrl("alu_op"),   0.U, !stall),
//  "br_type" -> RegEnable(ex_ctrl("br_type"),  0.U, !stall),
//  "kill"    -> RegEnable(ex_ctrl("kill"),     0.U, !stall),
    "st_type" -> (if (p(Difftest)) RegEnable(ex_ctrl("st_type"),  0.U, !stall) else UInt(0.W)),
    "ld_type" -> (if (p(Difftest)) RegEnable(ex_ctrl("ld_type"),  0.U, !stall) else UInt(0.W)),
    "wb_type" -> RegEnable(ex_ctrl("wb_type"),  0.U, !stall),
    "wen"     -> RegEnable(ex_ctrl("wen"),      0.U, !stall),
//  "csr_cmd" -> RegEnable(ex_ctrl("csr_cmd"),  0.U, !stall),
//  "illegal" -> RegEnable(ex_ctrl("illegal"),  0.U, !stall)
  )

  val mem_valid = mem_valid_true & !mem_csr_except

  if (p(Difftest)) {
    csr_except := csr.io.expt & ex_valid & (ex_inst =/= "h0000007b".U)
  } else {
    csr_except := csr.io.expt & ex_valid
  }
  mem_kill := (ex_ctrl("kill") | (br_infoValid_from_mem & (!br_isHit_from_mem)) | csr_except | mem_fence_i) & ex_valid
  mem2if_pc_sel := Mux(ex_valid === 1.U, ex_ctrl("pc_sel"), PC_4)
  mem2if_pc_alu := ex_alu_out
  dontTouch(mem2if_pc_sel)
//  dontTouch(mem2if_pc_alu)

  // wb /////////////////////////////////////
  bypass.io.wb.rd := mem_rd
  bypass.io.wb.valid := mem_valid & mem_ctrl("wen")
  bypass_mem_l_data := regs.io.wdata

  mem_wb_interrupt := ((ex_interrupt.orR() & ex_valid) | csr.io.expt) | (mem_valid_true & mem_csr_except)

  regs.io.waddr := mem_rd
  regs.io.wdata := MuxLookup(mem_ctrl("wb_type"), 0.U, Array(
    WB_ALU -> mem_alu_out,
    WB_MEM -> mem_l_data.bits,
    WB_PC4 -> mem_pc4,
    WB_CSR -> mem_csr
  ))
  regs.io.wen := (mem_ctrl("wen") & !stall & mem_valid) // | mem_l_data.valid

  if(p(Difftest)){
    println(">>>>>>>> difftest mode!")

    val commit_valid  = Wire(Bool())
    commit_valid := (mem_valid_true & !mem_csr_except & !stall) // | mem_l_data.valid | mem_s_complete
    dontTouch(commit_valid)

    val cycleCnt = Counter(Int.MaxValue)
    cycleCnt.inc()
    BoringUtils.addSource(cycleCnt.value, "cycleCnt")
    val instCnt = Counter(Int.MaxValue)
    when(commit_valid){
      instCnt.inc()
    }

    val dcache_op = WireInit(false.B)
    val dcache_data = WireInit(0.asUInt(p(XLen).W))
    val dcache_address = WireInit(0.asUInt(p(XLen).W))
    val dcache_mask = WireInit(0.asUInt(8.W))

    BoringUtils.addSink(dcache_mask, "dcache_mask")
    BoringUtils.addSink(dcache_data, "dcache_data")
    BoringUtils.addSink(dcache_address, "dcache_address")
    BoringUtils.addSink(dcache_op, "dcache_op")

//    val dse = Module(new DifftestStoreEvent)
//    dse.io.valid := RegNext(commit_valid & !RegEnable(RegEnable(dcache_op, !stall), !stall))
//    dse.io.storeAddr := RegNext(RegEnable(RegEnable(dcache_address, !stall), !stall))
//    dse.io.storeData := RegNext(RegEnable(RegEnable(0.U, !stall), !stall))
//    dse.io.storeMask := RegNext(RegEnable(RegEnable(dcache_mask, !stall), !stall))

    val dic = Module(new DifftestInstrCommit)
    dic.io.clock := clock
    dic.io.coreid := 0.U
    dic.io.index := 0.U
//    dic.io.valid := RegNext(ifet.io.out.valid)
    dic.io.valid := RegNext(commit_valid)
    dic.io.pc := RegNext(mem_pc)
    dic.io.instr := RegNext(mem_inst)
    dic.io.skip := RegNext(
      ((mem_inst === "h0000007b".U) |
      ((mem_ctrl("ld_type").orR() | mem_ctrl("st_type").orR()) & (p(CLINTRegs).values.map(mem_alu_out === _.U).reduce(_|_))) |
      (mem_inst === BitPat("b101100000000_?????_010_?????_1110011"))
      ) & !stall
    )
    dic.io.isRVC := false.B
    dic.io.scFailed := false.B
    dic.io.wen := RegNext(regs.io.wen)
    dic.io.wdata := RegNext(regs.io.wdata)
    dic.io.wdest := RegNext(regs.io.waddr)

    val dte = Module(new DifftestTrapEvent)
    dte.io.clock := clock
    dte.io.coreid := 0.U
    dte.io.valid := RegNext((mem_inst === "h0000006b".U) & (mem_valid === 1.U))
    dte.io.code := regs.io.trap_code.getOrElse(1.U)
    dte.io.pc := RegNext(mem_pc)
    dte.io.cycleCnt := cycleCnt.value
    dte.io.instrCnt := instCnt.value

    val difftest_uart_valid = Wire(Bool())
    val difftest_uart_ch    = Wire(UInt(8.W))
    BoringUtils.addSource(difftest_uart_valid, "difftest_uart_valid")
    BoringUtils.addSource(difftest_uart_ch, "difftest_uart_ch")
    difftest_uart_valid := RegNext((mem_inst === "h0000007b".U) & (mem_valid === 1.U))
    difftest_uart_ch := regs.io.trap_code.getOrElse(1.U)

  }
}

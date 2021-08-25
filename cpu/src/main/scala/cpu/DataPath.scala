package cpu

import chisel3.{util, _}
import chisel3.util._
import chipsalliance.rocketchip.config._
import chisel3.util.experimental.loadMemoryFromFileInline
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

  when(io.ex.isrs1 & (io.ex.rs1 === io.mem.rd) & io.mem.valid){
    io.forwardA := "b01".U
  }.elsewhen(io.ex.isrs1 & (io.ex.rs1 === io.wb.rd) & io.wb.valid){
    io.forwardA := "b11".U
  }.otherwise{
    io.forwardA := "b00".U
  }

  when(io.ex.isrs2 & (io.ex.rs2 === io.mem.rd) & io.mem.valid){
    io.forwardB := "b01".U
  }.elsewhen(io.ex.isrs2 & (io.ex.rs2 === io.wb.rd) & io.wb.valid){
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

  // cache not ready
  val stall = !io.icacahe.resp.valid || !io.dcache.resp.valid || !io.dcache.req.ready

  val mem2if_pc_sel = Wire(UInt(2.W))
  val mem2if_pc_alu = Wire(UInt(p(XLen).W))
  val mem_kill = Wire(UInt(1.W))

  // fetch /////////////////////////////////////

  ifet.io.icache <> io.icacahe
  ifet.io.pc_sel := mem2if_pc_sel   // ex_ctrl.asTypeOf(new CtrlSignal).pc_sel
  ifet.io.pc_alu := mem2if_pc_alu   // ex_alu_out
  ifet.io.pc_epc := BitPat.bitPatToUInt(ISA.nop)
  ifet.io.stall := stall | loadrisk.io.stall
  val br_taken_from_mem = Wire(Bool())
  ifet.io.br_taken := br_taken_from_mem
  ifet.io.kill := mem_kill

  val if_pc    = RegEnable(ifet.io.out.bits.pc, !stall & !loadrisk.io.stall)
  val if_inst  = RegEnable(ifet.io.out.bits.inst, !stall & !loadrisk.io.stall)
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

  val id_rs1   = RegEnable(id.io.rs1_addr, !stall)
  val id_rs2   = RegEnable(id.io.rs2_addr, !stall)
  val id_rdata1= RegEnable(regs.io.rdata1, !stall)
  val id_rdata2= RegEnable(regs.io.rdata2, !stall)
  val id_A     = RegEnable(Mux(ctrl.a_sel === A_PC, if_pc, regs.io.rdata1), !stall)
  val id_B     = RegEnable(Mux(ctrl.b_sel === B_IMM, id.io.imm, regs.io.rdata2), !stall)
  val id_rd    = RegEnable(id.io.rd_addr, !stall)
  val id_ctrl  = RegEnable(ctrl.asUInt(), !stall)
  val id_inst  = RegEnable(if_inst, !stall)
  val id_pc    = RegEnable(if_pc, !stall)
  val id_valid = RegEnable(Mux((mem_kill === 1.U) | loadrisk.io.stall, 0.U, if_valid), 0.U, !stall)

  // ex /////////////////////////////////////
  bypass.io.ex.isrs1 := true.B // id_ctrl.asTypeOf(new CtrlSignal).a_sel === A_RS1
  bypass.io.ex.isrs2 := true.B // id_ctrl.asTypeOf(new CtrlSignal).b_sel === B_RS2
  bypass.io.ex.rs1   := id_rs1
  bypass.io.ex.rs2   := id_rs2
  bypass.io.ex.valid := id_valid

  loadrisk.io.ex.valid := id_valid & !mem_kill
  loadrisk.io.ex.rd := id_rd
  loadrisk.io.ex.isLoad := id_ctrl.asTypeOf(new CtrlSignal).ld_type.orR()

  ex.io.alu_op := id_ctrl.asTypeOf(new CtrlSignal).alu_op

  val bypass_ex_alu_out = Wire(UInt(p(XLen).W))
  val bypass_mem_l_data = Wire(UInt(p(XLen).W))
  ex.io.rs1 := Mux(id_ctrl.asTypeOf(new CtrlSignal).a_sel =/= A_RS1, id_A, MuxLookup(bypass.io.forwardA, id_A, Seq(
    "b00".U -> id_A,
    "b01".U -> bypass_ex_alu_out,
    "b11".U -> bypass_mem_l_data
  )))
  ex.io.rs2 := Mux(id_ctrl.asTypeOf(new CtrlSignal).b_sel =/= B_RS2, id_B, MuxLookup(bypass.io.forwardB, id_B, Seq(
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
  br.io.br_type := Mux(id_valid === 1.U, id_ctrl.asTypeOf(new CtrlSignal).br_type, 0.U)

  val ex_rs1     = RegEnable(id_rs1, !stall)
  val ex_rs2     = RegEnable(id_rs2, !stall)
  val ex_taken   = RegEnable(br.io.taken, !stall)
  val ex_alu_out = RegEnable(ex.io.out, !stall)
  val ex_rdata2  = RegEnable(id_rdata2, !stall)
  val ex_rd      = RegEnable(id_rd, !stall)
  val ex_ctrl    = RegEnable(id_ctrl, !stall)
  val ex_inst    = RegEnable(id_inst, !stall)
  val ex_pc      = RegEnable(id_pc, !stall)
  val ex_valid   = RegEnable(Mux(mem_kill === 1.U, 0.U, id_valid), 0.U, !stall)

  bypass_ex_alu_out := ex_alu_out

  // mem /////////////////////////////////////

  bypass.io.mem.rd := ex_rd
  bypass.io.mem.valid := ex_valid & ex_ctrl.asTypeOf(new CtrlSignal).wen

  mem.io.dcache <> io.dcache
  // d$ req is sended by ex stage!
  mem.io.ld_type    := id_ctrl.asTypeOf(new CtrlSignal).ld_type
  mem.io.st_type    := id_ctrl.asTypeOf(new CtrlSignal).st_type
  mem.io.s_data     := br.io.rs2
  mem.io.alu_res    := ex.io.out
  mem.io.inst_valid := Mux(mem_kill === 1.U, 0.U, id_valid)
  mem.io.stall      := stall

  val mem_alu_out    = RegEnable(ex_alu_out, !stall)
  val mem_l_data     = RegEnable(mem.io.l_data, !stall)
  val mem_s_complete = RegEnable(mem.io.s_complete, !stall)
  val mem_rd         = RegEnable(ex_rd, !stall)
  val mem_ctrl       = RegEnable(ex_ctrl, !stall)
  val mem_inst       = RegEnable(ex_inst, !stall)
  val mem_pc         = RegEnable(ex_pc, !stall)
  val mem_valid      = RegEnable(ex_valid, 0.U, !stall)


  br_taken_from_mem := ex_taken & ex_valid
  mem_kill := (ex_ctrl.asTypeOf(new CtrlSignal).kill | ex_taken) & ex_valid
  mem2if_pc_sel := Mux(ex_valid === 1.U, ex_ctrl.asTypeOf(new CtrlSignal).pc_sel, 0.U)
  mem2if_pc_alu := ex_alu_out

  // wb /////////////////////////////////////
  bypass.io.wb.rd := mem_rd
  bypass.io.wb.valid := mem_valid & mem_ctrl.asTypeOf(new CtrlSignal).wen
  bypass_mem_l_data := regs.io.wdata

  regs.io.waddr := mem_rd
  regs.io.wdata := MuxLookup(mem_ctrl.asTypeOf(new CtrlSignal).wb_type, 0.U, Array(
    WB_ALU -> mem_alu_out,
    WB_MEM -> mem_l_data.bits,
    WB_PC4 -> (mem_pc + 4.U)
  ))
  regs.io.wen := (mem_ctrl.asTypeOf(new CtrlSignal).wen & !stall & mem_valid) // | mem_l_data.valid

  val commit_valid  = Wire(Bool())
  commit_valid := (mem_valid & !stall) // | mem_l_data.valid | mem_s_complete
  dontTouch(commit_valid)

  dontTouch(regs.io.wdata)

  val cycleCnt = Counter(65536)
  cycleCnt.inc()
  val instCnt = Counter(65536)
  when(commit_valid){
    instCnt.inc()
  }

  if(p(Difftest)){
    println(">>>>>>>> difftest mode!")

    val dic = Module(new DifftestInstrCommit)
    dic.io.clock := clock
    dic.io.coreid := 0.U
    dic.io.index := 0.U
//    dic.io.valid := RegNext(ifet.io.out.valid)
    dic.io.valid := RegNext(commit_valid)
    dic.io.pc := RegNext(mem_pc)
    dic.io.instr := RegNext(mem_inst)
    dic.io.skip := false.B
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

    val dcsr = Module(new DifftestCSRState)
    dcsr.io.clock := clock
    dcsr.io.coreid := 0.U
    dcsr.io.mstatus := 0.U
    dcsr.io.mcause := 0.U
    dcsr.io.mepc := 0.U
    dcsr.io.sstatus := 0.U
    dcsr.io.scause := 0.U
    dcsr.io.sepc := 0.U
    dcsr.io.satp := 0.U
    dcsr.io.mip := 0.U
    dcsr.io.mie := 0.U
    dcsr.io.mscratch := 0.U
    dcsr.io.sscratch := 0.U
    dcsr.io.mideleg := 0.U
    dcsr.io.medeleg := 0.U
    dcsr.io.mtval:= 0.U
    dcsr.io.stval:= 0.U
    dcsr.io.mtvec := 0.U
    dcsr.io.stvec := 0.U
    dcsr.io.priviledgeMode := 0.U
  }
}

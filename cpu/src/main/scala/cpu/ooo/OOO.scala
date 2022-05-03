package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import chisel3.util.experimental.BoringUtils
import cpu.dsa.gemm.{GEMM, GEMMDummy}
import cpu.ooo.MMU
import difftest._

class OOO(implicit p: Parameters) extends Module {
  val io = IO(new Bundle {
    val icache = Flipped(new CacheCPUIO)
    val dcache = Flipped(new CacheCPUIO)

    val time_interrupt = Input(Bool())

    val fence_i_do   = Output(Bool())
    val fence_i_done = Input(Bool())

//    val rocc = Flipped(new RoCCIO)
  })

  import Control._

  // ifet
  val ifet = Module(new OOOIF)
  // id
  val id = Seq.fill(2)(Module(new ID))
  val control = Seq.fill(2)(Module(new Control))
  val rename = Module(new RenameMap)
  // issue
  val station = Module(new Station)
  // ex
  val prfile = Module(new PRFile)
  val fixPointU = Module(new FixPointU)
  val mem = Module(new MemU)
  // commit
  val rob = Module(new ROB)

  val dcacheCrossBar = Module(new CPUCacheCrossBarN21(3))

  val mmu = Module(new MMU())


  // some intermediate signals
  val station_isfull = !station.io.in.head.ready // in(0).ready is the same as in(1).ready
  val rob_flush = Wire(Bool())
  val rob_kill = Wire(Bool())

  val soft_int = WireInit(false.B)
  val external_int = WireInit(false.B)
  BoringUtils.addSink(soft_int, "soft_int")
  BoringUtils.addSink(external_int, "external_int")

  // 单指令提交，只需要关注reg(0)就可以了
  io.fence_i_do := (rob.io.commit.reg(0).bits.fence_i_do) & rob.io.commit.reg(0).valid

  //= ifet ==================================================
  ifet.io.pc_sel := Mux(rob.io.is_xret, PC_EPC, 0.U)    // xret has kill, but it prioruty is higher
  ifet.io.pc_epc := rob.io.epc
  ifet.io.pc_alu := 0.U
  ifet.io.stall := station_isfull
  ifet.io.flush := rob_flush
  ifet.io.fence_i_do := io.fence_i_do
  ifet.io.fence_i_done := io.fence_i_done
  ifet.io.kill := rob_kill
  ifet.io.kill_pc := rob.io.commit.reg(0).bits.pc
  ifet.io.pc_except_entry.valid := rob.io.except
  ifet.io.pc_except_entry.bits := rob.io.exvec

  ifet.io.br_info.valid        := rob.io.commit.br_info.valid
  ifet.io.br_info.bits.isHit   := rob.io.commit.br_info.bits.isHit
  ifet.io.br_info.bits.isTaken := rob.io.commit.br_info.bits.isTaken
  ifet.io.br_info.bits.cur_pc  := rob.io.commit.br_info.bits.cur_pc
  ifet.io.br_info.bits.tgt     := rob.io.commit.br_info.bits.right_pc

  val if_reg = RegEnable(Mux(rob_flush, 0.U.asTypeOf(ifet.io.out), ifet.io.out), 0.U.asTypeOf(ifet.io.out), rob_flush | !station_isfull)

  //= decoder ==================================================
  val ctrl = Wire(Vec(2, (new ControlIO).signal))
  for(i <- 0 until 2){
    control(i).io.inst := if_reg(i).bits.inst
    id(i).io.inst := if_reg(i).bits.inst
    id(i).io.imm_sel := control(i).io.signal.imm_sel
    ctrl(i) := control(i).io.signal
  }

  for(i <- 0 until 2){
    rename.io.port(i).valid := if_reg(i).valid
    // query a and b pr, only rs1 and rs2 is register
    rename.io.port(i).query_a.lr.bits  := id(i).io.rs1_addr
    rename.io.port(i).query_a.lr.valid := (control(i).io.signal.a_sel === A_RS1) & if_reg(i).valid // 同下， valid===0,当作pc处理
    rename.io.port(i).query_b.lr.bits  := id(i).io.rs2_addr
    rename.io.port(i).query_b.lr.valid := (control(i).io.signal.b_sel === B_RS2) & if_reg(i).valid // 如果是imm，lr和pr的valid应该为0,station输入的时候如果发现pr.valid===0,就当作立即数处理
    // allocate c, only write back inst need allocate
    rename.io.port(i).allocate_c.lr.bits  := id(i).io.rd_addr
    rename.io.port(i).allocate_c.lr.valid := (control(i).io.signal.wen & (id(i).io.rd_addr =/= 0.U)) & if_reg(i).valid & !station_isfull
  }

  for(i <- 0 until 2){
    // write to station
    station.io.in(i).bits.pr1       := rename.io.port(i).query_a.pr.bits.idx
    station.io.in(i).bits.pr1_s     := Mux(rename.io.port(i).query_a.pr.fire(), rename.io.port(i).query_a.pr.bits.isReady, true.B) // 否则就是imm
    station.io.in(i).bits.pr1_inROB := rename.io.port(i).query_a.pr.bits.inROB
    station.io.in(i).bits.pr1_robIdx:= rename.io.port(i).query_a.pr.bits.robIdx
    station.io.in(i).bits.pc        := if_reg(i).bits.pc
    station.io.in(i).bits.pr2       := rename.io.port(i).query_b.pr.bits.idx
    station.io.in(i).bits.pr2_s     := Mux(rename.io.port(i).query_b.pr.fire(), rename.io.port(i).query_b.pr.bits.isReady, true.B) // 否则就是imm
    station.io.in(i).bits.pr2_inROB := rename.io.port(i).query_b.pr.bits.inROB
    station.io.in(i).bits.pr2_robIdx:= rename.io.port(i).query_b.pr.bits.robIdx
    station.io.in(i).bits.imm       := id(i).io.imm
    station.io.in(i).bits.prd       := Mux(rename.io.port(i).allocate_c.pr.valid, rename.io.port(i).allocate_c.pr.bits, 0.U)
    station.io.in(i).bits.A_sel     := ctrl(i).a_sel
    station.io.in(i).bits.B_sel     := ctrl(i).b_sel
    station.io.in(i).bits.alu_op    := ctrl(i).alu_op
    station.io.in(i).bits.ld_type   := ctrl(i).ld_type
    station.io.in(i).bits.st_type   := ctrl(i).st_type
    station.io.in(i).bits.csr_op    := ctrl(i).csr_cmd
    station.io.in(i).bits.wb_type   := ctrl(i).wb_type
    station.io.in(i).bits.wen       := ctrl(i).wen
    station.io.in(i).bits.illeage   := ctrl(i).illegal
    station.io.in(i).bits.except    := if_reg(i).bits.except
    station.io.in(i).bits.inst      := if_reg(i).bits.inst
    station.io.in(i).bits.br_type   := ctrl(i).br_type
    station.io.in(i).bits.pTaken    := if_reg(i).bits.pTaken
    station.io.in(i).bits.pPC       := if_reg(i).bits.pPC
    station.io.in(i).bits.current_rename_state := rename.io.port(i).allocate_c.current_rename_state.bits
    station.io.in(i).bits.state     := 1.U // wait to issue
    station.io.in(i).bits.rocc_cmd  := ctrl(i).rocc_cmd
    station.io.in(i).valid := if_reg(i).valid

    // write rob
    rob.io.in.fromID(i).bits.prn                  := station.io.in(i).bits.prd     // Mux(ctrl(i).st_type.orR(), 0.U, rename.io.port(i).allocate_c.pr.bits) // todo: how to make sure mem address?
    rob.io.in.fromID(i).bits.needData             := ctrl(i).st_type.orR() | ctrl(i).wen
//    rob.io.in.fromID(i).bits.isPrd                := !ctrl(i).st_type.orR()
    rob.io.in.fromID(i).bits.wen                  := station.io.in(i).bits.wen
    rob.io.in.fromID(i).bits.wb_type              := station.io.in(i).bits.wb_type
    rob.io.in.fromID(i).bits.st_type              := station.io.in(i).bits.st_type
    rob.io.in.fromID(i).bits.ld_type              := station.io.in(i).bits.ld_type
    rob.io.in.fromID(i).bits.pc                   := station.io.in(i).bits.pc
    rob.io.in.fromID(i).bits.inst                 := station.io.in(i).bits.inst
    rob.io.in.fromID(i).valid                     := station.io.in(i).fire          // 只有被station接受的inst才能进入rob中
    rob.io.in.fromID(i).bits.isBr                 := station.io.in(i).bits.br_type.orR
    rob.io.in.fromID(i).bits.isJ                  := station.io.in(i).bits.br_type === "b111".U
    rob.io.in.fromID(i).bits.pTaken               := station.io.in(i).bits.pTaken
    rob.io.in.fromID(i).bits.current_rename_state := station.io.in(i).bits.current_rename_state
    rob.io.in.fromID(i).bits.csr_cmd              := station.io.in(i).bits.csr_op
    rob.io.in.fromID(i).bits.interrupt.time       := io.time_interrupt
    rob.io.in.fromID(i).bits.interrupt.soft       := soft_int
    rob.io.in.fromID(i).bits.interrupt.external   := external_int
    rob.io.in.fromID(i).bits.kill                 := ctrl(i).kill
    rob.io.in.fromID(i).bits.rocc_cmd             := ctrl(i).rocc_cmd
  }

  //= issue ==================================================

  station.io.exu_statu(0) := fixPointU.io.in.ready
  station.io.exu_statu(1) := mem.io.in.ready

  val tmp_ex_data = Wire(Vec(2, new Bundle{
    val a = UInt(p(XLen).W)
    val b = UInt(p(XLen).W)
  }))

  for(i <- 0 until 2){
    prfile.io.read(i).raddr1 := station.io.out(i).bits.info.pr1
    prfile.io.read(i).raddr2 := station.io.out(i).bits.info.pr2

    rob.io.read(i)(0).stationIdx.valid := station.io.out(i).valid
    rob.io.read(i)(0).stationIdx.bits  := station.io.out(i).bits.info.pr1_robIdx
    rob.io.read(i)(1).stationIdx.valid := station.io.out(i).valid
    rob.io.read(i)(1).stationIdx.bits  := station.io.out(i).bits.info.pr2_robIdx

    // 其中reg需要从物理寄存器和rob中选择
    tmp_ex_data(i).a := Mux(station.io.out(i).bits.info.pr1_inROB & (station.io.out(i).bits.info.pr1 =/= 0.U), rob.io.read(i)(0).data.bits, prfile.io.read(i).rdata1)
    // 其中reg需要也是要从物理寄存器和rob中选择
    tmp_ex_data(i).b := Mux(station.io.out(i).bits.info.pr2_inROB & (station.io.out(i).bits.info.pr2 =/= 0.U), rob.io.read(i)(1).data.bits, prfile.io.read(i).rdata2)
  }

  val issue_0_valid = RegInit(false.B)
  issue_0_valid := Mux(rob_flush, false.B, Mux(station.io.out(0).fire(), true.B, Mux(fixPointU.io.in.fire(), false.B, issue_0_valid)))  // 握手信号打拍子，允许exu ready无效的时候数据还能进入reg中
  val ex_data_0 = RegEnable(tmp_ex_data(0), 0.U.asTypeOf(tmp_ex_data.head), station.io.out(0).fire())
  val issue_0 = RegEnable(station.io.out(0).bits, 0.U.asTypeOf(station.io.out(0).bits), station.io.out(0).fire())
  station.io.out(0).ready := fixPointU.io.in.ready | !issue_0_valid

  val issue_1_valid = RegInit(false.B)
  issue_1_valid := Mux(rob_flush, false.B, Mux(station.io.out(1).fire(), true.B, Mux(mem.io.in.fire(), false.B, issue_1_valid)))
  val ex_data_1 = RegEnable(tmp_ex_data(1), 0.U.asTypeOf(tmp_ex_data.head), station.io.out(1).fire())
  val issue_1 = RegEnable(station.io.out(1).bits, 0.U.asTypeOf(station.io.out(1).bits), station.io.out(1).fire())
  station.io.out(1).ready := mem.io.in.ready | !issue_1_valid

  //= ex ==================================================
  // fixpointU
  fixPointU.io.in.valid         := issue_0_valid
//  fixPointU.io.in.bits.pr1_data := ex_data_0.a
//  fixPointU.io.in.bits.pr2_data := ex_data_0.b
  fixPointU.io.in.bits.A        := Mux(issue_0.info.A_sel === A_RS1, ex_data_0.a, issue_0.info.pc)
  fixPointU.io.in.bits.B        := Mux(issue_0.info.B_sel === B_RS2, ex_data_0.b, issue_0.info.imm)
  fixPointU.io.in.bits.imm      := issue_0.info.imm
  fixPointU.io.in.bits.prd      := issue_0.info.prd
  fixPointU.io.in.bits.pTaken   := issue_0.info.pTaken
  fixPointU.io.in.bits.pPC      := issue_0.info.pPC
  fixPointU.io.in.bits.alu_op   := issue_0.info.alu_op
  fixPointU.io.in.bits.br_type  := issue_0.info.br_type
  fixPointU.io.in.bits.wb_type  := issue_0.info.wb_type
  fixPointU.io.in.bits.wen      := issue_0.info.wen
  fixPointU.io.in.bits.pc       := issue_0.info.pc
  fixPointU.io.in.bits.inst     := issue_0.info.inst
  fixPointU.io.in.bits.except   := issue_0.info.except
  fixPointU.io.in.bits.idx      := issue_0.idx
  fixPointU.io.kill             := rob_flush
  dontTouch(fixPointU.io)

  // memU
  mem.io.in.valid          := issue_1_valid
  mem.io.in.bits.A         := Mux(issue_1.info.A_sel === A_RS1, ex_data_1.a, issue_1.info.pc)
  mem.io.in.bits.B         := Mux(issue_1.info.B_sel === B_RS2, ex_data_1.b, issue_1.info.imm)
  mem.io.in.bits.alu_op    := issue_1.info.alu_op
  mem.io.in.bits.imm       := issue_1.info.imm
  mem.io.in.bits.prd       := issue_1.info.prd
  mem.io.in.bits.ld_type   := issue_1.info.ld_type
  mem.io.in.bits.st_type   := issue_1.info.st_type
  mem.io.in.bits.s_data    := mem.io.in.bits.B
  mem.io.in.bits.wen       := issue_1.info.wen
  mem.io.in.bits.csr_cmd   := issue_1.info.csr_op
  mem.io.in.bits.pc        := issue_1.info.pc
  mem.io.in.bits.inst      := issue_1.info.inst
  mem.io.in.bits.illegal   := issue_1.info.illeage
  mem.io.in.bits.rocc_cmd  := issue_1.info.rocc_cmd
  mem.io.in.bits.idx       := issue_1.idx
  mem.io.kill := rob_flush

  // rocc
  rob.io.in.rocc_queue <> mem.io.rocc_queue

  // mem read rob
  rob.io.memRead <> mem.io.readROB

  // to station
  station.io.cdb(0) <> fixPointU.io.cdb
  station.io.cdb(1) <> mem.io.cdb

  // to rename
  rename.io.cdb(0) <> fixPointU.io.cdb
  rename.io.cdb(1) <> mem.io.cdb

  //= commit ==================================================
//  val flush = WireInit(io.except | io.kill | (io.commit.br_info.valid & !io.commit.br_info.bits.isHit))
  rob_flush := (rob.io.commit.br_info.valid & !rob.io.commit.br_info.bits.isHit) | rob.io.except | rob.io.kill
  rob_kill := rob.io.kill

  station.io.robCommit.except := rob.io.except
  rename.io.robCommit.except := rob.io.except
  station.io.robCommit.flush := rob_flush
  rename.io.robCommit.kill := rob_kill      // rename need to distinguish kill, except and br

  rob.io.in.cdb(0) <> fixPointU.io.cdb
  rob.io.in.cdb(1) <> mem.io.cdb
//  rob.io.memCDB <> mem.io.memCDB

  // to physics registers
  prfile.io.write(0).wen   := rob.io.commit.reg(0).bits.wen
  prfile.io.write(0).waddr := rob.io.commit.reg(0).bits.prn
  prfile.io.write(0).wdata := rob.io.commit.reg(0).bits.data

  prfile.io.write(1).wen   := rob.io.commit.reg(1).bits.wen
  prfile.io.write(1).waddr := rob.io.commit.reg(1).bits.prn
  prfile.io.write(1).wdata := rob.io.commit.reg(1).bits.data

  // to rename
  rename.io.robCommit.reg(0).bits.prn := rob.io.commit2rename(0).bits.prn
  rename.io.robCommit.reg(0).bits.skipWB := rob.io.commit2rename(0).bits.skipWB
  rename.io.robCommit.reg(0).valid := rob.io.commit2rename(0).valid
  rename.io.robCommit.reg(1).bits.prn := rob.io.commit2rename(1).bits.prn
  rename.io.robCommit.reg(1).bits.skipWB := rob.io.commit2rename(1).bits.skipWB
  rename.io.robCommit.reg(1).valid := rob.io.commit2rename(1).valid
  // rob br info to renameMap
  rename.io.robCommit.br_info.valid := rob.io.commit.br_info.valid
  rename.io.robCommit.br_info.bits.isHit := rob.io.commit.br_info.bits.isHit
  rename.io.robCommit.br_info.bits.current_rename_state := rob.io.commit.br_info.bits.current_rename_state
  rename.io.robCommit.br_info.bits.isJ := rob.io.commit.br_info.bits.isJ

  // to station
  station.io.robCommit.reg(0).valid := rob.io.commit2station(0).valid
  station.io.robCommit.reg(0).bits.prn := rob.io.commit2station(0).bits.prn
  station.io.robCommit.reg(0).bits.wen := rob.io.commit2station(0).bits.wen
  station.io.robCommit.reg(1).valid := rob.io.commit2station(1).valid
  station.io.robCommit.reg(1).bits.prn := rob.io.commit2station(1).bits.prn
  station.io.robCommit.reg(1).bits.wen := rob.io.commit2station(1).bits.wen
  // rob br info to station
  station.io.robCommit.br_info.valid := rob.io.commit.br_info.valid
  station.io.robCommit.br_info.bits.isHit := rob.io.commit.br_info.bits.isHit

//  val rocc_add = Module(new RoCCAdder)
  val gemm = Module(new GEMMDummy(32, 16*8, 4))
  //rob <> rocc
  rob.io.commit2rocc.cmd <> gemm.io.rocc.cmd
  rob.io.commit2rocc.resp <> gemm.io.rocc.resp

  dcacheCrossBar.io.in(0) <> gemm.io.rocc.dcache
  dcacheCrossBar.io.in(1) <> rob.io.commit.dcache
  dcacheCrossBar.io.in(2) <> mem.io.dcache

  mmu.io.from_inst <> ifet.io.icache
  mmu.io.from_data <> dcacheCrossBar.io.out
  mmu.io.to_icache <> io.icache
  mmu.io.to_dcache <> io.dcache
  mmu.io.sfence_vma := rob.io.commit.reg(0).bits.sfence_vma_do & rob.io.commit.reg(0).fire

//  dcacheCrossBar.io.out <> io.dcache
//  ifet.io.icache <> io.icache

  if(p(Difftest)){
    println(">>>>>>>> difftest mode!")
    for(i <- 0 until 2){
      val commitPort = rob.io.commit.reg(i)
      val renameQueryPort = rename.io.difftest.get.toInstCommit(i)
      val dic = Module(new DifftestInstrCommit)
      dic.io.clock := clock
      dic.io.coreid := 0.U
      dic.io.index := i.U
      dic.io.valid := RegNext(commitPort.valid)
      dic.io.pc := RegNext(commitPort.bits.pc)
      dic.io.instr := RegNext(commitPort.bits.inst)
      dic.io.skip := RegNext(
        (  (commitPort.bits.inst === "h0000007b".U)   // putch
          |((commitPort.bits.isST | commitPort.bits.isLD) & (p(CLINTRegs).values.map(commitPort.bits.memAddress === _.U).reduce(_|_))) // clint
          |(commitPort.bits.inst === BitPat("b101100000000_?????_010_?????_1110011"))   // mcycle
          |(commitPort.bits.inst(6, 0) === BitPat("b0001011"))          // custom_0
          )
      )
      dic.io.isRVC := false.B
      dic.io.scFailed := false.B
      dic.io.wen := RegNext(commitPort.bits.wen)
      dic.io.wdata := RegNext(commitPort.bits.data)

      renameQueryPort.rename_state.bits := commitPort.bits.current_rename_state
      renameQueryPort.rename_state.valid := commitPort.valid
      renameQueryPort.pr.bits := commitPort.bits.prn
      renameQueryPort.pr.valid := true.B
      dic.io.wdest := RegNext(renameQueryPort.lr.bits)

    }

    val cycleCnt = RegInit(0.U(64.W))
    cycleCnt := cycleCnt + 1.U
    BoringUtils.addSource(cycleCnt, "cycleCnt")
    val instCnt = RegInit(0.U(64.W))
    when(rob.io.commit.reg(0).valid & rob.io.commit.reg(1).valid){
      instCnt := instCnt + 2.U
    }.elsewhen((!rob.io.commit.reg(0).valid) & (!rob.io.commit.reg(1).valid)){
      // no commit
    }.otherwise{
      instCnt := instCnt + 1.U
    }

    val dte = Module(new DifftestTrapEvent)
    dte.io.clock := clock
    dte.io.coreid := 0.U
    dte.io.valid := RegNext(
       ((rob.io.commit.reg(0).bits.inst === "h0000006b".U) & rob.io.commit.reg(0).valid)
      |((rob.io.commit.reg(1).bits.inst === "h0000006b".U) & rob.io.commit.reg(1).valid)
    )
    dte.io.code := prfile.io.difftest.get.trap_cpode.data.bits
    dte.io.pc := RegNext(Mux(rob.io.commit.reg(0).valid, rob.io.commit.reg(0).bits.pc, rob.io.commit.reg(1).bits.pc))
    dte.io.cycleCnt := cycleCnt
    dte.io.instrCnt := instCnt


    // todo: difftest uart
    val difftest_uart_valid = Wire(Bool())
    val difftest_uart_ch    = Wire(UInt(8.W))
    BoringUtils.addSource(difftest_uart_valid, "difftest_uart_valid")
    BoringUtils.addSource(difftest_uart_ch, "difftest_uart_ch")
    difftest_uart_valid := RegNext((rob.io.commit.reg(0).valid & (rob.io.commit.reg(0).bits.inst === "h0000007b".U)) | (rob.io.commit.reg(1).valid & (rob.io.commit.reg(1).bits.inst === "h0000007b".U)))
    difftest_uart_ch := prfile.io.difftest.get.trap_cpode.data.bits

    // arch register
    (rename.io.difftest.get.toArchReg, prfile.io.difftest.get.findArchReg).zipped.foreach(_ <> _)

    // branch
    val total_br_cnt = RegInit(0.U(64.W))
    val hit_cnt      = RegInit(0.U(64.W))
    val miss_cnt     = RegInit(0.U(64.W))
    when(rob.io.commit.reg(0).fire){
      when(rob.io.commit.reg(0).bits.isBr_J){
        total_br_cnt := total_br_cnt + 1.U
        when(rob.io.commit.reg(0).bits.isHit){
          hit_cnt := hit_cnt + 1.U
        }.otherwise{
          miss_cnt := miss_cnt + 1.U
        }
      }
    }

    // end
    when(dte.io.valid){
      printf("\n*** insts num=%d ***\n", instCnt)
      printf(  "***    cycles=%d ***\n", cycleCnt)
      printf("\n***    hit br=%d ***\n", hit_cnt)
      printf(  "***   miss br=%d ***\n", miss_cnt)
      printf(  "***  total br=%d ***\n", total_br_cnt)
    }
  }
}
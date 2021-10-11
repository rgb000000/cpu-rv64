package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import chisel3.util.experimental.BoringUtils

class OOO(implicit p: Parameters) extends Module {
  val io = IO(new Bundle {
    val icache = Flipped(new CacheCPUIO)
    val dcache = Flipped(new CacheCPUIO)

    val control = Flipped(new ControlIO)
    val time_interrupt = Input(Bool())
  })

  import Control._

  // ifet
  val ifet = Module(new OOOIF)
  // id
  val id = Vec(2, Module(new ID))
  val control = Vec(2, Module(new Control))
  val rename = Module(new RenameMap)
  // issue
  val station = Module(new Station)
  // ex
  val prfile = Module(new PRFile)
  val fixPointU = Module(new FixPointU)
  val mem = Module(new MemU)
  // commit
  val rob = Module(new ROB)


  // some intermediate signals
  val station_isfull = !station.io.in.ready

  val time_interrupt_enable = WireInit(false.B)
  val soft_interrupt_enable = WireInit(false.B)
  val external_interrupt_enable = WireInit(false.B)
  BoringUtils.addSink(time_interrupt_enable, "time_interrupt_enable")
  BoringUtils.addSink(soft_interrupt_enable, "soft_interrupt_enable")
  BoringUtils.addSink(external_interrupt_enable, "external_interrupt_enable")

  val soft_int = WireInit(false.B)
  val external_int = WireInit(false.B)
  BoringUtils.addSink(soft_int, "soft_int")
  BoringUtils.addSink(external_int, "external_int")

  //= ifet ==================================================
  ifet.io.icache <> io.icache

  val if_reg = RegEnable(ifet.io.out, 0.U.asTypeOf(ifet.io.out), !station_isfull)

  //= decoder ==================================================
  val ctrl = Vec(2, (new ControlIO).signal)
  for(i <- 0 until 2){
    control(i).io.inst := if_reg(i).bits.inst
    id(i).io.inst := if_reg(i).bits.inst
    id(i).io.imm_sel := control(i).io.signal.imm_sel
    ctrl(i) := control(i).io.signal
  }

  for(i <- 0 until 2){
    // query a and b pr, only rs1 and rs2 is register
    rename.io.port(i).bits.query_a.lr.bits  := id(i).io.rs1_addr
    rename.io.port(i).bits.query_a.lr.valid := control(i).io.signal.a_sel === A_RS1
    rename.io.port(i).bits.query_b.lr.bits  := id(i).io.rs2_addr
    rename.io.port(i).bits.query_b.lr.valid := control(i).io.signal.b_sel === B_RS2
    // allocate c, only need write back
    rename.io.port(i).bits.allocate_c.lr.bits  := id(i).io.rd_addr
    rename.io.port(i).bits.allocate_c.lr.valid := control(i).io.signal.wen
  }

  val id_interrupt = RegEnable(Cat(Seq(
    io.time_interrupt & time_interrupt_enable,
    soft_int & soft_interrupt_enable,
    external_int & external_interrupt_enable
  )), 0.U(3.W), !station_isfull)

  for(i <- 0 until 2){
    station.io.in.bits(i).pr1     := rename.io.port(i).bits.query_a.pr.bits.idx
    station.io.in.bits(i).pr1_s   := rename.io.port(i).bits.query_a.pr.bits.isReady
    station.io.in.bits(i).pc      := if_reg(i).bits.pc
    station.io.in.bits(i).pr2     := rename.io.port(i).bits.query_b.pr.bits.idx
    station.io.in.bits(i).pr2_s   := rename.io.port(i).bits.query_b.pr.bits.isReady
    station.io.in.bits(i).imm     := id(i).io.imm
    station.io.in.bits(i).prd     := rename.io.port(i).bits.allocate_c.pr.bits
    station.io.in.bits(i).A_sel   := ctrl(i).a_sel
    station.io.in.bits(i).B_sel   := ctrl(i).b_sel
    station.io.in.bits(i).alu_op  := ctrl(i).alu_op
    station.io.in.bits(i).ld_type := ctrl(i).ld_type
    station.io.in.bits(i).st_type := ctrl(i).st_type
    station.io.in.bits(i).csr_op  := ctrl(i).csr_cmd
    station.io.in.bits(i).wb_type := ctrl(i).wb_type
    station.io.in.bits(i).wen     := ctrl(i).wen
    station.io.in.bits(i).illeage := ctrl(i).illegal
    station.io.in.bits(i).inst    := if_reg(i).bits.inst
    station.io.in.bits(i).state   := 1.U // wait to issue
  }

  //= issue ==================================================

  station.io.exu_statu(0) := fixPointU.io.in.ready
  station.io.exu_statu(1) := mem.io.in.ready

  val tmp_ex_data = Vec(2, new Bundle{
    val a = UInt(p(XLen).W)
    val b = UInt(p(XLen).W)
  })

  for(i <- 0 until 2){
    prfile.io.read(i).raddr1      := station.io.out(i).bits.info.pr1
    prfile.io.read(i).raddr2      := station.io.out(i).bits.info.pr2

    tmp_ex_data(i).a := prfile.io.read(i).rdata1
    tmp_ex_data(i).b := prfile.io.read(i).rdata2
  }

  val ex_data_0 = RegEnable(tmp_ex_data(0), 0.U.asTypeOf(tmp_ex_data.head), fixPointU.io.in.ready)
  val issue_0 = RegEnable(station.io.out(0).bits.info, 0.U.asTypeOf(station.io.out(0).bits.info), fixPointU.io.in.ready)

  val ex_data_1 = RegEnable(tmp_ex_data(1), 0.U.asTypeOf(tmp_ex_data.head), mem.io.in.ready)
  val issue_1 = RegEnable(station.io.out(1).bits.info, 0.U.asTypeOf(station.io.out(1).bits.info), mem.io.in.ready)

  //= ex ==================================================
  // fixpointU
  fixPointU.io.in.bits.A        := Mux(issue_0.A_sel === A_RS1, ex_data_0.a, issue_0.pc)
  fixPointU.io.in.bits.B        := Mux(issue_0.B_sel === B_RS2, ex_data_0.b, issue_0.imm)
  fixPointU.io.in.bits.prd      := issue_0.prd
  fixPointU.io.in.bits.p_br     := issue_0.p_br
  fixPointU.io.in.bits.alu_op   := issue_0.alu_op
  fixPointU.io.in.bits.br_type  := issue_0.br_type
  fixPointU.io.in.bits.wb_type  := issue_0.wb_type
  fixPointU.io.in.bits.wen      := issue_0.wen

  // memU
  mem.io.in.bits.A         := Mux(station.io.out(1).bits.info.A_sel === A_RS1, prfile.io.read(1).rdata1, issue_1.pc)
  mem.io.in.bits.B         := Mux(station.io.out(1).bits.info.B_sel === B_RS2, prfile.io.read(1).rdata2, issue_1.imm)
  mem.io.in.bits.alu_op    := issue_1.alu_op
  mem.io.in.bits.prd       := issue_1.prd
  mem.io.in.bits.ld_type   := issue_1.ld_type
  mem.io.in.bits.st_type   := issue_1.st_type
  mem.io.in.bits.s_data    := mem.io.in.bits.B
  mem.io.in.bits.csr_cmd   := issue_1.csr_op
  mem.io.in.bits.pc        := issue_1.pc
  mem.io.in.bits.inst      := issue_1.inst
  mem.io.in.bits.illegal   := issue_1.illeage
  mem.io.in.bits.interrupt := id_interrupt

  station.io.cdb(0) <> fixPointU.io.cdb
  station.io.cdb(1) <> mem.io.cdb

  rename.io.cdb(0) <> fixPointU.io.cdb
  rename.io.cdb(1) <> mem.io.cdb

  //= commit ==================================================
  rob.io.in.cdb(0) <> fixPointU.io.cdb
  rob.io.in.cdb(1) <> mem.io.cdb
  rob.io.in.idxWantCommit.bits(0) := station.io.idxWaitCommit.bits(0)
  rob.io.in.idxWantCommit.bits(1) := station.io.idxWaitCommit.bits(1)

  prfile.io.write(0).wen   := rob.io.commit.reg(0).wen
  prfile.io.write(0).waddr := rob.io.commit.reg(0).prn
  prfile.io.write(0).wdata := rob.io.commit.reg(0).data

  prfile.io.write(1).wen   := rob.io.commit.reg(1).wen
  prfile.io.write(1).waddr := rob.io.commit.reg(1).prn
  prfile.io.write(1).wdata := rob.io.commit.reg(1).data

  rename.io.robCommit(0) <> rob.io.commit2rename(0)
  rename.io.robCommit(1) <> rob.io.commit2rename(1)
}
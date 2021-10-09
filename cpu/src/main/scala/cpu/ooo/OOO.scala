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
  val ifet = Module(new IF)
  // id
  val id = Module(new ID)
  val control = Module(new Control)
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

  val if_pc     = RegEnable(ifet.io.out.bits.pc,     0.U, !station_isfull)
  val if_pTaken = RegEnable(ifet.io.out.bits.pTaken, 0.U, !station_isfull)
  val if_pPC    = RegEnable(ifet.io.out.bits.pPC,    0.U, !station_isfull)
  val if_inst   = RegEnable(ifet.io.out.bits.inst,   0.U, !station_isfull)
  val if_valid  = RegEnable(ifet.io.out.valid,       0.U, !station_isfull)

  //= decoder ==================================================
  control.io.inst := if_inst
  id.io.inst := if_inst
  id.io.imm_sel := control.io.signal.imm_sel
  val ctrl = control.io.signal

  // query a and b pr, only rs1 and rs2 is register
  rename.io.query_a.lr.bits := id.io.rs1_addr
  rename.io.query_a.lr.valid := control.io.signal.a_sel === A_RS1
  rename.io.query_b.lr.bits := id.io.rs2_addr
  rename.io.query_b.lr.valid := control.io.signal.b_sel === B_RS2
  // allocate c, only need write back
  rename.io.allocate_c.lr.bits := id.io.rd_addr
  rename.io.allocate_c.lr.valid := control.io.signal.wen

  val id_pr1    = RegEnable(rename.io.query_a.pr.bits.idx,      0.U, !station_isfull)
  val id_pr1_s  = RegEnable(rename.io.query_a.pr.bits.isReady,  0.U, !station_isfull)
  val id_pr2    = RegEnable(rename.io.query_b.pr.bits.idx,      0.U, !station_isfull)
  val id_pr2_s  = RegEnable(rename.io.query_b.pr.bits.isReady,  0.U, !station_isfull)
  val id_prd    = RegEnable(rename.io.allocate_c.pr.bits,       0.U, !station_isfull)
  val id_imm    = RegEnable(id.io.imm,                 0.U, !station_isfull)
  val id_inst   = RegEnable(if_inst,                   0.U, !station_isfull)
  val id_pc     = RegEnable(if_pc,                     0.U, !station_isfull)
  val id_pTaken = RegEnable(if_pTaken,                 0.U, !station_isfull)
  val id_pPC    = RegEnable(if_pPC,                    0.U, !station_isfull)
  val id_valid  = RegEnable(if_valid,                  0.U, !station_isfull)
  val id_interrupt = RegEnable(Cat(Seq(
    io.time_interrupt & time_interrupt_enable,
    soft_int & soft_interrupt_enable,
    external_int & external_interrupt_enable
  )), 0.U(3.W), !station_isfull)
  val id_ctrl = Map(
    "pc_sel"  -> RegEnable(ctrl.pc_sel,   0.U, !station_isfull),
    "a_sel"   -> RegEnable(ctrl.a_sel,    0.U, !station_isfull),
    "b_sel"   -> RegEnable(ctrl.b_sel,    0.U, !station_isfull),
//  "imm_sel" -> RegEnable(ctrl.imm_sel,  0.U, !station_isfull),
    "alu_op"  -> RegEnable(ctrl.alu_op,   0.U, !station_isfull),
    "br_type" -> RegEnable(ctrl.br_type,  0.U, !station_isfull),
    "kill"    -> RegEnable(ctrl.kill,     0.U, !station_isfull),
    "st_type" -> RegEnable(ctrl.st_type,  0.U, !station_isfull),
    "ld_type" -> RegEnable(ctrl.ld_type,  0.U, !station_isfull),
    "wb_type" -> RegEnable(ctrl.wb_type,  0.U, !station_isfull),
    "wen"     -> RegEnable(ctrl.wen,      0.U, !station_isfull),
    "csr_cmd" -> RegEnable(ctrl.csr_cmd,  0.U, !station_isfull),
    "illegal" -> RegEnable(ctrl.illegal,  0.U, !station_isfull)
  )

  //= issue ==================================================
  station.io.in.bits.pr1     := id_pr1
  station.io.in.bits.pr1_s   := id_pr1_s
  station.io.in.bits.pc      := id_pc
  station.io.in.bits.A_sel   := id_ctrl("a_sel")
  station.io.in.bits.pr2     := id_pr2
  station.io.in.bits.pr2_s   := id_pr2_s
  station.io.in.bits.imm     := id_imm
  station.io.in.bits.B_sel   := id_ctrl("b_sel")
  station.io.in.bits.prd     := id_prd
  station.io.in.bits.alu_op  := id_ctrl("alu_op")
  station.io.in.bits.ld_type := id_ctrl("ld_type")
  station.io.in.bits.st_type := id_ctrl("st_type")
  station.io.in.bits.csr_op  := id_ctrl("csr_cmd")
  station.io.in.bits.wb_type := id_ctrl("wb_type")
  station.io.in.bits.state   := 1.U // wait to issue

  station.io.exu_statu(0) := fixPointU.io.in.ready
  station.io.exu_statu(1) := mem.io.in.ready

  //= ex ==================================================
  // fixpointU
  prfile.io.read(0).raddr1      := id_pr1
  prfile.io.read(0).raddr2      := id_pr2
  fixPointU.io.in.bits.A        := Mux(station.io.out(0).bits.info.A_sel === A_RS1, prfile.io.read(0).rdata1, id_pc)
  fixPointU.io.in.bits.B        := Mux(station.io.out(0).bits.info.B_sel === B_RS2, prfile.io.read(0).rdata2, id_imm)
  fixPointU.io.in.bits.prd      := id_prd
  fixPointU.io.in.bits.p_br     := id_pTaken
  fixPointU.io.in.bits.alu_op   := id_ctrl("alu_op")
  fixPointU.io.in.bits.br_type  := id_ctrl("br_type")
  fixPointU.io.in.bits.wb_type  := id_ctrl("wb_type")
  fixPointU.io.in.bits.wen      := id_ctrl("wen")

  // memU
  mem.io.in.bits.A         := Mux(station.io.out(1).bits.info.A_sel === A_RS1, prfile.io.read(1).rdata1, id_pc)
  mem.io.in.bits.B         := Mux(station.io.out(1).bits.info.B_sel === B_RS2, prfile.io.read(1).rdata2, id_imm)
  mem.io.in.bits.alu_op    := id_ctrl("alu_op")
  mem.io.in.bits.prd       := id_prd
  mem.io.in.bits.ld_type   := id_ctrl("ld_type")
  mem.io.in.bits.st_type   := id_ctrl("st_type")
  mem.io.in.bits.s_data    := mem.io.in.bits.B
  mem.io.in.bits.csr_cmd   := id_ctrl("csr_cmd")
  mem.io.in.bits.pc        := id_pc
  mem.io.in.bits.inst      := id_inst
  mem.io.in.bits.illegal   := id_ctrl("illegal")
  mem.io.in.bits.interrupt := id_interrupt

  //= commit ==================================================
  rob.io.in.cdb(0) <> fixPointU.io.cdb
  rob.io.in.cdb(1) <> mem.io.cdb
  rob.io.in.idxWantCommit.bits(0) := station.io.idxWaitCommit.bits(0)
  rob.io.in.idxWantCommit.bits(1) := station.io.idxWaitCommit.bits(1)

  prfile.io.write(0).wen := fixPointU.io.cdb.bits.wen
  prfile.io.write(0).waddr := fixPointU.io.cdb.bits.prn
  prfile.io.write(0).wdata := fixPointU.io.cdb.bits.data

  prfile.io.write(1).wen := mem.io.cdb.bits.wen
  prfile.io.write(1).waddr := mem.io.cdb.bits.prn
  prfile.io.write(1).wdata := mem.io.cdb.bits.data

}
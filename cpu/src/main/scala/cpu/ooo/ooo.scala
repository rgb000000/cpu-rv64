package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class OOO(implicit p: Parameters) extends Module{
    val io = IO(new Bundle{
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


    //= ifet
    ifet.io.icache <> io.icache

    //= decoder
    control.io.inst := if_inst
    id.io.inst := if_inst
    id.io.imm_sel := control.io.signal.imm_sel

    // query a and b pr, only rs1 and rs2 is register
    rename.io.query_a.lr.bits := id.io.rs1_addr
    rename.io.query_a.lr.valid := control.io.signal.a_sel === A_RS1
    rename.io.query_b.lr.bits := id.io.rs2_addr
    rename.io.query_b.lr.valid := control.io.signal.b_sel === B_RS2
    // allocate c, only need write back
    rename.io.allocate_c.lr.bits := id.io.rd_addr
    rename.io.allocate_c.lr.valid := control.io.signal.wen

    //= issue
    station.io.in.bits.pr1 := id_pr1
    station.io.in.bits.pr1_s := prfile_pr1_s
    station.io.in.bits.pc := id_pc
    station.io.in.bits.A_sel := id_ctrl_a_sel
    station.io.in.bits.pr2 := id_pr2
    station.io.in.bits.pr2_s := prfile_pr2_s
    station.io.in.bits.imm := id_imm
    station.io.in.bits.B_sel := id_b_sel
    station.io.in.bits.prd := id_prd
    station.io.in.bits.alu_op := id_alu_op
    station.io.in.bits.ld_type := id_alu_op
    station.io.in.bits.st_type := id_alu_op
    station.io.in.bits.csr_op := id_alu_op
    station.io.in.bits.wb_type := id_alu_op
    station.io.in.bits.state := 1.U // wait to issue

    //= ex


    //= commit
}
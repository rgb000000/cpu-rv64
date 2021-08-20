package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import chisel3.util.experimental.loadMemoryFromFileInline

import difftest._

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

  val ctrl = io.control

  val stall = RegNext(io.dcache.req.valid & !io.dcache.req.ready) | !io.dcache.req.ready | !io.icacahe.resp.valid | !io.dcache.resp.valid | (ifet.io.out.valid & (ctrl.ld_type.orR() | ctrl.st_type.orR()))

  // fetch
  ifet.io.icache <> io.icacahe
  ifet.io.pc_sel := io.control.pc_sel
  ifet.io.pc_alu := ex.io.out
  ifet.io.pc_epc := BitPat.bitPatToUInt(ISA.nop)
  ifet.io.stall := stall
  ifet.io.br_taken := br.io.taken

  // decode
  // control signal
  ctrl.inst := ifet.io.out.bits.inst

  id.io.inst := ifet.io.out.bits.inst
  id.io.imm_sel := ctrl.imm_sel
  regs.io.raddr1 := id.io.rs1_addr
  regs.io.raddr2 := id.io.rs2_addr
  val rd_addr = id.io.rd_addr

  br.io.rs1 := regs.io.rdata1
  br.io.rs2 := regs.io.rdata2
  br.io.br_type := ctrl.br_type

  // ex
  val A = Mux(ctrl.a_sel === A_PC, ifet.io.out.bits.pc, regs.io.rdata1)
  val B = Mux(ctrl.b_sel === B_IMM, id.io.imm, regs.io.rdata2)

  ex.io.alu_op := ctrl.alu_op
  ex.io.rs1 := A
  ex.io.rs2 := B

  // mem
  mem.io.dcache <> io.dcache
  mem.io.ld_type := ctrl.ld_type
  mem.io.st_type := ctrl.st_type
  mem.io.s_data := regs.io.rdata2
  mem.io.alu_res := ex.io.out
  mem.io.stall := stall
  mem.io.inst_valid := ifet.io.out.valid
  val l_data = mem.io.l_data

  //wb
  regs.io.waddr := rd_addr
  regs.io.wdata := MuxLookup(ctrl.wb_type, 0.U, Array(
    WB_ALU -> ex.io.out,
    WB_MEM -> l_data.bits,
    WB_PC4 -> (ifet.io.out.bits.pc + 4.U)
  ))
  regs.io.wen := (ctrl.wen & !stall & ifet.io.out.valid) | mem.io.l_data.valid

  val commit_valid  = Wire(Bool())
  commit_valid := (ifet.io.out.valid & !stall) | mem.io.l_data.valid | mem.io.s_complete
  dontTouch(commit_valid)

  dontTouch(regs.io.wdata)

  val cycleCnt = Counter(65536)
  cycleCnt.inc()
  val instCnt = Counter(65536)
  when(ifet.io.out.valid){
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
    dic.io.pc := RegNext(ifet.io.out.bits.pc)
    dic.io.instr := RegNext(ifet.io.out.bits.inst)
    dic.io.skip := false.B
    dic.io.isRVC := false.B
    dic.io.scFailed := false.B
    dic.io.wen := RegNext(regs.io.wen)
    dic.io.wdata := RegNext(regs.io.wdata)
    dic.io.wdest := RegNext(regs.io.waddr)

    val dte = Module(new DifftestTrapEvent)
    dte.io.clock := clock
    dte.io.coreid := 0.U
    dte.io.valid := RegNext(ifet.io.out.bits.inst === "h0000006b".U)
    dte.io.code := regs.io.trap_code.getOrElse(1.U)
    dte.io.pc := RegNext(ifet.io.out.bits.pc)
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

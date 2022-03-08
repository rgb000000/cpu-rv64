package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import cpu.{RoCCCommand, RoCCIO, RoCCRespone}

class CtrlIO(val depth: Int, val w: Int, val nbank: Int)(implicit val p: Parameters) extends Bundle {
  val rocc_cmd = Flipped(Decoupled(new RoCCCommand))
  val rocc_resp = Decoupled(new RoCCRespone)
  val dmaCtrl = Flipped(new DMACtrl())
  val exCtrl = Flipped(new ExCtrl(depth, w, nbank))
}

trait CtrlConst {
  val MVIN_OP  = "b1000000".U
  val MVOUT_OP = "b1000001".U
  val GEMM     = "b1000010".U
}

class Ctrl(val depth: Int, val w: Int, val nbank: Int)(implicit val p: Parameters) extends Module with CtrlConst {
  val io = IO(new CtrlIO(depth, w, nbank))

  val s_idle :: s_dma :: s_dma_done :: s_ex :: s_ex_done :: Nil = Enum(5)
  val state = RegInit(s_idle)

  // dma
  val isDMA = (io.rocc_cmd.bits.inst.funct === MVIN_OP) | (io.rocc_cmd.bits.inst.funct === MVOUT_OP)
  val addr_spad = io.rocc_cmd.bits.inst.rs1  // 0-7
  val addr_mem = io.rocc_cmd.bits.rs2

  // gemm
  val isGEMM = io.rocc_cmd.bits.inst.funct === GEMM
  val gemm_n = io.rocc_cmd.bits.inst.rs1

  val req = RegInit(io.rocc_cmd.bits)

  switch(state){
    is(s_idle){
      when(io.rocc_cmd.fire()){
        assert((isGEMM | isDMA) === true.B)
        state := Mux(isGEMM, s_ex, s_dma)
      }
    }

    is(s_dma){
      state := Mux(io.dmaCtrl.cmd.fire(), s_dma_done, state)
    }

    is(s_dma_done){
      state := Mux(io.dmaCtrl.done, s_idle, state)
    }

    is(s_ex){
      state := Mux(io.exCtrl.cmd.fire(), s_ex_done, state)
    }

    is(s_ex_done){
      state := Mux(io.exCtrl.done, s_idle, state)
    }
  }

  when(state === s_idle){
    when(io.rocc_cmd.fire()){
      req := io.rocc_cmd.bits
    }
  }

  io.rocc_cmd.ready := state === s_idle

  io.rocc_resp.valid := ((state === s_dma_done) & io.dmaCtrl.done) | ((state === s_ex_done) & io.exCtrl.done)
  io.rocc_resp.bits.rd := 0.U
  io.rocc_resp.bits.data := 0.U

  io.dmaCtrl.cmd.valid := state === s_dma
  io.dmaCtrl.cmd.bits.op := Mux(req.inst.funct === MVIN_OP, 1.U, 0.U)
  io.dmaCtrl.cmd.bits.addr_local := req.rs1
  io.dmaCtrl.cmd.bits.addr_mem := req.rs2
  io.dmaCtrl.cmd.bits.len := 16.U    // todo: len是否需要起作用，还是说dma操作就是固定16次?

  io.exCtrl.cmd.valid := state === s_ex
  //    0: d        2: a        4: d        6: a
  //    1: b        3: c        5: b        7: c

  // spad深度等于2倍的pe阵列行数
  val base = log2Ceil(depth/2)
  io.exCtrl.cmd.bits.a_addr := Mux(req.rs1 === 0.U, 2.U, 6.U) << base
  io.exCtrl.cmd.bits.b_addr := Mux(req.rs1 === 0.U, 1.U, 5.U) << base
  io.exCtrl.cmd.bits.c_addr := Mux(req.rs1 === 0.U, 3.U, 7.U) << base
  io.exCtrl.cmd.bits.d_addr := Mux(req.rs1 === 0.U, 0.U, 4.U) << base
}

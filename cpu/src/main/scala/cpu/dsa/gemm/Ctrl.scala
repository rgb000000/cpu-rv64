package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import cpu.{RoCCCommand, RoCCIO, RoCCRespone, XLen}

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


  // Decode and save to task_q
  // task Queue
  val MVOUT = 0.U(2.W)
  val MVIN  = 1.U(2.W)
  val GEMMX  = 3.U(2.W)

  val tmp_task = Wire(Decoupled(new Bundle{
    val op         = UInt(2.W)

    // dma
    val dma_addr_local = UInt(3.W)
    val dma_addr_mem   = UInt(64.W)
    val dma_step       = UInt(64.W)
    val dma_len        = UInt(8.W)

    // gemm
    val gemm_a_addr = UInt(log2Ceil(depth * nbank).W)
    val gemm_b_addr = UInt(log2Ceil(depth * nbank).W)
    val gemm_d_addr = UInt(log2Ceil(depth * nbank).W)
    val gemm_c_addr = UInt(log2Ceil(depth * nbank).W)
    val gemm_readD  = Bool()
    val gemm_writeC = Bool()
    val gemm_shift  = UInt(3.W)
  }))
  val task_q = Queue(tmp_task, 4, flow=true)

  io.rocc_cmd.ready := tmp_task.ready

  // dma
  val isDMA     = ((io.rocc_cmd.bits.inst.funct === MVIN_OP) | (io.rocc_cmd.bits.inst.funct === MVOUT_OP)) & io.rocc_cmd.fire
  val dma_op    = Mux(io.rocc_cmd.bits.inst.funct === MVIN_OP, 1.U, 0.U)
  val addr_spad = io.rocc_cmd.bits.rs1  // 0-7
  val addr_mem  = io.rocc_cmd.bits.rs2
  val step      = io.rocc_cmd.bits.rs1(p(XLen)-1, 3).asUInt

  // gemm
  val isGEMM = (io.rocc_cmd.bits.inst.funct === GEMM) & io.rocc_cmd.fire
  val base   = log2Ceil(depth/2)
  val a      = io.rocc_cmd.bits.rs1(2, 0).asUInt
  val b      = io.rocc_cmd.bits.rs1(5, 3).asUInt
  val d      = io.rocc_cmd.bits.rs1(8, 6).asUInt
  val c      = io.rocc_cmd.bits.rs1(11, 9).asUInt
  val readD  = io.rocc_cmd.bits.rs1(12).asBool
  val writeC = io.rocc_cmd.bits.rs1(13).asBool
  val shift  = io.rocc_cmd.bits.rs1(16, 14).asUInt

  tmp_task.valid := io.rocc_cmd.valid
  when(isDMA){
    tmp_task.bits.op := dma_op

    tmp_task.bits.dma_addr_local := addr_spad
    tmp_task.bits.dma_addr_mem   := addr_mem
    tmp_task.bits.dma_step       := step
    tmp_task.bits.dma_len        := 16.U

    tmp_task.bits.gemm_a_addr := 0.U
    tmp_task.bits.gemm_b_addr := 0.U
    tmp_task.bits.gemm_d_addr := 0.U
    tmp_task.bits.gemm_c_addr := 0.U
    tmp_task.bits.gemm_readD  := 0.U
    tmp_task.bits.gemm_writeC := 0.U
    tmp_task.bits.gemm_shift  := 0.U
  }.otherwise{
    tmp_task.bits.op := GEMMX

    tmp_task.bits.dma_addr_local := 0.U
    tmp_task.bits.dma_addr_mem   := 0.U
    tmp_task.bits.dma_step       := 0.U
    tmp_task.bits.dma_len        := 0.U

    tmp_task.bits.gemm_a_addr := a << base
    tmp_task.bits.gemm_b_addr := b << base
    tmp_task.bits.gemm_d_addr := d << base
    tmp_task.bits.gemm_c_addr := c << base
    tmp_task.bits.gemm_readD  := readD
    tmp_task.bits.gemm_writeC := writeC
    tmp_task.bits.gemm_shift  := shift
  }

  //    0: a        2: d        4: a        6: d
  //    1: b        3: c        5: b        7: c

  // issue in order
  val is_dma = task_q.bits.op =/= GEMMX
  val is_gemm = task_q.bits.op === GEMMX
  val can_issue = (
     (task_q.valid & is_gemm & io.dmaCtrl.cmd.ready & io.exCtrl.cmd.ready)                 // gemm need dma idle
    |(task_q.valid & is_dma  & (task_q.bits.op===MVIN) & io.dmaCtrl.cmd.ready) // MVIN need dma idle
    |(task_q.valid & is_dma  & (task_q.bits.op===MVOUT) & io.dmaCtrl.cmd.ready & io.exCtrl.cmd.ready) // MVOUT need dma and gemm idle
    )

  // dma
  io.dmaCtrl.cmd.valid           := task_q.valid & is_dma & can_issue
  io.dmaCtrl.cmd.bits.op         := Mux(task_q.bits.op === MVIN, 1.U, 0.U)
  io.dmaCtrl.cmd.bits.addr_local := task_q.bits.dma_addr_local
  io.dmaCtrl.cmd.bits.step       := task_q.bits.dma_step
  io.dmaCtrl.cmd.bits.addr_mem   := task_q.bits.dma_addr_mem
  io.dmaCtrl.cmd.bits.len        := 16.U    // todo: len是否需要起作用，还是说dma操作就是固定16次?
  // gemm
  io.exCtrl.cmd.valid            := task_q.valid & is_gemm & can_issue
  io.exCtrl.cmd.bits.a_addr      := task_q.bits.gemm_a_addr
  io.exCtrl.cmd.bits.b_addr      := task_q.bits.gemm_b_addr
  io.exCtrl.cmd.bits.d_addr      := task_q.bits.gemm_d_addr
  io.exCtrl.cmd.bits.c_addr      := task_q.bits.gemm_c_addr
  io.exCtrl.cmd.bits.readD       := task_q.bits.gemm_readD
  io.exCtrl.cmd.bits.writeC      := task_q.bits.gemm_writeC
  io.exCtrl.cmd.bits.shift       := task_q.bits.gemm_shift

  task_q.ready := can_issue

  dontTouch(io.dmaCtrl.cmd)
  dontTouch(io.exCtrl.cmd)

  val wait_mvout_done = RegInit(false.B)
  when(io.dmaCtrl.cmd.fire & (io.dmaCtrl.cmd.bits.op === MVOUT)){
    wait_mvout_done := true.B
  }.elsewhen(io.dmaCtrl.done){
    wait_mvout_done := false.B
  }

  io.rocc_resp.valid := wait_mvout_done & io.dmaCtrl.done
  io.rocc_resp.bits.rd := 0.U
  io.rocc_resp.bits.data := 0.U
}

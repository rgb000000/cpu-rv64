package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import cpu.RoCCIO

class GEMM(val depth: Int, val w: Int, val nbank: Int)(implicit val p: Parameters) extends Module {
  val io = IO(new Bundle {
    val rocc = new RoCCIO()
  })

  val ctrl = Module(new Ctrl(depth, w, nbank))

  val dma = Module(new DMA(depth, w, nbank))
  val spad = Module(new ScratchPad(depth, w, nbank))

  val ex = Module(new Ex(depth, w, nbank))

  // ctrl
  io.rocc.cmd <> ctrl.io.rocc_cmd
  io.rocc.resp <> ctrl.io.rocc_resp
  ctrl.io.dmaCtrl <> dma.io.ctrl
  ctrl.io.exCtrl <> ex.io.ctrl

  // dcache
  io.rocc.dcache <> dma.io.toCache

  // dma <> spad
  dma.io.toSlave.req <> spad.io.toDMA.req
  dma.io.toSlave.resp <> spad.io.toDMA.resp

  // spad <> ex
  spad.io.toArray <> ex.io.toSPad

  io.rocc.busy := false.B
  io.rocc.interrupt := false.B
  io.rocc.exception := false.B
}

package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class Core (implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val memAXI = Vec(1, new AXI4)
  })

  val datapath = Module(new DataPath)
  val icache = Module(new Cache("i"))
  val dcache = Module(new Cache("d"))
  val control = Module(new Control)
  val crossbar = Module(new InnerCrossBarNN(2, 2))   // [imem, dmem] to [clint, axi]
  val mem2axi = Module(new MemBus2AXI)
  val clint = Module(new CLINT)


  datapath.io.icacahe <> icache.io.cpu  // icache
  datapath.io.dcache <> dcache.io.cpu   // dcache
  datapath.io.control <> control.io     // control
  datapath.io.time_interrupt := clint.io.interrupt // time interrupt

  icache.io.fence_i := datapath.io.fence_i_do
  dcache.io.fence_i := datapath.io.fence_i_do
  datapath.io.fence_i_done := dcache.io.fence_i_done

  // crossbar <> i/d cache
  crossbar.io.in.zip(Seq(icache, dcache).map(_.io.mem)).foreach(info =>{
    val (cb, cache) = info
    cb <> cache
  })

  // crossbar <> clint, mem2axi
  (crossbar.io.out, Seq(clint.io.cpu, mem2axi.io.in)).zipped.foreach(_ <> _)
  // mem2axi <> io.axi
  dontTouch(io)
  mem2axi.io.axi4 <> io.memAXI.head
}

class AXIMaster extends Bundle{
  val awready = Input(Bool())
  val awvalid = Output(Bool())
  val awaddr  = Output(UInt(32.W))
  val awid    = Output(UInt(4.W))
  val awlen   = Output(UInt(8.W))
  val awsize  = Output(UInt(3.W))
  val awburst = Output(UInt(2.W))

  val wready  = Input(Bool())
  val wvalid  = Output(Bool())
  val wdata   = Output(UInt(64.W))
  val wstrb   = Output(UInt(8.W))
  val wlast   = Output(Bool())

  val bready  = Output(Bool())
  val bvalid  = Input(Bool())
  val bresp   = Input(UInt(2.W))
  val bid     = Input(UInt(4.W))

  val arready = Input(Bool())
  val arvalid = Output(Bool())
  val araddr  = Output(UInt(32.W))
  val arid    = Output(UInt(4.W))
  val arlen   = Output(UInt(8.W))
  val arsize  = Output(UInt(3.W))
  val arburst = Output(UInt(2.W))

  val rready  = Output(Bool())
  val rvalid  = Input(Bool())
  val rresp   = Input(UInt(2.W))
  val rdata   = Input(UInt(64.W))
  val rlast   = Input(Bool())
  val rid     = Input(UInt(4.W))
}

class ysyx_210013(implicit p: Parameters) extends Module {
  val io = IO(new Bundle {
    val interrupt = Input(Bool())
    val master = new AXIMaster
    val slave = Flipped(new AXIMaster)
  })

  val core = Module(new Core)

  core.io.memAXI.head.aw.ready := io.master.awready
  io.master.awvalid            := core.io.memAXI.head.aw.valid
  io.master.awaddr             := core.io.memAXI.head.aw.bits.addr
  io.master.awid               := core.io.memAXI.head.aw.bits.id
  io.master.awlen              := core.io.memAXI.head.aw.bits.len
  io.master.awsize             := core.io.memAXI.head.aw.bits.size
  io.master.awburst            := core.io.memAXI.head.aw.bits.burst

  core.io.memAXI.head.w.ready  := io.master.wready
  io.master.wvalid             := core.io.memAXI.head.w.valid
  io.master.wdata              := core.io.memAXI.head.w.bits.data
  io.master.wstrb              := core.io.memAXI.head.w.bits.strb
  io.master.wlast              := core.io.memAXI.head.w.bits.last

  io.master.bready                := core.io.memAXI.head.b.ready
  core.io.memAXI.head.b.valid     := io.master.bvalid
  core.io.memAXI.head.b.bits.resp := io.master.bresp
  core.io.memAXI.head.b.bits.id   := io.master.bid

  core.io.memAXI.head.ar.ready := io.master.arready
  io.master.arvalid            := core.io.memAXI.head.ar.valid
  io.master.araddr             := core.io.memAXI.head.ar.bits.addr
  io.master.arid               := core.io.memAXI.head.ar.bits.id
  io.master.arlen              := core.io.memAXI.head.ar.bits.len
  io.master.arsize             := core.io.memAXI.head.ar.bits.size
  io.master.arburst            := core.io.memAXI.head.ar.bits.burst

  io.master.rready                := core.io.memAXI.head.r.ready
  core.io.memAXI.head.r.valid     := io.master.rvalid
  core.io.memAXI.head.r.bits.resp := io.master.rresp
  core.io.memAXI.head.r.bits.data := io.master.rdata
  core.io.memAXI.head.r.bits.last := io.master.rlast
  core.io.memAXI.head.r.bits.id   := io.master.rid

  val slave = WireInit(0.U.asTypeOf(io.slave))
  io.slave <> slave

  core.io.memAXI.head.b.bits.user := 0.U
  core.io.memAXI.head.r.bits.user := 0.U
}

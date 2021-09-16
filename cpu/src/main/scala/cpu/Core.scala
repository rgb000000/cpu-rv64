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

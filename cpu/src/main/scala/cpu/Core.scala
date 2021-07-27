package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class Core (implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
//    val axi4 = new AXI4
  })

  val datapath = Module(new DataPath)
  val icache = Module(new Cache("i"))
  val dcache = Module(new Cache("d"))
  val control = Module(new Control)
  val crossbar = Module(new InnerCrossBar(2))   // [imem, dmem] to [mem]
  val mem2axi = Module(new MemBus2AXI)


  datapath.io.icacahe <> icache.io.cpu  // icache
  datapath.io.dcache <> dcache.io.cpu   // dcache
  datapath.io.control <> control.io     // control

  // crossbar <> i/d cache
  crossbar.io.in.zip(Seq(icache, dcache).map(_.io.mem)).foreach(info =>{
    val (cb, cache) = info
    cb <> cache
  })
  // crossbar <> mem2ai
  crossbar.io.out <> mem2axi.io.in
  // mem2axi <> io.axi
  val aximem = Module(new AXIMem)
  dontTouch(aximem.io)
  mem2axi.io.axi4 <> aximem.io
}

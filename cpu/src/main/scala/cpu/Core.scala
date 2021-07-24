package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class Core (implicit p: Parameters) extends Module{
  val io = IO(new Bundle{

  })

  val datapath = Module(new DataPath)
  val icahce = Module(new Cache("i"))
  val dcache = Module(new Cache("d"))
  val control = Module(new Control)

  datapath.io.icacahe <> icahce.io.cpu
  datapath.io.dcache <> dcache.io.cpu
}

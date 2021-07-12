package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class MEM (implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val addr = Input(UInt(32.W))
    val wdata = Input(UInt(p(XLen).W))
    val wen = Input(Bool())

    val rdata = Output(UInt(32.W))
  })

  val mem = SyncReadMem(32, UInt(32.W))

  when(io.wen){
    mem.write(io.addr, io.wdata)
  }

  io.rdata := mem.read(io.addr)
}

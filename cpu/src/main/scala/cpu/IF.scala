package cpu

import chipsalliance.rocketchip.config._
import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFileInline


class IF (implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val addr = Valid(UInt(p(IAW).W))
    val inst_in = Flipped(Valid(UInt(32.W)))
    val inst_out = Valid(UInt(32.W))
  })

  val pc = RegInit(p(PCStart).U(p(IAW).W))
  val inst = RegInit(BitPat.bitPatToUInt(isa.nop))

  io.addr.bits := pc
  io.addr.valid := true.B
  inst := Mux(io.inst_in.fire(), io.inst_in.bits, inst)

  io.inst_out.bits := inst
  io.inst_out.valid := RegNext(io.inst_in.fire())
}

class IFWrapper (implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val inst_out = Valid(UInt(32.W))
  })

  val sim_mem = SyncReadMem(32, UInt(32.W))
  loadMemoryFromFileInline(sim_mem, "inst.hex")

  val if_ = Module(new IF)

  if_.io.inst_in.bits := sim_mem.read(if_.io.addr.bits)
  if_.io.inst_in.valid := RegNext(if_.io.addr.valid)

  io.inst_out <> if_.io.inst_out
}
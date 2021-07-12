package cpu

import chipsalliance.rocketchip.config._
import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFileInline


class IF (implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val pc = Valid(UInt(p(IAW).W))
    val inst_in = Flipped(Valid(UInt(32.W)))
    val inst_out = Valid(UInt(32.W))
  })

  val pc = RegInit(p(PCStart).U(p(IAW).W))
  val inst = RegInit(BitPat.bitPatToUInt(ISA.nop))

  io.pc.bits := pc
  io.pc.valid := true.B
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

  val ifet = Module(new IF)

  ifet.io.inst_in.bits := sim_mem.read(ifet.io.pc.bits)
  ifet.io.inst_in.valid := RegNext(ifet.io.pc.valid)

  io.inst_out <> ifet.io.inst_out
}
package cpu

import chipsalliance.rocketchip.config._
import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFileInline


class IF (implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val pc = Valid(UInt(p(XLen).W))
    val icache = Flipped(new CacheCPUIO)
    val inst = Valid(UInt(32.W))
  })

  val pc = RegInit(p(PCStart).U(p(XLen).W))
  val inst = RegInit(BitPat.bitPatToUInt(ISA.nop))

  // always read instructions from icache
  io.icache.req.valid := 1.U
  io.icache.req.bits.op := 0.U // must read
  io.icache.req.bits.addr := pc// pc is addr
  io.icache.req.bits.mask := Mux(pc(2) === 1.U, "b1111_0000".U, "b0000_1111".U)  // need 32 bit instructions
  io.icache.req.bits.data := 0.U // nerver use because op is read

  when((io.icache.req.valid === 1.U) & (io.icache.resp.valid === 1.U)){
    // get reps
    inst := io.icache.resp.bits.data
    pc := pc // pc = pc_next
  }

  inst := Mux(io.icache.req.valid & io.icache.resp.valid, io.icache.resp.bits.data, inst)
  pc := Mux(io.icache.req.valid & io.icache.resp.valid, pc, pc)

  io.inst.bits := inst
  io.inst.valid := RegNext(io.icache.resp.valid & io.icache.resp.valid)

  io.pc.bits := pc
  io.pc.valid := RegNext(io.icache.resp.valid & io.icache.resp.valid)
}

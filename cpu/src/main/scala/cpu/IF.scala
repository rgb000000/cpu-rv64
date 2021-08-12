package cpu

import chipsalliance.rocketchip.config._
import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFileInline


class IF (implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val out = Valid(new Bundle{
      val pc = UInt(p(XLen).W)
      val inst = UInt(32.W)
    })

    val pc_alu = Input(UInt(p(XLen).W))
    val pc_epc = Input(UInt(p(XLen).W))
    val pc_sel = Input(UInt(2.W))

    val stall = Input(Bool())

    val icache = Flipped(new CacheCPUIO)
  })

  val pc = RegInit(p(PCStart).asUInt(p(XLen).W))
  val cur_pc = RegInit(p(PCStart).asUInt(p(XLen).W))
  val inst = RegInit(BitPat.bitPatToUInt(ISA.nop))

  // always read instructions from icache
  io.icache.req.valid := !io.stall
  io.icache.req.bits.op := 0.U // must read
  io.icache.req.bits.addr := pc// pc is addr
  io.icache.req.bits.mask := Mux(pc(2) === 1.U, "b1111_0000".U, "b0000_1111".U)  // need 32 bit instructions
  io.icache.req.bits.data := 0.U // nerver use because op is read

  val pc_next = Mux(io.stall, pc, MuxLookup(io.pc_sel, pc, Array(
    Control.PC_4   -> (pc + 4.U),
    Control.PC_ALU -> (io.pc_alu),
    Control.PC_EPC -> (io.pc_epc)
  )))

  dontTouch(pc_next)
  dontTouch(io.out)

  pc := Mux(io.icache.req.fire(), pc_next, pc)
  cur_pc := Mux(io.icache.req.fire(), pc, cur_pc)
  inst := Mux(io.icache.resp.fire() & (io.icache.resp.bits.cmd =/= 0.U), io.icache.resp.bits.data, inst)
  dontTouch(inst)

  io.out.bits.inst := Mux(io.out.valid, io.icache.resp.bits.data, inst)
  io.out.bits.pc := cur_pc
  io.out.valid := io.icache.resp.fire() & (io.icache.resp.bits.cmd =/= 0.U)

  dontTouch(io.icache)
}

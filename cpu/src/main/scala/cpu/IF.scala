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
    val br_taken = Input(Bool())

    val stall = Input(Bool())
    val kill = Input(Bool())

    val icache = Flipped(new CacheCPUIO)
  })

  val cur_pc = RegInit(p(PCStart).asUInt(p(XLen).W) - 4.U)
  val inst = RegInit(BitPat.bitPatToUInt(ISA.nop))

  val pc_next = Mux(io.stall, cur_pc, Mux(io.pc_sel === Control.PC_ALU, io.pc_alu, MuxLookup(io.pc_sel, 0.U, Array(
    Control.PC_0   -> (cur_pc),
    Control.PC_4   -> Mux(io.br_taken, io.pc_alu, cur_pc + 4.U),
    Control.PC_ALU -> (io.pc_alu),
    Control.PC_EPC -> (io.pc_epc)
  ))))

  // always read instructions from icache
  io.icache.req.valid := !io.stall
  io.icache.req.bits.op := 0.U // must read
  io.icache.req.bits.addr := pc_next // Mux(io.pc_sel === Control.PC_ALU, io.pc_alu, pc)// pc is addr
  io.icache.req.bits.mask := Mux(io.icache.req.bits.addr(2) === 1.U, "b1111_0000".U, "b0000_1111".U)  // need 32 bit instructions
  io.icache.req.bits.data := 0.U // nerver use because op is read

  dontTouch(pc_next)
  dontTouch(io.out)

//  pc := Mux(io.icache.req.fire(), pc_next, pc)
  cur_pc := Mux(io.icache.req.fire(), io.icache.req.bits.addr, cur_pc)
  inst := Mux(io.icache.resp.fire() & (io.icache.resp.bits.cmd =/= 0.U), io.icache.resp.bits.data, inst)
  dontTouch(inst)

  val stall_negedge = (!io.stall) & RegNext(io.stall)
  val is_valid_when_stall = RegInit(0.U)
  when(io.stall & io.out.valid){
    is_valid_when_stall := 1.U
  }.elsewhen(stall_negedge){
    is_valid_when_stall := 0.U
  }


  io.out.bits.inst := Mux(io.icache.resp.fire() & (io.icache.resp.bits.cmd =/= 0.U), io.icache.resp.bits.data, inst)
  io.out.bits.pc := cur_pc
  io.out.valid := Mux(io.kill, 0.U, io.icache.resp.fire() & (io.icache.resp.bits.cmd =/= 0.U)) | (is_valid_when_stall & stall_negedge)

  dontTouch(io.icache)
}

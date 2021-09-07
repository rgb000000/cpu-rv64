package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class CLINT(implicit p: Parameters) extends Module{
  // (0x02000000L, 0x0000ffffL, false,   0), // CLINT

  val io = IO(new Bundle{
    val cpu = Flipped(new CacheMemIO())
    val interrupt = Output(Bool())
  })

  dontTouch(io.interrupt)

  val mtime = RegInit(1.U(64.W))
  val mtimecmp = RegInit(2.U(64.W))

  val s_idle :: s_w :: s_resp :: Nil = Enum(3)
  val state = RegInit(s_idle)

  val op = Reg(Bool()) // 0: read     1: write
  val id = Reg(UInt(p(IDBits).W))
  val addr = Reg(UInt(64.W))

  val sel_data = Wire(UInt(64.W))
  sel_data := Mux(addr === "h02000000".U, mtime,
              Mux(addr === "h02000008".U, mtimecmp,
                0x7fffffff.U))

  io.cpu.req.ready := 1.U

  io.cpu.resp.valid := state === s_resp
  io.cpu.resp.bits.id := id
  io.cpu.resp.bits.data := 0.U
  io.cpu.resp.bits.cmd :=  Mux(op === 1.U, 1.U, MemCmdConst.ReadLast)

  io.interrupt := mtime >= mtimecmp

  mtime := mtime + 1.U

  when((state === s_idle) & io.cpu.req.fire()) {
    op := (io.cpu.req.bits.cmd) === MemCmdConst.WriteOnce
    id := io.cpu.req.bits.id
    addr := io.cpu.req.bits.addr
  }.elsewhen((state === s_w) & io.cpu.req.fire()){
    when(io.cpu.req.bits.addr === "h02000000".U){
      mtime := io.cpu.req.bits.data
    }.elsewhen(io.cpu.req.bits.addr === "h02000008".U){
      mtimecmp := io.cpu.req.bits.data
    }
  }.elsewhen((state === s_resp)){
    when(op === 1.U){
      io.cpu.resp.bits.data := 0.U
    }.otherwise{
      io.cpu.resp.bits.data := sel_data
    }
  }

  switch(state){
    is(s_idle){
      when(io.cpu.req.fire() & (io.cpu.req.bits.cmd === MemCmdConst.WriteOnce)){
        state := s_w
      }.elsewhen(io.cpu.req.fire() & (io.cpu.req.bits.cmd === MemCmdConst.ReadOnce)){
        state := s_resp
      }
    }
    is(s_w){
      when(io.cpu.req.fire()){
        state := s_resp
      }
    }
    is(s_resp){
      when(io.cpu.resp.fire()){
        state := s_idle
      }
    }
  }
}

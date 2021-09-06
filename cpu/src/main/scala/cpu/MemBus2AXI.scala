package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class MemBus2AXI(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val in = Flipped(new CacheMemIO)

    val axi4 = new AXI4
  })

  val s_idle :: s_read :: s_write :: s_resp :: Nil = Enum(4)
  val state = RegInit(s_idle)

  switch(state){
    is(s_idle){
      when(io.in.req.fire() & ((io.in.req.bits.cmd === MemCmdConst.WriteBurst) | (io.in.req.bits.cmd === MemCmdConst.WriteOnce) | (io.in.req.bits.cmd === MemCmdConst.WriteLast))){
        state := s_write
      }.elsewhen(io.in.req.fire() & ((io.in.req.bits.cmd === MemCmdConst.ReadBurst) | (io.in.req.bits.cmd === MemCmdConst.ReadOnce))){
        state := s_read
      }
    }
    is(s_write){
      when(io.in.req.fire() & (io.in.req.bits.cmd === MemCmdConst.WriteLast)){
        state := s_resp
      }
    }
    is(s_read){
      when(io.in.resp.fire() & (io.in.resp.bits.cmd === MemCmdConst.ReadLast)){
        state := s_idle
      }
    }
    is(s_resp){
      when(io.in.resp.valid){
        state := s_idle
      }
    }
  }

  val (ar, r, aw, w, b) = (io.axi4.ar, io.axi4.r, io.axi4.aw, io.axi4.w, io.axi4.b)

  when(state === s_read){
    io.in.resp.bits.id := r.bits.id
    io.in.resp.bits.data := r.bits.data
    io.in.resp.valid := r.valid
    io.in.resp.bits.cmd := Mux(r.bits.last, MemCmdConst.ReadLast, 0.U)
  }.elsewhen(state === s_resp){
    io.in.resp.bits.id := b.bits.id
    io.in.resp.bits.data := 0.U
    io.in.resp.valid := b.valid
    io.in.resp.bits.cmd := 1.U
  }.otherwise{
    io.in.resp.bits.id := 0.U
    io.in.resp.bits.data := 0.U
    io.in.resp.valid := 0.U
    io.in.resp.bits.cmd := 0.U
  }


  io.in.req.ready := ar.ready | aw.ready | w.ready

  ar.bits.lock := 0.U
  ar.bits.cache := 0.U
  ar.bits.prot := 0.U
  ar.bits.user := 0.U
  ar.bits.qos := 0.U
  ar.bits.id := io.in.req.bits.id
  ar.bits.addr := io.in.req.bits.addr
  ar.bits.len := (1.U << io.in.req.bits.len) // (p(CacheLineSize) / AXI4Parameters.dataBits).U
  ar.bits.size := 3.U // 8 * 8bits = 64bits
  ar.bits.burst := AXI4Parameters.BURST_INCR
  ar.valid := (io.in.req.bits.cmd === MemCmdConst.ReadBurst) & io.in.req.valid

  aw.bits.lock := 0.U
  aw.bits.cache := 0.U
  aw.bits.prot := 0.U
  aw.bits.user := 0.U
  aw.bits.qos := 0.U
  aw.bits.id := io.in.req.bits.id
  aw.bits.addr := io.in.req.bits.addr
  aw.bits.len := (1.U << io.in.req.bits.len)
  aw.bits.size := 3.U // 8 * 8bits = 64bits
  aw.bits.burst := AXI4Parameters.BURST_INCR
  aw.valid := (io.in.req.bits.cmd === MemCmdConst.WriteBurst) & io.in.req.valid

  w.bits.data := io.in.req.bits.data
  w.bits.strb := Cat(Seq.fill(p(XLen) / 8)(1.U(1.W))) // 0xff
  w.bits.last := io.in.req.bits.cmd === MemCmdConst.WriteLast
  w.valid := ((io.in.req.bits.cmd === MemCmdConst.WriteData) | (io.in.req.bits.cmd === MemCmdConst.WriteLast)) & io.in.req.valid

  r.ready := io.in.resp.ready

  b.ready := io.in.resp.ready
}

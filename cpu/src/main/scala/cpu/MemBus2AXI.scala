package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class MemBus2AXI(implicit p: Parameters) extends Module{

  val addressSpace = p(AddressSpace).groupBy(_._5)  // grouped by width

  val io = IO(new Bundle{
    val in = Flipped(new CacheMemIO)

    val axi4 = new AXI4
  })

  val addr_in = io.in.req.bits.addr
  val is32req = addressSpace(32).map(space => {
    (addr_in >= space._1.U(64.W)) & (addr_in < (space._1.U(64.W) + space._2.U(64.W)))
  }).reduce(_ | _)
  val is32high = Mux(io.in.req.bits.mask(3, 0) === "h0".U(4.W), true.B, false.B)

  val s_idle :: s_read :: s_write :: s_resp :: Nil = Enum(4)
  val state = RegInit(s_idle)
  val isBurst = RegInit(false.B)

  val is32req_reg = RegInit(false.B)
  val is32high_reg = RegInit(false.B)
  val req_mask_reg = RegInit(0.U((p(XLen) / 8).W))

  switch(state){
    is(s_idle){
      when(io.in.req.fire() & ((io.in.req.bits.cmd === MemCmdConst.WriteBurst) | (io.in.req.bits.cmd === MemCmdConst.WriteOnce))){
        state := s_write
        isBurst := (io.in.req.bits.cmd === MemCmdConst.WriteBurst)
        is32req_reg := is32req
        is32high_reg := is32high
        req_mask_reg := io.in.req.bits.mask
      }.elsewhen(io.in.req.fire() & ((io.in.req.bits.cmd === MemCmdConst.ReadBurst) | (io.in.req.bits.cmd === MemCmdConst.ReadOnce))){
        state := s_read
        isBurst := (io.in.req.bits.cmd === MemCmdConst.ReadBurst)
        is32req_reg := is32req
        is32high_reg := is32high
        req_mask_reg := io.in.req.bits.mask
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
    io.in.resp.bits.data := Mux(is32req_reg & is32high_reg, r.bits.data(31, 0) << 32.U, r.bits.data)
    io.in.resp.valid := r.valid
    io.in.resp.bits.cmd := Mux(isBurst, Mux(r.bits.last, MemCmdConst.ReadLast, 0.U), MemCmdConst.ReadLast)
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
  ar.bits.addr := Mux(is32req & is32high, io.in.req.bits.addr | "h0000_0000_0000_0004".U(64.W), io.in.req.bits.addr)
  ar.bits.len := (1.U << io.in.req.bits.len).asUInt() - 1.U // (p(CacheLineSize) / AXI4Parameters.dataBits).U
  ar.bits.size := Mux(is32req, 2.U, 3.U) // 8 * 8bits = 64bits
  ar.bits.burst := AXI4Parameters.BURST_INCR
  ar.valid := ((io.in.req.bits.cmd === MemCmdConst.ReadBurst) | (io.in.req.bits.cmd === MemCmdConst.ReadOnce)) & io.in.req.valid

  aw.bits.lock := 0.U
  aw.bits.cache := 0.U
  aw.bits.prot := 0.U
  aw.bits.user := 0.U
  aw.bits.qos := 0.U
  aw.bits.id := io.in.req.bits.id
  aw.bits.addr := Mux(is32req & is32high, io.in.req.bits.addr | "h0000_0000_0000_0004".U(64.W), io.in.req.bits.addr)
  aw.bits.len := (1.U << io.in.req.bits.len).asUInt() - 1.U
  aw.bits.size := Mux(is32req, 2.U, 3.U) // 8 * 8bits = 64bits
  aw.bits.burst := AXI4Parameters.BURST_INCR
  aw.valid := ((io.in.req.bits.cmd === MemCmdConst.WriteBurst) | (io.in.req.bits.cmd === MemCmdConst.WriteOnce)) & io.in.req.valid

  w.bits.data := Mux(is32req_reg & is32high_reg, io.in.req.bits.data >> 32.U, io.in.req.bits.data)
  w.bits.strb := Mux(is32req_reg & is32high_reg, req_mask_reg >> 4.U, Cat(Seq.fill(p(XLen) / 8)(1.U(1.W)))) // 0xff
  w.bits.last := io.in.req.bits.cmd === MemCmdConst.WriteLast
  w.valid := ((io.in.req.bits.cmd === MemCmdConst.WriteData) | (io.in.req.bits.cmd === MemCmdConst.WriteLast)) & io.in.req.valid

  r.ready := io.in.resp.ready

  b.ready := io.in.resp.ready
}

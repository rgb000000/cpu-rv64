package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class MemBus2AXI(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val in = Flipped(new CacheMemIO)

    val axi4 = new AXI4
  })

  val (ar, r, aw, w, b) = (io.axi4.ar, io.axi4.r, io.axi4.aw, io.axi4.w, io.axi4.b)

  val idle::s_ar::s_r::s_aw::s_w::s_b::nil = Enum(6)
  val state = RegInit(idle)

  val req_reg = RegInit(0.U.asTypeOf(io.in.req.bits)) // addr ,data, op, id

  val cnt = Counter(p(NBank))
  val resp_data_reg = Reg(Vec(p(NBank), UInt(p(XLen).W)))
  val resp_id_reg = Reg(UInt(p(IDBits).W))

  io.in.resp.bits.id := resp_id_reg
  io.in.resp.bits.data := Cat(resp_data_reg.init ++ List(r.bits.data))
  io.in.resp.valid := r.fire() & r.bits.last

  io.in.req.ready := state === idle

  ar.bits.lock := 0.U
  ar.bits.cache := 0.U
  ar.bits.prot := 0.U
  ar.bits.user := 0.U
  ar.bits.qos := 0.U
  ar.bits.id := req_reg.id
  ar.bits.addr := req_reg.addr
  ar.bits.len := (p(CacheLineSize) / AXI4Parameters.dataBits).U
  ar.bits.size := 3.U // 8 * 8bits = 64bits
  ar.bits.burst := AXI4Parameters.BURST_INCR
  ar.valid := state === s_ar

  aw.bits.lock := 0.U
  aw.bits.cache := 0.U
  aw.bits.prot := 0.U
  aw.bits.user := 0.U
  aw.bits.qos := 0.U
  aw.bits.id := req_reg.id
  aw.bits.addr := req_reg.addr
  aw.bits.len := (p(CacheLineSize) / AXI4Parameters.dataBits).U
  aw.bits.size := 3.U // 8 * 8bits = 64bits
  aw.bits.burst := AXI4Parameters.BURST_INCR
  aw.valid := state === s_aw

  w.bits.data := req_reg.data.asTypeOf(resp_data_reg)(cnt.value)
  w.bits.strb := Cat(Seq.fill(p(XLen) / 8)(1.U(1.W))) // 0xff
  w.bits.last := cnt.value === (p(NBank) - 1).U
  w.valid := state === s_w

  r.ready := state === s_r

  b.ready := state === s_b

  when(state === idle){
    when(io.in.req.fire()){
      req_reg := io.in.req.bits
    }
  }.elsewhen(state === s_ar){

  }.elsewhen(state === s_r){
    when(r.fire()){
      resp_data_reg(cnt.value) := r.bits.data
      resp_id_reg := r.bits.id
      cnt.inc()
    }
  }.elsewhen(state === s_aw){

  }.elsewhen(state === s_w){
    when(w.fire()){
      cnt.inc()
    }
  }.elsewhen(state === s_b){

  }

  switch(state){
    is(idle){
      when(io.in.req.fire()){
        // get a req, start work
        state := Mux(io.in.req.bits.op === 1.U, s_aw, s_ar)
      }
    }

    is(s_ar){
      when(ar.fire()){
        // send ar
        state := s_r
      }
    }

    is(s_r){
      when(r.fire() & r.bits.last){
        // wait until get read resp
        state := idle
      }
    }

    is(s_aw){
      when(aw.fire()){
        // send aw
        state := s_w
      }
    }

    is(s_w){
      when(w.fire()){
        // send w
        state := s_b
      }
    }

    is(s_b){
      when(b.fire()){
        state := idle
      }
    }

  }
}

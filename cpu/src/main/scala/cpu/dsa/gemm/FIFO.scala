package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class FIFOw2w(val inW: Int, val outW: Int, val entries: Int) extends Module {
  val io = IO(new Bundle{
    val enq = Flipped(Decoupled(UInt(inW.W)))
    val deq = Decoupled(UInt(outW.W))
    val count = Output(UInt(log2Ceil(entries + 1).W))
  })
  if(inW > outW){
    require(inW % outW == 0)

    val t = Vec(inW / outW, UInt(outW.W))
    val buf = RegInit(0.U(inW.W))
    val cnt = Counter(inW / outW)
    val tmp = Wire(Decoupled(UInt(outW.W)))

    val qin = Queue(io.enq)
    val qout = Module(new Queue(UInt(outW.W), entries))
    qout.io.enq <> tmp

    qin.ready := (qout.io.count <= (entries - (inW / outW)).U) & (cnt.value === 0.U)

    when(qin.fire()){
      buf := qin.bits
    }

    when(cnt.value === 0.U){
      tmp.valid := qin.fire()
      tmp.bits := qin.bits
    }.otherwise{
      tmp.valid := true.B
      tmp.bits := buf.asTypeOf(t)(cnt.value)
    }

    when(tmp.fire()){
      cnt.inc()
    }
    io.count := qout.io.count
    io.deq <> qout.io.deq

  }else if(outW > inW){
    require(outW % inW == 0)

    val t = Vec(outW / inW, UInt(inW.W))
    val buf = RegInit(0.U(outW.W).asTypeOf(t))
    val cnt = Counter(outW / inW)
    val tmp = Wire(Decoupled(UInt(outW.W)))

    val qin = Queue(io.enq, entries)
    val qout = Module(new Queue(UInt(outW.W), 2))
    qout.io.enq <> tmp

    qin.ready := qout.io.enq.ready

    when(qin.fire()){
      buf(cnt.value) := qin.bits
      cnt.inc()
    }

    tmp.bits := Cat(qin.bits, buf.asUInt()(outW - inW - 1, 0))
    when(qin.fire() & (cnt.value === ((outW/inW)-1).U)){
      tmp.valid := true.B
    }.otherwise{
      tmp.valid := false.B
    }

    io.count := qout.io.count
    io.deq <> qout.io.deq

  }else{
    require(outW == inW)
    val q = Module(new Queue(UInt(inW.W), entries, flow=true))
    q.io.enq <> io.enq
    io.deq <> q.io.deq
    io.count := q.io.count
  }
}

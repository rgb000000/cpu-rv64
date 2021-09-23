package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._


class InnerCrossBarN21(val n: Int)(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val in = Vec(n, Flipped(new CacheMemIO))

    val out = new CacheMemIO
  })

//  val arbiter = Module(new Arbiter(chiselTypeOf(io.in.head.req.bits), n))

  val lockfunc = (x: MemReq) => (x.cmd === MemCmdConst.WriteBurst) | ((x.cmd === MemCmdConst.WriteData) & (x.len =/= 0.U)) | ((x.cmd === MemCmdConst.WriteLast) & (x.len =/= 0.U))
  val arbiter = Module(new LockingArbiter(chiselTypeOf(io.in.head.req.bits), n, (p(CacheLineSize)/64)+1, Some(lockfunc)))

  val s_idle :: s_readResp :: s_writeResp ::Nil = Enum(3)
  val state = RegInit(s_idle)
  val thisReq = arbiter.io.out

  val cur_idx = RegInit(0.U(log2Ceil(n).W))

  switch (state) {
    is (s_idle) {
      when (thisReq.fire()) {
        cur_idx := arbiter.io.chosen
        when (thisReq.bits.cmd === MemCmdConst.ReadBurst) {
          state := s_readResp
        }.elsewhen(thisReq.bits.cmd === MemCmdConst.WriteBurst) {
          state := s_writeResp
        }.elsewhen(thisReq.bits.cmd === MemCmdConst.ReadOnce) {
          state := s_readResp
        }.elsewhen(thisReq.bits.cmd === MemCmdConst.WriteOnce) {
          state := s_writeResp
        }
      }
    }
    is (s_readResp) { when (io.out.resp.fire() && io.out.resp.bits.cmd === MemCmdConst.ReadLast) { state := s_idle } }
    is (s_writeResp) { when (io.out.resp.valid) { state := s_idle } }
  }

  // req
  (arbiter.io.in, io.in.map(_.req), 0 until n).zipped.foreach((arb, in, idx) => {
    arb.bits <> in.bits
    arb.valid := in.valid & ((state === s_idle) |
      ((state === s_writeResp) & (cur_idx === idx.U(log2Ceil(n).W)) & (((in.bits.cmd === MemCmdConst.WriteData) & (in.bits.len =/= 0.U)) | (in.bits.cmd === MemCmdConst.WriteLast))) |
      ((state === s_readResp) & (cur_idx === idx.U(log2Ceil(n).W))))
  })
  (arbiter.io.in, io.in.map(_.req), 0 until n).zipped.foreach((arb, in, idx) => {
    // to guarantee op atomic, a req can be accepted only state === s_idle
    in.ready := arb.ready &
      ((state === s_idle) |
        ((state === s_writeResp) & (cur_idx === idx.U(log2Ceil(n).W)) & (((in.bits.cmd === MemCmdConst.WriteData) & (in.bits.len =/= 0.U)) | (in.bits.cmd === MemCmdConst.WriteLast))) |
        ((state === s_readResp) & (cur_idx === idx.U(log2Ceil(n).W))))
  })


  io.out.req <> arbiter.io.out
  io.out.resp.ready := io.in(cur_idx).resp.ready

  // resp
  io.in.map(_.resp).zipWithIndex.foreach( info => {
    val (resp, i) = info
    resp.bits := io.out.resp.bits
    resp.valid := io.out.resp.valid & (io.out.resp.bits.id === i.U)
  })

}


class InnerCrossBar12N(val n: Int=2)(implicit p: Parameters) extends Module {
  val addressSpace = p(AddressSpace).groupBy(_._4) // groupby port type

  val io = IO(new Bundle{
    val in = Flipped(new CacheMemIO)

    val out = Vec(n, new CacheMemIO)
  })

//  io.out.foreach(dontTouch(_))

  val s_idle :: s_readResp :: s_writeResp :: s_bad :: Nil = Enum(4)
  val state = RegInit(s_idle)

  val addr_in = io.in.req.bits.addr

//  val outSelVec = VecInit(addressSpace.map(space => {
//    (addr_in >= space._1.U) & (addr_in < (space._1 + space._2).U)
//  }))

  val outSelVec = VecInit(Seq.fill(n)(false.B))
  for(i <- 0 until n) {
    outSelVec(i) := addressSpace(i).map(space => {
      (addr_in >= space._1.U(64.W)) & (addr_in < (space._1.U(64.W) + space._2.U(64.W)))
    }).reduce(_ | _)
  }

  val reqInvalidAddr = io.in.req.valid & !outSelVec.asUInt().orR()

  val outSelIdx = PriorityEncoder(outSelVec)
  val outSel = io.out(outSelIdx)

  val cur_idx = RegEnable(outSelIdx, io.in.req.fire() & (state === s_idle))

  // req connect    in.req  <>   io.out(xxx).req
  (io.out, outSelVec).zipped.foreach((out, sel) => {
    out.req.bits := io.in.req.bits
    out.req.valid := io.in.req.valid & sel & ((state === s_idle) | (state === s_writeResp))
  })
  io.in.req.ready := (outSel.req.ready || reqInvalidAddr) & ((state === s_idle) | (state === s_writeResp) | (state === s_bad))

  // resp connect
  io.in.resp.valid := io.out(cur_idx).resp.valid || (state === s_bad)
  io.in.resp.bits := io.out(cur_idx).resp.bits
  io.out.foreach(_.resp.ready := 0.U)
  io.out(cur_idx).resp.ready := io.in.resp.ready

  switch(state){
    is(s_idle){
      when(io.in.req.fire() & ((io.in.req.bits.cmd === MemCmdConst.WriteBurst) | (io.in.req.bits.cmd === MemCmdConst.WriteOnce)) & !reqInvalidAddr){
        state := s_writeResp
      }.elsewhen(io.in.req.fire() & ((io.in.req.bits.cmd === MemCmdConst.ReadBurst) | (io.in.req.bits.cmd === MemCmdConst.ReadOnce)) & !reqInvalidAddr){
        state := s_readResp
      }.elsewhen(io.in.req.fire() & reqInvalidAddr){
        state := s_bad
      }
    }
    is(s_writeResp){
      when(io.out(cur_idx).resp.valid) {
        state := s_idle
        io.out(cur_idx).resp.ready := 1.U
      }
    }
    is(s_readResp){
      when(io.out(cur_idx).resp.fire() & (io.out(cur_idx).resp.bits.cmd === MemCmdConst.ReadLast)){
        state := s_idle
      }
    }
    is(s_bad){
      when(io.in.resp.fire()){
        state := s_idle
      }
    }
  }
}

class InnerCrossBarNN(val Nin: Int = 2, val Nout: Int = 2)(implicit p: Parameters) extends Module{
  val io  = IO(new Bundle{
    val in  = Vec(Nin, Flipped(new CacheMemIO()))
    val out = Vec(Nout, new CacheMemIO())
  })

  val n2one = Module(new InnerCrossBarN21(Nin))
  val one2n = Module(new InnerCrossBar12N(Nout))

  (n2one.io.in, io.in).zipped.foreach(_ <> _)
  n2one.io.out <> one2n.io.in
  (io.out, one2n.io.out).zipped.foreach(_ <> _)
}
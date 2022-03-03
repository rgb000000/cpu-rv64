package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import cpu.{CacheCPUIO, MemCmdConst, XLen}

class DMAReq(val depth: Int, val w: Int, val nbank: Int) extends Bundle {
  val addr = UInt(log2Ceil(depth*nbank).W)
  val op = UInt(1.W)   //0: read    1: write
  val len = UInt(16.W)  // count of byte(8bit)
}

class DMAData(val depth: Int, val w: Int, val nbank: Int) extends Bundle {
  val data = UInt(w.W)
  val isLast = Bool()
}

class DMACtrl extends Bundle {
  val cmd = Flipped(Decoupled(new Bundle{
    val op = UInt(1.W)
    val addr_local = UInt(32.W)
    val addr_mem = UInt(32.W)
    val len = UInt(16.W) // count of byte(8bit)
  }))
  val done = Output(Bool())
}

class DMAIO(val depth: Int, val w: Int, val nbank: Int)(implicit val p: Parameters) extends Bundle {
  val ctrl = new DMACtrl

  val toCache = Flipped(new CacheCPUIO)

  val toSlave = new Bundle {
    val req = Decoupled(new ScratchPadReq(depth, w, nbank))
    val resp = Flipped(Decoupled(new ScratchPadResp(depth, w, nbank)))
  }
}

// DMA负责在D$和ScratchPad之间搬运数据
class DMA(val depth: Int, val w: Int, val nbank: Int)(implicit p: Parameters) extends Module {
  val io = IO(new DMAIO(depth, w, nbank))

  val s_idle :: s_read :: s_write :: s_done :: Nil  =  Enum(4)
  val state = RegInit(s_idle)

  val addr_mem = RegInit(0.U(32.W))
  val addr_local = RegInit(0.U(log2Ceil(depth * nbank).W))
  val op = RegInit(0.U(1.W))  // 0: read spad       1: write spad
  when(io.ctrl.cmd.fire()){
    addr_mem := io.ctrl.cmd.bits.addr_mem
    addr_local := io.ctrl.cmd.bits.addr_local
    op := io.ctrl.cmd.bits.op
  }

  // todo: 参数化这个8
  val CACHE_CNT_VALUE = (((p(MeshRow) * p(TileRow)) * (p(MeshRow) * p(TileRow)) * 8) / p(XLen)).toInt
  val SPAD_CNT_VALUE = p(MeshRow) * p(TileRow)
  // 目前现在 16*16的pe整列上做尝试
  require(CACHE_CNT_VALUE == 32)
  require(CACHE_CNT_VALUE > SPAD_CNT_VALUE)
  // 计数器都在目的端进行计数
  val wcnt = Counter(CACHE_CNT_VALUE)  // 统计写入端次数
  val rcnt = Counter(CACHE_CNT_VALUE)  // 统计读取端次数

  // 读写均对于spad而言
  val rfifo = Module(new FIFOw2w(w, 64, 4))
  val wfifo = Module(new FIFOw2w(64, w, 4))

  switch(state){
    is(s_idle){
      // 当接受到ctrl信号时，判断op来跳转到write状态还是read状态
      when(io.ctrl.cmd.fire()){
        state := Mux(io.ctrl.cmd.bits.op === 1.U, s_write, s_read)
      }
    }

    is(s_write){
      // 向cacahe发送读请求，将cache resp数据写入wfifo
      // wfifo不断向spad写入数据
      // 当spad写入次数达标则完成一write dma操作
      state := Mux(io.toSlave.req.fire() & (wcnt.value === (SPAD_CNT_VALUE - 1).U), s_done, state)
    }

    is(s_read){
      // 向spad发送读请求，发送一次req就跳转到等待resp的状态s_read_resp
      // 当cache写入次数达标则完成了一轮read dma操作
      state := Mux(io.toCache.req.fire() & (wcnt.value === (CACHE_CNT_VALUE - 1).U), s_done, state)
    }

    is(s_done){
      state := s_idle
    }
  }

  io.ctrl.done := state === s_done

  // wcnt
  when(state === s_write){
    when(io.toSlave.req.fire() & (io.toSlave.req.bits.op === 1.U)){
      when(wcnt.value === (SPAD_CNT_VALUE - 1).U){
        wcnt.value := 0.U
      }.otherwise{
        wcnt.inc()
      }
    }
  }.elsewhen(state === s_read){
    when(io.toCache.req.fire() & (io.toCache.req.bits.op === 1.U)){
      when(wcnt.value === (CACHE_CNT_VALUE - 1).U){
        wcnt.value := 0.U
      }.otherwise{
        wcnt.inc()
      }
    }
  }

  // rcnt
  when(state === s_read){
    when(io.toSlave.req.fire() & (io.toSlave.req.bits.op === 0.U)){
      when(rcnt.value === (SPAD_CNT_VALUE - 1).U){
        rcnt.value := 0.U
      }.otherwise{
        rcnt.inc()
      }
    }
  }.elsewhen(state === s_write){
    when(io.toCache.req.fire() & (io.toCache.req.bits.op === 0.U)){
      when(rcnt.value === (CACHE_CNT_VALUE - 1).U){
        rcnt.value := 0.U
      }.otherwise{
        rcnt.inc()
      }
    }
  }

  // Cache
  // s_write需要从Cache读数据到wfifo
  // s_read_req和s_read_resp状态需要将rfifo中的数据写入Cache
  io.toCache.req.bits.addr := addr_mem + (Mux(!op, wcnt.value, rcnt.value) << log2Ceil(64 / 8))
  io.toCache.req.bits.op := !op
  io.toCache.req.bits.mask := (-1).S.asUInt()
  io.toCache.req.bits.data := rfifo.io.deq.bits
  io.toCache.req.valid := Mux(state === s_write, wfifo.io.enq.ready, (state === s_read) & rfifo.io.deq.valid)

  // io.toSlave
  // s_write需要将wfifo数据写入Spad
  // s_read_req需要发送读spad请求
  // s_read_resp需要将spad resp数据写入rfifo中
  io.toSlave.req.bits.addr := addr_local + (Mux(op === 1.U, wcnt.value, rcnt.value) << log2Ceil(w/8))
  io.toSlave.req.bits.op := op
  io.toSlave.req.bits.mask := (-1).S.asUInt()
  io.toSlave.req.bits.id := 0.U
  io.toSlave.req.bits.data := wfifo.io.deq.bits
  io.toSlave.req.valid := Mux(state === s_write, wfifo.io.deq.valid, (state === s_read) & rfifo.io.enq.ready)

  io.toSlave.resp.ready := (state === s_read) & rfifo.io.enq.ready

  // rfifo
  rfifo.io.deq.ready := (state === s_read) & io.toCache.req.ready
  rfifo.io.enq.valid := io.toSlave.resp.valid
  rfifo.io.enq.bits := io.toSlave.resp.bits.data

  // wfifo
  wfifo.io.enq.bits := io.toCache.resp.bits.data
  wfifo.io.enq.valid := io.toCache.resp.valid & (io.toCache.resp.bits.cmd === 2.U)
  wfifo.io.deq.ready := io.toSlave.req.ready & (state === s_write)

  io.ctrl.cmd.ready := state === s_idle

}

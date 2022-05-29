package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

case object ScratchPadBankDepth extends Field[Int]

// readIO
class ScratchPadBankReadReq(val depth: Int)(implicit val p: Parameters) extends Bundle {
  val addr = UInt(log2Ceil(depth).W)
  val id = UInt(1.W)     // 0: dma    1: ctrl
}

class ScratchPadBankReadResp(val w: Int)(implicit val p: Parameters) extends Bundle {
  val data = UInt(w.W)
  val id = UInt(1.W)      // 0: dma    1: ctrl
}

class ScratchPanBankReadIO(val depth:Int, val w: Int)(implicit p: Parameters) extends Bundle {
  val req = Flipped(Decoupled(new ScratchPadBankReadReq(depth)))
  // ScratchPad中会包含多个Back，需要ready信号来控制
  val resp = Decoupled(new ScratchPadBankReadResp(w))
}

// writeIO
class ScratchPadBankWriteIO(val depth: Int, val w: Int)(implicit p: Parameters) extends Bundle {
  val en   = Input(Bool())
  val addr = Input(UInt(log2Ceil(depth).W))
  val data = Input(UInt(w.W))
  val mask = Input(UInt((w / 8).W))
}


class ScratchPadBankIO(val depth: Int, val w: Int)(implicit p: Parameters) extends Bundle {
  val read = new ScratchPanBankReadIO(depth, w)
  val write = new ScratchPadBankWriteIO(depth, w)
}

class ScratchPadBank(val depth: Int, val w: Int)(implicit p: Parameters) extends Module {

  val io = IO(new ScratchPadBankIO(depth, w))

  val mem = SyncReadMem(depth, Vec(w / 8, UInt(8.W)))

  // SyncMemTese进行了测试表明,rdata将会hold直到下次en有效
  def read(addr: UInt, en: Bool) = mem.read(addr, en)

  def write(addr: UInt, data: Vec[UInt], mask: Vec[Bool]) = mem.write(addr, data, mask)

  when(io.write.en) {
    write(io.write.addr, io.write.data.asTypeOf(Vec(w / 8, UInt(8.W))), VecInit(io.write.mask.asBools()))
  }

  val ren = io.read.req.fire()
  val rdata = {
    assert(!(ren & io.write.en))
    read(io.read.req.bits.addr, ren)
  }

  // buffer 1 cycle,    latency is 2  (sync_read + buf)
  val mem_id = RegInit(0.U(1.W))
  val buf_id = RegInit(0.U(1.W))

  val mem_rdata_valid = RegInit(false.B)
  val buf_valid = RegInit(false.B)
  val buf_ready = Wire(Bool())
  val mem_ready = Wire(Bool())
  val buf = RegInit(0.U.asTypeOf(rdata))

  when(ren){
    mem_rdata_valid := true.B
    mem_id := io.read.req.bits.id
  }.otherwise{
    mem_rdata_valid := Mux(mem_rdata_valid & buf_ready, 0.U, mem_rdata_valid)
  }

  when(mem_rdata_valid & buf_ready){
    buf_valid := true.B
    buf := rdata
    buf_id := mem_id
  }.otherwise{
    buf_valid := Mux(io.read.resp.fire(), 0.U, buf_valid)
  }

  buf_ready := io.read.resp.ready | !buf_valid
  mem_ready := buf_ready | !mem_rdata_valid

  io.read.req.ready := mem_ready & !io.write.en

  io.read.resp.bits.data := buf.asUInt()
  io.read.resp.bits.id := buf_id
  io.read.resp.valid := buf_valid
}


class ScratchPadReq(val depth: Int, val w: Int, val nbank: Int)(implicit val p: Parameters) extends Bundle {
  val op = Bool()
  val addr = UInt(log2Ceil(depth*nbank).W)
  val isTwins = Bool()   // read (addr + 0x10)
  val mask = UInt((w/8).W)
  val data = UInt(w.W)
  val id = UInt(1.W)  // 0: dma    1: ctrl
}

class ScratchPadResp(val depth: Int, val w: Int, val nbank: Int)(implicit val p: Parameters) extends Bundle {
  val data = UInt(w.W)
  val data2 = UInt(w.W)
  val id = UInt(1.W)  // 0: dma   1: ctrl
}

class ScratchPadIO(val depth: Int, val w: Int, val nbank: Int)(implicit val p: Parameters) extends Bundle {
  val req = Flipped(Decoupled(new ScratchPadReq(depth, w, nbank)))
  val resp = Decoupled(new ScratchPadResp(depth, w, nbank))
}

class ScratchPad(val depth: Int, val w: Int, val nbank: Int)(implicit val p: Parameters) extends Module {
  val io = IO(new Bundle{
    val toDMA = new ScratchPadIO(depth, w, nbank)
    val toArray = new ScratchPadIO(depth, w, nbank)
  })

  val banks = Seq.fill(nbank)(Module(new ScratchPadBank(depth, w)))

  val dma_tmp_req = Wire(Decoupled(new ScratchPadReq(depth, w, nbank)))
  val array_tmp_req = Wire(Decoupled(new ScratchPadReq(depth, w, nbank)))

  val dma_req_q = Queue(dma_tmp_req, 4, flow=true)
  val array_req_q = Queue(array_tmp_req, 4, flow=true)

  val tmp_resp = Wire(Decoupled(new ScratchPadResp(depth, w, nbank)))
  val resp_q = Queue(tmp_resp, 4, flow=true)

  io.toDMA.req.ready := dma_tmp_req.ready
  dma_tmp_req.valid := io.toDMA.req.valid
  dma_tmp_req.bits := io.toDMA.req.bits

  io.toArray.req.ready := array_tmp_req.ready
  array_tmp_req.valid := io.toArray.req.valid
  array_tmp_req.bits := io.toArray.req.bits

  val dma_which_bank = dma_req_q.bits.addr(log2Ceil(depth*nbank) - 1, log2Ceil(depth)).asUInt()
  val dma_which_op = dma_req_q.bits.op

  val array_which_bank = array_req_q.bits.addr(log2Ceil(depth*nbank) - 1, log2Ceil(depth)).asUInt()
  val array_which_op = array_req_q.bits.op

  // when both req is valid, their bank must different
  when((dma_which_bank === array_which_bank) & dma_req_q.valid & array_req_q.valid){
    assert(false.B)
  }
  when((dma_req_q.bits.op === array_req_q.bits.op) & dma_req_q.valid & array_req_q.valid){
    assert(false.B)
  }

  val read_ready_map = banks.zipWithIndex.map({
      case (bank, index) => index.U -> bank.io.read.req.ready
  })

  // write op 必定ready，scratchpad中是写优先于读的
  dma_req_q.ready := Mux(dma_which_op === 1.U, true.B,
                                       MuxLookup(dma_which_bank, false.B, read_ready_map))

  array_req_q.ready := Mux(dma_which_op === 1.U, true.B,
                                       MuxLookup(dma_which_bank, false.B, read_ready_map))

  banks.zipWithIndex.foreach({
    case (bank, index) => {
      val is_dma_req = (dma_req_q.valid & (dma_req_q.bits.addr(log2Ceil(depth*nbank)-1, log2Ceil(depth)).asUInt === index.U)) |
                       (dma_req_q.valid & ((dma_req_q.bits.addr(log2Ceil(depth*nbank)-1, log2Ceil(depth)).asUInt + 1.U) === index.U) & (dma_req_q.bits.op === 0.U) & (dma_req_q.bits.isTwins === true.B))

      val is_array_req = (array_req_q.valid & (array_req_q.bits.addr(log2Ceil(depth*nbank)-1, log2Ceil(depth)).asUInt() === index.U)) |
                       (array_req_q.valid & ((array_req_q.bits.addr(log2Ceil(depth*nbank)-1, log2Ceil(depth)).asUInt()+1.U) === index.U) & (array_req_q.bits.op === 0.U) & (array_req_q.bits.isTwins === true.B))

      when(is_dma_req){
        bank.io.read.req.valid := is_dma_req
        bank.io.read.req.bits.addr := dma_req_q.bits.addr
        bank.io.read.req.bits.id := dma_req_q.bits.id

        bank.io.write.en := dma_req_q.valid & (dma_req_q.bits.addr(log2Ceil(depth*nbank)-1, log2Ceil(depth)).asUInt() === index.U) & (dma_req_q.bits.op === 1.U)
        bank.io.write.addr := dma_req_q.bits.addr
        bank.io.write.mask := dma_req_q.bits.mask
        bank.io.write.data := dma_req_q.bits.data
      }.otherwise{
        bank.io.read.req.valid := is_array_req
        bank.io.read.req.bits.addr := array_req_q.bits.addr
        bank.io.read.req.bits.id := array_req_q.bits.id

        bank.io.write.en := array_req_q.valid & (array_req_q.bits.addr(log2Ceil(depth*nbank)-1, log2Ceil(depth)).asUInt() === index.U) & (array_req_q.bits.op === 1.U)
        bank.io.write.addr := array_req_q.bits.addr
        bank.io.write.mask := array_req_q.bits.mask
        bank.io.write.data := array_req_q.bits.data
      }
    }
  })

  // 由于多bank访问有可能出现乱序，所以使用了一个order_queue来保证顺序返回结果
  val tmp_order = Wire(Decoupled(new Bundle{
    val order = UInt(log2Ceil(nbank).W)
    val isTwins = Bool()
  }))
  val order_queue = Queue(tmp_order, 16) // todo: order目前设置的足够大来保证order_queue绝对不会满

  // only for read op
  val dma_req_is_read = dma_req_q.fire & (dma_req_q.bits.op === 0.U)
  val array_req_is_read = array_req_q.fire & (array_req_q.bits.op === 0.U)
  when(dma_req_is_read){
    tmp_order.valid := dma_req_is_read
    tmp_order.bits.order := dma_which_bank
    tmp_order.bits.isTwins := dma_req_q.bits.isTwins
  }.otherwise{
    tmp_order.valid := array_req_is_read
    tmp_order.bits.order := array_which_bank
    tmp_order.bits.isTwins := array_req_q.bits.isTwins
  }


  // 连接 tmp_resp信号
  tmp_resp.valid := Cat(banks.map(_.io.read.resp.valid)).orR
  val resp_data_map = banks.zipWithIndex.map({
    case (bank, index) => {
      index.U -> bank.io.read.resp.bits.data
    }
  })

  val resp_id_map = banks.zipWithIndex.map({
    case (bank, index) => {
      index.U -> bank.io.read.resp.bits.id
    }
  })
  tmp_resp.bits.data := MuxLookup(order_queue.bits.order, 0.U, resp_data_map)
  tmp_resp.bits.id := MuxLookup(order_queue.bits.order, 0.U, resp_id_map)
  tmp_resp.bits.data2 := MuxLookup(order_queue.bits.order, 0.U, Seq(
    0.U -> banks(1).io.read.resp.bits.data,
    2.U -> banks(3).io.read.resp.bits.data
  ))

  order_queue.ready := tmp_resp.fire()

  // 连接banks的ready信号和
  banks.zipWithIndex.foreach({
    case (bank, index) => {
      bank.io.read.resp.ready := (order_queue.valid & (order_queue.bits.order === index.U) & tmp_resp.ready) |
                                 (order_queue.valid & order_queue.bits.isTwins & ((order_queue.bits.order+1.U) === index.U))
    }
  })

  // 连接output
  io.toDMA.resp.bits.data := resp_q.bits.data
  io.toDMA.resp.bits.data2 := resp_q.bits.data2
  io.toDMA.resp.bits.id := resp_q.bits.id
  io.toDMA.resp.valid := resp_q.valid & (resp_q.bits.id === 0.U)

  io.toArray.resp.bits.data := resp_q.bits.data
  io.toArray.resp.bits.data2 := resp_q.bits.data2
  io.toArray.resp.bits.id := resp_q.bits.id
  io.toArray.resp.valid := resp_q.valid & (resp_q.bits.id === 1.U)

  resp_q.ready := Mux(resp_q.bits.id === 1.U, io.toArray.resp.ready, io.toDMA.resp.ready)
}
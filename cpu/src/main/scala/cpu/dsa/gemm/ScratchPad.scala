package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

case object ScratchPadBankDepth extends Field[Int]

// readIO
class ScratchPadBankReadReq(val depth: Int)(implicit p: Parameters) extends Bundle {
  val addr = UInt(log2Ceil(depth).W)

  override def cloneType = new ScratchPadBankReadReq(depth).asInstanceOf[this.type]
}

class ScratchPadBankReadResp(val w: Int)(implicit p: Parameters) extends Bundle {
  val data = UInt(w.W)

  override def cloneType = new ScratchPadBankReadResp(w).asInstanceOf[this.type]
}

class ScratchPanBankReadIO(val depth:Int, val w: Int)(implicit p: Parameters) extends Bundle {
  val req = Flipped(Decoupled(new ScratchPadBankReadReq(depth)))
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

  override def cloneType = new ScratchPadBankIO(depth, w).asInstanceOf[this.type]
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

  // buffer 1 cycle

  val mem_rdata_valid = RegInit(false.B)
  val buf_valid = RegInit(false.B)
  val buf_ready = Wire(Bool())
  val mem_ready = Wire(Bool())
  val buf = RegInit(0.U.asTypeOf(rdata))

  when(ren){
    mem_rdata_valid := true.B
  }.otherwise{
    mem_rdata_valid := Mux(mem_rdata_valid & buf_ready, 0.U, mem_rdata_valid)
  }

  when(mem_rdata_valid & buf_ready){
    buf_valid := true.B
    buf := rdata
  }.otherwise{
    buf_valid := Mux(io.read.resp.fire(), 0.U, buf_valid)
  }

  buf_ready := io.read.resp.ready | !buf_valid
  mem_ready := buf_ready | !mem_rdata_valid

  io.read.req.ready := mem_ready & !io.write.en

  io.read.resp.bits.data := buf.asUInt()
  io.read.resp.valid := buf_valid
}

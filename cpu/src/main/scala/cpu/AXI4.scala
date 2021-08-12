package cpu

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import chipsalliance.rocketchip.config._

object AXI4Parameters {
  // These are all fixed by the AXI4 standard:
  val lenBits   = 8
  val sizeBits  = 3
  val burstBits = 2
  val cacheBits = 4
  val protBits  = 3
  val qosBits   = 4
  val respBits  = 2

  // These are not fixed:
  val idBits    = 1
  val addrBits  = 64
  val dataBits  = 64
  val userBits  = 1

  def CACHE_RALLOCATE  = 8.U(cacheBits.W)
  def CACHE_WALLOCATE  = 4.U(cacheBits.W)
  def CACHE_MODIFIABLE = 2.U(cacheBits.W)
  def CACHE_BUFFERABLE = 1.U(cacheBits.W)

  def PROT_PRIVILEDGED = 1.U(protBits.W)
  def PROT_INSECURE    = 2.U(protBits.W)
  def PROT_INSTRUCTION = 4.U(protBits.W)

  def BURST_FIXED = 0.U(burstBits.W)
  def BURST_INCR  = 1.U(burstBits.W)
  def BURST_WRAP  = 2.U(burstBits.W)

  def RESP_OKAY   = 0.U(respBits.W)
  def RESP_EXOKAY = 1.U(respBits.W)
  def RESP_SLVERR = 2.U(respBits.W)
  def RESP_DECERR = 3.U(respBits.W)
}

trait AXI4HasUser {
  val user  = Output(UInt(AXI4Parameters.userBits.W))
}

trait AXI4HasData {
  def dataBits = AXI4Parameters.dataBits
  val data  = Output(UInt(dataBits.W))
}

trait AXI4HasId {
  def idBits = AXI4Parameters.idBits
  val id    = Output(UInt(idBits.W))
}

trait AXI4HasLast {
  val last = Output(Bool())
}

// AXI4-lite

class AXI4LiteBundleA extends Bundle {
  val addr  = Output(UInt(AXI4Parameters.addrBits.W))
  val prot  = Output(UInt(AXI4Parameters.protBits.W))
}

class AXI4LiteBundleW(override val dataBits: Int = AXI4Parameters.dataBits) extends Bundle with AXI4HasData {
  val strb = Output(UInt((dataBits/8).W))
}

class AXI4LiteBundleB extends Bundle {
  val resp = Output(UInt(AXI4Parameters.respBits.W))
}

class AXI4LiteBundleR(override val dataBits: Int = AXI4Parameters.dataBits) extends AXI4LiteBundleB with AXI4HasData


class AXI4Lite extends Bundle {
  val aw = Decoupled(new AXI4LiteBundleA)
  val w  = Decoupled(new AXI4LiteBundleW)
  val b  = Flipped(Decoupled(new AXI4LiteBundleB))
  val ar = Decoupled(new AXI4LiteBundleA)
  val r  = Flipped(Decoupled(new AXI4LiteBundleR))
}


// AXI4-full

class AXI4BundleA(override val idBits: Int) extends AXI4LiteBundleA with AXI4HasId with AXI4HasUser {
  val len   = Output(UInt(AXI4Parameters.lenBits.W))  // number of beats - 1
  val size  = Output(UInt(AXI4Parameters.sizeBits.W)) // bytes in beat = 2^size
  val burst = Output(UInt(AXI4Parameters.burstBits.W))
  val lock  = Output(Bool())
  val cache = Output(UInt(AXI4Parameters.cacheBits.W))
  val qos   = Output(UInt(AXI4Parameters.qosBits.W))  // 0=no QoS, bigger = higher priority
  // val region = UInt(width = 4) // optional
import chisel3.util.experimental.loadMemoryFromFile
  override def toPrintable: Printable = p"addr = 0x${Hexadecimal(addr)}, id = ${id}, len = ${len}, size = ${size}"
}

// id ... removed in AXI4
class AXI4BundleW(override val dataBits: Int) extends AXI4LiteBundleW(dataBits) with AXI4HasLast {
  override def toPrintable: Printable = p"data = ${Hexadecimal(data)}, wmask = 0x${strb}, last = ${last}"
}
class AXI4BundleB(override val idBits: Int) extends AXI4LiteBundleB with AXI4HasId with AXI4HasUser {
  override def toPrintable: Printable = p"resp = ${resp}, id = ${id}"
}
class AXI4BundleR(override val dataBits: Int, override val idBits: Int) extends AXI4LiteBundleR(dataBits) with AXI4HasLast with AXI4HasId with AXI4HasUser {
  override def toPrintable: Printable = p"resp = ${resp}, id = ${id}, data = ${Hexadecimal(data)}, last = ${last}"
}


class AXI4(val dataBits: Int = AXI4Parameters.dataBits, val idBits: Int = AXI4Parameters.idBits) extends AXI4Lite {
  override val aw = Decoupled(new AXI4BundleA(idBits))
  override val w  = Decoupled(new AXI4BundleW(dataBits))
  override val b  = Flipped(Decoupled(new AXI4BundleB(idBits)))
  override val ar = Decoupled(new AXI4BundleA(idBits))
  override val r  = Flipped(Decoupled(new AXI4BundleR(dataBits, idBits)))

//  def dump(name: String) = {
//    when (aw.fire()) { printf(p"${GTimer()},[${name}.aw] ${aw.bits}\n") }
//    when (w.fire()) { printf(p"${GTimer()},[${name}.w] ${w.bits}\n") }
//    when (b.fire()) { printf(p"${GTimer()},[${name}.b] ${b.bits}\n") }
//    when (ar.fire()) { printf(p"${GTimer()},[${name}.ar] ${ar.bits}\n") }
//    when (r.fire()) { printf(p"${GTimer()},[${name}.r] ${r.bits}\n") }
//  }
}

class RAMHelper extends BlackBox {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val en = Input(Bool())
    val rIdx = Input(UInt(64.W))
    val rdata = Output(UInt(64.W))
    val wIdx = Input(UInt(64.W))
    val wdata = Input(UInt(64.W))
    val wmask = Input(UInt(64.W))
    val wen = Input(Bool())
  })
}

class AXIMem(val width: Int = 64, val depth: Int = 256) extends Module{
  val io = IO(Flipped(new AXI4))


  val r_idle :: r_burst :: Nil = Enum(2)
  val r_state = RegInit(r_idle)
  val r_cnt = Counter(64)
  val read_req = RegInit(0.U.asTypeOf(io.ar.bits))

  val w_idle :: w_burst :: w_resp :: Nil = Enum(3)
  val w_state = RegInit(w_idle)
  val w_cnt = Counter(64)
  val write_req = RegInit(0.U.asTypeOf(io.aw.bits))
  val w_data = Vec(8, UInt(8.W))

//  val ram = Module(new RAMHelper)
//  ram.io.clk := clock
//  ram.io.en := 1.U
//  ram.io.rIdx := read_req.addr + (r_cnt.value << log2Ceil(64 / 8).U).asUInt() + "h8000_0000".U
//  val r_data = ram.io.rdata
//
//  ram.io.wIdx := write_req.addr + (w_cnt.value << log2Ceil(64 / 8).U).asUInt() + "h8000_0000".U
//  ram.io.wdata := io.w.bits.data
//  ram.io.wmask := Cat(io.w.bits.strb.asBools().map((x) => {
//    val res = Wire(UInt(8.W))
//    res := Mux(x,  "hff".U, "h00".U)
//    res
//  }))
//  ram.io.wen := io.w.fire()


  val mem = SyncReadMem(32, Vec(8, UInt(8.W)))
  loadMemoryFromFile(mem, "inst.hex")

  val r_addr = read_req.addr - "h8000_0000".U
  val r_data = mem.read((r_addr >> log2Ceil(64 / 8).U).asUInt() + r_cnt.value)

  val w_addr = write_req.addr - "h8000_0000".U
  when(io.w.fire()){
    mem.write((w_addr >> log2Ceil(64/8).U).asUInt() + w_cnt.value, io.w.bits.data.asTypeOf(w_data), io.w.bits.strb.asBools())
  }

  io.ar.ready := r_state === r_idle

  io.r.valid := RegNext(r_state === r_burst) & (r_state === r_burst)
  io.r.bits.data := r_data.asUInt()
  io.r.bits.id := read_req.id
  io.r.bits.resp := 1.U
  io.r.bits.last := r_cnt.value === read_req.len
  io.r.bits.user := 0.U

  io.aw.ready := w_state === w_idle

  io.w.ready := w_state === w_burst

  io.b.valid := w_state === w_resp
  io.b.bits.id := write_req.id
  io.b.bits.resp := 1.U
  io.b.bits.user := 1.U


  // get req
  when(r_state === r_idle){
    when(io.ar.fire()){
      read_req := io.ar.bits
    }
  }.elsewhen(r_state === r_burst){
    when(io.r.ready === 1.U){
      when(r_cnt.value === read_req.len){
        r_cnt.value := 0.U
      }.otherwise(
        r_cnt.inc()
      )
    }
  }

  when(w_state === w_idle){
    when(io.aw.fire()){
      write_req := io.aw.bits
    }
  }.elsewhen(w_state === w_burst){
    when(io.w.fire()){
      when(w_cnt.value === write_req.len - 1.U){
        w_cnt.value := 0.U
      }.otherwise{
        w_cnt.inc()
      }
    }
  }

  switch(r_state){
    is(r_idle){
      when(io.ar.fire()){
        r_state := r_burst
      }
    }

    is(r_burst){
      when(r_cnt.value === read_req.len){
        r_state := r_idle
      }
    }
  }


  switch(w_state){
    is(w_idle){
      when(io.aw.fire()){
        w_state := w_burst
      }
    }

    is(w_burst){
      when(w_cnt.value === write_req.len - 1.U){
        w_state := w_resp
      }
    }

    is(w_resp){
      w_state := w_idle
    }
  }

}

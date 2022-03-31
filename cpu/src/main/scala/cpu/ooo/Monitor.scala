package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import cpu.{AddresWidth, VAddrWidth, XLen}

class MonitorIO(implicit val p: Parameters) extends Bundle {
  val update = Flipped(Valid(new Bundle{
    val addr = UInt(p(VAddrWidth).W)
    val op = Bool()  // 0: lr(set)   1: sc(clear)
  }))

  val sc_addr = Input(UInt(p(VAddrWidth).W))
  val sc_ret = Output(UInt(p(XLen).W))

  val kill = Input(Bool())
}

// monitor use to watch lr/sc op
class Monitor(implicit val p: Parameters) extends Module {
  val io = IO(new MonitorIO)

  val const = new {
    val LR = 0.U(1.W)
    val SC = 1.U(1.W)
  }

  val info = new Bundle{
    val addr = UInt(p(VAddrWidth).W)
    val getLR = Bool()
  }

  val buf = RegInit(0.U.asTypeOf(info))

  when(io.update.fire & !io.kill){
    when(io.update.bits.op === const.LR) {
      buf.addr := io.update.bits.addr
      buf.getLR := true.B
    }.otherwise{
      buf.getLR := false.B
    }
  }.elsewhen(io.kill){
    buf.getLR := false.B
  }

  // only ret when sc op
  io.sc_ret := Mux((buf.addr === io.sc_addr) & buf.getLR, 0.U, 1.U)
}

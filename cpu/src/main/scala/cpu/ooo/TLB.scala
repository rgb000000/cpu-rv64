package cpu.ooo

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class TLBIO(implicit val p: Parameters) extends Bundle {
  val req = Flipped(Decoupled(new Bundle {
    val vaddr = UInt(39.W)
  }))

  val resp = Decoupled(new Bundle {
    val paddr = UInt(32.W)
  })
}

class TLB(implicit val p: Parameters) extends Module {
  val io = IO(new TLBIO)
}

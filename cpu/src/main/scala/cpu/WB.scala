package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class WB(implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val rd = Input(UInt(5.W))
    val wdata = Input(UInt(32.W))
    val wen = Input(Bool())
  })

}

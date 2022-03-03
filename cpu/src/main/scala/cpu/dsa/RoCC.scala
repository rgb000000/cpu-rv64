package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class RoCCInstruction extends Bundle {
  val funct = Bits(7.W)
  val rs2 = Bits(5.W)
  val rs1 = Bits(5.W)
  val xd = Bool()
  val xs1 = Bool()
  val xs2 = Bool()
  val rd = Bits(5.W)
  val opcode = Bits(7.W)
}

class RoCCCommand(implicit val p: Parameters) extends Bundle{
  val inst = new RoCCInstruction
  val rs1 = UInt(p(XLen).W)
  val rs2 = UInt(p(XLen).W)
}

class RoCCRespone(implicit val p: Parameters) extends Bundle{
  val rd = UInt(6.W) // TODO: here need no. of physics register
  val data = UInt(p(XLen).W)
}

class RoCCIO(implicit val p: Parameters) extends Bundle {
  val cmd = Flipped(Decoupled(new RoCCCommand))
  val resp = Decoupled(new RoCCRespone)
  val dcache = Flipped(new CacheCPUIO)
  val busy = Output(Bool())
  val interrupt = Output(Bool())
  val exception = Output(Bool())
}

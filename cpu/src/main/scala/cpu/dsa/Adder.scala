package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class MyRoccIO

class Adder (implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val a = Flipped(Decoupled(UInt(32.W)))
    val b = Flipped(Decoupled(UInt(32.W)))
    val c = Decoupled(UInt(32.W))
  })

  val s_idle :: s_busy :: s_done :: Nil = Enum(3)
  val state = RegInit(s_idle)


  val a = RegInit(0.U(64.W))
  val b = RegInit(0.U(64.W))
  val sum = RegInit(0.U(64.W))

  sum := a + b

  when(io.a.fire()){
    a := io.a.bits
  }

  when(io.b.fire()){
    b := io.b.bits
  }

  io.a.ready := true.B
  io.b.ready := true.B

  io.c.valid := true.B
  io.c.bits := sum
}

class RoCCAdder (implicit p: Parameters) extends Module{
  val io = IO(new RoCCIO)

  dontTouch(io)

  val impl = Module(new Adder())

  // func 0: read   rd rs1   x      cpu[rd]  = acc[rs1]
  // func 1: write   x rs1 rs2      acc[rs1] = rs2

  // addr: reg
  // 0:    a           w
  // 1:    b           w
  // 2:    sum         r
  // 3:    const 0x666 r


  // write
  impl.io.a.valid := io.cmd.valid & (io.cmd.bits.inst.funct === 1.U) & (io.cmd.bits.rs1 === 0.U)
  impl.io.a.bits := io.cmd.bits.rs2
  io.cmd.ready := impl.io.a.ready

  impl.io.b.valid := io.cmd.valid & (io.cmd.bits.inst.funct === 1.U) & (io.cmd.bits.rs1 === 1.U)
  impl.io.b.bits := io.cmd.bits.rs2
  // io.cmd.ready := impl.io.b.ready  // b.ready is the same as a.ready

  // read
  val readReq = RegInit(false.B)
  val addr = RegInit(0.U(64.W))
  when(io.cmd.fire() & (io.cmd.bits.inst.funct === 0.U)){
    readReq := true.B
    addr := io.cmd.bits.rs1
  }.elsewhen(io.resp.fire()){
    readReq := false.B
  }

  io.resp.valid := impl.io.c.valid & readReq
  io.resp.bits.data := MuxLookup(addr, 0.U, Seq(
    2.U -> impl.io.c.bits,
    3.U -> 666.U
  ))
  io.resp.bits.rd := 0.U
  impl.io.c.ready := io.resp.ready

  io.dcache <> DontCare

  io.busy := 0.U
  io.interrupt := 0.U
  io.exception := 0.U
}
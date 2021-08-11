package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

import difftest._

class SimTop(implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val logCtrl = new LogCtrlIO
    val perfInfo = new PerfInfoIO
    val uart = new UARTIO
  })

  val core = Module(new Core)

  io.uart.in.valid := false.B
  io.uart.out.valid := false.B
  io.uart.out.ch := 0.U
}

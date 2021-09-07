package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import chisel3.util.experimental.BoringUtils
import difftest._

class SimTop(implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val logCtrl = new LogCtrlIO
    val perfInfo = new PerfInfoIO
    val uart = new UARTIO
  })

  val core = Module(new Core)

  io.uart.in.valid := false.B

  val difftest_uart_valid = WireInit(false.B)
  val difftest_uart_ch    = WireInit(0.U(8.W))
  BoringUtils.addSink(difftest_uart_valid, "difftest_uart_valid")
  BoringUtils.addSink(difftest_uart_ch, "difftest_uart_ch")
  io.uart.out.valid := difftest_uart_valid
  io.uart.out.ch := difftest_uart_ch
}

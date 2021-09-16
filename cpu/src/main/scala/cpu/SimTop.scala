package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import chisel3.util.experimental.BoringUtils
import difftest._

// need to run with Simtop_wrap.v (which is in my difftest)
class MySimTop(implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val logCtrl = new LogCtrlIO
    val perfInfo = new PerfInfoIO
    val uart = new UARTIO
    val memAXI_0 = if(p(DRAM3Sim)) Some(new AXI4()) else None
  })

  if(p(DRAM3Sim)){
    val core = Module(new Core)
    io.memAXI_0.get <> core.io.memAXI.head
  }else{
    val core = Module(new Core)
    val aximem = Module(new AXIMem)
    dontTouch(aximem.io)
    core.io.memAXI.head <> aximem.io
  }

  io.uart.in.valid := false.B
  val difftest_uart_valid = WireInit(false.B)
  val difftest_uart_ch    = WireInit(0.U(8.W))
  BoringUtils.addSink(difftest_uart_valid, "difftest_uart_valid")
  BoringUtils.addSink(difftest_uart_ch, "difftest_uart_ch")
  io.uart.out.valid := difftest_uart_valid
  io.uart.out.ch := difftest_uart_ch
}

class SimTop(implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val logCtrl = new LogCtrlIO
    val perfInfo = new PerfInfoIO
    val uart = new UARTIO
    val memAXI_0 = if(p(DRAM3Sim)) Some(new AXI4()) else None
  })

  if(p(DRAM3Sim)){
    val core = Module(new Core)
    io.memAXI_0.get <> core.io.memAXI.head
  }else{
    val core = Module(new Core)
    val aximem = Module(new AXIMem)
    dontTouch(aximem.io)
    core.io.memAXI.head <> aximem.io
  }

  io.uart.in.valid := false.B
  val difftest_uart_valid = WireInit(false.B)
  val difftest_uart_ch    = WireInit(0.U(8.W))
  BoringUtils.addSink(difftest_uart_valid, "difftest_uart_valid")
  BoringUtils.addSink(difftest_uart_ch, "difftest_uart_ch")
  io.uart.out.valid := difftest_uart_valid
  io.uart.out.ch := difftest_uart_ch
}

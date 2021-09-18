package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class S011HD1P_X32Y2D128_BW extends BlackBox(Map(
//  "Bits"       -> 128,
//  "Word_Depth" -> 64,
//  "Add_Width"  -> 6,
//  "Wen_Width"  -> 128
)) {
  val io = IO(new Bundle {
    val Q    = Output(UInt(128.W))

    val CLK  = Input(Clock())
    val CEN  = Input(Bool())        // 0
    val WEN  = Input(Bool())        // 0
    val BWEN = Input(UInt(128.W))  // 0
    val A    = Input(UInt(6.W))
    val D    = Input(UInt(128.W))
  })

  def write(address: UInt, data: UInt, mask: UInt): Unit ={
    io.CEN := 0.U
    io.WEN := 0.U
    io.BWEN := Cat(mask.asBools().map(x => {
      Mux(x, "h00".U(8.W), "hff".U(8.W))
    }).reverse).asUInt()
    io.A := address
    io.D := data
  }

  def read(address: UInt): UInt ={
    io.CEN := 0.U
    io.WEN := 1.U
    io.BWEN := Cat(Seq.fill(128)(1.U(1.W))).asUInt()
    io.A := address
    io.D := 0.U
    io.Q
  }
}
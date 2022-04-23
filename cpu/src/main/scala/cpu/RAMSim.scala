package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class bytewrite_ram_1b(val size: Int, val addr_width: Int, val col_width: Int = 8, val nb_col: Int = 16) extends BlackBox(Map(
  "SIZE"       -> size,
  "ADDR_WIDTH" -> addr_width,
  "COL_WIDTH"  -> col_width,
  "NB_COL"     -> nb_col
)) with HasBlackBoxInline {
  val io = IO(new Bundle{
    val clk  = Input(Clock())
    val we   = Input(UInt(nb_col.W))
    val addr = Input(UInt(addr_width.W))
    val di   = Input(UInt((nb_col*col_width).W))
    val _do   = Output(UInt((nb_col*col_width).W))
  })

  setInline("bytewrite_ram_1b.v",
  """
    |module bytewrite_ram_1b (clk, we, addr, di, _do);
    |
    |parameter SIZE = 1024;
    |parameter ADDR_WIDTH = 10;
    |parameter COL_WIDTH = 8;
    |parameter NB_COL = 4;
    |
    |input clk;
    |input [NB_COL-1:0] we;
    |input [ADDR_WIDTH-1:0] addr;
    |input [NB_COL*COL_WIDTH-1:0] di;
    |output reg [NB_COL*COL_WIDTH-1:0] _do;
    |
    |reg [NB_COL*COL_WIDTH-1:0] RAM [SIZE-1:0];
    |
    |always @(posedge clk)
    |begin
    |    _do <= RAM[addr];
    |end
    |
    |generate genvar i;
    |for (i = 0; i < NB_COL; i = i+1)
    |begin
    |always @(posedge clk)
    |begin
    |    if (we[i])
    |        RAM[addr][(i+1)*COL_WIDTH-1:i*COL_WIDTH] <= di[(i+1)*COL_WIDTH-1:i*COL_WIDTH];
    |    end
    |end
    |endgenerate
    |
    |endmodule
    |
  """.stripMargin
  )

  def write(address: UInt, data: UInt, mask: UInt): Unit ={
    io.we   := mask
    io.addr := address
    io.di   := data
  }

  def read(address: UInt): UInt ={
    io.addr := address
    io.di := 0.U
    io._do
  }

  def idle() = {
    read(0.U)
  }
}

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

  def idle() = {
    read(0.U)
  }
}
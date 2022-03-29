package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

case object TileRow extends Field[Int]
case object TileCol extends Field[Int]

class TileIO[T<:Data](inType: T, outType: T, accType: T)(implicit p: Parameters) extends Bundle{
  val a_in = Input(Vec(p(TileRow), inType))
  val b_in = Input(Vec(p(TileCol), outType))
  val d_in = Input(Vec(p(TileCol), outType))

  val a_out = Output(Vec(p(TileRow), inType))
  val b_out = Output(Vec(p(TileCol), outType))
  val c_out = Output(Vec(p(TileCol), outType))

  val ctrl_in = Input(Vec(p(TileCol), new PEControl))
  val ctrl_out = Output(Vec(p(TileCol), new PEControl))
}

class Tile[T<:Data:Arithmetic](inType: T, outType: T, accType: T)(implicit p: Parameters) extends Module {
  val io = IO(new TileIO(inType, outType, accType))

  val pearray = Seq.fill(p(TileRow), p(TileCol))(Module(new PE(inType, outType, accType)))

  // a_in <> a_out
  for(row <- 0 until p(TileRow)){
    pearray(row).foldLeft(io.a_in(row)) {
      case (a_in, pe) =>
        pe.io.a_in := a_in
        pe.io.a_out
    }
  }
  for(row <- 0 until p(TileRow)){
    io.a_out(row) := pearray(row).last.io.a_out
  }

  // b_in <> b_out
  for(col <- 0 until p(TileCol)){
    pearray.map(_(col)).foldLeft(io.b_in(col)){
      case (b_in, pe) =>
        pe.io.b_in := b_in
        pe.io.b_out
    }
  }
  for(col <- 0 until p(TileCol)){
    io.b_out(col) := pearray.map(_(col)).last.io.b_out
  }

  // d_in <> c_out
  for(col <- 0 until p(TileCol)){
    pearray.map(_(col)).foldLeft(io.d_in(col)){
      case (d_in, pe) =>
        pe.io.d_in := d_in
        pe.io.c_out
    }
  }
  for(col <- 0 until p(TileCol)){
    io.c_out(col) := pearray.map(_(col)).last.io.c_out
  }

  // ctrl
  for(col <- 0 until p(TileCol)){
    pearray.map(_(col)).foldLeft(io.ctrl_in(col)){
      case (ctrl_in, pe) =>
        pe.io.ctrl_in := ctrl_in
        pe.io.ctrl_out
    }
  }
  for(col <- 0 until p(TileCol)){
    io.ctrl_out(col) := pearray.map(_(col)).last.io.ctrl_out
  }

}

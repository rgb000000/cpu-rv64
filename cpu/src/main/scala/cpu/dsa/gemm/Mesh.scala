package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

case object MeshRow extends Field[Int]
case object MeshCol extends Field[Int]

class MeshIO[T<:Data](inType: T, outType: T, accType: T)(implicit p: Parameters) extends Bundle{
  val row = p(MeshRow)
  val col = p(MeshCol)

  val a_in = Input(Vec(row, Vec(p(TileRow), inType)))
  val b_in = Input(Vec(col, Vec(p(TileCol), outType)))
  val d_in = Input(Vec(col, Vec(p(TileCol), outType)))

  val c_out = Output(Vec(col, Vec(p(TileCol), outType)))

  val ctrl_in = Input(Vec(col, Vec(p(TileCol), new PEControl)))

  override def cloneType = new MeshIO(inType, outType, accType).asInstanceOf[this.type]
}

class Mesh[T<:Data:Arithmetic](inType: T, outType: T, accType: T)(implicit p: Parameters) extends Module {
  val io = IO(new MeshIO(inType, outType, accType))

  val tilearray = Seq.fill(p(MeshRow), p(MeshCol))(Module(new Tile(inType, outType, accType)))

  // pipe a
  for(row <- 0 until p(MeshRow)){
    tilearray(row).foldLeft(io.a_in(row)){
      case (a_in, tile) =>
        tile.io.a_in := SRn(a_in)
        tile.io.a_out
    }
  }

  // pipe b
  for(col <- 0 until p(MeshCol)){
    tilearray.map(_(col)).foldLeft(io.b_in(col)){
      case (b_in, tile) =>
        tile.io.b_in := SRn(b_in)
        tile.io.b_out
    }
  }

  // NO pipe d between tile
  for(col <- 0 until p(MeshCol)){
    tilearray.map(_(col)).foldLeft(io.d_in(col)){
      case (d_in, tile) =>
        tile.io.d_in := SRn(d_in, 0)
        tile.io.c_out
    }
  }

  // NO pipe ctrl between tile
  for(col <- 0 until p(MeshCol)){
    tilearray.map(_(col)).foldLeft(io.ctrl_in(col)){
      case (ctrl_in, tile) =>
        tile.io.ctrl_in := SRn(ctrl_in, 0)
        tile.io.ctrl_out
    }
  }

  // c_out
  (tilearray.last, io.c_out).zipped.foreach{
    case (tile, c_out) =>
      c_out := tile.io.c_out
  }


}

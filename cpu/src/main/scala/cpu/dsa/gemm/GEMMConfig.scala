package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

trait GEMMConstant{
  // mode
  val M_IDLE    = 0.U
  val M_PRELOAD = 1.U
  val M_RUN     = 2.U
  val M_OUT     = 3.U

  // dataflow
  val DF_OS = 0.U
  val DF_WS = 1.U
}

class GEMM4444Config extends Config((site, here, up) => {
  case MeshRow => 4
  case MeshCol => 4

  case TileRow => 4
  case TileCol => 4

  case TransposeDIM => here(MeshRow) * here(TileRow)

})

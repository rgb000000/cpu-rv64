package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class GEMM4444Config extends Config((site, here, up) => {
  case MeshRow => 4
  case MeshCol => 4

  case TileRow => 4
  case TileCol => 4

})

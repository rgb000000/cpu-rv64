package cpu

import chipsalliance.rocketchip.config._

case object XLEN extends Field[Int]

class default_config extends Config ((site, here, up)=>{
  case XLEN => 64
})

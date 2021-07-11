package cpu

import chipsalliance.rocketchip.config._

case object XLEN extends Field[Int]

class DefaultConfig extends Config ((site, here, up)=>{
  case XLEN => 64
})

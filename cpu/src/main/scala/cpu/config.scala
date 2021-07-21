package cpu

import chipsalliance.rocketchip.config._

// register width
case object XLen extends Field[Int]

case object PCStart extends Field[Int]

class DefaultConfig extends Config ((site, here, up)=>{
  case XLen => 64
  case PCStart => 0x0

})

package cpu

import chipsalliance.rocketchip.config._

// register width
case object XLen extends Field[Int]

// Instructure Addrress Width
case object IAW extends Field[Int]

// Data Addrress Width
case object DAW extends Field[Int]

// TODO: unsigned int in scala?
case object PCStart extends Field[Int]

class DefaultConfig extends Config ((site, here, up)=>{
  case XLen => 64
  case IAW => 32
  case DAW => 32
  case PCStart => 0x0

})

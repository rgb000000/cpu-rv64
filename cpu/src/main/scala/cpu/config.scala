package cpu

import chipsalliance.rocketchip.config._

// register width
case object XLen extends Field[Int]

case object PCStart extends Field[String]

case object PCEVec extends Field[String]

case object Difftest extends Field[Boolean]

class DefaultConfig extends Config ((site, here, up)=>{
  case XLen           => 64
  case PCStart        => "h8000_0000"
  case PCEVec         => "h9000_0000"
  case L2$Size        => -1
  case I$Size         => here(CacheLineSize) * here(NWay) * 256
  case D$Size         => here(CacheLineSize) * here(NWay) * 256
  case CacheLineSize  => 64 * here(NBank)
  case NWay           => 4
  case NBank          => 4
  case IDBits         => 4

  case Difftest       => true
//  case Difftest       => false
})

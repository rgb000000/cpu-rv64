package cpu

import chipsalliance.rocketchip.config._

// register width
case object XLen extends Field[Int]

case object PCStart extends Field[Int]

class DefaultConfig extends Config ((site, here, up)=>{
  case XLen           => 64
  case PCStart        => 0x0
  case L2$Size        => -1
  case I$Size         => here(CacheLineSize) * here(NWay) * 256
  case D$Size         => here(CacheLineSize) * here(NWay) * 256
  case CacheLineSize  => 64 * here(NBank)
  case NWay           => 4
  case NBank          => 4
  case IDBits         => 4
})

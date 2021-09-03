package cpu

import chipsalliance.rocketchip.config._

// register width
case object XLen extends Field[Int]

case object PCStart extends Field[String]

case object PCEVec extends Field[String]

case object Difftest extends Field[Boolean]

//                                          start   range   isCache? type(MEMBus:0, AXI:1)
case object AddressSpace extends Field[Seq[(BigInt, BigInt, Boolean, Int)]]

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

  case AddressSpace   => Seq(
    //  start        range    isCache?
    (BigInt(0x02000000), BigInt(0x0000ffff), false,   0), // CLINT
    (BigInt(0x10000000), BigInt(0x00000fff), false,   1), // UART16550
    (BigInt(0x10001000), BigInt(0x00000fff), false,   1), // SPI Controller
    (BigInt(0x30000000), BigInt(0x0fffffff), false,   1), // SPI Flash XIP mode
    (BigInt(0x80000000), BigInt(0x7fffffff), true ,   1), // MEM
  )
})

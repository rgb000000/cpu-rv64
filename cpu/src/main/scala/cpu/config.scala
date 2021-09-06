package cpu

import chipsalliance.rocketchip.config._

// register width
case object XLen extends Field[Int]

case object PCStart extends Field[String]

case object PCEVec extends Field[String]

case object Difftest extends Field[Boolean]

//                                          start   range   isCache? type(MEMBus:0, AXI:1)
case object AddressSpace extends Field[Seq[(String, String, Boolean, Int)]]

class DefaultConfig extends Config ((site, here, up)=>{
  case XLen           => 64
  case PCStart        => "h8000_0000"
  case PCEVec         => "h9000_0000"
  case L2$Size        => -1
  case I$Size         => here(CacheLineSize) * here(NWay) * 32
  case D$Size         => here(CacheLineSize) * here(NWay) * 32
  case CacheLineSize  => 64 * here(NBank)
  case NWay           => 4
  case NBank          => 4
  case IDBits         => 4

  case Difftest       => true
//  case Difftest       => false

  case AddressSpace   => Seq(
    //   start       range   isCache? port_type
    ("h02000000", "h0000ffff", false,   0), // CLINT
    ("h10000000", "h00000fff", false,   1), // UART16550
    ("h10001000", "h00000fff", false,   1), // SPI Controller
    ("h30000000", "h0fffffff", false,   1), // SPI Flash XIP mode
    ("h80000000", "h7fffffff", true ,   1), // MEM
  )
})

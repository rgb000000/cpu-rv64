package cpu

import chipsalliance.rocketchip.config._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}

// register width
case object XLen extends Field[Int]

case object PCStart extends Field[String]

case object PCEVec extends Field[String]

case object Difftest extends Field[Boolean]

case object DRAM3Sim extends Field[Boolean]

//                                          start   range   isCache? type(MEMBus:0, AXI:1)
case object AddressSpace extends Field[Seq[(String, String, Boolean, Int)]]

case object CLINTRegs extends Field[Map[String, String]]


class BaseConfig extends Config ((site, here, up)=>{
  case XLen           => 64
  case PCStart        => "h8000_0000"
  case PCEVec         => "h9000_0000"
  case L2$Size        => -1
  case I$Size         => here(CacheLineSize) * here(NWay) * 64
  case D$Size         => here(CacheLineSize) * here(NWay) * 64
  case CacheLineSize  => 128
  case NWay           => 4
  case NBank          => 1
  case IDBits         => 4

  case AddressSpace   => Seq(
    //   start       range   isCache? port_type
    ("h02000000", "h0000ffff", false,   0), // CLINT
    ("h10000000", "h00000fff", false,   1), // UART16550
    ("h10001000", "h00000fff", false,   1), // SPI Controller
    ("h30000000", "h0fffffff", false,   1), // SPI Flash XIP mode
    ("h80000000", "h7fffffff", true ,   1), // MEM
  )

  case CLINTRegs => Map(
    "mtime"     -> "h0200_bff8",
    "mtimecmp"  -> "h0200_4000"
  )
})

class DifftestEnableConfig extends Config((site, here,up)=>{
  case Difftest       => true
  case DRAM3Sim       => false
})

class DifftestDisableConfig extends Config((site, here,up)=>{
  case Difftest       => false
  case DRAM3Sim       => false
})

class DifftestEnableWithDRAM3SimConfig extends Config((site, here,up)=>{
  case Difftest       => true
  case DRAM3Sim       => true
})


class DefaultConfig extends Config (
  new BaseConfig ++ new DifftestEnableConfig
)

class DRAM3SimConfig extends Config(
  new BaseConfig ++ new DifftestEnableWithDRAM3SimConfig
)

class FPGAConfig extends Config(
  new BaseConfig ++ new DifftestDisableConfig
)

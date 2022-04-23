package cpu

import chipsalliance.rocketchip.config._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import cpu.dsa.gemm.GEMM4444Config

// register width
case object XLen extends Field[Int]

case object AddresWidth extends Field[Int]

case object VAddrWidth extends Field[Int]

case object PAddrWidth extends Field[Int]

case object PCStart extends Field[String]

case object PCEVec extends Field[String]

case object Difftest extends Field[Boolean]

case object DRAM3Sim extends Field[Boolean]

//                                          start   range   isCache? type(MEMBus:0, AXI:1), width
case object AddressSpace extends Field[Seq[(String, String, Boolean, Int,                    Int)]]

case object CLINTRegs extends Field[Map[String, String]]

case object PRNUM extends Field[Int]

case object IGNORE_AD extends Field[Boolean] // xv6 doesn't use a/d bit


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
  case AddresWidth    => 64
  case VAddrWidth     => 32

  case BTBIndex       => 16

  case AddressSpace   => Seq(
    // 0 is innerInterface     1 is AXI
    //   start       range   isCache? port_type,  width
    ("h02000000", "h0000ffff", false,   0,         64), // CLINT
    ("h10000000", "h00000fff", false,   1,         32), // UART16550
    ("h10001000", "h00000fff", false,   1,         32), // SPI Controller
    ("h30000000", "h0fffffff", false,   1,         32), // SPI Flash XIP mode
    ("h80000000", "h7fffffff", true ,   1,         64), // MEM
  )

  case CLINTRegs => Map(
    "mtime"     -> "h0200_bff8",
    "mtimecmp"  -> "h0200_4000",

    "soft_int"  -> "h0200_e000",      // pass
    "external_int"  -> "h0200_e008",  // pass

    "uc_start"  -> "h0200_f000",      // pass
    "uc_range"  -> "h0200_f008",      // pass
    "branch_on" -> "h0200_f010"       // pass
  )

  case PRNUM => 32+16+2

  case IGNORE_AD => true
})

class DifftestEnableConfig extends Config((site, here, up)=>{
  case Difftest       => true
  case DRAM3Sim       => false
})

class DifftestDisableConfig extends Config((site, here, up)=>{
  case Difftest       => false
  case DRAM3Sim       => false
})

class DifftestEnableWithDRAM3SimConfig extends Config((site, here, up)=>{
  case Difftest       => true
  case DRAM3Sim       => true
})


class DefaultConfig extends Config (
  new BaseConfig ++ new DifftestEnableConfig
)

class DRAM3SimConfig extends Config(
  new BaseConfig ++ new DifftestEnableWithDRAM3SimConfig
)

class GEMM_DRAM3SimConfig extends Config(
  new DRAM3SimConfig ++ new GEMM4444Config
)

class FPGAConfig extends Config(
  new BaseConfig ++ new DifftestDisableConfig ++ new GEMM4444Config
)

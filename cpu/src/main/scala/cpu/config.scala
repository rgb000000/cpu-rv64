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

case object FPGA extends Field[Boolean]

class BaseConfig extends Config ((site, here, up)=>{
  case XLen           => 64
  case PCEVec         => "h9000_0000"
  case L2$Size        => -1
  case I$Size         => here(CacheLineSize) * here(NWay) * 64 * 4
  case D$Size         => here(CacheLineSize) * here(NWay) * 64 * 4
  case CacheLineSize  => 128
  case NWay           => 4
  case NBank          => 1
  case IDBits         => 4
  case AddresWidth    => 64
  case VAddrWidth     => 32

  case BTBIndex       => 16

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
  case FPGA           => true
  case PCStart        => "hc000_0000"
  case AddressSpace   => Seq(
    // 0 is innerInterface     1 is AXI
    //   start       range   isCache? port_type,  width
    ("h02000000", "h0000ffff", false,   0,         64), // 0- CLINT
    ("h03000000", "h0000ffff", false,   1,         32), // 1- UART16550
    ("h40000000", "h3fffffff", true,    1,         64), // 2- DDR in PS
    ("hc0000000", "h03ffffff", true,    1,         64), // 3- QSPI in PS
  )
})

class DifftestEnableWithDRAM3SimConfig extends Config((site, here, up)=>{
  case Difftest       => true
  case DRAM3Sim       => true
  case FPGA           => false
  case PCStart        => "h8000_0000"
  case AddressSpace   => Seq(
    // 0 is innerInterface     1 is AXI
    //   start       range   isCache? port_type,  width
    ("h02000000", "h0000ffff", false,   0,         64), // 0- CLINT
    ("h03000000", "h0000ffff", false,   1,         32), // 1- UART16550
    ("h04000000", "h0000ffff", false,   1,         32), // 2- SPI Controller
    ("h30000000", "h00400000", true,    1,         64), // 3- SPI Flash XIP mode, convert by axi-width-convert ip
    ("h80000000", "h7fffffff", true ,   1,         64), // 4- MEM
  )
})

class DRAM3SimConfig extends Config(
  new BaseConfig ++ new DifftestEnableWithDRAM3SimConfig
)

class GEMM_DRAM3SimConfig extends Config(
  new DRAM3SimConfig ++ new GEMM4444Config
)

class FPGAConfig extends Config(
  new BaseConfig ++ new DifftestDisableConfig ++ new GEMM4444Config
)

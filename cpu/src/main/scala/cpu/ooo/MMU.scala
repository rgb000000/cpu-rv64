package cpu.ooo

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import cpu.{CPUCacheCrossBarN21, CacheCPUIO}

class MMUIO(implicit val p: Parameters) extends Bundle {
  val from_inst = new CacheCPUIO
  val to_icache = Flipped(new CacheCPUIO)

  val from_data = new CacheCPUIO
  // ptw and ld/st inst
  val to_dcache = Flipped(new CacheCPUIO)

  val sfence_vmca = Input(Bool())
}

// MMU包含 ITLB DTLB和一个PTW
class MMU(implicit val p: Parameters) extends Module {
  val io = IO(new MMUIO)

  val itlb = Module(new TLB(true, 1))
  val dtlb = Module(new TLB(false, 16))
  val ptw = Module(new PTW(2))
  val xbar = Module(new CPUCacheCrossBarN21(2)) // 合并ptw的dcache访问和dtlb的dcache访问

  itlb.io.sfence_vmca := io.sfence_vmca
  dtlb.io.sfence_vmca := io.sfence_vmca

  itlb.io.from_cpu <> io.from_inst
  io.to_icache <> itlb.io.toCache

  dtlb.io.from_cpu <> io.from_data

  ptw.io.ins(0) <> itlb.io.ptw
  ptw.io.ins(1) <> dtlb.io.ptw


  xbar.io.in(0) <> ptw.io.toCache
  xbar.io.in(1) <> dtlb.io.toCache

  io.to_dcache <> xbar.io.out
}

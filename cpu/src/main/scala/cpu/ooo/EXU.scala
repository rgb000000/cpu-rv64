package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._


// 定点执行单元
class FixPointIn(implicit p: Parameters) extends Bundle{
  val A = UInt(p(XLen).W)
  val B = UInt(p(XLen).W)

  val prd = UInt(6.W)

  val alu_op = UInt(5.W)

  val br_type = UInt(3.W)
  val p_br = Bool()   // 0: not jump    1: jump

  val wb_type = UInt(2.W)
  val wen = Bool()
}

class FixPointU(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val in = Flipped(Decoupled(new FixPointIn))

    val cdb = Valid(new CDB)
  })

  // alu
  val alu = Module(new ALU)
  alu.io.rs1 := io.in.bits.A
  alu.io.rs2 := io.in.bits.B
  alu.io.alu_op := io.in.bits.alu_op
  val alu_res = alu.io.out

  // branch
  val br = Module(new Branch)
  br.io.rs1 := io.in.bits.A
  br.io.rs2 := io.in.bits.B
  br.io.br_type := io.in.bits.br_type
  val br_taken = br.io.taken

  io.cdb.bits.prn := io.in.bits.prd
  io.cdb.bits.data := alu_res
  io.cdb.bits.wen := io.in.bits.wen
  io.cdb.bits.brHit := Mux(io.in.bits.br_type.orR(), br.io.taken === io.in.bits.p_br, true.B)
}

// 访储执行单元 and CSR单元
class MemUIn(implicit p: Parameters) extends Bundle{
  val A = UInt(p(XLen).W)
  val B = UInt(p(XLen).W)

  val ld_type = UInt(3.W)
  val st_type = UInt(3.W)
  val s_data  = UInt(p(XLen).W)

  val csr_cmd = UInt(3.W)
}

class MemU(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val in = Flipped(Decoupled(new MemUIn))

    val dcache = Flipped(new CacheCPUIO)

    val cdb = Decoupled(new CDB)
  })

}

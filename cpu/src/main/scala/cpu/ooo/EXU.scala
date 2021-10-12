package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._


// 定点执行单元
class FixPointIn(implicit p: Parameters) extends Bundle{
  val idx = UInt(4.W)
  val A = UInt(p(XLen).W)
  val B = UInt(p(XLen).W)
  val alu_op = UInt(5.W)
  val prd = UInt(6.W) // physics rd id

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

  io.cdb.bits.idx := io.in.bits.idx
  io.cdb.bits.prn := io.in.bits.prd
  io.cdb.bits.data := alu_res
  io.cdb.bits.wen := io.in.bits.wen
  io.cdb.bits.brHit := Mux(io.in.bits.br_type.orR(), br.io.taken === io.in.bits.p_br, true.B)
  io.cdb.bits.expt := false.B // FixPointU can't generate except
  io.cdb.valid := io.in.valid

  io.in.ready := true.B  // fixPointU always ready
}

// 访储执行单元 and CSR单元
class MemUIn(implicit p: Parameters) extends Bundle{
  val idx = UInt(4.W)
  val A = UInt(p(XLen).W)
  val B = UInt(p(XLen).W)
  val alu_op = UInt(5.W)
  val prd = UInt(6.W) // physics rd id

  val ld_type = UInt(3.W)
  val st_type = UInt(3.W)
  val s_data  = UInt(p(XLen).W)

  val csr_cmd = UInt(3.W)
  // ctrl signals
  val pc      = UInt(p(XLen).W)
  val addr    = UInt(p(XLen).W)
  val inst    = UInt(32.W)
  val illegal = Bool()
  val interrupt = new Bundle{
    val time = Bool()
    val soft = Bool()
    val external = Bool()
  }

  val wen = Bool()
}

class MemU(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val in = Flipped(Decoupled(new MemUIn))

    val dcache = Flipped(new CacheCPUIO)

    val cdb = Valid(new CDB)
    val memCDB = Valid(new MEMCDB)
  })

  val alu = Module(new ALU)
  alu.io.rs1 := io.in.bits.A
  alu.io.rs2 := io.in.bits.B
  alu.io.alu_op := io.in.bits.alu_op
  val alu_res = alu.io.out

  val isCSR = io.in.bits.csr_cmd.orR()
  val isMem = (io.in.bits.ld_type.orR() | io.in.bits.st_type.orR()) & !isCSR

  // Mem op
  val mem = Module(new OOOMEM)
  mem.io.ld_type := io.in.bits.ld_type
  mem.io.st_type := 0.U    // OOOMEM only handle ld inst
  mem.io.s_data := io.in.bits.s_data
  mem.io.alu_res := alu_res
  // mem.io.inst_valid :=

  mem.io.dcache <> io.dcache


  // CSR op
  val csr = Module(new CSR)
  csr.io.cmd := io.in.bits.csr_cmd
  csr.io.in := alu_res
  csr.io.ctrl_signal.pc := io.in.bits.pc
  csr.io.ctrl_signal.addr := alu_res
  csr.io.ctrl_signal.inst := io.in.bits.inst
  csr.io.ctrl_signal.illegal := io.in.bits.illegal
  csr.io.ctrl_signal.st_type := io.in.bits.st_type
  csr.io.ctrl_signal.ld_type := io.in.bits.ld_type
  csr.io.pc_check := false.B
  csr.io.interrupt := io.in.bits.interrupt


  io.cdb.bits.idx := io.in.bits.idx
  when(io.in.fire() & isCSR){
    // csr op
    io.cdb.bits.prn := io.in.bits.prd
    io.cdb.bits.data := csr.io.out
    io.cdb.bits.wen := io.in.bits.wen
    io.cdb.bits.brHit := true.B
    io.cdb.bits.expt := csr.io.expt
    io.cdb.valid := true.B
  }.elsewhen(io.in.fire() & isMem){
    // mem op
    when(io.in.bits.ld_type.orR()){
      // ld inst
      io.cdb.bits.prn := io.in.bits.prd
      io.cdb.bits.data := mem.io.l_data.bits
      io.cdb.bits.wen := io.in.bits.wen
      io.cdb.bits.brHit := true.B
      io.cdb.bits.expt := false.B
    }.otherwise{
      // st inst
      io.cdb.bits.prn   := 0.U
      io.cdb.bits.data  := 0.U
      io.cdb.bits.wen   := 0.U
      io.cdb.bits.brHit := true.B
      io.cdb.bits.expt  := false.B

      io.memCDB.bits.prn   := alu_res
      io.memCDB.bits.data  := io.in.bits.s_data
      io.memCDB.bits.wen   := 0.U
      io.memCDB.bits.brHit := true.B
      io.memCDB.bits.expt  := false.B
    }
  }.otherwise{
    // fix point op (NOT including branch)
    io.cdb.bits.prn := io.in.bits.prd
    io.cdb.bits.data := alu_res
    io.cdb.bits.wen := io.in.bits.wen
    io.cdb.bits.brHit := true.B
    io.cdb.bits.expt := false.B // FixPointU can't generate except
  }

}

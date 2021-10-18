package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

import scala.collection.immutable.Nil


// 定点执行单元
class FixPointIn(implicit p: Parameters) extends Bundle{
  val idx = UInt(4.W)
//  val pr1_data = UInt(p(XLen).W)
//  val pr2_data = UInt(p(XLen).W)
  val A = UInt(p(XLen).W)
  val B = UInt(p(XLen).W)
  val alu_op = UInt(5.W)
  val prd = UInt(6.W) // physics rd id
  val imm = UInt(p(XLen).W)

  val br_type = UInt(3.W)
  val pTaken = Bool()   // 0: not jump    1: jump
  val pPC = UInt(p(AddresWidth).W)

  val wb_type = UInt(2.W)
  val wen = Bool()

  val pc = UInt(p(AddresWidth).W)
  val inst = UInt(32.W)
}

class FixPointU(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val in = Flipped(Decoupled(new FixPointIn))

    val cdb = Valid(new CDB)
  })

  // alu
  val alu = Module(new ALU)
  alu.io.rs1 := Mux(io.in.bits.br_type.orR(), io.in.bits.pc, io.in.bits.A)
  alu.io.rs2 := Mux(io.in.bits.br_type.orR(), io.in.bits.imm, io.in.bits.B)
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
  io.cdb.bits.wen := io.in.bits.wen & (io.cdb.bits.prn =/= 0.U)
  io.cdb.bits.brHit := Mux(io.in.bits.br_type.orR(), (br.io.taken === io.in.bits.pTaken) & ((br.io.taken & (io.in.bits.pPC === alu_res)) | (!br.io.taken)), true.B)
  io.cdb.bits.expt := false.B // FixPointU can't generate except
  io.cdb.bits.pc := io.in.bits.pc
  io.cdb.bits.inst := io.in.bits.inst
  io.cdb.valid := io.in.valid

  io.in.ready := true.B  // fixPointU always ready

  dontTouch(io.cdb)
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
  val pc      = UInt(p(AddresWidth).W)
  val inst    = UInt(32.W)
  val illegal = Bool()
  val interrupt = new Bundle{
    val time = Bool()
    val soft = Bool()
    val external = Bool()
  }

  val wen = Bool()
}

class MemReadROBIO(implicit p: Parameters) extends Bundle{
  val addr = Valid(UInt(p(AddresWidth).W))
  val data = Flipped(Valid(UInt(p(XLen).W)))
}

class MemU(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val in = Flipped(Decoupled(new MemUIn))

    val dcache = Flipped(new CacheCPUIO)

    val cdb = Valid(new CDB)
    val memCDB = Valid(new MEMCDB)

    val readROB = new MemReadROBIO
  })

  val alu = Module(new ALU)
  alu.io.rs1 := io.in.bits.A
  alu.io.rs2 := io.in.bits.B
  alu.io.alu_op := io.in.bits.alu_op
  val alu_res = alu.io.out

  val isCSR = io.in.bits.csr_cmd.orR()
  val isMem = (io.in.bits.ld_type.orR() | io.in.bits.st_type.orR()) & !isCSR
  val isALU = (!isCSR) & (!isMem)

  // Mem op
  val mem = Module(new OOOMEM)
  mem.io.ld_type := io.in.bits.ld_type
  mem.io.st_type := 0.U    // OOOMEM only handle ld inst
  mem.io.s_data := io.in.bits.s_data
  mem.io.alu_res := alu_res
  mem.io.inst_valid := io.in.valid & io.in.bits.st_type.orR()
  mem.io.stall := false.B
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
  csr.io.stall := false.B
  csr.io.ctrl_signal.valid := io.in.fire() & isCSR

  // mem FSM
  val s_idle :: s_mem :: s_ret :: Nil = Enum(3)
  val state = RegInit(s_idle)
  val ld_data = RegInit(0.U(p(XLen).W))

  when(state === s_mem){
    when(io.readROB.data.fire()){
      ld_data := io.readROB.data.bits
    }.elsewhen(io.dcache.resp.fire() & io.dcache.resp.bits.cmd === 2.U){
      ld_data := io.dcache.resp.bits.data
    }
  }

  io.in.ready := state === s_idle

  io.readROB.addr.bits := alu_res
  io.readROB.addr.valid := io.in.fire() & isMem

  switch(state){
    is(s_idle){
      when(io.in.fire() & isMem){
        state := s_mem
      }
    }
    is(s_mem){
      when(io.readROB.data.valid){
        // get data from rob
        state := s_ret
      }.elsewhen(io.dcache.resp.fire() & io.dcache.resp.bits.cmd === 2.U){
        // get data from dcache
        state := s_ret
      }
    }
    is(s_ret){
      // return data
      state := s_idle
    }
  }

  // assign cdb and memCDB
  io.cdb.bits.idx := io.in.bits.idx

  io.memCDB.bits.idx := io.in.bits.idx
  io.memCDB.bits.prn   := 0.U
  io.memCDB.bits.data  := 0.U
  io.memCDB.bits.wen   := 0.U
  io.memCDB.bits.brHit := true.B
  io.memCDB.bits.expt  := false.B
  io.memCDB.valid := false.B

  when(io.in.fire() & isCSR){
    // csr op
    io.cdb.bits.prn := io.in.bits.prd
    io.cdb.bits.data := csr.io.out
    io.cdb.bits.wen := io.in.bits.wen & (io.cdb.bits.prn =/= 0.U)
    io.cdb.bits.brHit := true.B
    io.cdb.bits.expt := csr.io.expt
    io.cdb.bits.pc := io.in.bits.pc
    io.cdb.bits.inst := io.in.bits.inst
    io.cdb.valid := true.B
  }.elsewhen(io.in.fire() & isALU){
    // fix point op (NOT including branch)
    io.cdb.bits.prn := io.in.bits.prd
    io.cdb.bits.data := alu_res
    io.cdb.bits.wen := io.in.bits.wen & (io.cdb.bits.prn =/= 0.U)
    io.cdb.bits.brHit := true.B
    io.cdb.bits.expt := false.B // FixPointU can't generate except
    io.cdb.bits.pc := io.in.bits.pc
    io.cdb.bits.inst := io.in.bits.inst
    io.cdb.valid := true.B
  }.otherwise{
    // mem op
    when(io.in.fire() & io.in.bits.st_type.orR()){
      // store inst
      io.cdb.bits.prn   := 0.U
      io.cdb.bits.data  := 0.U
      io.cdb.bits.wen   := 0.U
      io.cdb.bits.brHit := true.B
      io.cdb.bits.expt  := false.B
      io.cdb.bits.pc := io.in.bits.pc
      io.cdb.bits.inst := io.in.bits.inst
      io.cdb.valid := true.B

      io.memCDB.bits.prn   := alu_res
      io.memCDB.bits.data  := io.in.bits.s_data
      io.memCDB.bits.wen   := 0.U
      io.memCDB.bits.brHit := true.B
      io.memCDB.bits.expt  := false.B
      io.memCDB.valid := true.B
    }.otherwise{
      // load inst
      io.cdb.bits.prn := io.in.bits.prd
      io.cdb.bits.data := Mux(state === s_ret, ld_data, 0.U)
      io.cdb.bits.wen := io.in.bits.wen & (io.cdb.bits.prn =/= 0.U)
      io.cdb.bits.brHit := true.B
      io.cdb.bits.expt := false.B
      io.cdb.bits.pc := io.in.bits.pc
      io.cdb.bits.inst := io.in.bits.inst
      io.cdb.valid := state === s_ret
    }
  }

  dontTouch(io.cdb)
}

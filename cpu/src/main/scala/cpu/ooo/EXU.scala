package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

import scala.collection.immutable.Nil


// 定点执行单元
class FixPointIn(implicit p: Parameters) extends Bundle {
  val idx = UInt(4.W)
  //  val pr1_data = UInt(p(XLen).W)
  //  val pr2_data = UInt(p(XLen).W)
  val A = UInt(p(XLen).W)
  val B = UInt(p(XLen).W)
  val alu_op = UInt(5.W)
  val prd = UInt(6.W) // physics rd id
  val imm = UInt(p(XLen).W)

  val br_type = UInt(3.W)
  val pTaken = Bool() // 0: not jump    1: jump
  val pPC = UInt(p(AddresWidth).W)

  val wb_type = UInt(2.W)
  val wen = Bool()

  val pc = UInt(p(AddresWidth).W)
  val inst = UInt(32.W)
}

class FixPointU(implicit p: Parameters) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Decoupled(new FixPointIn))

    val cdb = Valid(new CDB)
  })

  // alu
  val alu = Module(new ALU)
  alu.io.rs1 := Mux(io.in.bits.br_type.orR(), Mux(io.in.bits.br_type === "b111".U, io.in.bits.A, io.in.bits.pc), io.in.bits.A)
  alu.io.rs2 := Mux(io.in.bits.br_type.orR(), io.in.bits.imm, io.in.bits.B)
  alu.io.alu_op := io.in.bits.alu_op
  val alu_res = alu.io.out

  // branch
  val br = Module(new Branch)
  br.io.rs1 := io.in.bits.A
  br.io.rs2 := io.in.bits.B
  br.io.br_type := io.in.bits.br_type

  io.cdb.bits.idx := io.in.bits.idx
  io.cdb.bits.prn := io.in.bits.prd
  io.cdb.bits.data := Mux(io.in.bits.br_type === "b111".U, io.in.bits.pc + 4.U, alu_res)
  io.cdb.bits.j_pc := alu_res
  io.cdb.bits.wen := io.in.bits.wen & (io.cdb.bits.prn =/= 0.U)
  io.cdb.bits.brHit := Mux(io.in.bits.br_type.orR(), (br.io.taken === io.in.bits.pTaken) & ((br.io.taken & (io.in.bits.pPC === alu_res)) | (!br.io.taken)), true.B)
  io.cdb.bits.isTaken := br.io.taken
  io.cdb.bits.expt := false.B // FixPointU can't generate except
  io.cdb.bits.pc := io.in.bits.pc
  io.cdb.bits.inst := io.in.bits.inst
  io.cdb.valid := io.in.valid

  io.cdb.bits.addr := 0.U
  io.cdb.bits.mask := 0.U

  io.in.ready := true.B // fixPointU always ready

  dontTouch(io.cdb)
}

// 访储执行单元 and CSR单元
class MemUIn(implicit p: Parameters) extends Bundle {
  val idx = UInt(4.W)
  val A = UInt(p(XLen).W)
  val B = UInt(p(XLen).W)
  val imm = UInt(p(XLen).W)
  val alu_op = UInt(5.W)
  val prd = UInt(6.W) // physics rd id

  val ld_type = UInt(3.W)
  val st_type = UInt(3.W)
  val s_data = UInt(p(XLen).W)

  val csr_cmd = UInt(3.W)
  // ctrl signals
  val pc = UInt(p(AddresWidth).W)
  val inst = UInt(32.W)
  val illegal = Bool()
  val interrupt = new Bundle {
    val time = Bool()
    val soft = Bool()
    val external = Bool()
  }

  val wen = Bool()
}

class MemReadROBIO(implicit p: Parameters) extends Bundle {
  val req = Valid(new Bundle {
    val addr = UInt(p(AddresWidth).W)
    val mask = UInt(8.W)
    val idx = UInt(4.W)
  })
  val data = Flipped(Valid(UInt(p(XLen).W)))
}

class MemU(implicit p: Parameters) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Decoupled(new MemUIn))

    val dcache = Flipped(new CacheCPUIO)

    val cdb = Valid(new CDB)
    //    val memCDB = Valid(new MEMCDB)

    val readROB = new MemReadROBIO

    val kill = Input(Bool())
  })

  import Control._

  val alu = Module(new ALU)
  alu.io.rs1 := io.in.bits.A
  alu.io.rs2 := Mux(io.in.bits.st_type.orR(), io.in.bits.imm, io.in.bits.B)
  alu.io.alu_op := io.in.bits.alu_op
  val alu_res = alu.io.out

  val isCSR = io.in.bits.csr_cmd.orR()
  val isLD = (io.in.bits.ld_type.orR()) & !isCSR
  val isST = (io.in.bits.st_type.orR()) & !isCSR
  val isALU = (!isCSR) & (!isLD) & (!isST)

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
  // Mem op
  val mem = Module(new OOOMEM)
  mem.io.ld_type := io.in.bits.ld_type
  mem.io.st_type := 0.U // OOOMEM only handle ld inst
  mem.io.s_data := io.in.bits.s_data
  mem.io.alu_res := alu_res
  mem.io.inst_valid := io.in.fire() & (state === s_idle) & isLD & !io.readROB.data.valid // idle状态，来了mem指令，并且rob中无
  mem.io.stall := false.B
  mem.io.dcache <> io.dcache

  // 读取rob的时候要找最近的addr和mask都能匹配上的那一项
  io.readROB.req.valid := io.in.fire() & isLD
  io.readROB.req.bits.addr := alu_res
  io.readROB.req.bits.mask := MuxLookup(io.in.bits.ld_type, 0.U, Array(
    LD_LD  -> ("b1111_1111".U),
    LD_LW  -> ("b0000_1111".U << alu_res(2,0).asUInt()), // <<0 or << 4
    LD_LH  -> ("b0000_0011".U << alu_res(2,0).asUInt()), // <<0, 2, 4, 6
    LD_LB  -> ("b0000_0001".U << alu_res(2,0).asUInt()), // <<0, 1, 2, 3 ... 7
    LD_LWU -> ("b0000_1111".U << alu_res(2,0).asUInt()), // <<0 or << 4
    LD_LHU -> ("b0000_0011".U << alu_res(2,0).asUInt()), // <<0, 2, 4, 6
    LD_LBU -> ("b0000_0001".U << alu_res(2,0).asUInt()), // <<0, 1, 2, 3 ... 7
  ))(7, 0)
  io.readROB.req.bits.idx := io.in.bits.idx


  val req_reg = RegInit(0.U.asTypeOf(io.in.bits))
  val kill_reg = RegInit(false.B)

  when((state === s_idle) & io.readROB.data.fire()) {
    val res = (io.readROB.data.bits >> (io.readROB.req.bits.addr(2, 0) << 3.U).asUInt())
    ld_data := MuxLookup(io.in.bits.ld_type, 0.S(p(XLen).W), Seq(
      Control.LD_LD  -> res(63, 0).asSInt(),
      Control.LD_LW  -> res(31, 0).asSInt(),
      Control.LD_LH  -> res(15, 0).asSInt(),
      Control.LD_LB  -> res( 7, 0).asSInt(),
      Control.LD_LWU -> res(31, 0).zext(),
      Control.LD_LHU -> res(15, 0).zext(),
      Control.LD_LBU -> res( 7, 0).zext(),
    )).asUInt()
  }.elsewhen((state === s_mem) & mem.io.l_data.valid) {
    // cache返回的结果已经是>>的结果了
    ld_data := mem.io.l_data.bits
    MuxLookup(req_reg.ld_type, 0.S(p(XLen).W), Seq(
      Control.LD_LD  -> mem.io.l_data.bits(63, 0).asSInt(),
      Control.LD_LW  -> mem.io.l_data.bits(31, 0).asSInt(),
      Control.LD_LH  -> mem.io.l_data.bits(15, 0).asSInt(),
      Control.LD_LB  -> mem.io.l_data.bits( 7, 0).asSInt(),
      Control.LD_LWU -> mem.io.l_data.bits(31, 0).zext(),
      Control.LD_LHU -> mem.io.l_data.bits(15, 0).zext(),
      Control.LD_LBU -> mem.io.l_data.bits( 7, 0).zext(),
    )).asUInt()
  }

  io.in.ready := state === s_idle


  when((((state === s_idle) & (io.in.fire() & isLD)) | (state === s_mem)) & io.kill) {
    kill_reg := true.B
  }.elsewhen(state === s_ret) {
    kill_reg := false.B
  }

  switch(state) {
    is(s_idle) {
      req_reg := io.in.bits
      when(io.in.fire() & isLD & io.readROB.data.fire()) {
        // data in rob need ret
        state := s_ret
      }.elsewhen(io.in.fire() & isLD & !io.readROB.data.fire()) {
        // data not in rob, need query dcache
        // send dcache read req at the same time
        state := s_mem
      }.otherwise {
        state := state
      }
    }
    is(s_mem) {
      when(io.dcache.resp.fire() & io.dcache.resp.bits.cmd === 2.U) {
        // get data from dcache
        state := s_ret
      }
    }
    is(s_ret) {
      // return data
      state := s_idle
    }
  }

  //  io.memCDB.bits.idx := io.in.bits.idx
  //  io.memCDB.bits.prn   := 0.U
  //  io.memCDB.bits.data  := 0.U
  //  io.memCDB.bits.wen   := 0.U
  //  io.memCDB.bits.brHit := true.B
  //  io.memCDB.bits.expt  := false.B
  //  io.memCDB.valid := false.B

  io.cdb.bits.addr := 0.U
  io.cdb.bits.mask := 0.U

  when(io.in.fire() & isCSR) {
    // csr op
    io.cdb.bits.idx := io.in.bits.idx
    io.cdb.bits.prn := io.in.bits.prd
    io.cdb.bits.data := csr.io.out
    io.cdb.bits.wen := io.in.bits.wen & (io.cdb.bits.prn =/= 0.U)
    io.cdb.bits.brHit := true.B
    io.cdb.bits.expt := csr.io.expt
    io.cdb.bits.pc := io.in.bits.pc
    io.cdb.bits.inst := io.in.bits.inst
    io.cdb.valid := true.B
  }.elsewhen(io.in.fire() & isALU) {
    // fix point op (NOT including branch)
    io.cdb.bits.idx := io.in.bits.idx
    io.cdb.bits.prn := io.in.bits.prd
    io.cdb.bits.data := alu_res
    io.cdb.bits.wen := io.in.bits.wen & (io.cdb.bits.prn =/= 0.U)
    io.cdb.bits.brHit := true.B
    io.cdb.bits.expt := false.B // FixPointU can't generate except
    io.cdb.bits.pc := io.in.bits.pc
    io.cdb.bits.inst := io.in.bits.inst
    io.cdb.valid := true.B
  }.otherwise {
    // mem op
    when(io.in.fire() & io.in.bits.st_type.orR()) {
      // store inst
      io.cdb.bits.idx := io.in.bits.idx
      io.cdb.bits.prn := 0.U
      io.cdb.bits.addr := alu_res // 传递st的地址
      io.cdb.bits.data := (io.in.bits.s_data << (alu_res(2,0) << 3.U).asUInt())(63, 0) // 传递st的数据
      io.cdb.bits.wen := 0.U
      io.cdb.bits.brHit := true.B
      io.cdb.bits.expt := false.B
      io.cdb.bits.pc := io.in.bits.pc
      io.cdb.bits.inst := io.in.bits.inst
      io.cdb.valid := true.B

      io.cdb.bits.mask := MuxLookup(io.in.bits.st_type, 0.U, Array(
        ST_SD -> ("b1111_1111".U),
        ST_SW -> ("b0000_1111".U << io.cdb.bits.addr(2, 0).asUInt()), // <<0 or << 4
        ST_SH -> ("b0000_0011".U << io.cdb.bits.addr(2, 0).asUInt()), // <<0, 2, 4, 6
        ST_SB -> ("b0000_0001".U << io.cdb.bits.addr(2, 0).asUInt()), // <<0, 1, 2, 3 ... 7
      ))(7, 0)

      //      io.memCDB.bits.prn   := alu_res
      //      io.memCDB.bits.data  := io.in.bits.s_data
      //      io.memCDB.bits.wen   := 0.U
      //      io.memCDB.bits.brHit := true.B
      //      io.memCDB.bits.expt  := false.B
      //      io.memCDB.valid := true.B
    }.otherwise {
      // load inst
      io.cdb.bits.idx := req_reg.idx
      io.cdb.bits.prn := req_reg.prd
      io.cdb.bits.data := Mux(state === s_ret, ld_data, 0.U)
      io.cdb.bits.wen := req_reg.wen & (io.cdb.bits.prn =/= 0.U)
      io.cdb.bits.brHit := true.B
      io.cdb.bits.expt := false.B
      io.cdb.bits.pc := req_reg.pc
      io.cdb.bits.inst := req_reg.inst
      io.cdb.valid := (state === s_ret) & (!kill_reg) & !io.kill
    }
  }

  io.cdb.bits.isTaken := false.B
  io.cdb.bits.j_pc := 0.U
  dontTouch(io.cdb)
}

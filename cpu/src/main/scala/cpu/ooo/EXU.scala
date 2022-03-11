package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import cpu.ooo.{Divider, Multiplier, SignExt}

// 定点执行单元
class FixPointIn(implicit val p: Parameters) extends Bundle {
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
    val kill = Input(Bool())

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

  // mul
  val mul = Module(new Multiplier)
  val mul_a = Mux(io.in.bits.alu_op === ALU.ALU_MULHU, io.in.bits.A, SignExt(io.in.bits.A, p(XLen)+1))
  val mul_b = Mux(Seq(ALU.ALU_MULHSU, ALU.ALU_MULHU).map(_ === io.in.bits.alu_op).reduce(_ | _), io.in.bits.B, SignExt(io.in.bits.B, p(XLen)+1))
  val mul_sign = true.B  // ignore
  val mul_isW = io.in.bits.alu_op === ALU.ALU_MULW
  val mul_isHi = Seq(ALU.ALU_MULH, ALU.ALU_MULHSU, ALU.ALU_MULHU).map(_ === io.in.bits.alu_op).reduce(_ | _)
  mul.io.in.bits.src(0) := mul_a
  mul.io.in.bits.src(1) := mul_b
  mul.io.in.bits.ctrl.sign := mul_sign
  mul.io.in.bits.ctrl.isW := mul_isW
  mul.io.in.bits.ctrl.isHi := mul_isHi
  mul.io.kill := io.kill

  val mul_info = Wire(Decoupled(io.in.bits))
  mul_info.valid := mul.io.in.valid
  mul_info.bits := io.in.bits
  mul_info.ready := mul.io.in.ready
  val mul_info_q = Queue(mul_info, 2)  // mul latency is 2
  mul_info.ready := mul.io.out.valid & !div.io.out.valid

  // div
  val div = Module(new Divider)
  val div_a = io.in.bits.A
  val div_b = io.in.bits.B
  val div_sign = Seq(ALU.ALU_DIV, ALU.ALU_DIVW, ALU.ALU_REM, ALU.ALU_REMW).map(_ === io.in.bits.alu_op).reduce(_ | _)
  val div_isW = Seq(ALU.ALU_DIVW, ALU.ALU_DIVUW, ALU.ALU_REMW, ALU.ALU_REMUW).map(_ === io.in.bits.alu_op).reduce(_ | _)
  val div_isHi = Seq(ALU.ALU_REM, ALU.ALU_REMUW, ALU.ALU_REMU, ALU.ALU_REMW).map(_ === io.in.bits.alu_op).reduce(_ | _)
  div.io.in.bits.src(0) := div_a
  div.io.in.bits.src(1) := div_b
  div.io.in.bits.ctrl.sign := div_sign
  div.io.in.bits.ctrl.isW := div_isW
  div.io.in.bits.ctrl.isHi := div_isHi
  div.io.kill := io.kill

  val div_info = Wire(Decoupled(io.in.bits))
  div_info.valid := div.io.in.valid
  div_info.bits := io.in.bits
  div_info.ready := io.in.ready
  val div_info_q = Queue(div_info, 1)
  div_info.ready := div.io.out.valid

  when(div.io.out.valid){
    io.cdb.bits.idx := div_info_q.bits.idx
    io.cdb.bits.prn := div_info.bits.prd
    io.cdb.bits.data := div.io.out.bits
    io.cdb.bits.wen := true.B & (io.cdb.bits.prn =/= 0.U)
    io.cdb.bits.brHit := true.B
    io.cdb.bits.isTaken := false.B
    io.cdb.bits.pc := div_info_q.bits.pc
    io.cdb.bits.inst := div_info.bits.inst
    io.cdb.valid := true.B
  }.elsewhen(mul.io.out.valid){
    io.cdb.bits.idx := mul_info_q.bits.idx
    io.cdb.bits.prn := mul_info.bits.prd
    io.cdb.bits.data := mul.io.out.bits
    io.cdb.bits.wen := true.B & (io.cdb.bits.prn =/= 0.U)
    io.cdb.bits.brHit := true.B
    io.cdb.bits.isTaken := false.B
    io.cdb.bits.pc := mul_info_q.bits.pc
    io.cdb.bits.inst := mul_info.bits.inst
    io.cdb.valid := true.B
  }.otherwise{
    io.cdb.bits.idx := io.in.bits.idx
    io.cdb.bits.prn := io.in.bits.prd
    io.cdb.bits.data := Mux(io.in.bits.br_type === "b111".U, io.in.bits.pc + 4.U, alu_res)
    io.cdb.bits.j_pc := alu_res
    io.cdb.bits.wen := io.in.bits.wen & (io.cdb.bits.prn =/= 0.U)
    io.cdb.bits.brHit := Mux(io.in.bits.br_type.orR(), (br.io.taken === io.in.bits.pTaken) & ((br.io.taken & (io.in.bits.pPC === alu_res)) | (!br.io.taken)), true.B)
    io.cdb.bits.isTaken := br.io.taken
    io.cdb.bits.pc := io.in.bits.pc
    io.cdb.bits.inst := io.in.bits.inst
    io.cdb.valid := io.in.valid
  }
  io.cdb.bits.addr := 0.U
  io.cdb.bits.mask := 0.U
  io.cdb.bits.expt := false.B // FixPointU can't generate except

  div.io.out.ready := div.io.out.valid
  mul.io.out.ready := mul.io.out.valid & !div.io.out.valid

  io.in.ready := io.in.valid & MuxCase(false.B, Seq(
    Seq(ALU.ALU_MUL, ALU.ALU_MULH, ALU.ALU_MULHSU, ALU.ALU_MULHU, ALU.ALU_MULW).map(_ === io.in.bits.alu_op).reduce(_ | _) -> mul.io.in.ready,
    Seq(ALU.ALU_DIV, ALU.ALU_DIVU, ALU.ALU_DIVW, ALU.ALU_DIVUW).map(_ === io.in.bits.alu_op).reduce(_ | _) -> div.io.in.ready,
    Seq(ALU.ALU_REM, ALU.ALU_REMU, ALU.ALU_REMW, ALU.ALU_REMUW).map(_ === io.in.bits.alu_op).reduce(_ | _) -> div.io.in.ready,
  ))

  dontTouch(io.cdb)
}

// 访储执行单元 and CSR单元
class MemUIn(implicit val p: Parameters) extends Bundle {
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
  val rocc_cmd = UInt(2.W)
  // ctrl signals
  val pc = UInt(p(AddresWidth).W)
  val inst = UInt(32.W)
  val illegal = Bool()

  val wen = Bool()
}

class MemReadROBIO(implicit val p: Parameters) extends Bundle {
  val req = Valid(new Bundle {
    val addr = UInt(p(AddresWidth).W)
    val mask = UInt(8.W)
    val idx = UInt(4.W)
  })
  val resp = Flipped(Valid(new Bundle {
    val data = UInt(p(XLen).W)
    val mask = UInt(8.W)
    val meet = Bool()
  }))
}

class MemU(implicit p: Parameters) extends Module {
  val addressSpace = p(AddressSpace)
  val io = IO(new Bundle {
    val in = Flipped(Decoupled(new MemUIn))

    val dcache = Flipped(new CacheCPUIO)

    val cdb = Valid(new CDB)
    val rocc_queue = Decoupled(new RoCCQueueIO)
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
  val isRoCC = io.in.bits.rocc_cmd.orR()
  val isLD = (io.in.bits.ld_type.orR()) & !isCSR
  val isST = (io.in.bits.st_type.orR()) & !isCSR
  val isALU = (!isCSR) & (!isLD) & (!isST)

//  // CSR op
//  val csr = Module(new CSR)
//  csr.io.cmd := io.in.bits.csr_cmd
//  csr.io.in := alu_res
//  csr.io.ctrl_signal.pc := io.in.bits.pc
//  csr.io.ctrl_signal.addr := alu_res
//  csr.io.ctrl_signal.inst := io.in.bits.inst
//  csr.io.ctrl_signal.illegal := io.in.bits.illegal
//  csr.io.ctrl_signal.st_type := io.in.bits.st_type
//  csr.io.ctrl_signal.ld_type := io.in.bits.ld_type
//  csr.io.pc_check := false.B
//  csr.io.interrupt := io.in.bits.interrupt
//  csr.io.stall := false.B
//  csr.io.ctrl_signal.valid := io.in.fire() & isCSR

  val invalid_mem_addr = !WireInit(addressSpace.map(x => {
    (alu_res >= x._1.U(p(AddresWidth).W)) & (alu_res < (x._1.U(p(AddresWidth).W) + x._2.U(p(AddresWidth).W)))
  }).reduce(_ | _))
  // mem FSM
  val s_idle :: s_mem :: s_ret :: Nil = Enum(3)
  val state = RegInit(s_idle)
  val ld_data = RegInit(0.U(p(XLen).W))
  // Mem op
  val req_reg = RegInit(0.U.asTypeOf(io.in.bits))
  val addr_reg = RegInit(0.U(p(AddresWidth).W))
  val kill_reg = RegInit(false.B)
  val diff_mask = RegInit(0.U(8.W))

  val mem = Module(new OOOMEM)
  mem.io.ld_type := Mux(state === s_idle, io.in.bits.ld_type, req_reg.ld_type)
  mem.io.alu_res := Mux(state === s_idle, alu_res, addr_reg)
  mem.io.inst_valid := (!io.kill) & io.in.fire() & (state === s_idle) & isLD & (io.readROB.resp.fire() & !io.readROB.resp.bits.meet) & (!invalid_mem_addr) // idle状态，来了mem指令，并且rob中无
  mem.io.dcache <> io.dcache

  // 读取rob的时候要找最近的addr和mask都能匹配上的那一项
  io.readROB.req.valid := io.in.fire() & isLD
  io.readROB.req.bits.addr := alu_res
  io.readROB.req.bits.mask := MuxLookup(io.in.bits.ld_type, 0.U, Array(
    LD_LD -> ("b1111_1111".U),
    LD_LW -> ("b0000_1111".U << alu_res(2, 0).asUInt()), // <<0 or << 4
    LD_LH -> ("b0000_0011".U << alu_res(2, 0).asUInt()), // <<0, 2, 4, 6
    LD_LB -> ("b0000_0001".U << alu_res(2, 0).asUInt()), // <<0, 1, 2, 3 ... 7
    LD_LWU -> ("b0000_1111".U << alu_res(2, 0).asUInt()), // <<0 or << 4
    LD_LHU -> ("b0000_0011".U << alu_res(2, 0).asUInt()), // <<0, 2, 4, 6
    LD_LBU -> ("b0000_0001".U << alu_res(2, 0).asUInt()), // <<0, 1, 2, 3 ... 7
  ))(7, 0)
  io.readROB.req.bits.idx := io.in.bits.idx


  when((state === s_idle)) {
    when(io.readROB.resp.fire()) {
      when(io.readROB.resp.bits.meet) {
        val res = io.readROB.resp.bits.data >> (io.readROB.req.bits.addr(2, 0) << 3.U).asUInt()
        ld_data := MuxLookup(io.in.bits.ld_type, 0.S(p(XLen).W), Seq(
          Control.LD_LD -> res(63, 0).asSInt(),
          Control.LD_LW -> res(31, 0).asSInt(),
          Control.LD_LH -> res(15, 0).asSInt(),
          Control.LD_LB -> res(7, 0).asSInt(),
          Control.LD_LWU -> res(31, 0).zext(),
          Control.LD_LHU -> res(15, 0).zext(),
          Control.LD_LBU -> res(7, 0).zext(),
        )).asUInt()
      }.otherwise{
        ld_data := io.readROB.resp.bits.data
      }
    }.elsewhen(invalid_mem_addr) {
      ld_data := 0.U
    }
  }.elsewhen((state === s_mem) & mem.io.l_data.valid) {
    // cache返回的结果已经是>>的结果了, 需要恢复64bit对齐，st指令存储在rob中的也是64bit对齐
    val dcache_ret_data = mem.io.l_data.bits << (addr_reg(2, 0) << 3.U)
    // 组合dcache返回的数据和rob中的数据
    val tmp = Cat(diff_mask.asBools().zipWithIndex.map(x => {
      val (valid, i) = x
      val res = Wire(UInt(8.W))
      res := Mux(valid, dcache_ret_data(8 * (i + 1) - 1, 8 * i), ld_data(8 * (i + 1) - 1, 8 * i))
      res
    }).reverse) >> (addr_reg(2, 0) << 3.U).asUInt()
    ld_data := MuxLookup(req_reg.ld_type, 0.S(p(XLen).W), Seq(
      Control.LD_LD -> tmp(63, 0).asSInt(),
      Control.LD_LW -> tmp(31, 0).asSInt(),
      Control.LD_LH -> tmp(15, 0).asSInt(),
      Control.LD_LB -> tmp(7, 0).asSInt(),
      Control.LD_LWU -> tmp(31, 0).zext(),
      Control.LD_LHU -> tmp(15, 0).zext(),
      Control.LD_LBU -> tmp(7, 0).zext(),
    )).asUInt()
  }

  // if input is a rocc inst, need to make sure rocc_queue is ready to accept rs1 and rs2
  io.in.ready := (state === s_idle) & ((io.in.valid & io.in.bits.rocc_cmd.orR() & io.rocc_queue.ready) | !io.in.bits.rocc_cmd.orR())


  when((((state === s_idle) & (io.in.fire() & isLD) & !io.kill) | (state === s_mem)) & io.kill) {
    kill_reg := true.B
  }.elsewhen(state === s_ret) {
    kill_reg := false.B
  }

  switch(state) {
    is(s_idle) {
      req_reg := io.in.bits
      addr_reg := alu_res
      when(io.in.fire() & isLD & !io.kill) {
        when(io.readROB.resp.fire() & io.readROB.resp.bits.meet) {
          // 全部在rob中，可以直接ret
          state := s_ret
          diff_mask := io.readROB.resp.bits.mask ^ io.readROB.req.bits.mask
        }.elsewhen(invalid_mem_addr) {
          // 无效的地址,由于乱须执行导致
          state := s_ret
        }.elsewhen(io.readROB.resp.fire() & !io.readROB.resp.bits.meet) {
          // 不在或者不完全在rob中，需要向mem发送ld请求
          state := s_mem
          diff_mask := io.readROB.resp.bits.mask ^ io.readROB.req.bits.mask
        }
      }
    }
    is(s_mem) {
      when(mem.io.l_data.valid) {
        // get data from dcache by mem
        state := s_ret
      }
    }
    is(s_ret) {
      // return data
      state := s_idle
    }
  }

  io.cdb.bits.addr := 0.U
  io.cdb.bits.mask := 0.U

  // valid can't depend on ready
  io.rocc_queue.valid := io.in.fire() & io.in.bits.rocc_cmd.orR()
  io.rocc_queue.bits.rs1 := io.in.bits.A
  io.rocc_queue.bits.rs2 := io.in.bits.B

  when(io.in.fire() & isCSR) {
    // csr op
    // csr读数只通过commit端口，cdb处不会改变rename和station状态，因为csr放在了rob里面，当前还没有读csr
    io.cdb.bits.idx := io.in.bits.idx
    io.cdb.bits.prn := io.in.bits.prd  // rd
    io.cdb.bits.data := alu_res        // data传递csr的in
    io.cdb.bits.wen := false.B // !! io.in.bits.wen & (io.cdb.bits.prn =/= 0.U)
    io.cdb.bits.brHit := true.B
    io.cdb.bits.expt := false.B
    io.cdb.bits.pc := io.in.bits.pc
    io.cdb.bits.inst := io.in.bits.inst // inst里面蕴含了csr addr
    io.cdb.valid := true.B
  }.elsewhen(io.in.fire() & isRoCC){
    // rocc inst also need to execute in order!
    // and its result is return in commit stage
    io.cdb.bits.idx := io.in.bits.idx
    io.cdb.bits.prn := io.in.bits.prd
    io.cdb.bits.data := alu_res
    io.cdb.bits.wen := false.B         // !!
    io.cdb.bits.brHit := true.B
    io.cdb.bits.expt := false.B
    io.cdb.bits.pc := io.in.bits.pc
    io.cdb.bits.inst := io.in.bits.inst // rocc cmd need inst
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
      io.cdb.bits.data := (io.in.bits.s_data << (alu_res(2, 0) << 3.U).asUInt()) (63, 0) // 传递st的数据
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
      io.cdb.bits.addr := addr_reg
    }
  }

  io.cdb.bits.isTaken := false.B
  io.cdb.bits.j_pc := 0.U
  dontTouch(io.cdb)
}

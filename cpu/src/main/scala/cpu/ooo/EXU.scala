package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import cpu.ooo.{Divider, ExceptType, Multiplier, SignExt}

// 定点执行单元
class FixPointIn(implicit val p: Parameters) extends Bundle {
  val idx = UInt(4.W)
  //  val pr1_data = UInt(p(XLen).W)
  //  val pr2_data = UInt(p(XLen).W)
  val A = UInt(p(XLen).W)
  val B = UInt(p(XLen).W)
  val alu_op = UInt(6.W)
  val prd = UInt(6.W) // physics rd id
  val imm = UInt(p(XLen).W)

  val br_type = UInt(3.W)
  val pTaken = Bool() // 0: not jump    1: jump
  val pPC = UInt(p(AddresWidth).W)

  val wb_type = UInt(2.W)
  val wen = Bool()

  val except = UInt(2.W)

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
  val div = Module(new Divider)

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

  val mul_info = Wire(Decoupled(io.in.bits.cloneType))
  mul_info.valid := mul.io.in.valid
  mul_info.bits := io.in.bits
  val mul_info_q = withReset(reset.asBool() | io.kill){Queue(mul_info, 3)}  // mul latency is 2
  mul_info_q.ready := mul.io.out.valid & !div.io.out.valid

  // div
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

  val div_info = Wire(Decoupled(io.in.bits.cloneType))
  div_info.valid := div.io.in.fire()
  div_info.bits := io.in.bits
  val div_info_q = withReset(reset.asBool() | io.kill){Queue(div_info, 1)}
  div_info_q.ready := div.io.out.valid

  val isDiv = Seq(ALU.ALU_DIV, ALU.ALU_DIVU, ALU.ALU_DIVW, ALU.ALU_DIVUW).map(_ === io.in.bits.alu_op).reduce(_ | _) | Seq(ALU.ALU_REM, ALU.ALU_REMU, ALU.ALU_REMW, ALU.ALU_REMUW).map(_ === io.in.bits.alu_op).reduce(_ | _)
  val isMul = Seq(ALU.ALU_MUL, ALU.ALU_MULH, ALU.ALU_MULHSU, ALU.ALU_MULHU, ALU.ALU_MULW).map(_ === io.in.bits.alu_op).reduce(_ | _)

  when(div.io.out.fire()){
    io.cdb.bits.idx := div_info_q.bits.idx
    io.cdb.bits.prn := div_info_q.bits.prd
    io.cdb.bits.prn_data := div.io.out.bits
    io.cdb.bits.wen := true.B & (io.cdb.bits.prn =/= 0.U)
    io.cdb.bits.brHit := true.B
    io.cdb.bits.isTaken := false.B
    io.cdb.bits.pc := div_info_q.bits.pc
    io.cdb.bits.inst := div_info_q.bits.inst
    io.cdb.bits.expt := ExceptType.NO   // todo: 被除数等于0的异常怎么判断
    io.cdb.valid := true.B
  }.elsewhen(mul.io.out.fire()){
    io.cdb.bits.idx := mul_info_q.bits.idx
    io.cdb.bits.prn := mul_info_q.bits.prd
    io.cdb.bits.prn_data := mul.io.out.bits
    io.cdb.bits.wen := true.B & (io.cdb.bits.prn =/= 0.U)
    io.cdb.bits.brHit := true.B
    io.cdb.bits.isTaken := false.B
    io.cdb.bits.pc := mul_info_q.bits.pc
    io.cdb.bits.inst := mul_info_q.bits.inst
    io.cdb.bits.expt := ExceptType.NO
    io.cdb.valid := true.B
  }.otherwise{
    io.cdb.bits.idx := io.in.bits.idx
    io.cdb.bits.prn := io.in.bits.prd
    io.cdb.bits.prn_data := Mux(io.in.bits.br_type === "b111".U, io.in.bits.pc + 4.U, alu_res)
    io.cdb.bits.wen := io.in.bits.wen & (io.cdb.bits.prn =/= 0.U)
    io.cdb.bits.brHit := Mux(io.in.bits.br_type.orR(), (br.io.taken === io.in.bits.pTaken) & ((br.io.taken & (io.in.bits.pPC === alu_res)) | (!br.io.taken)), true.B)
    io.cdb.bits.isTaken := br.io.taken
    io.cdb.bits.pc := io.in.bits.pc
    io.cdb.bits.inst := io.in.bits.inst
    io.cdb.bits.expt := io.in.bits.except  // 转发异常
    // common inst req accept and commit
    io.cdb.valid := io.in.valid & (!isDiv) & (!isMul)
  }
  io.cdb.bits.j_pc := alu_res
  io.cdb.bits.addr := 0.U
  io.cdb.bits.mask := 0.U
  io.cdb.bits.store_data := 0.U // FixPoiuntU can't handle store inst

  div.io.out.ready := div.io.out.valid & RegNext(div.io.out.valid)
  mul.io.out.ready := mul.io.out.valid & !div.io.out.valid


  div.io.in.valid := io.in.valid & isDiv & !io.kill
  mul.io.in.valid := io.in.valid & isMul & !io.kill

  io.in.ready := io.in.valid & MuxCase(true.B & (!div.io.out.fire()) & (!mul.io.out.fire()), Seq(
     isMul -> mul.io.in.ready,
     isDiv -> div.io.in.ready,
  ))

  dontTouch(io.cdb)
}

// 访储执行单元 and CSR单元
class MemUIn(implicit val p: Parameters) extends Bundle {
  val idx = UInt(4.W)
  val A = UInt(p(XLen).W)
  val B = UInt(p(XLen).W)
  val imm = UInt(p(XLen).W)
  val alu_op = UInt(6.W)
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

class LSU(implicit val p: Parameters) extends Module {
  val addressSpace = p(AddressSpace)
  val io = IO(new Bundle{
    val in = Flipped(Decoupled(new MemUIn))
    val dcache = Flipped(new CacheCPUIO)
    val cdb = Valid(new CDB)
    val rocc_queue = Decoupled(new RoCCQueueIO)
    val readROB = new MemReadROBIO
    val kill = Input(Bool())
  })

  import Control._

  val alu = Module(new ALU)
}

// LoadU for loading from rob and mem
class LoadU(implicit val p: Parameters) extends Module {
  val addressSpace = p(AddressSpace)
  val io = IO(new Bundle{
    val req = Flipped(Decoupled(new Bundle{
      val addr = UInt(p(AddresWidth).W)
      val ld_type = UInt(3.W)
      val idx = UInt(4.W)    // 当前的指令的保留站idx，用于rob读取时候向前查找最近的一项
    }))
    val resp = Decoupled(new Bundle{
      val data = UInt(p(XLen).W)
      val except = Bool()
    })
    val dcache = Flipped(new CacheCPUIO)
    val readROB = new MemReadROBIO
    val kill = Input(Bool())
  })

  // 如果需要的数据全在rob中就可以ret，如果不在或者不全在就需要mem load一次然后ret
  val s_idle :: s_mem :: s_ret :: Nil = Enum(3)
  val state = RegInit(s_idle)
  val req_reg = RegInit(0.U.asTypeOf(io.req.bits)) // 缓存req
  val addr_reg = RegInit(0.U(32.W))   // 缓存req 地址
  val diff_mask = RegInit(0.U(8.W))   // rob存在的数据和req需要的数据之间的差

  // 检测超出地址空间的无效地址
  val invalid_mem_addr = !WireInit(addressSpace.map(x => {
    (io.req.bits.addr >= x._1.U(p(AddresWidth).W)) & (io.req.bits.addr < (x._1.U(p(AddresWidth).W) + x._2.U(p(AddresWidth).W)))
  }).reduce(_ | _)) & false.B // do it in cache

  // mem 封装了从cache load数据的功能
  val mem = Module(new OOOMEM)
  mem.io.ld_type := Mux(state === s_idle, io.req.bits.ld_type, req_reg.ld_type)
  mem.io.alu_res := Mux(state === s_idle, io.req.bits.addr, addr_reg)
  mem.io.inst_valid := (!io.kill) & io.req.fire() & (state === s_idle) & (io.readROB.resp.fire & !io.readROB.resp.bits.meet) & (!invalid_mem_addr) // idle状态，来了mem指令，并且rob中无
  mem.io.dcache <> io.dcache

  // 最终拼凑的结果
  val ld_data = RegInit(0.U(p(XLen).W))
  val is_except = RegInit(false.B)

  switch(state) {
    is(s_idle) {
      when(io.req.fire() & !io.kill) {
        req_reg := io.req.bits
        addr_reg := io.req.bits.addr
        when(io.readROB.resp.fire & io.readROB.resp.bits.meet) {
          // 全部在rob中，可以直接ret
          state := s_ret
          diff_mask := io.readROB.resp.bits.mask ^ io.readROB.req.bits.mask
        }.elsewhen(invalid_mem_addr) {
          // 无效的地址,由于乱须执行导致
          state := s_ret
        }.elsewhen(io.readROB.resp.fire & !io.readROB.resp.bits.meet) {
          // 不在或者不完全在rob中，需要向mem发送ld请求
          state := s_mem
          diff_mask := io.readROB.resp.bits.mask ^ io.readROB.req.bits.mask
        }
      }
    }
    is(s_mem) {
      when(mem.io.resp.valid) {
        // get data from dcache by mem
        state := s_ret
      }
    }
    is(s_ret) {
      // return data
      state := s_idle
    }
  }

  // 读取rob的时候要找最近的addr和mask都能匹配上的那一项
  io.readROB.req.valid := io.req.fire()
  io.readROB.req.bits.addr := io.req.bits.addr
  io.readROB.req.bits.mask := MuxLookup(io.req.bits.ld_type, 0.U, Array(
    Control.LD_LD  -> ("b1111_1111".U),
    Control.LD_LW  -> ("b0000_1111".U << io.req.bits.addr(2, 0).asUInt()), // <<0 or << 4
    Control.LD_LH  -> ("b0000_0011".U << io.req.bits.addr(2, 0).asUInt()), // <<0, 2, 4, 6
    Control.LD_LB  -> ("b0000_0001".U << io.req.bits.addr(2, 0).asUInt()), // <<0, 1, 2, 3 ... 7
    Control.LD_LWU -> ("b0000_1111".U << io.req.bits.addr(2, 0).asUInt()), // <<0 or << 4
    Control.LD_LHU -> ("b0000_0011".U << io.req.bits.addr(2, 0).asUInt()), // <<0, 2, 4, 6
    Control.LD_LBU -> ("b0000_0001".U << io.req.bits.addr(2, 0).asUInt()), // <<0, 1, 2, 3 ... 7
  ))(7, 0)
  io.readROB.req.bits.idx := io.req.bits.idx

  when(state === s_idle) {
    when(io.readROB.resp.fire) {
      when(io.readROB.resp.bits.meet) {
        val res = io.readROB.resp.bits.data >> (io.readROB.req.bits.addr(2, 0) << 3.U).asUInt()
        is_except := false.B
        ld_data := MuxLookup(io.req.bits.ld_type, 0.S(p(XLen).W), Seq(
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
  }.elsewhen((state === s_mem) & mem.io.resp.valid) {
    // cache返回的结果已经是>>的结果了, 需要恢复64bit对齐，st指令存储在rob中的也是64bit对齐
    val dcache_ret_data = mem.io.resp.bits.data << (addr_reg(2, 0) << 3.U)
    // 组合dcache返回的数据和rob中的数据
    val tmp = Cat(diff_mask.asBools().zipWithIndex.map(x => {
      val (valid, i) = x
      val res = Wire(UInt(8.W))
      res := Mux(valid, dcache_ret_data(8 * (i + 1) - 1, 8 * i), ld_data(8 * (i + 1) - 1, 8 * i))
      res
    }).reverse) >> (addr_reg(2, 0) << 3.U).asUInt()
    is_except := mem.io.resp.bits.except
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

  io.req.ready := state === s_idle
  // resp逻辑
  io.resp.valid := state === s_ret
  io.resp.bits.data := ld_data
  io.resp.bits.except := is_except
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
  val isAMOW = (io.in.bits.alu_op >= ALU.ALU_AMOADD_W) & (io.in.bits.alu_op <= ALU.ALU_AMOSWAP_W)
  val isAMOD = (io.in.bits.alu_op >= ALU.ALU_AMOADD_D) & (io.in.bits.alu_op <= ALU.ALU_AMOSWAP_D)
  val isAMO = isAMOW | isAMOD
  val isLR = (io.in.bits.alu_op === ALU.ALU_LR_W) | (io.in.bits.alu_op === ALU.ALU_LR_D)
  val isSC = (io.in.bits.alu_op === ALU.ALU_SC_W) | (io.in.bits.alu_op === ALU.ALU_SC_D)
  val isALU = (!isCSR) & (!isLD) & (!isST) & (!isRoCC) & (!isAMO) & (!isLR) & (!isSC)

  val in_reg = RegInit(0.U.asTypeOf(io.in.bits))
  val isAMOW_reg = RegInit(false.B)
  val addr_reg = RegInit(0.U(32.W))
  val kill_reg = RegInit(false.B)

  val s_idle :: s_load :: s_amoload :: s_amocal :: s_amostore :: Nil = Enum(5)
  val state = RegInit(s_idle)

  when(io.in.fire() & (isLD | isAMO)){
    in_reg := io.in.bits
    addr_reg := Mux(isAMO | isLR, io.in.bits.A, alu_res)  // amoop addr is rs1, not alu_res
    isAMOW_reg := isAMOW
  }
  when((state =/= s_idle) & io.kill){
    kill_reg := true.B
  }.elsewhen(state === s_idle){
    kill_reg := false.B
  }

  val loadU = Module(new LoadU)
  loadU.io.dcache <> io.dcache
  loadU.io.readROB <> io.readROB
  loadU.io.kill := io.kill
  loadU.io.req.valid := io.in.fire() & (isLD | isAMO)
  loadU.io.req.bits.addr := Mux(isLD & !isLR, alu_res, io.in.bits.A)
  loadU.io.req.bits.ld_type := Mux(isLD & !isLR, io.in.bits.ld_type, Mux(isAMOW, Control.LD_LW, Control.LD_LD))
  loadU.io.req.bits.idx := io.in.bits.idx
  loadU.io.resp.ready := (state === s_load) | (state === s_amoload)


  // idle 并且 loadU也idle才可以接受 req  todo: 是否可以让直接转发的req直接通过?
  io.in.ready := (state === s_idle) & (loadU.io.req.ready)

  val ld_data = RegInit(0.U(p(XLen).W))
  val is_except = RegInit(false.B)
  dontTouch(ld_data)
  ld_data := Mux(loadU.io.resp.fire, loadU.io.resp.bits.data, ld_data)
  is_except := Mux(loadU.io.resp.fire, loadU.io.resp.bits.except, is_except)

  val amo_res = RegInit(0.U(p(XLen).W))
  val amo_a = ld_data
  val amo_b = in_reg.B

  val issub = ((in_reg.alu_op =/= ALU.ALU_AMOADD_D) & (in_reg.alu_op =/= ALU.ALU_AMOADD_W)).asBool()
  val _add = (amo_a +& (amo_b ^ Cat(Seq.fill(p(XLen))(issub)).asUInt())) + issub
  val _xor = amo_a ^ amo_b
  val _or  = amo_a | amo_b
  val _and = amo_a & amo_b
  val a_lessu_b = !_add(p(XLen))    // _add = a - b + Mod，如果a-b是正数，那么最高位为1, a>b
  val a_less_b  = _xor(p(XLen)-1) ^ a_lessu_b  // a，b异号  a-b 的符号位置相加为0，扩展的符号位不会变
  val _minu = Mux(a_lessu_b, amo_a, amo_b)
  val _maxu = Mux(a_lessu_b, amo_b, amo_a)
  val _min = Mux(a_less_b, amo_a, amo_b)
  val _max = Mux(a_less_b, amo_b, amo_a)

  when(state === s_amocal){
    amo_res := MuxLookup(in_reg.alu_op, 0.U, Seq(
      ALU.ALU_AMOADD_W  -> ( _add(31, 0) << (addr_reg(2, 0) << 3.U).asUInt()),
      ALU.ALU_AMOXOR_W  -> ( _xor(31, 0) << (addr_reg(2, 0) << 3.U).asUInt()),
      ALU.ALU_AMOOR_W   -> (  _or(31, 0) << (addr_reg(2, 0) << 3.U).asUInt()),
      ALU.ALU_AMOAND_W  -> ( _and(31, 0) << (addr_reg(2, 0) << 3.U).asUInt()),
      ALU.ALU_AMOMIN_W  -> ( _min(31, 0) << (addr_reg(2, 0) << 3.U).asUInt()),
      ALU.ALU_AMOMAX_W  -> ( _max(31, 0) << (addr_reg(2, 0) << 3.U).asUInt()),
      ALU.ALU_AMOMINU_W -> (_minu(31, 0) << (addr_reg(2, 0) << 3.U).asUInt()),
      ALU.ALU_AMOMAXU_W -> (_maxu(31, 0) << (addr_reg(2, 0) << 3.U).asUInt()),
      ALU.ALU_AMOSWAP_W -> (amo_b(31, 0) << (addr_reg(2, 0) << 3.U).asUInt()),
      ALU.ALU_AMOADD_D  -> _add,
      ALU.ALU_AMOXOR_D  -> _xor,
      ALU.ALU_AMOOR_D   -> _or,
      ALU.ALU_AMOAND_D  -> _and,
      ALU.ALU_AMOMIN_D  -> _min,
      ALU.ALU_AMOMAX_D  -> _max,
      ALU.ALU_AMOMINU_D -> _minu,
      ALU.ALU_AMOMAXU_D -> _maxu,
      ALU.ALU_AMOSWAP_D -> amo_b,
    ))
  }

  switch(state){
    is(s_idle){
      state := MuxCase(state, Seq(
        (io.in.fire() & isLD & !io.kill) -> s_load,
        (io.in.fire() & isAMO & !io.kill) -> s_amoload
      ))
    }
    is(s_load){
      state := MuxCase(state, Seq(
        loadU.io.resp.fire() -> s_idle
      ))
    }
    is(s_amoload){
      state := MuxCase(state, Seq(
        (loadU.io.resp.fire() & !loadU.io.resp.bits.except) -> s_amocal,
        (loadU.io.resp.fire() & loadU.io.resp.bits.except) -> s_idle, // 出现异常直接返回到idle
      ))
    }
    is(s_amocal){
      // 计算
      state := s_amostore
    }
    is(s_amostore){
      // 存储
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
    io.cdb.bits.prn_data := alu_res        // data传递csr的in
    io.cdb.bits.store_data := 0.U
    io.cdb.bits.wen := false.B // !! io.in.bits.wen & (io.cdb.bits.prn =/= 0.U)  csr data not occur here
    io.cdb.bits.brHit := true.B
    io.cdb.bits.expt := ExceptType.NO
    io.cdb.bits.pc := io.in.bits.pc
    io.cdb.bits.inst := io.in.bits.inst // inst里面蕴含了csr addr
    io.cdb.valid := true.B
  }.elsewhen(io.in.fire() & isRoCC){
    // rocc inst also need to execute in order!
    // and its result is return in commit stage
    io.cdb.bits.idx := io.in.bits.idx
    io.cdb.bits.prn := io.in.bits.prd
    io.cdb.bits.prn_data := alu_res
    io.cdb.bits.store_data := 0.U
    io.cdb.bits.wen := false.B         // !!
    io.cdb.bits.brHit := true.B
    io.cdb.bits.expt := ExceptType.NO
    io.cdb.bits.pc := io.in.bits.pc
    io.cdb.bits.inst := io.in.bits.inst // rocc cmd need inst
    io.cdb.valid := true.B
  }.elsewhen(io.in.fire() & isALU) {
    // fix point op (NOT including branch)
    io.cdb.bits.idx := io.in.bits.idx
    io.cdb.bits.prn := io.in.bits.prd
    io.cdb.bits.prn_data := alu_res
    io.cdb.bits.store_data := 0.U
    io.cdb.bits.wen := io.in.bits.wen & (io.cdb.bits.prn =/= 0.U)
    io.cdb.bits.brHit := true.B
    io.cdb.bits.expt := ExceptType.NO
    io.cdb.bits.pc := io.in.bits.pc
    io.cdb.bits.inst := io.in.bits.inst
    io.cdb.valid := true.B
  }.otherwise {
    // mem op
    when(io.in.fire() & (io.in.bits.st_type.orR() & !isAMO)) {
      // store inst
      io.cdb.bits.idx := io.in.bits.idx
      io.cdb.bits.prn := 0.U
      io.cdb.bits.prn_data := 0.U
      io.cdb.bits.addr := Mux(isSC, io.in.bits.A, alu_res) // 传递st的地址
      io.cdb.bits.store_data := (io.in.bits.s_data << (io.cdb.bits.addr(2, 0) << 3.U).asUInt()) (63, 0) // 传递st的数据
      io.cdb.bits.wen := 0.U
      io.cdb.bits.brHit := true.B
      io.cdb.bits.expt := ExceptType.NO
      io.cdb.bits.pc := io.in.bits.pc
      io.cdb.bits.inst := io.in.bits.inst
      io.cdb.valid := true.B

      io.cdb.bits.mask := MuxLookup(io.in.bits.st_type, 0.U, Array(
        ST_SD -> ("b1111_1111".U),
        ST_SW -> ("b0000_1111".U << io.cdb.bits.addr(2, 0).asUInt()), // <<0 or << 4
        ST_SH -> ("b0000_0011".U << io.cdb.bits.addr(2, 0).asUInt()), // <<0, 2, 4, 6
        ST_SB -> ("b0000_0001".U << io.cdb.bits.addr(2, 0).asUInt()), // <<0, 1, 2, 3 ... 7
      ))(7, 0)
    }.elsewhen((state === s_amoload) & loadU.io.resp.fire & loadU.io.resp.bits.except){
      // amo指令load出现异常
      io.cdb.bits.idx := in_reg.idx
      io.cdb.bits.prn := 0.U
      io.cdb.bits.prn_data := 0.U
      io.cdb.bits.expt := ExceptType.SPF
      io.cdb.bits.wen := false.B
      io.cdb.bits.brHit := true.B
      io.cdb.bits.pc := in_reg.pc
      io.cdb.bits.inst := in_reg.inst
      io.cdb.valid := true.B & !kill_reg & !io.kill
      io.cdb.bits.addr := addr_reg
      io.cdb.bits.store_data := 0.U
      io.cdb.bits.mask := 0.U
    }.elsewhen(state === s_amostore){
      // amo store   只有load不出现异常状态机才能传播到store状态
      io.cdb.bits.idx := in_reg.idx
      io.cdb.bits.prn := in_reg.prd
      io.cdb.bits.prn_data := ld_data
      io.cdb.bits.wen := true.B  // amo need write back to register, it will done by csr
      io.cdb.bits.brHit := true.B
      io.cdb.bits.expt := ExceptType.NO
      io.cdb.bits.pc := in_reg.pc
      io.cdb.bits.inst := in_reg.inst
      io.cdb.valid := true.B & !kill_reg & !io.kill
      io.cdb.bits.addr := addr_reg
      io.cdb.bits.store_data := amo_res
      io.cdb.bits.mask := Mux(isAMOW_reg, "b0000_1111".U << io.cdb.bits.addr(2, 0).asUInt(), "b1111_1111".U)
    }.otherwise {
      // load inst
      io.cdb.bits.idx := in_reg.idx
      io.cdb.bits.prn := in_reg.prd
      io.cdb.bits.prn_data := loadU.io.resp.bits.data
      io.cdb.bits.expt := Mux(loadU.io.resp.bits.except, ExceptType.LPF, ExceptType.NO)
      io.cdb.bits.store_data := 0.U
      io.cdb.bits.wen := in_reg.wen & (io.cdb.bits.prn =/= 0.U)
      io.cdb.bits.brHit := true.B
      io.cdb.bits.pc := in_reg.pc
      io.cdb.bits.inst := in_reg.inst
      io.cdb.valid := ((state === s_load) & loadU.io.resp.fire()) & (!kill_reg) & !io.kill
      io.cdb.bits.addr := addr_reg
    }
  }

  io.cdb.bits.isTaken := false.B
  io.cdb.bits.j_pc := 0.U
  dontTouch(io.cdb)
}

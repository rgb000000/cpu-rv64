package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import chisel3.util.experimental.BoringUtils
import Control.{RoCC_R, RoCC_W, RoCC_X}
import cpu.ooo.ExceptType

class RoCCQueueIO(implicit val p: Parameters) extends Bundle{
  val rs1 = UInt(p(XLen).W)
  val rs2 = UInt(p(XLen).W)
}

class ROBIO(implicit val p: Parameters) extends Bundle {
  val in = new Bundle {
    val fromID = Vec(2, Flipped(Valid(new Bundle {
//      val stationIdx = UInt(4.W)
      val prn = UInt(p(AddresWidth).W)
      val needData = Bool()
//      val isPrd = Bool()

      val wen = Bool()
      val wb_type = UInt(2.W)
      val st_type = UInt(3.W)
      val ld_type = UInt(3.W)
      val pc = UInt(p(AddresWidth).W)
      val inst = UInt(32.W)
      val isBr = Bool()
      val isJ = Bool()
      val pTaken = Bool()
      val current_rename_state = Vec(p(PRNUM), Bool())
      val csr_cmd = UInt(3.W)
      val interrupt = new Bundle {
        val time     = Bool()
        val soft     = Bool()
        val external = Bool()
      }
      val kill = Bool()
      val rocc_cmd = UInt(2.W)
    })))

    val cdb = Vec(2, Flipped(Valid(new CDB)))
    val rocc_queue = Flipped(Decoupled(new RoCCQueueIO))
  }

  val read = Vec(2, Vec(2, new Bundle {
    val stationIdx = Flipped(Valid(UInt(4.W)))
    val data = Valid(UInt(p(XLen).W))
  }))

  val memRead = Flipped(new MemReadROBIO)

//  val memCDB = Flipped(Valid(new MEMCDB))

  // commit to physice register and dcache
  val commit = new Bundle {
    val reg = Vec(2, Valid(new Bundle {
      val prn = UInt(6.W)
      val data = UInt(p(XLen).W)
      val wen = Bool()

      // from branch, difftest use
      val current_rename_state = Vec(p(PRNUM), Bool())
      val isHit = Bool()
//      val right_pc = UInt(p(AddresWidth).W)   // right_pc is the same as data

      val fence_i_do = Bool()
      val sfence_vma_do = Bool()
      val isRocc_R = Bool()   // need flush pipeline

      // for difftest
      val pc = UInt(p(AddresWidth).W)
      val inst = UInt(32.W)
      val memAddress = UInt(p(AddresWidth).W)
      val isST = Bool()
      val isLD = Bool()
      val isRocc = Bool()
      val isBr_J = Bool()
    }))
    val dcache = Flipped(new CacheCPUIO)

    // 这一轮提交的分支预测信息，只update一个分支信息
    val br_info = Valid(new Bundle{
      // to branch
      val current_rename_state = Vec(p(PRNUM), Bool())
      val valid_value = UInt(p(PRNUM).W)
      val isHit = Bool()
      val isJ = Bool()
      val isTaken = Bool()
      val cur_pc = UInt(p(AddresWidth).W)
      val right_pc = UInt(p(AddresWidth).W)   // right_pc is the same as data
    })
  }

  val commit2rename = Vec(2, Valid(new Bundle{
    val prn = UInt(6.W)
    val skipWB = Bool()
  }))

  val commit2station = Vec(2, Valid(new Bundle{
    // 如果wen为真就表示这个prn是prn而不是memAddress， station拿到这个信息更新他的表
    val prn = UInt(6.W)
    val wen = Bool()
  }))

  val commit2rocc = new Bundle{
    val cmd = Decoupled(new RoCCCommand)
    val resp = Flipped(Decoupled(new RoCCRespone))
  }

  val except = Output(Bool())
  val exvec = Output(UInt(p(AddresWidth).W))    // 中断跳转到exvec执行

  val kill = Output(Bool())   // 这里的kill是强制kill，例如rocc_r  sfence
  val is_xret = Output(Bool())

  val epc = Output(UInt(p(AddresWidth).W))
}

class ROBInfo(implicit val p: Parameters) extends Bundle {
  val stationIdx = UInt(4.W)

  val pc = UInt(p(AddresWidth).W)
  val inst = UInt(32.W)

  // for writing back reg
  val prn = UInt(6.W)
  val prn_data = UInt(p(XLen).W)
  // for store inst
  val addr = UInt(p(AddresWidth).W)
  val store_data = UInt(64.W)

  val j_pc = UInt(p(AddresWidth).W)
  val needData = Bool()
  val mask = UInt(8.W)
  val wen = Bool()
  val wb_type = UInt(2.W)
  val st_type = UInt(3.W)
  val ld_type = UInt(3.W)

  val brHit = Bool()
  val isTake = Bool()

  val isBr = Bool()
  val isJ = Bool()
  val pTaken = Bool()
  val current_rename_state = Vec(p(PRNUM), Bool())

  val isLR = Bool()
  val isSC = Bool()

  val csr_cmd = UInt(3.W)
  val interrupt = new Bundle {
    val time     = Bool()
    val soft     = Bool()
    val external = Bool()
  }
  val kill = Bool()

  val state = UInt(2.W)

  val memAddr = UInt(p(AddresWidth).W) // for difftest skip when r/w clint

  val rocc_cmd = UInt(2.W)

  val except = UInt(2.W)
}


class ROB(implicit p: Parameters) extends Module {
  val io = IO(new ROBIO)

  val S_EMPTY    = 0.U(2.W)
  val S_WAITDATA = 1.U(2.W)
  val S_GETDATA  = 2.U(2.W)
  val S_COMMITED = 3.U(2.W)

  // flush includes kill, expect, branch fail
  val flush = WireInit(io.except | io.kill | (io.commit.br_info.valid & !io.commit.br_info.bits.isHit))
  dontTouch(flush)
  val rocc_queue = withReset(flush | reset.asBool()){ Queue(io.in.rocc_queue, 4) }

  val rob = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new ROBInfo))))

  def write_rob(fromIDport: Int, idx: UInt) = {
    rob(idx).prn := io.in.fromID(fromIDport).bits.prn
    rob(idx).needData := io.in.fromID(fromIDport).bits.needData
    rob(idx).wen := io.in.fromID(fromIDport).bits.wen | io.in.fromID(fromIDport).bits.csr_cmd(1,0).orR()
    rob(idx).wb_type := io.in.fromID(fromIDport).bits.wb_type
    rob(idx).st_type := io.in.fromID(fromIDport).bits.st_type
    rob(idx).ld_type := io.in.fromID(fromIDport).bits.ld_type
    rob(idx).mask := "h00".U
    rob(idx).state := S_WAITDATA
    rob(idx).pc := io.in.fromID(fromIDport).bits.pc
    rob(idx).inst := io.in.fromID(fromIDport).bits.inst
    rob(idx).isBr := io.in.fromID(fromIDport).bits.isBr
    rob(idx).isJ  := io.in.fromID(fromIDport).bits.isJ
    rob(idx).isLR := io.in.fromID(fromIDport).bits.ld_type.orR() & (io.in.fromID(fromIDport).bits.inst(6, 0) === "b0101111".U) & (io.in.fromID(fromIDport).bits.inst(28) === "b1".U)
    rob(idx).isSC := io.in.fromID(fromIDport).bits.st_type.orR() & (io.in.fromID(fromIDport).bits.inst(6, 0) === "b0101111".U) & (io.in.fromID(fromIDport).bits.inst(28) === "b1".U)
    rob(idx).pTaken := io.in.fromID(fromIDport).bits.pTaken
    rob(idx).current_rename_state := io.in.fromID(fromIDport).bits.current_rename_state
    rob(idx).csr_cmd := io.in.fromID(fromIDport).bits.csr_cmd
    rob(idx).kill := io.in.fromID(fromIDport).bits.kill
    rob(idx).interrupt.time := io.in.fromID(fromIDport).bits.interrupt.time
    rob(idx).interrupt.soft := io.in.fromID(fromIDport).bits.interrupt.soft
    rob(idx).interrupt.external := io.in.fromID(fromIDport).bits.interrupt.external
    rob(idx).rocc_cmd := io.in.fromID(fromIDport).bits.rocc_cmd
  }

  // write rob
  val wrCnt = Counter(16)
  when((io.commit.br_info.valid & !io.commit.br_info.bits.isHit) | io.except | io.kill){
    wrCnt.value := 0.U
  }.elsewhen(io.in.fromID(0).fire() & io.in.fromID(1).fire()) {
    // 0, 1
    wrCnt.value := wrCnt.value + 2.U
    write_rob(0, wrCnt.value)
    write_rob(1, wrCnt.value + 1.U)
  }.elsewhen(io.in.fromID(0).fire() & !io.in.fromID(1).fire()) {
    // 0
    wrCnt.value := wrCnt.value + 1.U
    write_rob(0, wrCnt.value)
  }.elsewhen((!io.in.fromID(0).fire()) & io.in.fromID(1).fire()) {
    // 1
    wrCnt.value := wrCnt.value + 1.U
    write_rob(1, wrCnt.value)
  }.otherwise {
    // none
  }


  val csr = Module(new CSR)
  def csr_enable(rob_info: ROBInfo, valid: Bool): Unit = {
    csr.io.cmd                 := rob_info.csr_cmd
    csr.io.in                  := rob_info.prn_data
    csr.io.ctrl_signal.pc      := rob_info.pc
    csr.io.ctrl_signal.addr    := 0.U
    csr.io.ctrl_signal.inst    := rob_info.inst
    csr.io.ctrl_signal.illegal := false.B         // FIXME: need to consider illegal inst!
    csr.io.ctrl_signal.st_type := 0.U
    csr.io.ctrl_signal.ld_type := 0.U
    csr.io.pc_check            := false.B
    csr.io.interrupt           := rob_info.interrupt
    // 这里针对store进行了特殊处理  store op会等到dcache resp才会被提交
    csr.io.has_except          := Mux(io.commit.dcache.resp.fire & io.commit.dcache.resp.bits.except, ExceptType.SPF, rob_info.except)
    csr.io.except_addr         := rob_info.addr
    csr.io.stall               := false.B
    csr.io.ctrl_signal.valid   := valid
  }

  val monitor = Module(new Monitor)
  monitor.io.kill := io.except  // only kill when except
  def monitor_enable(rob_info: ROBInfo, valid: Bool): Unit = {
    monitor.io.update.valid := valid & (rob_info.isLR | rob_info.isSC)
    monitor.io.update.bits.addr := rob_info.addr
    monitor.io.update.bits.op := rob_info.isSC
    monitor.io.sc_addr := rob_info.addr
  }


  dontTouch(io.commit)
  def write_prfile(portIdx: Int, rob_info: ROBInfo, valid: Bool) = {
    io.commit.reg(portIdx).bits.prn := rob_info.prn
    io.commit.reg(portIdx).bits.data := Mux(rob_info.csr_cmd(1,0).orR(), csr.io.out,
                                        Mux(rob_info.isSC, monitor.io.sc_ret,
                                        Mux(rob_info.rocc_cmd === RoCC_R, io.commit2rocc.resp.bits.data, rob_info.prn_data)))
    io.commit.reg(portIdx).bits.wen := rob_info.wen
    io.commit.reg(portIdx).bits.pc := rob_info.pc
    io.commit.reg(portIdx).bits.inst := rob_info.inst
    io.commit.reg(portIdx).valid := valid
    io.commit.reg(portIdx).bits.current_rename_state := rob_info.current_rename_state
    io.commit.reg(portIdx).bits.isHit := rob_info.brHit

    io.commit.reg(portIdx).bits.memAddress := rob_info.memAddr
    io.commit.reg(portIdx).bits.isST := rob_info.st_type.orR()
    io.commit.reg(portIdx).bits.isLD := rob_info.ld_type.orR()
    io.commit.reg(portIdx).bits.isRocc := rob_info.rocc_cmd.orR()

    io.commit.reg(portIdx).bits.fence_i_do := (rob_info.inst === ISA.fence_i) & valid
    io.commit.reg(portIdx).bits.sfence_vma_do := (rob_info.inst === ISA.sfence_vma) & valid
    io.commit.reg(portIdx).bits.isRocc_R := (rob_info.rocc_cmd === RoCC_R) & valid
    io.commit.reg(portIdx).bits.isBr_J := (rob_info.isBr | rob_info.isJ) & valid

    io.commit2rename(portIdx).valid := rob_info.wen & valid
    io.commit2rename(portIdx).bits.prn := rob_info.prn
    io.commit2rename(portIdx).bits.skipWB := rob_info.csr_cmd.orR() | rob_info.isSC

    io.commit2station(portIdx).valid := valid
    io.commit2station(portIdx).bits.prn := rob_info.prn
    io.commit2station(portIdx).bits.wen := rob_info.wen
  }

  def write_dcache(rob_info: ROBInfo, valid: Bool, commitIdx: UInt) = {
    io.commit.dcache.req.valid := valid
    io.commit.dcache.req.bits.addr := rob_info.addr
    io.commit.dcache.req.bits.data := rob_info.store_data
    io.commit.dcache.req.bits.mask := rob_info.mask
    io.commit.dcache.req.bits.op := 1.U // must write
  }

  if(p(Difftest)){
    val cycleCnt = WireInit(0.asUInt(64.W))
    BoringUtils.addSink(cycleCnt, "cycleCnt")
    when(io.commit.dcache.req.fire() & (io.commit.dcache.req.bits.op === 1.U)){
      when(io.commit.dcache.req.bits.addr === BitPat("b0000_0000_0000_0000_0000_0000_0000_0000_1000_0000_0000_0000_1000_1111_1110_????")){
        printf("addr: %x, data: %x, sd_mask: %x, time: %d \n", io.commit.dcache.req.bits.addr, io.commit.dcache.req.bits.data, io.commit.dcache.req.bits.mask, cycleCnt)
      }
    }
  }

//  def commit2rename(portIdx: Int, prn: UInt, wen: Bool): Unit = {
//
//  }

//  def br_info(current_state: Vec[Bool], isHit: Bool, pTaken: Bool, cur_pc: UInt, right_pc: UInt, valid: Bool): Unit ={
//    io.commit.br_info.valid := valid
//    io.commit.br_info.bits.current_rename_state := current_state
//    io.commit.br_info.bits.isHit := isHit
//    io.commit.br_info.bits.isTaken := Mux(isHit, pTaken, !pTaken)
//    io.commit.br_info.bits.cur_pc := cur_pc
//    io.commit.br_info.bits.right_pc := right_pc
//  }

  def out_br_info(isHit: Bool, info: ROBInfo): Unit ={
    when(info.isSC & (monitor.io.sc_ret =/= 0.U) & (info.state === S_GETDATA)){
      // SC fail, reuse isJ pass
      io.commit.br_info.valid := true.B
      io.commit.br_info.bits.current_rename_state := info.current_rename_state
      io.commit.br_info.bits.isHit                := isHit
      io.commit.br_info.bits.isJ                  := true.B
      io.commit.br_info.bits.isTaken              := false.B
      io.commit.br_info.bits.cur_pc               := info.pc
      io.commit.br_info.bits.right_pc             := info.pc + 4.U
    }.otherwise{
      // normal branch op
      io.commit.br_info.valid := info.isBr
      io.commit.br_info.bits.current_rename_state := info.current_rename_state
      io.commit.br_info.bits.isHit                := isHit
      io.commit.br_info.bits.isJ                  := info.isJ
      // isTaken表示实际上跳不跳，有时跳不跳预测是对u的，但是地址不对，这个情况需要考虑到，而不是简单的通过isHit和pTaken判断
      io.commit.br_info.bits.isTaken              := info.isTake
      io.commit.br_info.bits.cur_pc               := info.pc
      io.commit.br_info.bits.right_pc             := info.j_pc
    }
  }

  // commit
  val commitIdx = Counter(16)
  io.except := csr.io.expt
  io.epc := csr.io.epc
  io.exvec := csr.io.exvec
  dontTouch(io.epc)

  val head = rob(commitIdx.value)
  val next_head = rob(commitIdx.value + 1.U)
  val head_show = WireInit(head)
  dontTouch(head_show)
  csr_enable(head, head.state === S_GETDATA)
  monitor_enable(head, (head.state === S_GETDATA) & io.commit.reg(0).valid)
  // SC fail need flush pipeline
  io.kill := (head.kill | csr.io.w_satp | csr.io.is_xret) & (head.state === S_GETDATA) & io.commit.reg(0).valid
  io.is_xret := csr.io.is_xret

  val s_rocc_cmd :: s_rocc_resp :: Nil = Enum(2)
  val rocc_commit_state = RegInit(s_rocc_cmd)
  io.commit2rocc.cmd.valid := ((rocc_commit_state === s_rocc_cmd) & head.rocc_cmd.orR()) & (head.state === S_GETDATA)
  io.commit2rocc.cmd.bits.inst := head.inst.asTypeOf(new RoCCInstruction) // 32bit inst
  io.commit2rocc.cmd.bits.rs1 := rocc_queue.bits.rs1 // 64bit data
  io.commit2rocc.cmd.bits.rs2 := rocc_queue.bits.rs2 // 64bit data
  rocc_queue.ready := io.commit2rocc.cmd.fire()

  // 用于控制dcache req只发起一次
  val store_req_once = RegInit(false.B)
  when(io.commit.dcache.req.fire){
    store_req_once := true.B
  }.elsewhen(io.commit.dcache.resp.fire & (io.commit.dcache.resp.bits.cmd === 1.U)){
    store_req_once := false.B
  }

  io.commit2rocc.resp.ready := (rocc_commit_state === s_rocc_resp) & (head.state === S_GETDATA)

  // the second commit channel, only when 1st commit channle is commit and 2rd channel is a normal inst
  val next_head_can_commit = (
    (next_head.state === S_GETDATA)
      &(!next_head.st_type.orR)
      &(!next_head.isLR.orR)
      &(!next_head.csr_cmd.orR)
      &(!next_head.rocc_cmd.orR)
      &(!next_head.isBr & !next_head.isJ & !next_head.kill)
      &(!next_head.except.orR)
      &(!next_head.interrupt.asUInt.orR)
    )

  write_prfile(1, 0.U.asTypeOf(new ROBInfo), false.B)

  // the first commit channel
  when(head.state === S_GETDATA){
    when((!head.st_type.orR) & (!head.csr_cmd.orR) & (!head.rocc_cmd.orR)){
      // 普通指令
      when(!csr.io.expt){
        // 无中断，正常执行
        when(head.brHit){
          // 跳转预测成功
          when(!head.kill){
            commitIdx.value := Mux(next_head_can_commit, commitIdx.value + 2.U, commitIdx.value + 1.U)
            write_prfile(0, head,      true.B)
            write_prfile(1, Mux(next_head_can_commit, next_head, 0.U.asTypeOf(next_head)), next_head_can_commit)
            write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
            head.state := S_COMMITED
            next_head.state := Mux(next_head_can_commit, S_COMMITED, next_head.state)
            out_br_info(true.B, head)
          }.otherwise{
            // 触发了kill 只有fence_i会走到这里，需要在dcacahe idle时候执行
            write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
            when(io.commit.dcache.req.ready){
              commitIdx.value := 0.U
              write_prfile(0, head, true.B)
              rob.foreach(x => {
                x.state := S_EMPTY
              })
              out_br_info(true.B, head)
            }.otherwise{
              // dcache没idle 先不提交fence_i
              write_prfile(0, head, false.B)
              out_br_info(true.B, 0.U.asTypeOf(new ROBInfo))
            }
          }
        }.otherwise{
          // 跳转预测失败
          commitIdx.value := 0.U
          write_prfile(0, head, true.B)
          write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
          rob.foreach(x => {
            x.state := S_EMPTY
          })
          out_br_info(false.B, head)
        }
      }.otherwise{
        // 不执行，提交中断
        commitIdx.value := 0.U
        write_prfile(0, 0.U.asTypeOf(new ROBInfo), false.B)
        write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
        rob.foreach(x => {
          x.state := S_EMPTY
        })
        out_br_info(false.B, head)
      }
    }.elsewhen(head.csr_cmd.orR()){
      // csr操作
      when(!csr.io.expt){
        // 无中断，正常执行
        when(!head.kill){
          when(!csr.io.w_satp){
            // 不kill 正常执行
            commitIdx.value := Mux(next_head_can_commit, commitIdx.value + 2.U, commitIdx.value + 1.U)
            write_prfile(0, head,      true.B)
            write_prfile(1, Mux(next_head_can_commit, next_head, 0.U.asTypeOf(next_head)), next_head_can_commit)
            write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
            head.state := S_COMMITED
            next_head.state := Mux(next_head_can_commit, S_COMMITED, next_head.state)
            out_br_info(true.B, head)
          }.otherwise{
            // w satp, kill
            commitIdx.value := 0.U
            write_prfile(0, head, true.B)
            write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
            rob.foreach(x => {
              x.state := S_EMPTY
            })
            out_br_info(true.B, head)
          }
        }.otherwise{
          // 触发了kill
          commitIdx.value := 0.U
          write_prfile(0, head, true.B)
          write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
          rob.foreach(x => {
            x.state := S_EMPTY
          })
          out_br_info(true.B, head)
        }
      }.otherwise{
        // 不执行，提交中断
        commitIdx.value := 0.U
        write_prfile(0, 0.U.asTypeOf(new ROBInfo), false.B)
        write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
        rob.foreach(x => {
          x.state := S_EMPTY
        })
        out_br_info(false.B, head)
      }
    }.elsewhen(head.st_type.orR()){
      // st指令 or atomic inst
      when(!csr.io.expt){
        // 无中断，正常执行
        when(!head.isSC){
          // normal store op
          write_dcache(head, !store_req_once, 0.U)
          when(io.commit.dcache.resp.fire & (io.commit.dcache.resp.bits.cmd === 1.U) & !io.commit.dcache.resp.bits.except){
            // dcache返回正常
            commitIdx.value := Mux(next_head_can_commit, commitIdx.value + 2.U, commitIdx.value + 1.U)
            write_prfile(0, head,      true.B)
            write_prfile(1, Mux(next_head_can_commit, next_head, 0.U.asTypeOf(next_head)), next_head_can_commit)
            head.state := S_COMMITED
            next_head.state := Mux(next_head_can_commit, S_COMMITED, next_head.state)
            out_br_info(true.B, head)
          }.elsewhen(io.commit.dcache.resp.fire & (io.commit.dcache.resp.bits.cmd === 1.U) & io.commit.dcache.resp.bits.except){
            // dcache返回出现异常  不执行,提交异常
            commitIdx.value := 0.U
            write_prfile(0, 0.U.asTypeOf(new ROBInfo), false.B)
            rob.foreach(x => {
              x.state := S_EMPTY
            })
            out_br_info(false.B, head)
          }.otherwise{
            // dcache没有准备好，不提交
            write_prfile(0, head, false.B)
            out_br_info(true.B, 0.U.asTypeOf(new ROBInfo))
          }
        }.otherwise{
          // SC op
          when(monitor.io.sc_ret === 0.U){
            // SC success
            write_dcache(head, !store_req_once, 0.U)
            when(io.commit.dcache.resp.fire & (io.commit.dcache.resp.bits.cmd === 1.U) & !io.commit.dcache.resp.bits.except){
              commitIdx.value := Mux(next_head_can_commit, commitIdx.value + 2.U, commitIdx.value + 1.U)
              write_prfile(0, head,      true.B)
              write_prfile(1, Mux(next_head_can_commit, next_head, 0.U.asTypeOf(next_head)), next_head_can_commit)
              head.state := S_COMMITED
              next_head.state := Mux(next_head_can_commit, S_COMMITED, next_head.state)
              out_br_info(true.B, head)
            }.elsewhen(io.commit.dcache.resp.fire & (io.commit.dcache.resp.bits.cmd === 1.U) & io.commit.dcache.resp.bits.except){
              // dcache返回出现异常  不执行,提交异常
              commitIdx.value := 0.U
              write_prfile(0, 0.U.asTypeOf(new ROBInfo), false.B)
              rob.foreach(x => {
                x.state := S_EMPTY
              })
              out_br_info(false.B, head)
            }.otherwise{
              // dcache没有准备好，不提交
              write_prfile(0, head, false.B)
              out_br_info(true.B, 0.U.asTypeOf(new ROBInfo))
            }
          }.otherwise{
            // SC fail   reuse isJ to commit to rename
            write_dcache(head, false.B, 0.U)
            commitIdx.value := 0.U
            write_prfile(0, head, true.B)
            rob.foreach(x => {
              x.state := S_EMPTY
            })
            out_br_info(false.B, head)
          }
        }
      }.otherwise{
        // 不执行，提交中断
        commitIdx.value := 0.U
        write_prfile(0, 0.U.asTypeOf(new ROBInfo), false.B)
        write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
        rob.foreach(x => {
          x.state := S_EMPTY
        })
        out_br_info(false.B, head)
      }
    }.elsewhen(head.rocc_cmd.orR()){
      // commit rocc inst
      when(!csr.io.expt){
        // no expt
        when(head.rocc_cmd === RoCC_W){
          // send cmd
          when(io.commit2rocc.cmd.fire()){
            commitIdx.inc()
            write_prfile(0, head, true.B)
            write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
            head.state := S_COMMITED
            out_br_info(true.B, head)
//            printf("commit rocc_w cmd")
          }.otherwise{
            write_prfile(0, 0.U.asTypeOf(new ROBInfo), false.B)
            write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
            out_br_info(true.B, 0.U.asTypeOf(new ROBInfo))
          }
        }.elsewhen(head.rocc_cmd === RoCC_R){
          // send cmd, wait resp, and kill rob when resp.fire()
          when(io.commit2rocc.cmd.fire()){
            rocc_commit_state := s_rocc_resp

            write_prfile(0, 0.U.asTypeOf(new ROBInfo), false.B)
            write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
            out_br_info(true.B, 0.U.asTypeOf(new ROBInfo))
//            printf("commit rocc_r cmd")
          }.elsewhen(io.commit2rocc.resp.fire()){
            rocc_commit_state := s_rocc_cmd

            commitIdx.value := 0.U
            write_prfile(0, head, true.B)
            write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
            out_br_info(true.B, head)
            rob.foreach(x => {
              x.state := S_EMPTY
            })
//            printf("commit rocc_r resp")
          }.otherwise{
            write_prfile(0, 0.U.asTypeOf(new ROBInfo), false.B)
            write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
            out_br_info(true.B, 0.U.asTypeOf(new ROBInfo))
          }
        }.otherwise{
          write_prfile(0, 0.U.asTypeOf(new ROBInfo), false.B)
          write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
          out_br_info(true.B, 0.U.asTypeOf(new ROBInfo))
        }
      }.otherwise{
        // dont execute, commit expt
        commitIdx.value := 0.U
        write_prfile(0, 0.U.asTypeOf(new ROBInfo), false.B)
        write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
        rob.foreach(x => {
          x.state := S_EMPTY
        })
        out_br_info(false.B, head)
      }
    }.otherwise{
      write_prfile(0, 0.U.asTypeOf(new ROBInfo), false.B)
      write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
      out_br_info(true.B, 0.U.asTypeOf(new ROBInfo))
    }
  }.otherwise{
    write_prfile(0, 0.U.asTypeOf(new ROBInfo), false.B)
    write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
    out_br_info(true.B, 0.U.asTypeOf(new ROBInfo))
  }

  // getData
  io.in.cdb.foreach(cdb => {
    when(cdb.fire & !flush) {
      rob(cdb.bits.idx).state := S_GETDATA

      // prn
      rob(cdb.bits.idx).prn_data := cdb.bits.prn_data

      // except
      rob(cdb.bits.idx).except := cdb.bits.expt

      // store
      rob(cdb.bits.idx).addr := cdb.bits.addr
      rob(cdb.bits.idx).mask := cdb.bits.mask
      rob(cdb.bits.idx).store_data := cdb.bits.store_data

      rob(cdb.bits.idx).isTake := cdb.bits.isTaken
      rob(cdb.bits.idx).brHit := cdb.bits.brHit
      rob(cdb.bits.idx).j_pc := cdb.bits.j_pc

      rob(cdb.bits.idx).memAddr := cdb.bits.addr
    }
  })

  // station read rob in issue stage for reg
  for (i <- 0 until 2) {
    for (j <- 0 until 2) {
      when(io.read(i)(j).stationIdx.fire) {
        io.read(i)(j).data.bits := rob(io.read(i)(j).stationIdx.bits).prn_data
        io.read(i)(j).data.valid := true.B
      }.otherwise{
        io.read(i)(j).data.bits := 0.U
        io.read(i)(j).data.valid := false.B
      }
    }
  }

  // memU can read rob when execute ld inst
  // 但是要考虑如果rob中存在多个同一个addr的data，那么那一个是最新的呢
  // 考虑使用移位构造新的queryRes然后再使用优先级编码器来找到最新的  (res >> idx) | (res << idx)

  val ret_mask = VecInit(Seq.fill(8)(false.B))    // 找到的mask
  val ret_data = VecInit(Seq.fill(8)(0.U(8.W)))   // 找到的data
  for(i <- 0 until 8){
    // 每一个字节都分别查询
    val memQueryResult = rob.map(x => {
      (x.addr(31, 3) === io.memRead.req.bits.addr(31, 3)) & x.st_type.orR() & (x.mask(i) & io.memRead.req.bits.mask(i)) & (x.state =/= S_EMPTY) // mask的第ibit都是1
    })
    val memQueryResult_1 = Cat(memQueryResult).asUInt()
    val memQueryResult_2 = Wire(UInt(16.W))
    memQueryResult_2 := ((memQueryResult_1 >> (16.U - 1.U - io.memRead.req.bits.idx)).asUInt() | (memQueryResult_1 << (1.U + io.memRead.req.bits.idx)).asUInt())(15, 0).asUInt()
    val tmpIdx = PriorityEncoder(memQueryResult_2)
    val memQueryIdx = (io.memRead.req.bits.idx - tmpIdx)(3, 0).asUInt() // 往上查找
    when(io.memRead.req.fire){
      ret_mask(i) := Cat(memQueryResult_2).orR()
      ret_data(i) := Mux(Cat(memQueryResult_2).orR(), rob(memQueryIdx).store_data((i+1)*8 - 1, i*8), 0.U)
    }.otherwise{
      ret_mask(i) := false.B
      ret_data(i) := 0.U
    }
  }

  io.memRead.resp.valid := io.memRead.req.valid
  io.memRead.resp.bits.mask := ret_mask.asUInt()
  io.memRead.resp.bits.data := ret_data.asUInt()
  io.memRead.resp.bits.meet := ret_mask.asUInt() === io.memRead.req.bits.mask

  dontTouch(io.in.cdb)

  io.commit.br_info.bits.valid_value := io.commit.br_info.bits.current_rename_state.asUInt()
  dontTouch(io.commit.br_info.bits.valid_value)

  if(p(Difftest)){
    val both_ready = Wire(Bool())
    dontTouch(both_ready)
    both_ready := (rob(commitIdx.value).state ===  S_GETDATA) & (rob(commitIdx.value + 1.U).state ===  S_GETDATA)

    val ready_num = Wire(UInt(8.W))
    dontTouch(ready_num)
    ready_num := rob.map(_.state === S_GETDATA).map(_.asUInt).reduce(_ +& _)
  }
}

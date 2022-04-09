package cpu

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import chipsalliance.rocketchip.config._

class StationIn(implicit val p: Parameters) extends Bundle {
  // rs1
  val pr1 = UInt(6.W)
  val pr1_s = Bool() // pr1 state
  val pr1_inROB = Bool() // pr1 data in ROB, need to read rob to get it
  val pr1_robIdx = UInt(4.W)
  val pc = UInt(p(AddresWidth).W)
  val A_sel = UInt(1.W)

  // rs2
  val pr2 = UInt(6.W)
  val pr2_s = Bool() // pr2 state
  val pr2_inROB = Bool() // pr2 data in ROB, need to read rob to get it
  val pr2_robIdx = UInt(4.W)
  val imm = UInt(64.W)
  val B_sel = UInt(1.W)

  // rd
  val prd = UInt(6.W)

  // alu op
  val alu_op = UInt(6.W)

  // br_type
  val br_type = UInt(3.W)
  val pTaken = Bool()
  val pPC = UInt(p(AddresWidth).W)

  // mem op
  val ld_type = UInt(3.W)
  val st_type = UInt(3.W)

  // csr op
  val csr_op = UInt(3.W)

  // illeage
  val illeage = Bool()
  val except = UInt(2.W)

  // inst
  val inst = UInt(32.W)

  // wb type
  val wb_type = UInt(2.W)
  val wen = Bool()

  // rename current state 记录了valid状态
  val current_rename_state = Vec(p(PRNUM), Bool())

  // state
  val state = UInt(2.W) // 00: 无效
  // 01: 等待发射
  // 10: 发射
  // 11： 写回了但是等待提交

  val rocc_cmd = UInt(2.W)
}

class CDB(implicit val p: Parameters) extends Bundle {
  val idx = UInt(4.W)
  val prn = UInt(6.W)
  val prn_data = UInt(64.W)
  val j_pc = UInt(p(AddresWidth).W)
  val wen = Bool()
  val brHit = Bool()
  val isTaken = Bool()
  val expt = UInt(2.W)

  // for store inst
  val addr = UInt(p(AddresWidth).W)
  val mask = UInt(8.W)
  val store_data = UInt(64.W)

  val pc = UInt(p(AddresWidth).W)
  val inst = UInt(32.W)
}

class MEMCDB(implicit p: Parameters) extends Bundle {
  val idx = UInt(4.W)
  val prn = UInt(p(AddresWidth).W)
  val data = UInt(64.W)
  val wen = Bool()
  val brHit = Bool()
  val expt = Bool()
}

class Station(implicit val p: Parameters) extends Module {
  val io = IO(new Bundle {
    val in = Vec(2, Flipped(Decoupled(new StationIn)))
    val cdb = Vec(2, Flipped(Valid(new CDB)))

    val out = Vec(2, Decoupled(new Bundle {
      val idx = UInt(4.W)
      val info = new StationIn
    }))

    val exu_statu = Input(Vec(2, Bool()))

    val robCommit = new Bundle {
      val reg = Vec(2, Flipped(Valid(new Bundle {
        val prn = UInt(6.W)
        val wen = Bool()
        //      val data = UInt(p(XLen).W)
        //      val wen = Bool()
      })))
      val br_info = Flipped(Valid(new Bundle {
        val isHit = Bool()
      }))
      val except = Input(Bool())
      val kill = Input(Bool())
    }
  })

  io.out.foreach(dontTouch(_))

  val S_INVALID = 0.U(2.W)
  val S_WAIT = 1.U(2.W)
  val S_ISSUE = 2.U(2.W)
  val S_COMMIT = 3.U(2.W)

  import Control._

  val station = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new StationIn))))
  station.foreach(x => {
    dontTouch(x.pc)
    dontTouch(x.inst)
  })

  val commitPtr = Counter(32)

  // issue
  val which_station_ready_0 = Cat(station.map(x => {
    // alu op and branch, no ld/st, no csr, no rocc, no amo, do M extension
    x.pr1_s & x.pr2_s & (!x.ld_type.orR) & (!x.st_type.orR) & (!x.csr_op.orR) & (!x.rocc_cmd.orR) & (x.alu_op <= ALU.ALU_REMUW) & (x.state === S_WAIT)
  }).reverse)
  val readyIdx_0 = WireInit(PriorityEncoder(which_station_ready_0))

  val which_station_ready_1 = Cat(station.map(x => {
    // alu ld/st csr, rocc(need in order like mem inst), no branch, no M extension, no except(ipf)
    x.pr1_s & x.pr2_s & (!x.br_type.orR) & (
      x.rocc_cmd.orR
        | x.csr_op.orR
        | x.st_type.orR
        | x.ld_type.orR
        | (x.alu_op >= ALU.ALU_AMOADD_W)
        | (x.alu_op <= ALU.ALU_XXX)
      ) & !x.except & (x.state === S_WAIT)
  }).reverse)
  val commit_value = commitPtr.value(3, 0).asUInt
  val which_station_ready_1_commit = ((which_station_ready_1 >> commit_value).asUInt | (which_station_ready_1 << (16.U - commit_value)).asUInt)(15, 0).asUInt
  val readyIdx_1 = WireInit((commit_value + PriorityEncoder(which_station_ready_1_commit))(3, 0).asUInt) // 往下查找

  // 这部分是为了让mem指令严格的顺序 and rocc
  val which_station_isMem = Cat(station.map(x => {
    // 看看哪些是访存储指令 and rocc
    (x.ld_type.orR() | x.st_type.orR() | x.rocc_cmd.orR())
  }).reverse)
  val which_station_isMem_from_commit = ((which_station_isMem >> commit_value).asUInt() | (which_station_isMem << (16.U - commit_value)).asUInt())(15, 0).asUInt()
  val nextMemIdx = WireInit((commit_value + PriorityEncoder(which_station_isMem_from_commit))(3, 0).asUInt()) // 往下查找

  // fixpointU
  io.out(0).valid := which_station_ready_0.orR()
  io.out(0).bits.info := station(readyIdx_0)
  io.out(0).bits.idx := readyIdx_0
  // memU
  val readyIdx_1_isMem = station(readyIdx_1).st_type.orR() | station(readyIdx_1).ld_type.orR() | station(readyIdx_1).rocc_cmd.orR()
  io.out(1).valid := which_station_ready_1.orR() & (((readyIdx_1 =/= readyIdx_0) & which_station_ready_0.orR()) | (!which_station_ready_0.orR())) & ((!readyIdx_1_isMem) | (readyIdx_1_isMem & (nextMemIdx === readyIdx_1)))
//  io.out(1).valid := which_station_ready_1.orR() & (readyIdx_1 =/= readyIdx_0) & ((!readyIdx_1_isMem) | (readyIdx_1_isMem & (nextMemIdx === readyIdx_1)))
  io.out(1).bits.info := station(readyIdx_1)
  io.out(1).bits.idx := readyIdx_1

  // input
  val inPtr = Counter(32)


  def commit(prn: UInt, wen: Bool): Unit = {
    station.foreach(x => {
      when((x.pr1 === prn) & wen & (x.state === S_WAIT)){
        x.pr1_inROB := false.B
        x.pr1_s := true.B
      }

      when((x.pr2 === prn) & wen & (x.state === S_WAIT)){
        x.pr2_inROB := false.B
        x.pr2_s := true.B
      }
    })

    // 下面这个写法，当station里面有多个匹配的时候只能改到一个，有bug！
//    val pr1Res = station.map(x => {
//      (x.pr1 === prn) & wen & (x.state === S_WAIT)
//    })
//    val pr1Idx = PriorityEncoder(pr1Res)
//    when(Cat(pr1Res).orR()) {
//      station(pr1Idx).pr1_inROB := false.B
//      station(pr1Idx).pr1_s := true.B
//    }
//
//    val pr2Res = station.map(x => {
//      (x.pr2 === prn) & wen & (x.state === S_WAIT)
//    })
//    val pr2Idx = PriorityEncoder(pr2Res)
//    when(Cat(pr2Res).orR()) {
//      station(pr2Idx).pr2_inROB := false.B
//      station(pr2Idx).pr2_s := true.B
//    }
  }

  // commit

  // br isMiss, need clear station, 优先级最高，写在最后
  // 分支跳转未命中清空、中断异常清空
  when((io.robCommit.br_info.valid & !io.robCommit.br_info.bits.isHit) | io.robCommit.except | io.robCommit.kill) {
    // clear station
    station.foreach(x => {
      x.state := S_INVALID
      x.pr1_s := false.B
      x.pr2_s := false.B
      x.pr1_inROB := false.B
      x.pr2_inROB := false.B
    })

    // clear cnt
    inPtr.value := 0.U
    commitPtr.value := 0.U
  }.otherwise{
    // cdb
    io.cdb.foreach(cdb => {
      station.map(x => {
        when(cdb.valid & cdb.bits.wen & ((x.A_sel === A_RS1) & (!x.pr1_s) & (x.pr1 === cdb.bits.prn) & (x.state === S_WAIT)) & (cdb.bits.prn =/= 0.U)) {
          x.pr1_s := true.B
          x.pr1_inROB := true.B
          x.pr1_robIdx := cdb.bits.idx
        }

        when(cdb.valid & cdb.bits.wen & ((x.B_sel === B_RS2) & (!x.pr2_s) & (x.pr2 === cdb.bits.prn) & (x.state === S_WAIT)) & (cdb.bits.prn =/= 0.U)) {
          x.pr2_s := true.B
          x.pr2_inROB := true.B
          x.pr2_robIdx := cdb.bits.idx
        }
      })
    })

    // commit
    when(io.robCommit.reg(0).fire() & io.robCommit.reg(1).fire()) {
      // commit 0, 1
      commitPtr.value := commitPtr.value + 2.U
      commit(io.robCommit.reg(0).bits.prn, io.robCommit.reg(0).bits.wen)
      commit(io.robCommit.reg(1).bits.prn, io.robCommit.reg(1).bits.wen)

    }.elsewhen(io.robCommit.reg(0).fire() & !io.robCommit.reg(1).fire()) {
      // commit 0
      commitPtr.value := commitPtr.value + 1.U
      commit(io.robCommit.reg(0).bits.prn, io.robCommit.reg(0).bits.wen)
    }.elsewhen((!io.robCommit.reg(0).fire()) & io.robCommit.reg(1).fire()) {
      // commit 1
      commitPtr.value := commitPtr.value + 1.U
      commit(io.robCommit.reg(1).bits.prn, io.robCommit.reg(1).bits.wen)
    }.otherwise {
      // none
    }

    // input
    def cdb_commit_forwrd(r: StationIn, s: StationIn): Unit = {
      // r is input
      // s is reg in station
      s := r
      io.cdb.foreach( cdb => {
        when(cdb.fire() & cdb.bits.wen & (cdb.bits.prn =/= 0.U)){
          when(r.pr1 === cdb.bits.prn){
            s.pr1_s := true.B
            s.pr1_inROB := true.B
            s.pr1_robIdx := cdb.bits.idx
          }
          when(r.pr2 === cdb.bits.prn){
            s.pr2_s := true.B
            s.pr2_inROB := true.B
            s.pr2_robIdx := cdb.bits.idx
          }
        }
      })

      io.robCommit.reg.foreach(rob => {
        when(rob.fire() & rob.bits.wen & (rob.bits.prn =/= 0.U)){
          when(r.pr1 === rob.bits.prn){
            s.pr1_s := true.B
            s.pr1_inROB := false.B
          }
          when(r.pr2 === rob.bits.prn){
            s.pr2_s := true.B
            s.pr2_inROB := false.B
          }
        }
      })

      s.state := S_WAIT
    }

    val a = io.in(0)
    val b = io.in(1)
    when(a.fire & b.fire) {
      // input a and b
      inPtr.value := inPtr.value + 2.U
      cdb_commit_forwrd(a.bits, station(inPtr.value))
      cdb_commit_forwrd(b.bits, station(inPtr.value + 1.U))
    }.elsewhen(a.fire & !b.fire) {
      // input a
      inPtr.inc()
      cdb_commit_forwrd(a.bits, station(inPtr.value))
    }.elsewhen((!a.fire) & b.fire) {
      // input b
      inPtr.inc()
      cdb_commit_forwrd(b.bits, station(inPtr.value))
    }.otherwise {

    }

    // issue
    when(io.out(0).fire()) {
      station(readyIdx_0).state := S_ISSUE
    }
    when(io.out(1).fire()) {
      station(readyIdx_1).state := S_ISSUE
    }
  }

  // 至少有两个空位置才可以, 如果inPrt和commitPrt高位相等，
  val emptyNum = Mux(inPtr.value(4) === commitPtr.value(4), 16.U - inPtr.value(3, 0) + commitPtr.value(3, 0).asUInt(), commitPtr.value(3, 0) - inPtr.value(3, 0))
  io.in(0).ready := emptyNum > 2.U
  io.in(1).ready := emptyNum > 2.U
}

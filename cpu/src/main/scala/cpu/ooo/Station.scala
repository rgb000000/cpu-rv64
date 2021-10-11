package cpu

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import chipsalliance.rocketchip.config._

class StationIn(implicit p: Parameters) extends Bundle{
  val valid = Bool()

  // rs1
  val pr1 = UInt(6.W)
  val pr1_s = Bool()    // pr1 state
  val pc  = UInt(64.W)
  val A_sel = UInt(1.W)

  // rs2
  val pr2 = UInt(6.W)
  val pr2_s = Bool()    // pr2 state
  val imm = UInt(64.W)
  val B_sel = UInt(1.W)

  // rd
  val prd = UInt(6.W)

  // alu op
  val alu_op = UInt(5.W)

  // br_type
  val br_type = UInt(3.W)
  val p_br = Bool()

  // mem op
  val ld_type = UInt(3.W)
  val st_type = UInt(3.W)

  // csr op
  val csr_op = UInt(3.W)

  // illeage
  val illeage = Bool()

  // inst
  val inst = UInt(32.W)

  // wb type
  val wb_type = UInt(2.W)
  val wen = Bool()

  // state
  val state = UInt(2.W) // 00: 无效
                        // 01: 等待发射
                        // 10: 发射
                        // 11： 写回了但是等待提交
}

class CDB(implicit p: Parameters) extends Bundle{
  val idx = UInt(4.W)
  val prn = UInt(6.W)
  val data = UInt(64.W)
  val wen = Bool()
  val brHit = Bool()
  val expt = Bool()
}

class Station(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val in = Flipped(Decoupled(Vec(2, new StationIn)))
    val cdb = Vec(2, Flipped(Valid(new CDB)))

    val out = Vec(2, Decoupled(new Bundle{
      val info = new StationIn
    }))

    val exu_statu = Input(Vec(2, Bool()))

    val commit = Vec(2, Flipped(Valid(new Bundle{
      val idx = UInt(4.W)
    })))

    val idxWaitCommit = Valid(Vec(2, UInt(4.W)))

  })

  val S_INVALID = 0.U(2.W)
  val S_WAIT    = 1.U(2.W)
  val S_ISSUE   = 2.U(2.W)
  val S_COMMIT  = 3.U(2.W)

  import Control._

  val station = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new StationIn))))

  // instructions status change
  io.cdb.foreach(cdb => {
    station.map(x => {
      when(cdb.valid & ((x.A_sel === A_RS1) & (!x.pr1_s) & (x.pr1 === cdb.bits.prn))){
        x.pr1_s := true.B
      }.elsewhen(cdb.valid & ((x.B_sel === B_RS2) & (!x.pr2_s) & (x.pr2 === cdb.bits.prn))){
        x.pr2_s := true.B
      }
    })
  })

  // issue
  val which_station_ready_0 = Cat(station.map(x => {
    // alu op and branch, no ld/st and csr
    x.pr1_s & x.pr2_s & (!x.ld_type.orR()) & (!x.st_type.orR()) & (!x.csr_op.orR())
  }).reverse)
  val readyIdx_0 = PriorityEncoder(which_station_ready_0)

  val which_station_ready_1 = Cat(station.map(x => {
    // alu ld/st csr, no branch
    x.pr1_s & x.pr2_s & (!x.br_type.orR())
  }).reverse)
  val readyIdx_1 = PriorityEncoder(which_station_ready_1)

  // fixpointU
  io.out(0).valid := which_station_ready_0.orR()
  when(which_station_ready_0.orR()){
    io.out(0).bits.info := station(readyIdx_0)
    station(readyIdx_0).state := S_ISSUE
  }
  // memU
  io.out(1).valid := which_station_ready_1.orR() & (readyIdx_1 =/= readyIdx_0)
  when(which_station_ready_1.orR() & (readyIdx_1 =/= readyIdx_0)){
    io.out(1).bits.info := station(readyIdx_1)
    station(readyIdx_1).state := S_ISSUE
  }

  // input
  val inPtr = Counter(16)
  when(io.in.fire()){
    val a = io.in.bits(0)
    val b = io.in.bits(1)
    when(a.valid & b.valid){
      // input a and b
      inPtr.value := inPtr.value + 2.U
      station(inPtr.value) := a
      station(inPtr.value).state := S_WAIT

      station(inPtr.value + 1.U) := b
      station(inPtr.value + 1.U).state := S_WAIT
    }.elsewhen(a.valid & !b.valid){
      // input a
      inPtr.inc()
      station(inPtr.value) := a
      station(inPtr.value).state := S_WAIT
    }.elsewhen((!a.valid) & b.valid){
      // input b
      inPtr.inc()
      station(inPtr.value) := b
      station(inPtr.value).state := S_WAIT
    }.otherwise{
      // none
    }
  }
  io.in.ready := station.map(_.state).map(x => {(x === S_INVALID)}).reduce(_ | _)

  // commit
  when(io.commit(0).fire() & io.commit(1).fire()){
    // commit 0, 1
    station
  }.elsewhen(io.commit(0).fire() & !io.commit(1).fire()){
    // commit 0
  }.elsewhen((!io.commit(0).fire()) & io.commit(1).fire()){
    // commit 1
  }.otherwise{
    // none
  }

  val commitPtr = Counter(16)
  when(io.commit.fire()){
    assert(station(io.commit.bits.idx).state === S_COMMIT)
    when(io.commit.bits.state){
      station(io.commit.bits.idx).state := S_INVALID
    }.otherwise{
      // 当commit是 撤回时候，例如分支预测失败了，那么就将保留站所有项的state置为无效了
      station.foreach(x => {
        x.state := S_INVALID
      })
    }
  }

  io.idxWaitCommit.bits(0) := commitPtr.value
  io.idxWaitCommit.bits(1) := commitPtr.value + 1.U
}
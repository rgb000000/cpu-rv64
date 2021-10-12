package cpu

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import chipsalliance.rocketchip.config._

class StationIn(implicit p: Parameters) extends Bundle{
  val valid = Bool()

  // rs1
  val pr1 = UInt(6.W)
  val pr1_s = Bool()     // pr1 state
  val pr1_inROB = Bool() // pr1 data in ROB, need to read rob to get it
  val pr1_robIdx = UInt(4.W)
  val pc  = UInt(64.W)
  val A_sel = UInt(1.W)

  // rs2
  val pr2 = UInt(6.W)
  val pr2_s = Bool()     // pr2 state
  val pr2_inROB = Bool() // pr2 data in ROB, need to read rob to get it
  val pr2_robIdx = UInt(4.W)
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

class MEMCDB(implicit p: Parameters) extends Bundle{
  val idx = UInt(4.W)
  val prn = UInt(p(AddresWidth).W)
  val data = UInt(64.W)
  val wen = Bool()
  val brHit = Bool()
  val expt = Bool()
}

class Station(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val in = Vec(2, Flipped(Decoupled(new StationIn)))
    val cdb = Vec(2, Flipped(Valid(new CDB)))

    val out = Vec(2, Decoupled(new Bundle{
      val info = new StationIn
    }))

    val exu_statu = Input(Vec(2, Bool()))

    val robCommit = Vec(2, Flipped(Valid(new Bundle{
      val prn = UInt(6.W)
//      val data = UInt(p(XLen).W)
//      val wen = Bool()
    })))
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
        x.pr1_inROB := true.B
        x.pr1_robIdx := cdb.bits.idx
      }.elsewhen(cdb.valid & ((x.B_sel === B_RS2) & (!x.pr2_s) & (x.pr2 === cdb.bits.prn))){
        x.pr2_s := true.B
        x.pr2_inROB := true.B
        x.pr2_robIdx := cdb.bits.idx
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
  io.out(0).bits.info := station(readyIdx_0)
  when(which_station_ready_0.orR()){
    station(readyIdx_0).state := S_ISSUE
  }
  // memU
  io.out(1).valid := which_station_ready_1.orR() & (readyIdx_1 =/= readyIdx_0)
  io.out(1).bits.info := station(readyIdx_1)
  when(which_station_ready_1.orR() & (readyIdx_1 =/= readyIdx_0)){
    station(readyIdx_1).state := S_ISSUE
  }

  // input
  val inPtr = Counter(32)
  val a = io.in(0)
  val b = io.in(1)
  when(a.fire() & b.fire()){
    // input a and b
    inPtr.value := inPtr.value + 2.U

    station(inPtr.value) := a.bits
    station(inPtr.value).state := S_WAIT

    station(inPtr.value + 1.U) := b.bits
    station(inPtr.value + 1.U).state := S_WAIT
  }.elsewhen(a.fire() & !b.fire()){
    // input a
    inPtr.inc()

    station(inPtr.value) := a.bits
    station(inPtr.value).state := S_WAIT
  }.elsewhen((!a.fire()) & b.fire()){
    // input b
    inPtr.inc()

    station(inPtr.value) := b.bits
    station(inPtr.value).state := S_WAIT
  }.otherwise{

  }


  def commit(prn: UInt, wen: Bool) = {
    val pr1Res = station.map(_.pr1).map(_ === prn).map(_ & wen)
    val pr1Idx = PriorityEncoder(pr1Res)
    when(Cat(pr1Res).orR()){
      station(pr1Idx).pr1_inROB := false.B
      station(pr1Idx).pr1_s := true.B
    }

    val pr2Res = station.map(_.pr2).map(_ === prn).map(_ & wen)
    val pr2Idx = PriorityEncoder(pr2Res)
    when(Cat(pr2Res).orR()){
      station(pr2Idx).pr2_inROB := false.B
      station(pr2Idx).pr2_s := true.B
    }
  }
  // commit
  val commitPtr = Counter(32)
  when(io.robCommit(0).fire() & io.robCommit(1).fire()){
    // commit 0, 1
    commitPtr.value := commitPtr.value + 2.U
    commit(io.robCommit(0).bits.prn, io.robCommit(0).valid)
    commit(io.robCommit(1).bits.prn, io.robCommit(1).valid)

  }.elsewhen(io.robCommit(0).fire() & !io.robCommit(1).fire()){
    // commit 0
    commitPtr.value := commitPtr.value + 1.U
    commit(io.robCommit(0).bits.prn, io.robCommit(0).valid)
  }.elsewhen((!io.robCommit(0).fire()) & io.robCommit(1).fire()){
    // commit 1
    commitPtr.value := commitPtr.value + 1.U
    commit(io.robCommit(1).bits.prn, io.robCommit(1).valid)
  }.otherwise{
    // none
  }

  // 至少有两个空位置才可以
  val emptyNum = Mux(inPtr.value(4) === commitPtr.value(4), 16.U - inPtr.value(3, 0) + commitPtr.value(3, 0).asUInt(), commitPtr.value(3, 0) - inPtr.value(3, 0))
  io.in(0).ready := emptyNum >= 2.U
  io.in(1).ready := emptyNum >= 2.U
}

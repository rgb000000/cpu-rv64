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

  // wb type
  val wb_type = UInt(2.W)

  // state
  val state = UInt(2.W) // 00: 无效
                        // 01: 等待发射
                        // 10: 发射
                        // 11： 写回了但是等待提交
}

class CDB(implicit p: Parameters) extends Bundle{
  val prn = UInt(6.W)
  val data = UInt(64.W)
  val wen = Bool()
  val brHit = Bool()
  val expt = Bool()
}

class Station(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val in = Flipped(Decoupled(new StationIn))
    val cdb = Flipped(Valid(new CDB))

    val out = Decoupled(new Bundle{
      val info = new StationIn
      val exid = UInt(1.W)
    })

    val exu_statu = Input(Vec(2, Bool()))

    val commit = Flipped(Valid(new Bundle{
      val idx = UInt(4.W)
      val state = Bool()  // 1 taken      0 withdraw
    }))
  })

  val S_INVALID = 0.U(2.W)
  val S_WAIT    = 1.U(2.W)
  val S_ISSUE   = 2.U(2.W)
  val S_COMMIT  = 3.U(2.W)

  import Control._

  val station = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new StationIn))))

  // instructions status change
  station.map(x => {
    when(io.cdb.valid & ((x.A_sel === A_RS1) & (!x.pr1_s) & (x.pr1 === io.cdb.bits.prn))){
      x.pr1_s := true.B
    }.elsewhen(io.cdb.valid & ((x.B_sel === B_RS2) & (!x.pr2_s) & (x.pr2 === io.cdb.bits.prn))){
      x.pr2_s := true.B
    }
  })

  // issue
  val which_station_ready = Cat(station.map(x => {
    x.pr1_s & x.pr2_s
  }).reverse)
  val readyIdx = PriorityEncoder(which_station_ready)

  io.out.valid := which_station_ready.orR()
  when(which_station_ready.orR()){
    io.out.bits.info := station(readyIdx)
    station(readyIdx).state := S_ISSUE
  }

  // input
  val inPtr = Counter(16)
  when(io.in.fire()){
    inPtr.inc()
    station(inPtr.value) := io.in.bits
    station(inPtr.value).state := S_WAIT
  }
  io.in.ready := station.map(_.state).map(x => {(x === S_INVALID)}).reduce(_ | _)

  // commit
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
}

package cpu

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import chipsalliance.rocketchip.config._

class RenameMap(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{

    val query_a = new Bundle{
      val lr = Flipped(Valid(UInt(5.W)))  // logic register
      val pr = Valid(new Bundle{
        val idx = UInt(6.W)
        val isReady = Bool()
      })           // physics register
    }

    val query_b = new Bundle{
      val lr = Flipped(Valid(UInt(5.W)))
      val pr = Valid(new Bundle{
        val idx = UInt(6.W)
        val isReady = Bool()
      })
    }

    val allocate_c = new Bundle {
      val lr = Flipped(Valid(UInt(5.W)))  // logic register
      val pr = Valid(UInt(6.W))           // physics register
    }

    val cdb = Vec(2, Flipped(Valid(new CDB)))         // wb
    val robCommit = Vec(2, Flipped(Valid(UInt(6.W)))) // commit
  })

  val STATECONST = new Bundle{
    val EMPRY  = 0.U(2.W)
    val MAPPED = 1.U(2.W)
    val WB     = 2.U(2.W)
    val COMMIT = 3.U(2.W)
  }

  val info = new Bundle{
    val PRIdx = UInt(6.W) // 0 - 63
    val LRIdx = UInt(5.W)
    val valid = Bool()
    val state = UInt(2.W)
  }

  // 初始化的时候 逻辑寄存器0-31对应物理寄存器的0-31
  val cam = RegInit(VecInit(Seq.tabulate(32)(n => {
    val tmp = info.cloneType
    tmp.PRIdx := n.U
    tmp.LRIdx := n.U
    tmp.valid := true.B
    tmp.state := STATECONST.COMMIT
    tmp
  }) ++ Seq.tabulate(32)(n => {
    val tmp = info.cloneType
    tmp.PRIdx := 0.U
    tmp.LRIdx := 0.U
    tmp.valid := false.B
    tmp.state := STATECONST.EMPRY
    tmp
  })))

  // query a
  val query_a = WireInit(VecInit(cam.map(x => x.valid & (x.LRIdx === io.query_a.lr.bits))))
  assert(Cat(query_a).orR() =/= 0.U)
  val query_a_idx = PriorityEncoder(query_a)
  io.query_a.pr.bits.idx := query_a_idx
  io.query_a.pr.bits.isReady := (cam(query_a_idx).state === STATECONST.WB) | (cam(query_a_idx).state === STATECONST.COMMIT)
  io.query_a.pr.valid := io.query_a.lr.fire()

  // quary b
  val query_b = WireInit(VecInit(cam.map(x => x.valid & (x.LRIdx === io.query_b.lr.bits))))
  assert(Cat(query_b).orR() =/= 0.U)
  val query_b_idx = PriorityEncoder(query_b)
  io.query_b.pr.bits.idx := query_b_idx
  io.query_b.pr.bits.isReady := (cam(query_b_idx).state === STATECONST.WB) | (cam(query_b_idx).state === STATECONST.COMMIT)
  io.query_b.pr.valid := io.query_b.lr.fire()

  // allocate c
  val emptyPR = WireInit(VecInit(cam.map(_.state).map(_ === STATECONST.EMPRY)))
  val emptyPRIdx = PriorityEncoder(emptyPR)
  when(io.allocate_c.lr.fire()){
    cam(emptyPRIdx).state := STATECONST.MAPPED
    cam(emptyPRIdx).LRIdx := io.allocate_c.lr.bits
  }
  io.allocate_c.pr.valid := Mux(io.allocate_c.lr.fire(), 1.U, 0.U)
  io.allocate_c.pr.bits := Mux(io.allocate_c.lr.fire(), emptyPRIdx, 0.U)

  io.cdb.foreach(cdb => {
    when(cdb.fire()){
      cam(cdb.bits.prn).state := STATECONST.WB
    }
  })

  io.robCommit.foreach(robcommit => {
    when(robcommit.fire()){
      cam(robcommit.bits).state := STATECONST.COMMIT
    }
  })

}

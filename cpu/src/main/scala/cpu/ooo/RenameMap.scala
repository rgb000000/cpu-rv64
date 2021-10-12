package cpu

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import chipsalliance.rocketchip.config._

class QueryAllocate(implicit p: Parameters) extends Bundle {
  val query_a = new Bundle{
    val lr = Flipped(Valid(UInt(5.W)))  // logic register
    val pr = Valid(new Bundle{
      val idx = UInt(6.W)
      val isReady = Bool()

      val robIdx = UInt(4.W)
      val inROB = Bool()
    })           // physics register
  }

  val query_b = new Bundle{
    val lr = Flipped(Valid(UInt(5.W)))
    val pr = Valid(new Bundle{
      val idx = UInt(6.W)
      val isReady = Bool()

      val robIdx = UInt(4.W)
      val inROB = Bool()
    })
  }

  val allocate_c = new Bundle {
    val lr = Flipped(Valid(UInt(5.W)))  // logic register
    val pr = Valid(UInt(6.W))           // physics register
  }

  val valid = Input(Bool())
}

class RenameMap(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val port = Vec(2, new QueryAllocate)

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
    val robIdx = UInt(4.W)
  }

  // 初始化的时候 逻辑寄存器0-31对应物理寄存器的0-31
  val cam = RegInit(VecInit(Seq.tabulate(32)(n => {
    val tmp = Wire(info.cloneType)
    tmp.PRIdx := n.U
    tmp.LRIdx := n.U
    tmp.valid := true.B
    tmp.state := STATECONST.COMMIT
    tmp.robIdx := 0.U
    tmp
  }) ++ Seq.tabulate(32)(n => {
    val tmp = Wire(info.cloneType)
    tmp.PRIdx := 0.U
    tmp.LRIdx := 0.U
    tmp.valid := false.B
    tmp.state := STATECONST.EMPRY
    tmp.robIdx := 0.U
    tmp
  })))

  def quert_a_and_b(port: QueryAllocate): Unit = {
    // query a
    val query_a = WireInit(VecInit(cam.map(x => x.valid & (x.LRIdx === port.query_a.lr.bits))))
    assert(Cat(query_a).orR() =/= 0.U)
    val query_a_idx = PriorityEncoder(query_a)
    port.query_a.pr.bits.idx := query_a_idx
    port.query_a.pr.bits.isReady := (cam(query_a_idx).state === STATECONST.WB) | (cam(query_a_idx).state === STATECONST.COMMIT)
    port.query_a.pr.bits.inROB := cam(query_a_idx).state === STATECONST.WB
    port.query_a.pr.bits.robIdx := cam(query_a_idx).robIdx
    port.query_a.pr.valid := port.query_a.lr.fire()

    // quary b
    val query_b = WireInit(VecInit(cam.map(x => x.valid & (x.LRIdx === port.query_b.lr.bits))))
    assert(Cat(query_b).orR() =/= 0.U)
    val query_b_idx = PriorityEncoder(query_b)
    port.query_b.pr.bits.idx := query_b_idx
    port.query_b.pr.bits.isReady := (cam(query_b_idx).state === STATECONST.WB) | (cam(query_b_idx).state === STATECONST.COMMIT)
    port.query_b.pr.bits.inROB := cam(query_b_idx).state === STATECONST.WB
    port.query_b.pr.bits.robIdx := cam(query_b_idx).robIdx
    port.query_b.pr.valid := port.query_b.lr.fire()
  }

  def allocate_c(port: QueryAllocate, emptyPRIdx: UInt) = {
    // allocate c
    when(port.allocate_c.lr.fire()){
      cam(emptyPRIdx).state := STATECONST.MAPPED
      cam(emptyPRIdx).LRIdx := port.allocate_c.lr.bits
    }
    port.allocate_c.pr.valid := Mux(port.allocate_c.lr.fire(), 1.U, 0.U)
    port.allocate_c.pr.bits := Mux(port.allocate_c.lr.fire(), emptyPRIdx, 0.U)
  }

  // query port a and b
  io.port.foreach(port => {
    quert_a_and_b(port)
  })

  // allocate port a and b
  val emptyPR = WireInit(VecInit(cam.map(_.state).map(_ === STATECONST.EMPRY)))
  val emptyPRIdx_0 = PriorityEncoder(emptyPR)
  val emptyPRIdx_1 = 64.U - PriorityEncoder(emptyPR.reverse)
  assert(emptyPRIdx_0 =/= emptyPRIdx_1)
  allocate_c(io.port(0), emptyPRIdx_0)
  allocate_c(io.port(1), emptyPRIdx_1)

//  when(io.port(0).valid & io.port(1).valid){
//    // 0 and 1
//    io.port.foreach(port => {
//      quert_a_and_b(port)
//    })
//
//    // allocate c0 and c1
//    val emptyPR = WireInit(VecInit(cam.map(_.state).map(_ === STATECONST.EMPRY)))
//    val emptyPRIdx_0 = PriorityEncoder(emptyPR)
//    val emptyPRIdx_1 = 64.U - PriorityEncoder(emptyPR.reverse)
//    assert(emptyPRIdx_0 =/= emptyPRIdx_1)
//    allocate_c(io.port(0), emptyPRIdx_0)
//    allocate_c(io.port(1), emptyPRIdx_1)
//
//  }.elsewhen(io.port(0).valid & !io.port(1).valid){
//    // 0
//    io.port.foreach(port => {
//      quert_a_and_b(port)
//    })
//
//    val port = io.port(0)
//    // allocate c
//    val emptyPR = WireInit(VecInit(cam.map(_.state).map(_ === STATECONST.EMPRY)))
//    val emptyPRIdx = PriorityEncoder(emptyPR)
//    allocate_c(port, emptyPRIdx)
//  }.elsewhen((!io.port(0).valid) & io.port(1).valid){
//    // 1
//    io.port.foreach(port => {
//      quert_a_and_b(port)
//    })
//
//    val port = io.port(1)
//    // allocate c
//    val emptyPR = WireInit(VecInit(cam.map(_.state).map(_ === STATECONST.EMPRY)))
//    val emptyPRIdx = PriorityEncoder(emptyPR)
//    allocate_c(port, emptyPRIdx)
//  }.otherwise{
//    // none
//    io.port.foreach(port => {
//      port.query_a.pr.bits.idx := 0.U
//      port.query_a.pr.bits.isReady := 0.U
//      port.query_a.pr.valid := 0.U
//
//      port.query_b.pr.bits.idx := 0.U
//      port.query_b.pr.bits.isReady := 0.U
//      port.query_b.pr.valid := 0.U
//    })
//  }

  io.cdb.foreach(cdb => {
    when(cdb.fire()){
      cam(cdb.bits.prn).state := STATECONST.WB
      cam(cdb.bits.prn).robIdx := cdb.bits.idx
    }
  })

  io.robCommit.foreach(robcommit => {
    when(robcommit.fire()){
      cam(robcommit.bits).state := STATECONST.COMMIT
    }
  })

}

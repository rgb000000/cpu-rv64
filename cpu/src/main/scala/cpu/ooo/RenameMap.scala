package cpu

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import chipsalliance.rocketchip.config._

class RenameMap(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{

    val query_a = new Bundle{
      val lr = Flipped(Valid(UInt(5.W)))
      val pr = Valid(UInt(6.W))
    }

    val query_b = new Bundle{
      val lr = Flipped(Valid(UInt(5.W)))
      val pr = Valid(UInt(6.W))
    }

    val allocate_c = new Bundle {
      val lr = Flipped(Valid(UInt(5.W)))  // logic register
      val pr = Valid(UInt(6.W))           // physics register
    }

    val wb = Flipped(Valid(UInt(6.W)))
    val commit = Flipped(Valid(UInt(6.W)))

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
  io.query_a.pr.bits := query_a_idx
  io.query_a.pr.bits := io.query_a.lr.fire()

  // quary b
  val query_b = WireInit(VecInit(cam.map(x => x.valid & (x.LRIdx === io.query_b.lr.bits))))
  assert(Cat(query_b).orR() =/= 0.U)
  val query_b_idx = PriorityEncoder(query_b)
  io.query_b.pr.bits := query_b_idx
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

  when(io.wb.fire()){
    cam(io.wb.bits).state := STATECONST.WB
  }

  when(io.commit.fire()){
    cam(io.commit.bits).state := STATECONST.EMPRY
  }

}

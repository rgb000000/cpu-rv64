package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class ROBIO(implicit p: Parameters) extends Bundle {
  val in = new Bundle {
    val cdb = Vec(2, Flipped(Decoupled(cdb)))
    val idxWantCommit = Input(Valid(Vec(2, UInt(4.W))))
  }

  val out = Vec(2, Valid(UInt(6.W)))
}

class ROB(implicit p: Parameters) extends Module {
  val io = IO(new ROBIO)

  val info = new Bundle {
    val cdb = new CDB
    val valid = Bool()
  }

  val rob = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(info))))

  // write rob
  val cnt = Counter(16)
  when(io.in.cdb(0).fire() & !io.in.cdb(1).fire()) {
    // wr cdb0
    cnt.value := cnt.value + 1.U
    rob(cnt.value).cdb := io.in.cdb(0).bits
    rob(cnt.value).valid := true.B
  }.elsewhen(!io.in.cdb(0).fire() & io.in.cdb(1).fire()) {
    // wr cdb1
    cnt.value := cnt.value + 1.U
    rob(cnt.value).cdb := io.in.cdb(1).bits
    rob(cnt.value).valid := true.B
  }.elsewhen(io.in.cdb(0).fire() & io.in.cdb(1).fire()) {
    // wr cdb0 and cdb1
    cnt.value := cnt.value + 2.U
    rob(cnt.value).cdb := io.in.cdb(0).bits
    rob(cnt.value).valid := true.B
    rob(cnt.value + 1.U).cdb := io.in.cdb(1).bits
    rob(cnt.value + 1.U).valid := true.B
  }.otherwise {
    // no wr
  }

  // commit
  val isIdxsGet = Wire(Vec(2, Bool()))
  val ROBidxs = Wire(Vec(2, UInt(4.W)))

  for (i <- 0 until 2) {
    val idxGet = Cat(rob.map(_.cdb.idx).map(_ === io.in.idxWantCommit.bits(i))).orR()
    val ROBidx = PriorityEncoder(idxGet)
    isIdxsGet(i) := idxGet
    ROBidxs(i) := ROBidx
  }

  for(i <- 0 until 2){
    io.out(i).bits := rob(ROBidxs(i)).cdb.prn
    io.out(i).valid := io.in.idxWantCommit.valid & isIdxsGet(i) & rob(ROBidxs(i)).cdb.wen

    rob(ROBidxs(i)).valid := !(io.in.idxWantCommit.valid & isIdxsGet(0))
  }

}
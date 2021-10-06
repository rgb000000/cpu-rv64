package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class ROBIO(implicit p: Parameters) extends Module{
    val cdb = Vec(2, Flipped(Decoupled(cdb)))

    val idxWantCommit = Input(Valid(UInt(4.W)))
}

class ROB(implicit p: Parameters) extends Module{
    val io = IO(new Bundle{
        val in = new ROBIO
    }) 

    val info = new Bundle{
        val idx = UInt(4.W)
        val brHit = Bool()
        val expt = Bool()
        val valid = Bool()
    }

    val rob = RegInit(0.U.asTypeOf(info))

    // write rob
    val cnt = Counter(16)
    when(io.in.cdb(0).fire() & !io.in.cdb(1).fire()){
        // wr cdb0
        cnt.value += 1.U
    }.elsewhen(!io.in.cdb(0).fire() & io.in.cdb(1).fire()){
        // wr cdb1
        cnt.value += 1.U
    }.elsewhen(io.in.cdb(0).fire() & io.in.cdb(1).fire()){
        // wr cdb0 and cdb1
        cnt.value += 2.U
    }.otherwise{
        // no wr
    }

    // commit
    val isIdxWantCommit = rob.map(_.idx).map(_ === io.in.idxWantCommit)
    val whichROBidx = PriorityEncoder(isIdxWantCommit)
    when(io.in.idxWantCommit.valid & isIdxWantCommit.orR()){
        rob(whichROBidx).valid := false.B
    }
}
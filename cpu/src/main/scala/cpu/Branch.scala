package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

case object BTBIndex extends Field[Int]

class BranchIO(implicit p: Parameters) extends Bundle{
  val rs1 = Input(UInt(p(XLen).W))
  val rs2 = Input(UInt(p(XLen).W))

  val br_type = Input(UInt(3.W))
  val taken = Output(Bool())
}

class Branch(implicit p: Parameters) extends Module {
  val io = IO(new BranchIO())

  val eq = io.rs1 === io.rs2
  val neq = !eq
  val less = io.rs1.asSInt() < io.rs2.asSInt()
  val greater_eq = !less
  val less_u = io.rs1 < io.rs2
  val greater_eq_u = !less_u

  io.taken :=
    ((io.br_type === Control.BR_EQ) && eq) ||
    ((io.br_type === Control.BR_NE) && neq) ||
    ((io.br_type === Control.BR_LT) && less) ||
    ((io.br_type === Control.BR_GE) && greater_eq) ||
    ((io.br_type === Control.BR_LTU) && less_u) ||
    ((io.br_type === Control.BR_GEU) && greater_eq_u) ||
    ( io.br_type === Control.BR_J)

}

class BTBIO(implicit p: Parameters) extends Bundle {
  val query = new Bundle {
    val pc  = Flipped(Valid(UInt(p(XLen).W)))

    val res = Valid(new Bundle {
      val tgt = UInt(p(XLen).W)
      val pTaken = Bool()
      val is_miss = Bool()
    })
  }

  val update = Flipped(Valid(new Bundle {
    val pc  = UInt(p(XLen).W)
    val tgt = UInt(p(XLen).W)
    val isTaken = Bool()
  }))
}

class BTB(implicit p: Parameters) extends Module{
  val io = IO(new BTBIO)

  val CAMType = new Bundle{
    val pc  = UInt(p(XLen).W)
    val tgt = UInt(p(XLen).W)
    val bht = UInt(2.W)
  }

  val cam = RegInit(VecInit(Seq.fill(p(BTBIndex))(0.U.asTypeOf(CAMType))))
  val ptr = Counter(p(BTBIndex))

  // query
  val query_compare_res = Cat(cam.map(_.pc).map(_ === io.query.pc.bits).reverse)
  val query_is_miss = query_compare_res.orR() === 0.U
  val query_select_data = Mux1H(for(i <- query_compare_res.asBools().zipWithIndex) yield (i._1, cam(i._2)))
  io.query.res.valid := io.query.pc.valid
  io.query.res.bits.tgt := query_select_data.tgt
  io.query.res.bits.pTaken := query_select_data.bht(1)
  io.query.res.bits.is_miss := query_is_miss // | true.B

  // update
  val update_compare_res = Cat(cam.map(_.pc).map(_ === io.update.bits.pc))
  val update_is_miss = update_compare_res.orR() === 0.U
  val update_index = PriorityEncoder(Cat(update_compare_res.asBools()))
  when(io.update.valid & !update_is_miss){
    // update and hit
    cam(update_index).tgt := io.update.bits.tgt
    when(io.update.bits.isTaken & (cam(update_index).bht =/= "b11".U)){
      cam(update_index).bht := cam(update_index).bht + 1.U
    }.elsewhen(!io.update.bits.isTaken & (cam(update_index).bht =/= "b00".U)){
      cam(update_index).bht := cam(update_index).bht - 1.U
    }
  }.elsewhen(io.update.valid & update_is_miss){
    // update and miss
    cam(ptr.value).pc := io.update.bits.pc
    cam(ptr.value).tgt := io.update.bits.tgt
    cam(ptr.value).bht := Mux(io.update.bits.isTaken, "b10".U, "b01".U)
    ptr.inc()
  }
}
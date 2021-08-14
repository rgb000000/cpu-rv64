package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

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
    ((io.br_type === Control.BR_GEU) && greater_eq_u)

}

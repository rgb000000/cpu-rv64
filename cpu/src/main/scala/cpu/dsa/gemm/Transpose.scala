package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

case object TransposeDIM extends Field[Int]

class TransposeIO[T <: Data](inType: T)(implicit p: Parameters) extends Bundle{
  val dim = p(TransposeDIM)

  val in = Flipped(Decoupled(Vec(dim, inType)))
  val out = Decoupled(Vec(dim, inType))

  override def cloneType = new TransposeIO(inType).asInstanceOf[this.type]
}

trait TransposeParam{
  val IN_DIR = 0.U
  val OUT_DIR = 1.U
}

// PE for Transpose only
class PE_T[T <: Data](inType: T) extends Module with TransposeParam {
  val io = IO(new Bundle{
    val left = Input(inType)
    val down = Input(inType)

    val right = Output(inType)
    val up = Output(inType)

    val dir = Input(UInt(1.W)) // 0: in,   1: out
    val en = Input(Bool())
  })

  val reg = RegEnable(Mux(io.dir === IN_DIR, io.left, io.down), io.en)

  io.up := reg
  io.right := reg
}

class Transpose[T <: Data](inType: T)(implicit p: Parameters) extends Module with TransposeParam {
  val io = IO(new TransposeIO(inType))

  val dim = p(TransposeDIM)

  val pearray = Seq.fill(dim, dim)(Module(new PE_T(inType)))
  val cnt = Counter(dim)
  val dir = RegInit(IN_DIR)
  val en = Wire(Bool())

  // horizontal
  for(i <- 0 until dim){
    pearray(i).foldLeft(io.in.bits(i)){
      case (in, pe) =>
        pe.io.left := in
        pe.io.right
    }
  }

  // vertical
  for(i <- 0 until dim){
    pearray.map(_(i)).reverse.foldLeft(0.U.asTypeOf(inType)){
      case (in, pe) =>
        pe.io.down := in
        pe.io.up
    }
  }

  // io.out
  for(i <- 0 until dim){
    io.out.bits(i) := pearray.head(i).io.up
  }

  // dir and en
  pearray.foreach(_.foreach(_.io.dir := dir))
  pearray.foreach(_.foreach(_.io.en := en))

  io.in.ready := dir === IN_DIR

  io.out.valid := dir === OUT_DIR

  en := io.in.fire() | io.out.fire()

  when(io.in.fire() | io.out.fire()){
    when(cnt.value === (dim - 1).U){
      dir := !dir
    }
    cnt.inc()
  }

}

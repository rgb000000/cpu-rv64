package cpu.dsa.gemm

import chisel3._
import chisel3.util._

import scala.language.implicitConversions

abstract class ArithmeticOps[T <: Data](self: T){
  def +(t: T): T
  def *(t: T): T
  def mac(m1: T, m2: T): T
  def clipped2witdhOf(t: T): T
  def >>(u: UInt): T
}

abstract class Arithmetic[T <: Data] {
  implicit def cast(self: T): ArithmeticOps[T]
}

object Arithmetic{

  implicit object UIntArithmetic extends Arithmetic[UInt]{
    override implicit def cast(self: UInt): ArithmeticOps[UInt] = new ArithmeticOps[UInt](self) {
      override def +(t: UInt): UInt = self + t
      override def *(t: UInt): UInt = self * t
      override def mac(m1: UInt, m2: UInt): UInt = m1 * m2 + self
      override def >>(u: UInt): UInt = (self >> u).asUInt()
      override def clipped2witdhOf(t: UInt): UInt = {
        val sat = ((1 << (t.getWidth)) - 1).U
        Mux(self > sat, sat, self)(t.getWidth-1, 0).asUInt()
      }
    }
  }

  implicit object SIntArithmetic extends Arithmetic[SInt]{
    override implicit def cast(self: SInt): ArithmeticOps[SInt] = new ArithmeticOps[SInt](self) {
      override def +(t: SInt): SInt = self + t
      override def *(t: SInt): SInt = self * t
      override def mac(m1: SInt, m2: SInt): SInt = m1 * m2 + self
      override def >>(u: UInt): SInt = (self >> u).asSInt()
      override def clipped2witdhOf(t: SInt): SInt = {
        val max = ((1 << (t.getWidth - 1)) - 1).S
        val min = (-(1 << (t.getWidth - 1))).S
        Mux(self > max, max,
        Mux(self < min, min, self))(t.getWidth-1, 0).asSInt()
      }
    }
  }

}

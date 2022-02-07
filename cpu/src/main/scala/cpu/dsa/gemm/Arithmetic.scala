package cpu.dsa.gemm

import chisel3._
import chisel3.util._

import scala.language.implicitConversions

abstract class ArithmeticOps[T <: Data](self: T){
  def +(t: T): T
  def *(t: T): T
  def mac(m1: T, m2: T): T
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
    }
  }

  implicit object SIntArithmetic extends Arithmetic[SInt]{
    override implicit def cast(self: SInt): ArithmeticOps[SInt] = new ArithmeticOps[SInt](self) {
      override def +(t: SInt): SInt = self + t
      override def *(t: SInt): SInt = self * t
      override def mac(m1: SInt, m2: SInt): SInt = m1 * m2 + self
    }
  }

}

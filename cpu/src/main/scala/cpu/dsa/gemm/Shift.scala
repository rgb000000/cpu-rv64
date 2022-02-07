package cpu.dsa.gemm

import chisel3._
import chisel3.util._

object SRn {
  // ShiftReg n cycles
  def apply(data: Data, n: Int = 1) ={
    ShiftRegister(data, n)
  }
}

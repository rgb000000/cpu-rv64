package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

object ALU {
  val ALU_ADD    = 0.U(4.W)
  val ALU_SUB    = 1.U(4.W)
  val ALU_AND    = 2.U(4.W)
  val ALU_OR     = 3.U(4.W)
  val ALU_XOR    = 4.U(4.W)
  val ALU_SLT    = 5.U(4.W)
  val ALU_SLL    = 6.U(4.W)
  val ALU_SLTU   = 7.U(4.W)
  val ALU_SRL    = 8.U(4.W)
  val ALU_SRA    = 9.U(4.W)
  val ALU_COPY_A = 10.U(4.W)
  val ALU_COPY_B = 11.U(4.W)
  val ALU_XXX    = 15.U(4.W)
}

class ALU (implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val rs1 = Input(UInt(p(XLen).W))
    val rs2 = Input(UInt(p(XLen).W))
    val opcode = Input(UInt(p(XLen).W))

    val out = Output(UInt(p(XLen).W))
  })
  import ALU._
  val shamt = io.rs2(4, 0).asUInt()

  io.out := MuxLookup(io.opcode, io.rs2, Seq(
    ALU_ADD  -> (io.rs1 + io.rs2),
    ALU_SUB  -> (io.rs1 - io.rs2),
    ALU_SRA  -> (io.rs1.asSInt >> shamt).asUInt,
    ALU_SRL  -> (io.rs1 >> shamt),
    ALU_SLL  -> (io.rs1 << shamt),
    ALU_SLT  -> (io.rs1.asSInt < io.rs2.asSInt),
    ALU_SLTU -> (io.rs1 < io.rs2),
    ALU_AND  -> (io.rs1 & io.rs2),
    ALU_OR   -> (io.rs1 | io.rs2),
    ALU_XOR  -> (io.rs1 ^ io.rs2),
    ALU_COPY_A -> io.rs1
  ))

}

class EX(implicit p: Parameters) extends Module {
  val io = IO(new Bundle {
    val rs1 = Input(UInt(p(XLen).W))
    val rs2 = Input(UInt(p(XLen).W))

    val out = Output(UInt(p(XLen).W))
  })

  val alu = Module(new ALU)

  alu.io.rs1 := io.rs1
  alu.io.rs2 := io.rs2

  io.out := RegNext(alu.io.out)


}

package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import cpu.ALU.ALU_ADD

object ALU {
  val ALU_ADD    = 0.U(4.W) // +
  val ALU_SUB    = 1.U(4.W) // -
  val ALU_AND    = 2.U(4.W) // &
  val ALU_OR     = 3.U(4.W) // |
  val ALU_XOR    = 4.U(4.W) // ^
  val ALU_SLT    = 5.U(4.W) // <
  val ALU_SLL    = 6.U(4.W) // << logic
  val ALU_SLTU   = 7.U(4.W) // < unsigned
  val ALU_SRL    = 8.U(4.W) // >> logic
  val ALU_SRA    = 9.U(4.W) // >> arithmetic
  val ALU_COPY_A = 10.U(4.W)// rs1
  val ALU_COPY_B = 11.U(4.W)// rs2
  val ALU_XXX    = 15.U(4.W)//

  val ALU_ALL    = 0.U(1.W) // return all result
  val ALU_CUT32  = 1.U(1.W) // return [31:0]
}

class ALU (implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val rs1 = Input(UInt(p(XLen).W))
    val rs2 = Input(UInt(p(XLen).W))
    val alu_op = Input(UInt(4.W))
    val res_cut = Input(UInt(1.W))

    val out = Output(UInt(p(XLen).W))
  })
  import ALU._
  val shamt = io.rs2(4, 0).asUInt()

  val out = MuxLookup(io.alu_op, io.rs2, Seq(
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

  io.out := MuxCase(out, Array(
    (io.res_cut === ALU_ALL) -> out,
    (io.res_cut === ALU_CUT32) -> out(31,0).asSInt().asUInt()
  ))
}

class EX(implicit p: Parameters) extends Module {
  val io = IO(new Bundle {
    val rs1 = Input(UInt(p(XLen).W))
    val rs2 = Input(UInt(p(XLen).W))
    val alu_op = Input(UInt(4.W))
    val alu_cut = Input(UInt(1.W))

    val out = Output(UInt(p(XLen).W))
  })

  val alu = Module(new ALU)

  alu.io.rs1 := io.rs1
  alu.io.rs2 := io.rs2
  alu.io.alu_op := io.alu_op
  alu.io.res_cut := io.alu_cut

  io.out := alu.io.out


}

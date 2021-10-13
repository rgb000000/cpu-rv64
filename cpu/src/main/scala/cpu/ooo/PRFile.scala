package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

import difftest._

class PRFile(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    // read port
    val read = Vec(2, new Bundle{
      val raddr1 = Input(UInt(log2Ceil(64).W))
      val raddr2 = Input(UInt(log2Ceil(64).W))
      val rdata1 = Output(UInt(p(XLen).W))
      val rdata2 = Output(UInt(p(XLen).W))
    })

    // writer port
    val write = Vec(2, new Bundle{
      val wen = Input(Bool())
      val waddr = Input(UInt(log2Ceil(64).W))
      val wdata = Input(UInt(p(XLen).W))
    })

    val difftest = if(p(Difftest)) {Some(new Bundle{
      val archReg = new Bundle{
        val prs = Flipped(Valid(Vec(32, UInt(6.W))))
      }

      val trap_cpode = new Bundle{
        val pr = Flipped(Valid(UInt(6.W)))
        val data = Valid(UInt(p(XLen).W))
      }
    })} else {None}
  })

  val registers = RegInit(VecInit(Seq.fill(64)(0.asUInt(p(XLen).W))))

  io.read(0).rdata1 := Mux(io.read(0).raddr1.orR() === 0.U, 0.U, Mux(io.write(0).wen & io.write(0).waddr === io.read(0).raddr1, io.write(0).wdata, registers(io.read(0).raddr1)))
  io.read(0).rdata2 := Mux(io.read(0).raddr2.orR() === 0.U, 0.U, Mux(io.write(0).wen & io.write(0).waddr === io.read(0).raddr2, io.write(0).wdata, registers(io.read(0).raddr2)))

  io.read(1).rdata1 := Mux(io.read(1).raddr1.orR() === 0.U, 0.U, Mux(io.write(1).wen & io.write(1).waddr === io.read(1).raddr1, io.write(1).wdata, registers(io.read(1).raddr1)))
  io.read(1).rdata2 := Mux(io.read(1).raddr2.orR() === 0.U, 0.U, Mux(io.write(1).wen & io.write(1).waddr === io.read(1).raddr2, io.write(1).wdata, registers(io.read(1).raddr2)))

  when(io.write(0).wen === 1.U & io.write(0).waddr.orR() =/= 0.U){
    registers(io.write(0).waddr) := io.write(0).wdata
  }

  when(io.write(1).wen === 1.U & io.write(1).waddr.orR() =/= 0.U){
    registers(io.write(1).waddr) := io.write(1).wdata
  }


  if(p(Difftest)){
    val vitual_arch_reg = Wire(Vec(32, UInt(64.W)))
    for(i <- 0 until 32){
      vitual_arch_reg(i) := registers(io.difftest.get.archReg.prs.bits(i))
    }


    val dar = Module(new DifftestArchIntRegState)
    dar.io.clock := clock
    dar.io.coreid := 0.U
    dar.io.gpr := vitual_arch_reg

    io.difftest.get.trap_cpode.data.valid := io.difftest.get.trap_cpode.pr.valid
    io.difftest.get.trap_cpode.data.bits := registers(io.difftest.get.trap_cpode.pr.bits)
  }
}

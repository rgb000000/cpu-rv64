package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

import difftest._

class PRFile(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    // read port
    val read = Vec(2, new Bundle{
      val raddr1 = Input(UInt(log2Ceil(p(PRNUM)).W))
      val raddr2 = Input(UInt(log2Ceil(p(PRNUM)).W))
      val rdata1 = Output(UInt(p(XLen).W))
      val rdata2 = Output(UInt(p(XLen).W))
    })

    // writer port
    val write = Vec(2, new Bundle{
      val wen = Input(Bool())
      val waddr = Input(UInt(log2Ceil(p(PRNUM)).W))
      val wdata = Input(UInt(p(XLen).W))
    })

    val difftest = if(p(Difftest)) {Some(new Bundle{
      val findArchReg = Vec(2, new Bundle{
        val pr = Valid(UInt(6.W))
        val lr = Flipped(Valid(UInt(5.W)))
      })

      val trap_cpode = new Bundle{
        val data = Valid(UInt(p(XLen).W))
      }
    })} else {None}
  })

  val registers = RegInit(VecInit(Seq.fill(p(PRNUM))(0.asUInt(p(XLen).W))))


  io.read(0).rdata1 := Mux(io.read(0).raddr1.orR() === 0.U, 0.U, Mux(io.write(0).wen & io.write(0).waddr === io.read(0).raddr1, io.write(0).wdata, registers(io.read(0).raddr1)))
  io.read(0).rdata2 := Mux(io.read(0).raddr2.orR() === 0.U, 0.U, Mux(io.write(0).wen & io.write(0).waddr === io.read(0).raddr2, io.write(0).wdata, registers(io.read(0).raddr2)))

  io.read(1).rdata1 := Mux(io.read(1).raddr1.orR() === 0.U, 0.U, Mux(io.write(1).wen & io.write(1).waddr === io.read(1).raddr1, io.write(1).wdata, registers(io.read(1).raddr1)))
  io.read(1).rdata2 := Mux(io.read(1).raddr2.orR() === 0.U, 0.U, Mux(io.write(1).wen & io.write(1).waddr === io.read(1).raddr2, io.write(1).wdata, registers(io.read(1).raddr2)))

  when(io.write(0).wen & io.write(0).waddr.orR()){
    registers(io.write(0).waddr) := io.write(0).wdata
  }

  when(io.write(1).wen & io.write(1).waddr.orR()){
    registers(io.write(1).waddr) := io.write(1).wdata
  }


  if(p(Difftest)){
    for(i <- 0 until 2){
      io.difftest.get.findArchReg(i).pr.bits := io.write(i).waddr
      io.difftest.get.findArchReg(i).pr.valid := io.write(i).wen
    }
    val arch_reg = RegInit(VecInit(Seq.fill(32)(0.asUInt(p(XLen).W))))

    when(io.write(0).wen & io.write(0).waddr.orR()){
      arch_reg(io.difftest.get.findArchReg(0).lr.bits) := io.write(0).wdata
    }

    when(io.write(1).wen  & io.write(1).waddr.orR()){
      arch_reg(io.difftest.get.findArchReg(1).lr.bits) := io.write(1).wdata
    }

    val dar = Module(new DifftestArchIntRegState)
    dar.io.clock := clock
    dar.io.coreid := 0.U
    dar.io.gpr := arch_reg

    io.difftest.get.trap_cpode.data.valid := true.B
    io.difftest.get.trap_cpode.data.bits := arch_reg(10)
  }
}

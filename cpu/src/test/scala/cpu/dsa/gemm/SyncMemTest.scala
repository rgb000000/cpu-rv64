package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chiseltest._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
//import chiseltest.internal.{VerilatorBackendAnnotation, WriteVcdAnnotation}
import firrtl.options.TargetDirAnnotation
import org.scalatest.FreeSpec

class SyncMemTest extends FreeSpec with ChiselScalatestTester {
  "SyncReadMem Test" in {
    val annos = Seq(
      TargetDirAnnotation("test_run_dir"),
      //      VerilatorBackendAnnotation,
      WriteVcdAnnotation,
    )
    RawTester.test(new Module{
      val io = IO(new Bundle() {
        val wen = Input(Bool())
        val waddr = Input(UInt(4.W))
        val wdata = Input(UInt(8.W))

        val ren = Input(Bool())
        val raddr = Input(UInt(4.W))
        val rdata = Output(UInt(8.W))
      })

      val mem = SyncReadMem(16, UInt(8.W))

      io.rdata := mem.read(io.raddr, io.ren & !io.wen)

      when(io.wen){
        mem.write(io.waddr, io.wdata)
      }

    }, annos){c =>

      c.io.wen.poke(true.B)
      c.io.waddr.poke(3.U)
      c.io.wdata.poke(0x77.U)

      c.clock.step(1)

      c.io.wen.poke(false.B)

      c.clock.step(10)

      c.io.ren.poke(true.B)
      c.io.raddr.poke(3.U)

      c.clock.step(1)

      c.io.ren.poke(false.B)

      c.clock.step(10)

    }
  }
}

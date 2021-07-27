package cpu

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import org.scalatest.FreeSpec
import java.io._

class MemTest extends Module{
  val io = IO(new Bundle{
    val dataA = Output(UInt(64.W))
    val dataB = Output(UInt(64.W))
  })

  val memA = SyncReadMem(32, UInt(64.W))
  loadMemoryFromFile(memA, "inst.hex")
  val memB = SyncReadMem(32, Vec(8, UInt(8.W)))
  loadMemoryFromFile(memB, "inst.hex")

  io.dataA := memA.read(0.U)
  io.dataB := memB.read(0.U).asUInt()
}

class TestSpec extends FreeSpec {
  "IFSpec will generate IF Verilog" in {
    implicit val p = new DefaultConfig
    (new ChiselStage).execute(
      Array(
        "-X", "verilog",
        "--target-dir", "test_run_dir"
      ),
      Seq(ChiselGeneratorAnnotation(() => new MemTest()))
    )

  }
}

package cpu

import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import org.scalatest.FreeSpec
import java.io._

class IFSpec extends FreeSpec {
  "IFSpec will generate IF Verilog" in {
    implicit val p = new DefaultConfig
    (new ChiselStage).execute(
      Array(
        "-X", "verilog",
        "--target-dir", "test_run_dir"
      ),
      Seq(ChiselGeneratorAnnotation(() => new IFWrapper()))
    )

    val writer = new PrintWriter(new File("test.txt" ))
    writer.write("hello world")
    writer.close()

  }
}

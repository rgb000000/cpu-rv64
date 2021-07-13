package cpu

import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import org.scalatest.FreeSpec
import java.io._

class DPSpec extends FreeSpec {
  "DPSpec (DataPath) will generate CPU Verilog" in {
    implicit val p = new DefaultConfig
    (new ChiselStage).execute(
      Array(
        "-X", "verilog",
        "--target-dir", "test_run_dir/DP"
      ),
      Seq(ChiselGeneratorAnnotation(() => new DataPath))
    )
  }
}

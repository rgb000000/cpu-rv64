package cpu

import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}

object BazelRunner {
  def main(args: Array[String]): Unit = {
    var module_name: Option[String] = None
    def theThingUnderTest = {
      val module = {
        // {MODULECODE}
      }
      module_name = Some("??")
       module
    }
    // if (theArgs(1) != module_name.get) {
    //   System.err.println(
    //     s"Expected module_name to be '${module_name.get}'. Got '${theArgs(1)}'"
    //   )
    //   System.exit(1)
    // }
    println("Generating Verilog for {MODULECODE}")
    implicit val p = new DefaultConfig
    (new ChiselStage).execute(
      Array(
        "-X", "verilog",
        "--target-dir", args(0)
      ),
      Seq(ChiselGeneratorAnnotation(() => new {MODULECODE}))
    )
    println("Success!")
  }
}
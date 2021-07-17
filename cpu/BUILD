# cpu
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library", "scala_macro_library","scala_binary", "scala_test")
load("//config:chisel.bzl", "chisel_library", "chisel_treadle_test", "chisel_verilog", "hello", "verilator_test")
chisel_library(
  name = "cpu",
  srcs = glob(["src/main/scala/cpu/*.scala"]),
  deps = [
    "//dependency:config"
  ],
  resources = ["src/main/resources"],
  visibility = ["//visibility:public"]
)

chisel_treadle_test(
    name = "IFVerilog",
    srcs = glob(["src/test/scala/cpu/IFSpec.scala"]),
    deps = [
        "cpu",
        "//dependency:config"
    ],
)

chisel_treadle_test(
    name = "DP",
    srcs = glob(["src/test/scala/cpu/DPSpec.scala"]),
    deps = [
        "cpu",
        "//dependency:config"
    ],
)

chisel_verilog(
    name = "V",
    module_name = "DataPath",
    module_code = "cpu.DataPath",
    deps = [
      "cpu",
      "//dependency:config"
    ],
)

hello(
  name = "hh",
  depss = "222"
)

verilator_test(
  name = "VV",
  module_name = "DataPath",
  module_code = "cpu.DataPath",
  inst_file = glob(["src/main/resources/inst.hex"]),
  deps = [
    "cpu",
    "//dependency:config"
  ],
  srcs = glob(["src/test/resources/DataPath-harness.cpp"])
)
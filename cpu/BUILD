# cpu
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_binary", "scala_library", "scala_macro_library", "scala_test")
load("//config:chisel.bzl", "chisel_library", "chisel_treadle_test", "chisel_verilog", "difftest", "getVerilog", "hello", "verilator_test")

chisel_library(
    name = "cpu",
    srcs = glob(["src/main/scala/cpu/*.scala"]),
    resources = ["src/main/resources"],
    visibility = ["//visibility:public"],
    deps = [
        "//dependency:config",
        "//dependency:difftest",
    ],
)

#chisel_treadle_test(
#    name = "IFVerilog",
#    srcs = glob(["src/test/scala/cpu/IFSpec.scala"]),
#    deps = [
#        "cpu",
#        "//dependency:config",
#    ],
#)
#
#chisel_treadle_test(
#    name = "DP",
#    srcs = glob(["src/test/scala/cpu/DPSpec.scala"]),
#    deps = [
#        "cpu",
#        "//dependency:config",
#    ],
#)
#
#chisel_verilog(
#    name = "V",
#    module_code = "cpu.DataPath",
#    module_name = "DataPath",
#    deps = [
#        "cpu",
#        "//dependency:config",
#    ],
#)

hello(
    name = "hh",
    depss = "222",
)

#verilator_test(
#    name = "datapath_vt",
#    srcs = glob(["src/test/resources/DataPath-harness.cpp"]),
#    inst_file = glob(["src/main/resources/inst.hex"]),
#    module_code = "cpu.DataPath",
#    module_name = "DataPath",
#    deps = [
#        "cpu",
#        "//dependency:config",
#    ],
#)
#
#verilator_test(
#    name = "core_vt",
#    srcs = glob(["src/test/resources/Core-harness.cpp"]),
#    inst_file = glob(["src/main/resources/inst*.hex"]),
#    module_code = "cpu.Core",
#    module_name = "Core",
#    deps = [
#        "cpu",
#        "//dependency:config",
#    ],
#)

difftest(
    name = "SimTop",
    srcs = glob(["src/test/resources/Core-harness.cpp"]),
    inst_file = glob(["src/main/resources/inst*.hex"]),
    module_code = "cpu.SimTop",
    module_name = "SimTop",
    deps = [
        "cpu",
        "//dependency:config",
    ],
)

difftest(
    name = "DRAM3Sim",
    srcs = glob(["src/test/resources/Core-harness.cpp"]),
    config_name = "DRAM3SimConfig",
    inst_file = glob(["src/main/resources/inst*.hex"]),
    module_code = "cpu.MySimTop",
    module_name = "MySimTop",
    deps = [
        "cpu",
        "//dependency:config",
    ],
)

getVerilog(
    name = "Core",
    srcs = glob(["src/test/resources/Core-harness.cpp"]),
    inst_file = glob(["src/main/resources/inst*.hex"]),
    module_code = "cpu.Core",
    module_name = "Core",
    deps = [
        "cpu",
        "//dependency:config",
    ],
)

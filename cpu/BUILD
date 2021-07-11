# cpu
load("//config:chisel.bzl", "chisel_library", "chisel_treadle_test")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library", "scala_macro_library","scala_binary", "scala_test")

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
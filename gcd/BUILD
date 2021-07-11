# gcd
load("//config:chisel.bzl", "chisel_library", "chisel_treadle_test")

chisel_library(
    name = "gcd",
    srcs = glob(["src/main/scala/*.scala"]),
    visibility = ["//visibility:public"]
)
 
chisel_treadle_test(
    name = "test",
    srcs = glob(["src/test/scala/GCDSpec.scala"]),
    deps = ["gcd"]
)

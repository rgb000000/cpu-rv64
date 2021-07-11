# gcd
load("//config:chisel.bzl", "chisel_library", "chisel_treadle_test")

chisel_library(
    name = "gcd",
    srcs = glob(["src/*.scala"]),
    visibility = ["//visibility:public"]
)
 
chisel_treadle_test(
    name = "test",
    srcs = glob(["test/GCDSpec.scala"]),
    deps = ["//gcd"]
)

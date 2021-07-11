load("//config:chisel.bzl", "chisel_library", "chisel_treadle_test")

chisel_library(
    name = "config",
    srcs = glob(["api-config-chipsalliance/design/craft/src/config/*.scala"]),
    visibility = ["//visibility:public"]
)

chisel_library(
    name = "hardfloat",
    srcs = glob(["berkeley-hardfloat/src/main/scala/*.scala"]),
    visibility = ["//visibility:public"]
)

chisel_library(
    name = "rocket-chip",
    srcs = glob([
        "rocket-chip/src/main/scala/**/*.scala",
        "rocket-chip/src/main/scala/*.scala",
        ]),
    deps = [
        "hardfloat",
        "config"
    ],
    visibility = ["//visibility:public"]
)
load("//config:chisel.bzl", "chisel_library", "chisel_treadle_test")

chisel_library(
  name = "cpu",
  srcs = glob(["src/main/scala/*.scala"]),
  deps = [
    "//dependency:config"
  ],
  resources = ["src/main/resources"],
  visibility = ["//visibility:public"]
)


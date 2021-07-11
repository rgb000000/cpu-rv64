load("@io_bazel_rules_scala//scala:scala.bzl", "scala_binary", "scala_library", "scala_test")

_chisel_deps = [
    "@maven//:edu_berkeley_cs_chisel3_2_12",
    "@maven//:edu_berkeley_cs_chisel3_core_2_12",
    "@maven//:edu_berkeley_cs_chisel3_macros_2_12",
    "@maven//:edu_berkeley_cs_firrtl_2_12",
    "@io_bazel_rules_scala//testing/toolchain:scalatest_classpath",
]

_chiseltest_deps = [
    "@maven//:edu_berkeley_cs_chiseltest_2_12",
]

_chisel_plugins = [
    "@maven//:org_scalamacros_paradise_2_12_13",
    "@maven//:edu_berkeley_cs_chisel3_plugin_2_12_13",
]

_scalacopts = [
    "-Xsource:2.11",
    "-language:reflectiveCalls",
    "-deprecation",
    "-feature",
    "-Xcheckinit",
    # Enables autoclonetype2 in 3.4.x (on by default in 3.5)
    "-P:chiselplugin:useBundlePlugin"
]


def chisel_library(name, srcs, deps = [], visibility = None):
    scala_library(
        name = name,
        srcs = srcs,
        deps = _chisel_deps + deps,
        plugins = _chisel_plugins,
        scalacopts = _scalacopts,
        visibility = visibility
    )

def chisel_treadle_test(name, srcs, trace=False, deps=[]):
    scala_test(
        name = name,
        srcs = srcs,
        deps = _chisel_deps + _chiseltest_deps + deps,
        plugins = _chisel_plugins,
        scalacopts = _scalacopts,
        jvm_flags = ["-DWRITE_VCD=1"] if trace else [],
    )
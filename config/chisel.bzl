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


def chisel_library(name, srcs, deps = [], resources=[], visibility = None):
    scala_library(
        name = name,
        srcs = srcs,
        deps = _chisel_deps + deps,
        plugins = _chisel_plugins,
        scalacopts = _scalacopts,
        resources = resources,
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

# def _chisel_verilog_scala_source_impl(ctx):
#     out = ctx.actions.declare_file(ctx.label.name + ".scala")
#     ctx.actions.expand_template(
#         output = out,
#         template = ctx.file._template,
#         substitutions = {"{MODULECODE}": ctx.attr.module_code},
#     )
#     return [DefaultInfo(files = depset([out]))]

# _chisel_verilog_scala_source = rule(
#     implementation = _chisel_verilog_scala_source_impl,
#     attrs = {
#         "module_code": attr.string(mandatory = True),
#         "_template": attr.label(
#             allow_single_file = True,
#             default = "verilog_generation.tpl.scala",
#         ),
#     },
# )

# def _chisel_verilog_run_generator_impl(ctx):
#     out = ctx.actions.declare_file(ctx.label.name + ".v")
#     ctx.actions.run(
#         outputs = [out],
#         executable = ctx.executable.tool,
#         tools = [ctx.executable.tool],
#         arguments = [
#             out.path,
#             ctx.attr.module_name,
#         ],
#         progress_message = "Emitting verilog for %s" % ctx.label.name,
#     )
#     return [
#         DefaultInfo(files = depset([out])),
#         VerilogModuleInfo(
#             top = ctx.attr.module_name,
#             files = depset([out]),
#         ),
#     ]

# _chisel_verilog_run_generator = rule(
#     implementation = _chisel_verilog_run_generator_impl,
#     attrs = {
#         "tool": attr.label(
#             mandatory = True,
#             executable = True,
#             cfg = "exec",
#         ),
#         "module_name": attr.string(mandatory = True),
#     },
# )

# def chisel_verilog(
#         name,
#         module_name,
#         module_code,
#         deps,
#         visibility = None):
#     _chisel_verilog_scala_source(
#         name = name + "_emit_verilog_scala",
#         module_code = module_code,
#     )
#     scala_binary(
#         name = name + "_emit_verilog_binary",
#         main_class = "runner.TheBazelRunner",
#         srcs = [
#             "%s_emit_verilog_scala" % name,
#         ],
#         deps = deps + _chisel_deps,
#         plugins = _chisel_plugins,
#         visibility = ["//visibility:private"],
#     )
#     _chisel_verilog_run_generator(
#         name = name,
#         visibility = visibility,
#         tool = name + "_emit_verilog_binary",
#         module_name = module_name,
#     )


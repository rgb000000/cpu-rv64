load("@io_bazel_rules_scala//scala:scala.bzl", "scala_binary", "scala_library", "scala_test")
load("@rules_verilog//verilog:defs.bzl", "VerilogModuleInfo")
load("@rules_verilator//verilator:defs.bzl", "verilator_cc_library")

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

###################################################

def _chisel_verilog_scala_source_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name + ".scala")
    ctx.actions.expand_template(
        output = out,
        template = ctx.file._template,
        substitutions = {"{MODULECODE}": ctx.attr.module_code},
    )
    return [DefaultInfo(files = depset([out]))]

_chisel_verilog_scala_source = rule(
    implementation = _chisel_verilog_scala_source_impl,
    attrs = {
        "module_code": attr.string(mandatory = True),
        "_template": attr.label(
            allow_single_file = True,
            default = "//cpu:src/test/scala/cpu/BazelRunner.scala",
        ),
    },
)

def _chisel_verilog_run_generator_impl(ctx):
    out = ctx.actions.declare_directory(ctx.label.name)
    v_file = ctx.actions.declare_file(ctx.label.name + "/" + ctx.attr.module_name + ".v")
    ctx.actions.run(
        outputs = [out, v_file],
        executable = ctx.executable.tool,
        tools = [ctx.executable.tool],
        arguments = [
            out.path,
            ctx.attr.module_name,
        ],
        progress_message = "Emitting verilog for %s" % ctx.label.name,
    )
    return [
        DefaultInfo(files = depset([out, v_file])),
        VerilogModuleInfo(
            top = ctx.attr.module_name,
            files = depset([out]),
        ),
    ]

_chisel_verilog_run_generator = rule(
    implementation = _chisel_verilog_run_generator_impl,
    attrs = {
        "tool": attr.label(
            mandatory = True,
            executable = True,
            cfg = "exec",
        ),
        "module_name": attr.string(mandatory = True),
    },
)

###################################################

def chisel_verilog(
        name,
        module_name,
        module_code,
        deps,
        visibility = None
        ):
    _chisel_verilog_scala_source(
        name = name + "_emit_verilog_scala",
        module_code = module_code,
    )
    scala_binary(
        name = name + "_emit_verilog_binary",
        main_class = "cpu.BazelRunner",
        srcs = [
            "%s_emit_verilog_scala" % name,
        ],
        deps = deps + _chisel_deps,
        plugins = _chisel_plugins,
        visibility = ["//visibility:private"],
    )
    _chisel_verilog_run_generator(
        name = name,
        visibility = visibility,
        tool = name + "_emit_verilog_binary",
        module_name = module_name,
    )

###################################################

def hello_impl(ctx):
    print("hello world")
    print(ctx.attr.depss)
    out = ctx.actions.declare_file(ctx.attr.depss + ".cao")
    ctx.actions.run_shell(
        outputs = [out],
        command = "echo doge > %s" % (out.path)
    )
    return [DefaultInfo(files = depset([out]))]


_hello = rule(
    implementation = hello_impl,
    attrs = {
        "depss": attr.string()
    }
)

def hello(
    name, 
    depss = "123"):
    _hello(
        name = name,
        depss = depss
    )

###################################################

def _verilator_compile_impl(ctx):
    v_file = ctx.attr.v_file.files.to_list()[1]
    harness_file = ctx.file.harness_file
    out_dir = ctx.actions.declare_directory("src/obj_dir")
    harness_file_clone = ctx.actions.declare_file("src/" + harness_file.basename)
    v_file_clone = ctx.actions.declare_file("src/" + v_file.basename)
    vcd_file = ctx.actions.declare_file("src/wave.vcd") # define in harness.cpp

    ctx.actions.run_shell(
        inputs = [v_file, harness_file],
        outputs = [harness_file_clone, v_file_clone],
        command = "cp %s %s && cp %s %s" % (harness_file.path, harness_file_clone.path, v_file.path, v_file_clone.path),
        progress_message = "cp harness.cpp"
    )
    args = ctx.actions.args()

    ctx.actions.run_shell(
        inputs = [v_file_clone, harness_file_clone],
        outputs = [out_dir, vcd_file],
        command = "cd %s/.. && verilator --cc %s --trace --exe %s  --build && ./obj_dir/V%s" % (out_dir.path, v_file_clone.basename, harness_file_clone.basename, v_file_clone.basename[:-2]),
        progress_message = "Compiling .v with .cpp",
        use_default_shell_env = True 
    )

    return [DefaultInfo(files = depset([out_dir, vcd_file]))]

_verilator_compile = rule(
    implementation = _verilator_compile_impl,
    attrs = {
        "v_file": attr.label(),
        "harness_file": attr.label(allow_single_file=True)
    }
)

###################################################

def verilator_test(
    name,
    module_name,
    module_code,
    deps,
    srcs,
    visibility = None
    ):
    _chisel_verilog_scala_source(
        name = name + "_emit_verilog_scala",
        module_code = module_code,
    )
    scala_binary(
        name = name + "_emit_verilog_binary",
        main_class = "cpu.BazelRunner",
        srcs = [
            "%s_emit_verilog_scala" % name,
        ],
        deps = deps + _chisel_deps,
        plugins = _chisel_plugins,
        visibility = ["//visibility:private"],
    )
    _chisel_verilog_run_generator(
        name = name + "_files",
        visibility = visibility,
        tool = name + "_emit_verilog_binary",
        module_name = module_name,
    )

    _verilator_compile(
        name = name,
        v_file = name + "_files",
        harness_file = srcs[0]
    )

# def chisel_verilator_test(
#         name,
#         module_name,
#         module_code,
#         deps,
#         srcs,
#         trace = False,
#         cpp_deps = []
#         ):

#     print("my name is " + name)
#     chisel_verilog(
#         name = name + "_v",
#         deps = deps,
#         module_name = module_name,
#         module_code = module_code,
#     )
#     verilator_cc_library(
#         name = name + "_verilator",
#         module = name + "_v",
#         # vopts = [],
#         trace = trace,
#     )

#     _hello(
#         name = name + "_hello",
#         depss = name + "_v"
#     )
    
#     # print(">?>>>>")
#     # native.cc_binary(
#     #     name = name + "_verilator_bin",
#     #     srcs = srcs,
#     #     deps = [name + "_verilator"],
#     # )

#     # native.cc_test(
#     #     name = name,
#     #     deps = [
#     #         name + ".verilator",
#     #         # "@catch2//:catch2",
#     #         # "//config:catch_main",
#     #         # "//config:testbench",
#     #     ] + cpp_deps,
#     #     srcs = srcs,
#     #     # This needs to be linkstatic since libverilator is statically linked in the verilated code
#     #     linkstatic = 1,
#     #     local_defines = ["CHISEL_VERILATOR_TEST_TRACE"] if trace else [],
#     # )

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
    "-P:chiselplugin:useBundlePlugin",
]

def chisel_library(name, srcs, deps = [], resources = [], visibility = None):
    scala_library(
        name = name,
        srcs = srcs,
        deps = _chisel_deps + deps,
        plugins = _chisel_plugins,
        scalacopts = _scalacopts,
        resources = resources,
        visibility = visibility,
    )

def chisel_treadle_test(name, srcs, trace = False, deps = []):
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
        substitutions = {
            "{MODULECODE}": ctx.attr.module_code,
            "{CONFIGNAME}": ctx.attr.config_name,
            "{MODE}": ctx.attr.mode,
        },
    )
    return [DefaultInfo(files = depset([out]))]

_chisel_verilog_scala_source = rule(
    implementation = _chisel_verilog_scala_source_impl,
    attrs = {
        "module_code": attr.string(mandatory = True),
        "config_name": attr.string(mandatory = True),
        "_template": attr.label(
            allow_single_file = True,
            default = "//cpu:src/test/scala/cpu/BazelRunner.scala",
        ),
        "mode": attr.string(mandatory = True),
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
        visibility = None):
    _chisel_verilog_scala_source(
        name = name + "_emit_verilog_scala",
        module_code = module_code,
        config_name = "DefaultConfig",
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
        command = "echo doge > %s" % (out.path),
    )
    return [DefaultInfo(files = depset([out]))]

_hello = rule(
    implementation = hello_impl,
    attrs = {
        "depss": attr.string(),
    },
)

def hello(
        name,
        depss = "123"):
    _hello(
        name = name,
        depss = depss,
    )

###################################################

def _verilator_compile_impl(ctx):
    v_dir = ctx.attr.v_file.files.to_list()[0]
    module_name = ctx.attr.v_file.files.to_list()[1].basename[:-2]

    harness_file = ctx.file.harness_file
    harness_file_clone = ctx.actions.declare_file(harness_file.basename)

    inst_file = ctx.files.inst_file
    inst_file_clone = [ctx.actions.declare_file(f.basename) for f in inst_file]

    vcd_file = ctx.actions.declare_file("%s_wave.vcd" % module_name)  # define in harness.cpp
    obj_dir = ctx.actions.declare_directory("obj_dir")

    ctx.actions.run_shell(
        inputs = [v_dir, harness_file] + inst_file,
        outputs = [harness_file_clone] + inst_file_clone,
        command = "cp %s %s && cp %s/* %s" % (harness_file.path, harness_file_clone.path, inst_file[0].dirname, vcd_file.dirname),
        progress_message = "cp harness.cpp",
    )
    args = ctx.actions.args()

    ctx.actions.run_shell(
        inputs = [v_dir, harness_file_clone] + inst_file_clone,
        outputs = [vcd_file, obj_dir],
        command = "ls -la && verilator --cc %s/*.v --trace --exe %s  --build --Mdir %s && cd %s/../ && ./obj_dir/V%s" % (v_dir.path, harness_file_clone.basename, obj_dir.path, obj_dir.path, module_name),
        progress_message = "Compiling .v with .cpp",
        use_default_shell_env = True,
    )

    return [DefaultInfo(files = depset([vcd_file]))]

_verilator_compile = rule(
    implementation = _verilator_compile_impl,
    attrs = {
        "v_file": attr.label(),
        "harness_file": attr.label(allow_single_file = True),
        "inst_file": attr.label_list(allow_files = True),
        "module_name": attr.string(mandatory = True),
    },
)

###################################################
def _difftest_compile_impl(ctx):
    simtop = ctx.attr.SimTop.files.to_list()[1]
    difftest_dir_clone = ctx.actions.declare_directory("difftest")
    build_dir = ctx.actions.declare_directory("build")
    root = "/SSD/sqw/prj/yay/cpu-rv64"
    print(">>>>>>>> root is", root)

    cmd = ""
    if ctx.attr.mode == "SimTop":
        cmd = "echo $PWD && tree && source ~/.zshrc" + \
              "&& cp %s %s" % (simtop.path, build_dir.path) + \
              "&& cp -r %s %s" % (root + "/dependency/difftest/src", difftest_dir_clone.path) + \
              "&& cp -r %s %s" % (root + "/dependency/difftest/config", difftest_dir_clone.path) + \
              "&& cp %s %s" % (root + "/dependency/difftest/Makefile", difftest_dir_clone.path) + \
              "&& cp %s %s" % (root + "/dependency/difftest/verilator.mk", difftest_dir_clone.path) + \
              "&& cp %s %s" % (root + "/dependency/difftest/vcs.mk", difftest_dir_clone.path) + \
              "&& cd %s" % (difftest_dir_clone.path) + \
              "&& make emu EMU_TRACE=1"
    elif ctx.attr.mode == "DRAM3Sim":
        cmd = "echo $PWD && tree && source ~/.zshrc" + \
              "&& cp %s %s" % (simtop.path, build_dir.path) + \
              "&& cp %s %s" % (root + "/dependency/vsrc/SimTop_wrap.v", build_dir.path + "/SimTop.v") + \
              "&& cp %s %s" % (root + "/dependency/vsrc/S011HD1P_X32Y2D128_BW.v", build_dir.path + "/S011HD1P_X32Y2D128_BW.v") + \
              "&& cp -r %s %s" % (root + "/dependency/difftest/src", difftest_dir_clone.path) + \
              "&& cp -r %s %s" % (root + "/dependency/difftest/config", difftest_dir_clone.path) + \
              "&& cp %s %s" % (root + "/dependency/difftest/Makefile", difftest_dir_clone.path) + \
              "&& cp %s %s" % (root + "/dependency/difftest/verilator.mk", difftest_dir_clone.path) + \
              "&& cp %s %s" % (root + "/dependency/difftest/vcs.mk", difftest_dir_clone.path) + \
              "&& cd %s" % (difftest_dir_clone.path) + \
              "&& make emu EMU_TRACE=1 WITH_DRAMSIM3=1"

    ctx.actions.run_shell(
        inputs = [simtop],
        outputs = [build_dir, difftest_dir_clone],
        command = cmd,
        progress_message = "Compiling .v with .cpp",
        use_default_shell_env = True,
    )
    return DefaultInfo(files = depset([difftest_dir_clone]))

_difftest_compile = rule(
    implementation = _difftest_compile_impl,
    attrs = {
        "SimTop": attr.label(),
        "EMU_VFILES": attr.label_list(allow_files = True),
        "EMU_CXXFILES": attr.label_list(allow_files = True),
        "mode": attr.string(mandatory = True),
    },
)

###################################################

def verilator_test(
        name,
        module_name,
        module_code,
        deps,
        srcs,
        inst_file = [],
        visibility = None):
    _chisel_verilog_scala_source(
        name = name + "_emit_verilog_scala",
        module_code = module_code,
        config_name = "DefaultConfig",
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
        harness_file = srcs[0],
        inst_file = inst_file,
        module_name = module_name,
    )

###################################################

def difftest(
        name,
        module_name,
        module_code,
        deps,
        srcs,
        mode,
        inst_file = [],
        config_name = "DefaultConfig",
        visibility = None):
    _chisel_verilog_scala_source(
        name = name + "_emit_verilog_scala",
        module_code = module_code,
        config_name = config_name,
        mode = mode,
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
    _difftest_compile(
        name = name,
        SimTop = name + "_files",
        mode = mode,
    )

def getVerilog(
        name,
        module_name,
        module_code,
        deps,
        srcs,
        mode,
        inst_file = [],
        config_name = "FPGAConfig",
        visibility = None):
    _chisel_verilog_scala_source(
        name = name + "_emit_verilog_scala",
        module_code = module_code,
        config_name = config_name,
        mode = mode,
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

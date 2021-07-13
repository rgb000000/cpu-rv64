# WORKSPACE

workspace(name="cpu-rv64")

full_scala_version = "2.12.13"

short_scala_version = "2.12"

chisel_version = "3.4.3"

chiseltest_version = "0.3.3"

treadle_version = "1.3.1"

diagrammer_version = "1.3.1"


load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

#######################################################################
skylib_version = "1.0.3"
http_archive(
    name = "bazel_skylib",
    sha256 = "1c531376ac7e5a180e0237938a2536de0c54d93f5c278634818e0efc952dd56c",
    type = "tar.gz",
    url = "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/{}/bazel-skylib-{}.tar.gz".format(skylib_version, skylib_version),
)
########################################################################
rules_scala_version = "5df8033f752be64fbe2cedfd1bdbad56e2033b15"
http_archive(
    name = "io_bazel_rules_scala",
    sha256 = "b7fa29db72408a972e6b6685d1bc17465b3108b620cb56d9b1700cf6f70f624a",
    strip_prefix = "rules_scala-%s" % rules_scala_version,
    type = "zip",
    url = "https://github.com/bazelbuild/rules_scala/archive/%s.zip" % rules_scala_version,
)
########################################################################
RULES_JVM_EXTERNAL_TAG = "4.0"
RULES_JVM_EXTERNAL_SHA = "31701ad93dbfe544d597dbe62c9a1fdd76d81d8a9150c2bf1ecf928ecdf97169"
http_archive(
    name = "rules_jvm_external",
    strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
    sha256 = RULES_JVM_EXTERNAL_SHA,
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_TAG,
)
load("@rules_jvm_external//:defs.bzl", "maven_install")
########################################################################
http_archive(
    name = "rules_verilator",
    strip_prefix = "rules_verilator-0.1-rc4",
    sha256 = "c0d7a13f586336ab12ea60cbfca226b660a39c6e8235ac1099e39dd2ace3166f",                                                                                                                                                       
    url = "https://github.com/kkiningh/rules_verilator/archive/v0.1-rc4.zip",
)

load(
    "@rules_verilator//verilator:repositories.bzl",
    "rules_verilator_dependencies",
    "rules_verilator_toolchains",
)

rules_verilator_dependencies()
rules_verilator_toolchains()

# Register toolchain dependencies
load("@rules_m4//m4:m4.bzl", "m4_register_toolchains")
m4_register_toolchains()

load("@rules_flex//flex:flex.bzl", "flex_register_toolchains")
flex_register_toolchains()

load("@rules_bison//bison:bison.bzl", "bison_register_toolchains")
bison_register_toolchains()
########################################################################

# Stores Scala version and other configuration
# 2.12 is a default version, other versions can be use by passing them explicitly:
# scala_config(scala_version = "2.11.12")
load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")
scala_config(scala_version=full_scala_version)

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
scala_repositories()
#register_toolchains("//config:the_scala_toolchain")

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
scala_register_toolchains()

# optional: setup ScalaTest toolchain and dependencies
load("@io_bazel_rules_scala//testing:scalatest.bzl", "scalatest_repositories", "scalatest_toolchain")
scalatest_repositories()
scalatest_toolchain()


# Run `bazel run @unpinned_maven//:pin` every time this changes
maven_install(
    artifacts = [
        "edu.berkeley.cs:chisel3_%s:%s" % (short_scala_version, chisel_version),
        "edu.berkeley.cs:treadle_%s:%s" % (short_scala_version, treadle_version),
        "edu.berkeley.cs:firrtl-diagrammer_%s:%s" % (short_scala_version, diagrammer_version),
        "edu.berkeley.cs:chiseltest_%s:%s" % (short_scala_version, chiseltest_version),

        # Compiler plugins
        "edu.berkeley.cs:chisel3-plugin_%s:%s" % (full_scala_version, chisel_version),
        "org.scalamacros:paradise_%s:2.1.1" % full_scala_version,
    ],
    fetch_sources = True,
    maven_install_json = "//:maven_install.json",
    override_targets = {
        "org.scala-lang.scala-library": "@io_bazel_rules_scala_scala_library//:io_bazel_rules_scala_scala_library",
        "org.scala-lang.scala-reflect": "@io_bazel_rules_scala_scala_reflect//:io_bazel_rules_scala_scala_reflect",
        "org.scala-lang.scala-compiler": "@io_bazel_rules_scala_scala_compiler//:io_bazel_rules_scala_scala_compiler",
        # "org.scala-lang.modules.scala-parser-combinators_%s" % short_scala_version: "@io_bazel_rules_scala_scala_parser_combinators//:io_bazel_rules_scala_scala_parser_combinators",
        # "org.scala-lang.modules.scala-xml_%s" % short_scala_version: "@io_bazel_rules_scala_scala_xml//:io_bazel_rules_scala_scala_xml",
    },
    repositories = [
        "https://repo1.maven.org/maven2",
    ],
)




# # chisel3
# maven_install(
#     artifacts = [
#         "edu.berkeley.cs:chisel3_2.12:3.4.3",
#         "edu.berkeley.cs:chisel3-plugin_2.12.10:3.4.3",
#         "org.scalamacros:paradise_2.12.10:2.1.1",
#         "edu.berkeley.cs:chiseltest_2.12:0.3.3",
#         "edu.berkeley.cs:treadle_2.12:1.3.3",
#     ],
#     fetch_sources = True,
#     maven_install_json = "//:maven_install.json",
# 
#     override_targets = {
#         "org.scala-lang.scala-library": "@io_bazel_rules_scala_scala_library//:io_bazel_rules_scala_scala_library",
#         "org.scala-lang.scala-reflect": "@io_bazel_rules_scala_scala_reflect//:io_bazel_rules_scala_scala_reflect",
#         "org.scala-lang.scala-compiler": "@io_bazel_rules_scala_scala_compiler//:io_bazel_rules_scala_scala_compiler",
#     },
# 
#     repositories = [
#         # Private repositories are supported through HTTP Basic auth
#         # "http://username:password@localhost:8081/artifactory/my-repository",
#         # "https://maven.google.com",
#         "https://repo1.maven.org/maven2",
#     ],
# )

load("@maven//:defs.bzl", "pinned_maven_install")
pinned_maven_install()

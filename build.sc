// import Mill dependency
import mill._
import mill.define.Sources
import mill.modules.Util
import mill.scalalib.TestModule.ScalaTest
import scalalib._
// support BSP
import mill.bsp._

trait CommonModule extends ScalaModule {
  override def scalaVersion = "2.12.10"

  override def scalacOptions = Seq("-Xsource:2.11")

  private val macroParadise = ivy"org.scalamacros:::paradise:2.1.0"

  override def compileIvyDeps = Agg(macroParadise)

  override def scalacPluginIvyDeps = Agg(macroParadise)
}

val chisel = Agg(
  ivy"edu.berkeley.cs::chisel3:3.4.3"
)

object `api-config-chipsalliance` extends CommonModule {
  override def millSourcePath = os.pwd / "dependency" / "api-config-chipsalliance" / "design" / "craft"
}

object hardfloat extends SbtModule with CommonModule {
  override def millSourcePath = os.pwd / "dependency" / "berkeley-hardfloat"
  override def ivyDeps = super.ivyDeps() ++ chisel
}

object `rocket-chip` extends SbtModule with CommonModule {

  override def ivyDeps = super.ivyDeps() ++ Agg(
    ivy"${scalaOrganization()}:scala-reflect:${scalaVersion()}",
    ivy"org.json4s::json4s-jackson:3.6.1"
  ) ++ chisel

  object macros extends SbtModule with CommonModule

  override def moduleDeps = super.moduleDeps ++ Seq(
    `api-config-chipsalliance`, macros, hardfloat
  )

}

object `cpu-rv64` extends SbtModule with CommonModule { m =>
  override def millSourcePath = os.pwd

  override def forkArgs = Seq("-Xmx64G")

  override def ivyDeps = super.ivyDeps() ++ chisel

  override def moduleDeps = super.moduleDeps ++ Seq(
    `rocket-chip`
  )

  override def scalacPluginIvyDeps = Agg(
    ivy"edu.berkeley.cs:::chisel3-plugin:3.4.3",
    ivy"org.scalamacros:::paradise:2.1.1"
  )

  object test extends Tests with ScalaTest {
    override def ivyDeps = m.ivyDeps() ++ Agg(
      ivy"edu.berkeley.cs::chiseltest:0.3.3"
    )
  }
}

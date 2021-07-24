package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._


class InnerCrossBar(val n: Int)(implicit p: Parameters) extends Module{
  val io = IO(new Bundle{
    val in = Flipped(Vec(n, new CacheMemIO))

    val out = new CacheMemIO
  })

  val arbiter = Module(new Arbiter(chiselTypeOf(io.in.head.req.bits), n))

  // req
  (arbiter.io.in, io.in.map(_.req)).zipped.foreach((arb, in) => {
    arb <> in
  })

  // resp
  io.in.map(_.resp).zipWithIndex.foreach( info => {
    val (resp, i) = info
    resp.bits := io.out.resp.bits
    resp.valid := io.out.resp.valid & (io.out.resp.bits.id === i.U)
  })

}

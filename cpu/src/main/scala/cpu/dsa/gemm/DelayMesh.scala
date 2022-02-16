package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class DelayMeshIO[T<:Data](inType: T, outType: T, accType: T)(implicit p: Parameters) extends Bundle{
  val row = p(MeshRow)
  val col = p(MeshCol)

  val a_in = Flipped(Decoupled(Vec(row, Vec(p(TileRow), inType))))
  val b_in = Flipped(Decoupled(Vec(col, Vec(p(TileCol), outType))))
  val d_in = Flipped(Decoupled(Vec(col, Vec(p(TileCol), outType))))

  val req = Flipped(Decoupled(new Bundle {
    val ctrl = Vec(col, Vec(p(TileCol), new PEControl))
  }))

  val resp = Decoupled(new Bundle{
    val c_out = Vec(col, Vec(p(TileCol), outType))
  })

  override def cloneType = new DelayMeshIO(inType, outType, accType).asInstanceOf[this.type]
}

class DelayMesh[T<:Data:Arithmetic](inType: T, outType: T, accType: T)(implicit p: Parameters) extends Module with GEMMConstant {
  val row = p(MeshRow)
  val col = p(MeshCol)

  val io = IO(new DelayMeshIO(inType, outType, accType))

  val mesh_a_in    = Wire(Vec(row, Vec(p(TileRow), inType)))
  val mesh_b_in    = Wire(Vec(col, Vec(p(TileCol), outType)))
  val mesh_d_in    = Wire(Vec(col, Vec(p(TileCol), outType)))
  val mesh_ctrl_in = Wire(Vec(col, Vec(p(TileCol), new PEControl)))

  dontTouch(mesh_a_in)
  dontTouch(mesh_b_in)
  dontTouch(mesh_d_in)

  val a_buf = RegEnable(io.a_in.bits, 0.U.asTypeOf(io.a_in.bits), io.a_in.fire())
  val b_buf = RegEnable(io.b_in.bits, 0.U.asTypeOf(io.b_in.bits), io.b_in.fire())
  val d_buf = RegEnable(io.d_in.bits, 0.U.asTypeOf(io.d_in.bits), io.d_in.fire())

  val req_buf = RegEnable(io.req.bits, 0.U.asTypeOf(io.req.bits), io.req.fire())

  val mesh = Module(new Mesh(inType, outType, accType))

  io.req.ready := 1.U
  io.resp.valid := req_buf.ctrl.head.head.mode === M_PRELOAD
  io.a_in.ready := req_buf.ctrl.head.head.mode === M_RUN
  io.b_in.ready := req_buf.ctrl.head.head.mode === M_RUN
  io.d_in.ready := req_buf.ctrl.head.head.mode === M_PRELOAD


  mesh.io.a_in := mesh_a_in
  mesh.io.b_in := mesh_b_in
  mesh.io.d_in := mesh_d_in
  mesh.io.ctrl_in := mesh_ctrl_in

  io.resp.bits.c_out := mesh.io.c_out

  // delay a_in
  for(r <- 0 until row){
    mesh_a_in(r) := SRn(a_buf(r), r)
  }

  // delay b_in
  for(c <- 0 until col){
    mesh_b_in(c) := SRn(b_buf(c), c)
  }

  // d needn't to delay
  for(c <- 0 until col){
    mesh_d_in(c) := SRn(d_buf(c), 0)
  }

  // ctrl needn't to delay
  for(c <- 0 until col){
    (mesh_ctrl_in, req_buf.ctrl).zipped.foreach{
      case (mesh_in, io_in) =>
        mesh_in := SRn(io_in, 0)
    }
  }
}

package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class MEM (implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val dcache = Flipped(new CacheCPUIO)

    val ld_type = Input(UInt(3.W))
    val st_type = Input(UInt(2.W))

    val s_data = Input(UInt(p(XLen).W))
    val alu_res = Input(UInt(p(XLen).W))

    val l_data = Output(Valid(UInt(p(XLen).W)))
    val s_complete = Output(Bool())

    val stall = Input(Bool())
    val inst_valid = Input(Bool())
  })

  import Control._

  // generate req
  when((io.ld_type =/= 0.U)){
    // is load inst
    // such as: x[rd] = sext(M[x[rs1] + sext(offset)][7:0])
    io.dcache.req.valid := 1.U & io.inst_valid
    io.dcache.req.bits.addr := io.alu_res
    io.dcache.req.bits.mask := MuxLookup(io.ld_type, 0.U, Array(
      LD_LD  -> ("b1111_1111".U),
      LD_LW  -> ("b0000_1111".U << io.alu_res(2,0).asUInt()), // <<0 or << 4
      LD_LH  -> ("b0000_0011".U << io.alu_res(2,0).asUInt()), // <<0, 2, 4, 6
      LD_LB  -> ("b0000_0001".U << io.alu_res(2,0).asUInt()), // <<0, 1, 2, 3 ... 7
      LD_LWU -> ("b0000_1111".U << io.alu_res(2,0).asUInt()), // <<0 or << 4
      LD_LHU -> ("b0000_0011".U << io.alu_res(2,0).asUInt()), // <<0, 2, 4, 6
      LD_LBU -> ("b0000_0001".U << io.alu_res(2,0).asUInt()), // <<0, 1, 2, 3 ... 7
    ))
    io.dcache.req.bits.op := 0.U   // read
    io.dcache.req.bits.data := 0.U // useless when load
  }.elsewhen((io.st_type =/= 0.U)){
    // is store inst
    // such as: M[x[rs1]+sext(offset)] = x[rs2][7:0]
    io.dcache.req.valid := 1.U & io.inst_valid
    io.dcache.req.bits.addr := io.alu_res
    io.dcache.req.bits.mask := MuxLookup(io.st_type, 0.U, Array(
      ST_SD  -> ("b1111_1111".U),
      ST_SW  -> ("b0000_1111".U << io.alu_res(2,0).asUInt()), // <<0 or << 4
      ST_SH  -> ("b0000_0011".U << io.alu_res(2,0).asUInt()), // <<0, 2, 4, 6
      ST_SB  -> ("b0000_0001".U << io.alu_res(2,0).asUInt()), // <<0, 1, 2, 3 ... 7
    ))
    io.dcache.req.bits.op := 1.U   // write
    io.dcache.req.bits.data := io.s_data << (io.alu_res(2,0) << 3.U).asUInt() // useless when load
  }.otherwise{
    // not a mem inst
    io.dcache.req.valid := 0.U
    io.dcache.req.bits.addr := 0.U
    io.dcache.req.bits.mask := 0.U
    io.dcache.req.bits.op := 0.U
    io.dcache.req.bits.data := 0.U
  }

  // get reps
  when(io.dcache.resp.fire() & (io.dcache.resp.bits.cmd =/= 0.U) & io.ld_type.orR()){
    io.l_data.bits := (io.dcache.resp.bits.data) // >> io.alu_res(2,0).asUInt()
    io.l_data.bits := MuxLookup(io.ld_type, 0.S(p(XLen).W), Seq(
      Control.LD_LD  -> io.dcache.resp.bits.data(63, 0).asSInt(),
      Control.LD_LW  -> io.dcache.resp.bits.data(31, 0).asSInt(),
      Control.LD_LH  -> io.dcache.resp.bits.data(15, 0).asSInt(),
      Control.LD_LB  -> io.dcache.resp.bits.data( 7, 0).asSInt(),
      Control.LD_LWU -> io.dcache.resp.bits.data(31, 0).zext(),
      Control.LD_LHU -> io.dcache.resp.bits.data(15, 0).zext(),
      Control.LD_LBU -> io.dcache.resp.bits.data( 7, 0).zext(),
    )).asUInt()
    io.l_data.valid := 1.U
  }.otherwise{
    io.l_data.bits := 0.U
    io.l_data.valid := 0.U
  }

//  io.s_complete := Mux((io.dcache.resp.fire() & (io.dcache.resp.bits.cmd =/= 0.U)) & !io.stall & io.st_type.orR(), 1.U, 0.U)
  io.s_complete := Mux((io.dcache.resp.fire() & (io.dcache.resp.bits.cmd =/= 0.U)) & io.st_type.orR(), 1.U, 0.U)
  dontTouch(io.s_complete)
}

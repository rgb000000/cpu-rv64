package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import chisel3.util.experimental.BoringUtils

class MEM (implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val dcache = Flipped(new CacheCPUIO)

    val ld_type = Input(UInt(3.W))
    val st_type = Input(UInt(3.W))

    val s_data = Input(UInt(p(XLen).W))
    val alu_res = Input(UInt(p(XLen).W))

    val l_data = Output(Valid(UInt(p(XLen).W)))
    val s_complete = Output(Bool())

    val stall = Input(Bool())
    val inst_valid = Input(Bool())
  })

  import Control._

  // handle cacahe read conflict_bank
  val dcache_ready_reg = RegNext(io.dcache.req.valid & !io.dcache.req.ready, false.B)

  val ld_type = RegInit(0.asUInt(3.W))
  val st_type = RegInit(0.asUInt(3.W))

  // generate req
  when(io.ld_type =/= 0.U){
    // is load inst
    // such as: x[rd] = sext(M[x[rs1] + sext(offset)][7:0])
    io.dcache.req.valid := ((1.U & io.inst_valid) | dcache_ready_reg) & !io.stall
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
    ld_type := Mux(!io.stall, io.ld_type, ld_type)
  }.elsewhen(io.st_type =/= 0.U){
    // is store inst
    // such as: M[x[rs1]+sext(offset)] = x[rs2][7:0]
    io.dcache.req.valid := 1.U & io.inst_valid & !io.stall
    io.dcache.req.bits.addr := io.alu_res
    io.dcache.req.bits.mask := MuxLookup(io.st_type, 0.U, Array(
      ST_SD  -> ("b1111_1111".U),
      ST_SW  -> ("b0000_1111".U << io.alu_res(2,0).asUInt()), // <<0 or << 4
      ST_SH  -> ("b0000_0011".U << io.alu_res(2,0).asUInt()), // <<0, 2, 4, 6
      ST_SB  -> ("b0000_0001".U << io.alu_res(2,0).asUInt()), // <<0, 1, 2, 3 ... 7
    ))
    io.dcache.req.bits.op := 1.U   // write
    io.dcache.req.bits.data := io.s_data << (io.alu_res(2,0) << 3.U).asUInt() // useless when load
    st_type := Mux(!io.stall, io.st_type, st_type)
  }.otherwise{
    // not a mem inst
    io.dcache.req.valid := 0.U
    io.dcache.req.bits.addr := 0.U
    io.dcache.req.bits.mask := 0.U
    io.dcache.req.bits.op := 0.U
    io.dcache.req.bits.data := 0.U
  }

  // get reps

  val stall_data_valid = io.dcache.resp.fire() & (io.dcache.resp.bits.cmd === 2.U) & io.stall
  val stall_data_valid_posedge = stall_data_valid & !RegNext(stall_data_valid, false.B)

  val l_data = RegEnable(io.l_data.bits,        0.U,     stall_data_valid_posedge)
  val l_data_valid = RegEnable(io.l_data.valid, false.B, stall_data_valid_posedge)

  val stall_negedge = !io.stall & RegNext(io.stall, false.B)
  when(stall_negedge){
    io.l_data.bits := l_data
    io.l_data.valid := l_data_valid
  }.otherwise{
    when(io.dcache.resp.fire() & (io.dcache.resp.bits.cmd === 2.U)){
      io.l_data.bits := (io.dcache.resp.bits.data) // >> io.alu_res(2,0).asUInt()
      io.l_data.bits := MuxLookup(ld_type, 0.S(p(XLen).W), Seq(
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
  }
  // reso cmd : 1 write cache resp     2 read cache resp
//  io.s_complete := Mux((io.dcache.resp.fire() & (io.dcache.resp.bits.cmd =/= 0.U)) & !io.stall & io.st_type.orR(), 1.U, 0.U)
  io.s_complete := Mux((io.dcache.resp.fire() & (io.dcache.resp.bits.cmd === 1.U)), 1.U, 0.U)
  dontTouch(io.s_complete)

  if(p(Difftest)){
    val cycleCnt = WireInit(0.asUInt(64.W))
    BoringUtils.addSink(cycleCnt, "cycleCnt")
//    when(io.dcache.req.fire() & (io.dcache.req.bits.op === 1.U)){
//      when(io.dcache.req.bits.addr === BitPat("b0000_0000_0000_0000_0000_0000_0000_0000_1000_0000_0000_0000_1000_1110_1000_????")){
//        printf("addr: %x, data: %x, sd_type: %x, time: %d \n", io.dcache.req.bits.addr, io.dcache.req.bits.data, io.st_type, cycleCnt)
//      }
//    }
//
//    when(io.dcache.req.fire() & (io.dcache.req.bits.op === 0.U)){
//      printf("addr: %x, data: %x, ld_type: %x \n", io.dcache.req.bits.addr, 0.U, io.ld_type)
//    }

    BoringUtils.addSource(io.dcache.req.bits.mask, "dcache_mask")
    BoringUtils.addSource(io.dcache.req.bits.data, "dcache_data")
    BoringUtils.addSource(io.dcache.req.bits.addr, "dcache_address")
    BoringUtils.addSource(io.dcache.req.bits.op, "dcache_op")
  }
}

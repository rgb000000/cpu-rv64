package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import chisel3.util.experimental.BoringUtils

class CLINT(implicit p: Parameters) extends Module{
  // (0x02000000L, 0x0000ffffL, false,   0), // CLINT
  val addrs = p(CLINTRegs)
  val mtime_addr = addrs("mtime").U
  val mtimecmp_addr = addrs("mtimecmp").U

  val soft_int_addr = addrs("soft_int").U
  val external_int_addr = addrs("external_int").U

  val uc_start_addr = addrs("uc_start").U
  val uc_range_addr = addrs("uc_range").U
  val branch_on_addr = addrs("branch_on").U

  val io = IO(new Bundle{
    val cpu = Flipped(new CacheMemIO())
    val interrupt = Output(Bool())
  })

  dontTouch(io.interrupt)

  val mtime = RegInit(1.U(64.W))
  val mtimecmp = RegInit(2.U(64.W))

  val soft_int = RegInit(false.B)
  val external_int = RegInit(false.B)
  val external_in = WireInit(false.B)
  BoringUtils.addSink(external_in, "external_in")
  external_int := external_in

  val uc_start = RegInit(0.U(64.W))
  val uc_range = RegInit(0.U(64.W))
  val branch_on = RegInit(true.B)

  BoringUtils.addSource(soft_int, "soft_int")
  BoringUtils.addSource(external_int, "external_int")
  BoringUtils.addSource(uc_start, "uc_start")
  BoringUtils.addSource(uc_range, "uc_range")
  BoringUtils.addSource(branch_on, "branch_on")

  val s_idle :: s_w :: s_resp :: Nil = Enum(3)
  val state = RegInit(s_idle)

  val op = RegInit(false.B) // 0: read     1: write
  val id = RegInit(0.U(p(IDBits).W))
  val addr = RegInit(0.U(64.W))

  val sel_data = Wire(UInt(64.W))
  sel_data := MuxLookup(addr, 0x7fffffff.U, Array(
    mtime_addr    -> mtime,
    mtimecmp_addr -> mtimecmp,

    soft_int_addr -> soft_int,
    external_int_addr -> external_int,

    uc_start_addr -> uc_start,
    uc_range_addr -> uc_range,
    branch_on_addr-> branch_on
  ))

  io.cpu.req.ready := state =/= s_resp

  io.cpu.resp.valid := state === s_resp
  io.cpu.resp.bits.id := id
  io.cpu.resp.bits.data := 0.U
  io.cpu.resp.bits.cmd :=  Mux(op === 1.U, 1.U, MemCmdConst.ReadLast)

  io.interrupt := RegNext(mtime >= mtimecmp, 0.U)

  mtime := mtime + 1.U

  when((state === s_idle) & io.cpu.req.fire()) {
    op := (io.cpu.req.bits.cmd) === MemCmdConst.WriteOnce
    id := io.cpu.req.bits.id
    addr := io.cpu.req.bits.addr
  }.elsewhen((state === s_w) & io.cpu.req.fire()){
    when(io.cpu.req.bits.addr === mtime_addr){
      mtime := io.cpu.req.bits.data
    }.elsewhen(io.cpu.req.bits.addr === mtimecmp_addr){
      mtimecmp := io.cpu.req.bits.data
    }.elsewhen(io.cpu.req.bits.addr === soft_int_addr){
      soft_int := io.cpu.req.bits.data(0)
    }.elsewhen(io.cpu.req.bits.addr === external_int_addr){
      external_int := false.B
    }.elsewhen(io.cpu.req.bits.addr === uc_start_addr){
      uc_start := io.cpu.req.bits.data
    }.elsewhen(io.cpu.req.bits.addr === uc_range_addr){
      uc_range := io.cpu.req.bits.data
    }.elsewhen(io.cpu.req.bits.addr === branch_on_addr){
      branch_on := io.cpu.req.bits.data(0)
    }
  }.elsewhen((state === s_resp)){
    when(op === 1.U){
      io.cpu.resp.bits.data := 0.U
    }.otherwise{
      io.cpu.resp.bits.data := sel_data
    }
  }

  switch(state){
    is(s_idle){
      when(io.cpu.req.fire() & (io.cpu.req.bits.cmd === MemCmdConst.WriteOnce)){
        state := s_w
      }.elsewhen(io.cpu.req.fire() & (io.cpu.req.bits.cmd === MemCmdConst.ReadOnce)){
        state := s_resp
      }
    }
    is(s_w){
      when(io.cpu.req.fire()){
        state := s_resp
      }
    }
    is(s_resp){
      when(io.cpu.resp.fire()){
        state := s_idle
      }
    }
  }
}

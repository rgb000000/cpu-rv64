package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class ExCtrl(val depth: Int, val w: Int, val nbank: Int) extends Bundle {
  val a_addr = UInt(log2Ceil(depth * nbank).W)
  val b_addr = UInt(log2Ceil(depth * nbank).W)
  val d_addr = UInt(log2Ceil(depth * nbank).W)
  val c_addr = UInt(log2Ceil(depth * nbank).W)
}

class ExIO(val depth: Int, val w: Int, val nbank: Int)(implicit val p: Parameters) extends Bundle {
  val toSPad = Flipped(new ScratchPadIO(depth, w, nbank))
  val ctrl = Flipped(Decoupled(new ExCtrl(depth, w, nbank)))
}

class Ex(val depth: Int, val w: Int, val nbank: Int)(implicit val p: Parameters) extends Module {
  val io = IO(new ExIO(depth, w, nbank))

  val core = Module(new DelayMesh(UInt(8.W), UInt(8.W), UInt(8.W)))

  // c = a*b + d
  // 先加载c进入pe阵列reg中，然后加载b让其经过转置，然后再加载a同时开始计算，等计算完成就读出c  todo: 在读出c的同时能不能同时加载下一轮的d?
  val s_idle :: s_load_d :: s_load_b :: s_load_a :: s_store_c :: Nil = Enum(5)
  val state = RegInit(s_idle)

  val OP_TIMES = p(MeshRow) * p(TileRow)
  require(OP_TIMES == 16)
  val cnt = Counter(OP_TIMES)

  val read_cnt_meet = io.toSPad.resp.fire() & (cnt.value === (OP_TIMES - 1).U)
  val write_cnt_meet = io.toSPad.req.fire() & (io.toSPad.req.bits.op === 1.U) & (cnt.value === (OP_TIMES - 1).U)

  val addrs = RegInit(0.U.asTypeOf(io.ctrl.bits))

  // fsm
  switch(state){
    is(s_idle){
      state := Mux(io.ctrl.fire(), s_load_d, state)
    }

    is(s_load_d){
      state := Mux(read_cnt_meet, s_load_b, state)
    }

    is(s_load_b){
      state := Mux(read_cnt_meet, s_load_a, state)
    }

    is(s_load_a){
      state := Mux(read_cnt_meet, s_store_c, state)
    }

    is(s_store_c){
      state := Mux(write_cnt_meet, s_idle, state)
    }
  }

  // addrs
  when(state === s_idle){
    when(io.ctrl.fire()){
      addrs := io.ctrl.bits
    }
  }
  io.ctrl.ready := state === s_idle

  // cnt
  when((state === s_load_d) | (state === s_load_b) | (state === s_load_a)){
    when(io.toSPad.resp.fire()){
      cnt.inc()
    }
  }.elsewhen(state === s_store_c){
    when(io.toSPad.req.fire()){
      cnt.inc()
    }
  }

  // toSpad
  io.toSPad.req.valid := (state === s_load_d) | (state === s_load_b) | (state === s_load_a) | ((state === s_store_c) & core.io.resp.fire())
  io.toSPad.req.bits.op := Mux(state === s_store_c, 1.U, 0.U)
  io.toSPad.req.bits.mask := (-1).S.asUInt()
  io.toSPad.req.bits.id := 1.U
  io.toSPad.req.bits.data := Mux(state === s_store_c, core.io.resp.bits.c_out.asUInt(), 0.U)
  io.toSPad.req.bits.addr := MuxLookup(state, 0.U, Seq(
    s_load_d -> addrs.d_addr,
    s_load_b -> addrs.b_addr,
    s_load_a -> addrs.a_addr,
    s_store_c -> addrs.c_addr
  ))

  io.toSPad.resp.ready := (state === s_load_d) | (state === s_load_b) | (state === s_load_a)

  // mesh
  core.io.req.valid := (state === s_load_d) | (state === s_load_b) | (state === s_load_a) | (state === s_store_c)
  core.io.req.bits.ctrl.foreach(_.foreach(_.dataflow := 0.U))
  core.io.req.bits.ctrl.foreach(_.foreach(_.mode := MuxLookup(state, 0.U, Seq(
    s_load_d -> 1.U,
    s_load_b -> 0.U,  // 加载b的时候mesh要停止什么也不做
    s_load_a -> 2.U,  // 当加载a的时候b已经经过transposer了，可以直接开始计算了
    s_store_c -> 3.U
  ))))

  core.io.a_in.valid := (state === s_load_a) & io.toSPad.resp.fire()
  core.io.a_in.bits := io.toSPad.resp.bits.data.asTypeOf(core.io.a_in.bits)

  core.io.b_in.valid := (state === s_load_b) & io.toSPad.resp.fire()
  core.io.b_in.bits := io.toSPad.resp.bits.data.asTypeOf(core.io.b_in.bits)

  core.io.d_in.valid := (state === s_load_d) & io.toSPad.resp.fire()
  core.io.d_in.bits := io.toSPad.resp.bits.data.asTypeOf(core.io.d_in.bits)

  core.io.resp.ready := state === s_store_c
}

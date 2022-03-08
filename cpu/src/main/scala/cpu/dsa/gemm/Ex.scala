package cpu.dsa.gemm

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class ExCtrl(val depth: Int, val w: Int, val nbank: Int) extends Bundle {
  val cmd = Flipped(Decoupled(new Bundle {
    val a_addr = UInt(log2Ceil(depth * nbank).W)
    val b_addr = UInt(log2Ceil(depth * nbank).W)
    val d_addr = UInt(log2Ceil(depth * nbank).W)
    val c_addr = UInt(log2Ceil(depth * nbank).W)
  }))
  val done = Output(Bool())
}

class ExIO(val depth: Int, val w: Int, val nbank: Int)(implicit val p: Parameters) extends Bundle {
  val toSPad = Flipped(new ScratchPadIO(depth, w, nbank))
  val ctrl = new ExCtrl(depth, w, nbank)
}

class Ex(val depth: Int, val w: Int, val nbank: Int)(implicit val p: Parameters) extends Module {
  val io = IO(new ExIO(depth, w, nbank))

  val core = Module(new DelayMesh(UInt(8.W), UInt(8.W), UInt(8.W)))
  val transpose = Module(new Transpose(UInt(8.W)))

  // c = a*b + d
  // 先加载c进入pe阵列reg中，然后加载b让其经过转置，然后再加载a同时开始计算，等计算完成就读出c  todo: 在读出c的同时能不能同时加载下一轮的d?
//  val s_idle :: s_load_d :: s_load_b :: s_wait_a :: s_load_a :: s_wait_run :: s_store_c :: s_done :: Nil = Enum(8)
  val s_idle :: s_load_DA :: s_wait_B :: s_load_B :: s_wait_run :: s_store_C :: s_done :: Nil = Enum(7)
  val state = RegInit(s_idle)

  val OP_TIMES = p(MeshRow) * p(TileRow)
  require(OP_TIMES == 16)
  val read_cnt = Counter(OP_TIMES)
  val req_cnt = Counter(OP_TIMES*2) // use to close req
  val run_cnt = Counter(OP_TIMES) // use to stop mesh run

  val read_cnt_meet = io.toSPad.resp.fire() & (read_cnt.value === (OP_TIMES - 1).U)
  val write_cnt_meet = io.toSPad.req.fire() & (io.toSPad.req.bits.op === 1.U) & (req_cnt.value === (OP_TIMES - 1).U)
  val req_cnt_meet = req_cnt.value === OP_TIMES.U
  val run_cnt_meet = run_cnt.value === (p(MeshRow)*2).U

  val addrs = RegInit(0.U.asTypeOf(io.ctrl.cmd.bits))

  // fsm
  switch(state){
    is(s_idle){
      state := Mux(io.ctrl.cmd.fire(), s_load_DA, state)
    }

    is(s_load_DA){
      state := Mux(read_cnt_meet, s_wait_B, state)
    }

    is(s_wait_B){
      state := Mux(io.toSPad.resp.valid, s_load_B, state)
    }

    is(s_load_B){
      state := Mux(read_cnt_meet, s_wait_run, state)
    }

    is(s_wait_run){
      state := Mux(run_cnt_meet, s_store_C, state)
    }

    is(s_store_C){
      state := Mux(write_cnt_meet, s_done, state)
    }

    is(s_done){
      state := s_idle
    }
  }

  // run_cnt
  when(run_cnt_meet){
    run_cnt.value := 0.U
  }.elsewhen(state === s_wait_run){
    run_cnt.inc()
  }

  // req_cnt, only for read
  when(read_cnt_meet | write_cnt_meet){
    req_cnt.value := 0.U
  }.elsewhen(io.toSPad.req.fire()){
    when(req_cnt.value =/= OP_TIMES.U){
      req_cnt.inc()
    }
  }

  // cnt
  when((state === s_load_DA) | (state === s_load_B)){
    when(io.toSPad.resp.fire()){
      read_cnt.inc()
    }
  }

  // addrs
  when(state === s_idle){
    when(io.ctrl.cmd.fire()){
      addrs := io.ctrl.cmd.bits
    }
  }

  io.ctrl.cmd.ready := state === s_idle
  io.ctrl.done := state === s_done


  // toSpad
  io.toSPad.req.valid := (((state === s_load_DA) | (state === s_load_B) | (state === s_wait_B)) & !req_cnt_meet) | ((state === s_store_C) & core.io.resp.fire())
  io.toSPad.req.bits.op := Mux(state === s_store_C, 1.U, 0.U)
  io.toSPad.req.bits.mask := "hffff".U
  io.toSPad.req.bits.id := 1.U
  io.toSPad.req.bits.data := Mux(state === s_store_C, core.io.resp.bits.c_out.asUInt(), 0.U)
  io.toSPad.req.bits.isTwins := Mux(state === s_load_DA, true.B, false.B)
  io.toSPad.req.bits.addr := MuxLookup(state, 0.U, Seq(
    s_load_DA -> (addrs.d_addr + 0xf.U),  // d order is reverse
    s_wait_B -> addrs.b_addr,
    s_load_B -> addrs.b_addr,
    s_wait_run -> addrs.b_addr,
    s_store_C -> (addrs.c_addr + 0xf.U)   // c order is reverse
  )) + Mux((state =/= s_store_C) & (state =/= s_load_DA), req_cnt.value, (1 << io.toSPad.req.bits.addr.getWidth).U - req_cnt.value)

  io.toSPad.resp.ready := (state === s_load_DA) | ((state === s_load_B) & core.io.a_in.ready)

  // mesh
  // 这里要有个要求，需要数据是连续的的来，但凡中间差一个cycle都会导致数据传输错误，所以需要保证Spad能在固定延迟返回数据，一旦流起来就不能中断，所以mesh对spad的优先级要高于dma
  core.io.req.valid := (state === s_load_DA) | (state === s_wait_B) | (state === s_load_B) | (state === s_store_C)
  core.io.req.bits.ctrl.foreach(_.foreach(_.dataflow := 0.U))
  core.io.req.bits.ctrl.foreach(_.foreach(_.mode := MuxLookup(state, 0.U, Seq(
    s_load_DA -> 1.U,
    s_wait_B -> 0.U,
    s_load_B -> 2.U,  // 当加载b的时候a已经经过transposer了，可以直接开始计算了
    s_wait_run -> 2.U,  // 当加载b的时候a已经经过transposer了，可以直接开始计算了
    s_store_C -> 3.U
  ))))

  // b data
  core.io.b_in.valid := ((state === s_load_B) | (state === s_wait_run)) & io.toSPad.resp.fire()
  core.io.b_in.bits := io.toSPad.resp.bits.data.asTypeOf(core.io.b_in.bits)

  // a data2
  transpose.io.in.valid := (state === s_load_DA) & io.toSPad.resp.fire()
  transpose.io.in.bits := io.toSPad.resp.bits.data2.asTypeOf(transpose.io.in.bits)
  transpose.io.out.ready := core.io.a_in.ready
  core.io.a_in.valid := transpose.io.out.valid
  core.io.a_in.bits := transpose.io.out.bits.asTypeOf(core.io.a_in.bits)

  // d
  core.io.d_in.valid := (state === s_load_DA) & io.toSPad.resp.fire()
  core.io.d_in.bits := io.toSPad.resp.bits.data.asTypeOf(core.io.d_in.bits)

  // c
  core.io.resp.ready := state === s_store_C
}

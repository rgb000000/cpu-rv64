package cpu

import chipsalliance.rocketchip.config._
import chisel3._
import chisel3.util._
import chisel3.util.experimental.{BoringUtils, loadMemoryFromFileInline}

class BrInfo(implicit p: Parameters) extends Bundle {
  val isHit = Bool()
  val isTaken = Bool()
  val cur_pc = UInt(p(XLen).W)
}

class IF (implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val out = Valid(new Bundle{
      val pc = UInt(p(XLen).W)
      val inst = UInt(32.W)

      val pTaken = Bool()
      val pPC = UInt(p(XLen).W)
    })

    val pc_alu = Input(UInt(p(XLen).W))
    val pc_epc = Input(UInt(p(XLen).W))
    val pc_sel = Input(UInt(2.W))
    val br_info = Flipped(Valid(new BrInfo))

    val pc_except_entry = Flipped(Valid(UInt(p(XLen).W)))

    val stall = Input(Bool())
    val kill = Input(Bool())

    val icache = Flipped(new CacheCPUIO)

    val fence_i_done = Input(Bool())
    val fence_pc = Input(UInt(32.W))
    val fence_i_do = Input(Bool())
  })

  val btb = Module(new BTB)

  val cur_pc = RegInit(p(PCStart).asUInt(p(XLen).W) - 4.U)
  val inst = RegInit(BitPat.bitPatToUInt(ISA.nop))

//  val pc_next = Mux(io.stall, cur_pc, Mux(io.pc_sel === Control.PC_ALU, io.pc_alu, MuxLookup(io.pc_sel, 0.U, Array(
//    Control.PC_0   -> (cur_pc),
//    Control.PC_4   -> Mux(io.br_taken, io.pc_alu, cur_pc + 4.U),
//    Control.PC_ALU -> (io.pc_alu),
//    Control.PC_EPC -> (io.pc_epc)
//  ))))

  val branch_on = WireInit(0.U)
  BoringUtils.addSink(branch_on, "branch_on")

  // query
  btb.io.query.pc.bits := io.out.bits.pc
  btb.io.query.pc.valid := io.out.valid
  val pnpc = btb.io.query.res.bits.tgt
  val pTaken  = Mux(btb.io.query.res.bits.is_miss, 0.U, btb.io.query.res.bits.pTaken) & branch_on

  val pc_next = Mux(io.stall, cur_pc,
                  Mux(io.pc_except_entry.valid, io.pc_except_entry.bits,
                    Mux(io.br_info.fire() & (!io.br_info.bits.isHit), Mux(io.br_info.bits.isTaken, io.pc_alu, io.br_info.bits.cur_pc + 4.U),
                      Mux(io.br_info.fire() & io.br_info.bits.isHit, Mux((pTaken === 1.U) & btb.io.query.res.fire(), pnpc, cur_pc + 4.U), //预测正确之后就不需要跳转到pc_alu去执行了
                        Mux(io.fence_i_done, RegEnable(io.fence_pc, 0.U, io.fence_i_do) + 4.U,
                          Mux((pTaken === 1.U) & btb.io.query.res.fire(), pnpc, MuxLookup(io.pc_sel, 0.U, Array(
                            Control.PC_0   -> (cur_pc),
                            Control.PC_4   -> (cur_pc + 4.U),
                            Control.PC_ALU -> (io.pc_alu),
                            Control.PC_EPC -> (io.pc_epc)
                  ))))))))

  // always read instructions from icache
  io.icache.req.valid := !io.stall
  io.icache.req.bits.op := 0.U // must read
  io.icache.req.bits.addr := pc_next // Mux(io.pc_sel === Control.PC_ALU, io.pc_alu, pc)// pc is addr
  io.icache.req.bits.mask := Mux(io.icache.req.bits.addr(2) === 1.U, "b1111_0000".U, "b0000_1111".U)  // need 32 bit instructions
  io.icache.req.bits.data := 0.U // nerver use because op is read

//  dontTouch(pc_next)
//  dontTouch(io.out)

//  pc := Mux(io.icache.req.fire(), pc_next, pc)
  cur_pc := Mux(io.icache.req.fire(), io.icache.req.bits.addr, Mux(io.icache.req.valid & !io.icache.req.ready & !io.stall, pc_next - 4.U, cur_pc))
  inst := Mux(io.icache.resp.fire() & (io.icache.resp.bits.cmd =/= 0.U), io.icache.resp.bits.data(31, 0), inst)
//  dontTouch(inst)

  val stall_negedge = (!io.stall) & RegNext(io.stall, false.B)
  val is_valid_when_stall = RegInit(0.U)
  when(io.stall & io.out.valid){
    is_valid_when_stall := 1.U
  }.elsewhen(stall_negedge){
    is_valid_when_stall := 0.U
  }

  // update
  btb.io.update.valid := io.br_info.fire()
  btb.io.update.bits.pc := io.br_info.bits.cur_pc
  btb.io.update.bits.tgt := Mux(io.br_info.bits.isTaken, io.pc_alu, io.br_info.bits.cur_pc + 4.U)
  btb.io.update.bits.isTaken := io.br_info.bits.isTaken

  io.out.bits.inst := Mux(io.icache.resp.fire() & (io.icache.resp.bits.cmd =/= 0.U), io.icache.resp.bits.data, inst)
  io.out.bits.pc := cur_pc
  io.out.bits.pTaken := pTaken
  io.out.bits.pPC := Mux(btb.io.query.res.bits.is_miss, 0.U, btb.io.query.res.bits.tgt)
  io.out.valid := Mux(io.kill, 0.U, io.icache.resp.fire() & (io.icache.resp.bits.cmd =/= 0.U)) | (is_valid_when_stall & stall_negedge)

//  dontTouch(io.icache)
}

class OOOIF (implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val out = Vec(2, Valid(new Bundle{
      val pc = UInt(p(XLen).W)
      val inst = UInt(32.W)

      val pTaken = Bool()
      val pPC = UInt(p(XLen).W)
    }))

    val pc_alu = Input(UInt(p(XLen).W))
    val pc_epc = Input(UInt(p(XLen).W))
    val pc_sel = Input(UInt(2.W))
    val br_info = Flipped(Valid(new BrInfo))

    val pc_except_entry = Flipped(Valid(UInt(p(XLen).W)))

    val stall = Input(Bool())
    val kill = Input(Bool())

    val icache = Flipped(new CacheCPUIO)

    val fence_i_done = Input(Bool())
    val fence_pc = Input(UInt(32.W))
    val fence_i_do = Input(Bool())
  })

  val btb = Vec(2, Module(new BTB)) // 0 for low, 1 for high

  val cur_pc = RegInit(p(PCStart).asUInt(p(XLen).W) - 8.U)
  val inst = RegInit(VecInit(Seq.fill(2)(BitPat.bitPatToUInt(ISA.nop))))

  //  val pc_next = Mux(io.stall, cur_pc, Mux(io.pc_sel === Control.PC_ALU, io.pc_alu, MuxLookup(io.pc_sel, 0.U, Array(
  //    Control.PC_0   -> (cur_pc),
  //    Control.PC_4   -> Mux(io.br_taken, io.pc_alu, cur_pc + 4.U),
  //    Control.PC_ALU -> (io.pc_alu),
  //    Control.PC_EPC -> (io.pc_epc)
  //  ))))

  val branch_on = WireInit(0.U)
  BoringUtils.addSink(branch_on, "branch_on")

  val inst_valid = Vec(2, Bool())
  inst_valid(0) := pc_next(2) === 0.U
  inst_valid(1) := true.B

  // query
  val pnpc = Vec(2, UInt(p(AddresWidth).W))
  val pTaken = Vec(2, Bool())
  for(i <- 0 until 2){
    btb(i).io.query.pc.bits  := io.out(i).bits.pc
    btb(i).io.query.pc.valid := io.out(i).valid & inst_valid(i)

    pnpc(i) := btb(i).io.query.res.bits.tgt
    pTaken(i) := Mux(btb(i).io.query.res.bits.is_miss, 0.U, btb(i).io.query.res.bits.pTaken) & branch_on
  }

  val pnpc_f = Wire(UInt(p(AddresWidth).W))
  val pTaken_f = Wire(Bool())
  val cancel_inst_1 = Wire(Bool())

  when(btb(0).io.query.res.fire() & pTaken(0)){
    // inst_0 Taken! need cancel inst_1
    pnpc_f := btb(0).io.query.res.bits.tgt
    pTaken_f := pTaken(0)
    cancel_inst_1 := true.B
  }.elsewhen(btb(1).io.query.res.fire() & pTaken(1)){
    // inst_0 not Taken, inst_1 Taken
    pnpc_f := btb(1).io.query.res.bits.tgt
    pTaken_f := pTaken(1)
    cancel_inst_1 := false.B
  }.otherwise{
    // inst_0 and inst_1 all not Taken
    pnpc_f := 0.U
    pTaken_f := false.B
    cancel_inst_1 := false.B
  }

  def get_next_pc(pc: UInt) = {
    Mux(pc(2), pc + 4.U, pc + 8.U)
  }

  val pc_next = Mux(io.stall, cur_pc,
    Mux(io.pc_except_entry.valid, io.pc_except_entry.bits,
      Mux(io.br_info.fire() & (!io.br_info.bits.isHit), Mux(io.br_info.bits.isTaken, io.pc_alu, io.br_info.bits.cur_pc + 4.U),
        Mux(io.br_info.fire() & io.br_info.bits.isHit, Mux(pTaken_f, pnpc_f, get_next_pc(cur_pc)), //预测正确之后就不需要跳转到pc_alu去执行了
          Mux(io.fence_i_done, RegEnable(io.fence_pc, 0.U, io.fence_i_do) + 4.U,
            Mux(pTaken_f, pnpc_f, MuxLookup(io.pc_sel, 0.U, Array(
              Control.PC_0   -> (cur_pc),
              Control.PC_4   -> get_next_pc(cur_pc),
              Control.PC_ALU -> (io.pc_alu),
              Control.PC_EPC -> (io.pc_epc)
            ))))))))

  // always read instructions from icache
  io.icache.req.valid := !io.stall
  io.icache.req.bits.op := 0.U // must read
  io.icache.req.bits.addr := (pc_next >> 3.U) << 3.U // Mux(io.pc_sel === Control.PC_ALU, io.pc_alu, pc)// pc is addr
  io.icache.req.bits.mask := "b1111_1111".U // Mux(io.icache.req.bits.addr(2) === 1.U, "b1111_0000".U, "b0000_1111".U)  // need 32 bit instructions
  io.icache.req.bits.data := 0.U // nerver use because op is read

  //  dontTouch(pc_next)
  //  dontTouch(io.out)

  val inst_valid = Vec(2, Bool())
  inst_valid(0) := !pc_next(2)
  inst_valid(1) := true.B

  cur_pc := Mux(io.icache.req.fire(), io.icache.req.bits.addr, Mux(io.icache.req.valid & !io.icache.req.ready & !io.stall, pc_next - 4.U, cur_pc))
  inst := Mux(io.icache.resp.fire() & (io.icache.resp.bits.cmd =/= 0.U), io.icache.resp.bits.data(31, 0), inst)


  val stall_negedge = (!io.stall) & RegNext(io.stall, false.B)
  val is_valid_when_stall = RegInit(VecInit(Seq.fill(2)(false.B)))
  when(io.stall & io.out(0).valid){
    is_valid_when_stall(0) := 1.U
  }.elsewhen(stall_negedge){
    is_valid_when_stall(0) := 0.U
  }

  when(io.stall & io.out(1).valid){
    is_valid_when_stall(1) := 1.U
  }.elsewhen(stall_negedge){
    is_valid_when_stall(1) := 0.U
  }

  // update
  btb(0).io.update.valid := io.br_info.fire() & (io.br_info.bits.cur_pc(2) === 0.U)
  btb(0).io.update.bits.pc := io.br_info.bits.cur_pc
  btb(0).io.update.bits.tgt := Mux(io.br_info.bits.isTaken, io.pc_alu, io.br_info.bits.cur_pc + 4.U)
  btb(0).io.update.bits.isTaken := io.br_info.bits.isTaken

  btb(1).io.update.valid := io.br_info.fire() & (io.br_info.bits.cur_pc(2) === 1.U)
  btb(1).io.update.bits.pc := io.br_info.bits.cur_pc
  btb(1).io.update.bits.tgt := Mux(io.br_info.bits.isTaken, io.pc_alu, io.br_info.bits.cur_pc + 4.U)
  btb(1).io.update.bits.isTaken := io.br_info.bits.isTaken

  io.out(0).bits.pc := (cur_pc >> 3.U) << 3.U
  io.out(0).bits.inst := Mux(io.icache.resp.fire() & (io.icache.resp.bits.cmd =/= 0.U), io.icache.resp.bits.data(31, 0), inst(0))
  io.out(0).bits.pTaken := pTaken(0)
  io.out(0).bits.pPC := Mux(btb(0).io.query.res.bits.is_miss, 0.U, btb(0).io.query.res.bits.tgt)
  io.out(0).valid := Mux(io.kill, 0.U, io.icache.resp.fire() & (io.icache.resp.bits.cmd =/= 0.U)) | (is_valid_when_stall(0) & stall_negedge)

  io.out(1).bits.pc := io.out(0).bits.pc | "b100".U
  io.out(1).bits.inst := Mux(io.icache.resp.fire() & (io.icache.resp.bits.cmd =/= 0.U), io.icache.resp.bits.data(63, 32), inst(1))
  io.out(1).bits.pTaken := pTaken(1)
  io.out(1).bits.pPC := Mux(btb(0).io.query.res.bits.is_miss, 0.U, btb(0).io.query.res.bits.tgt)
  io.out(1).valid := Mux(io.kill, 0.U, io.icache.resp.fire() & (io.icache.resp.bits.cmd =/= 0.U)) | (is_valid_when_stall(1) & stall_negedge)

}

package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class ROBIO(implicit p: Parameters) extends Bundle {
  val in = new Bundle {
    val fromID = Vec(2, Flipped(Valid(new Bundle {
//      val stationIdx = UInt(4.W)
      val prdORaddr = UInt(p(AddresWidth).W)
      val needData = Bool()
      val isPrd = Bool()

      val wen = Bool()
      val st_type = UInt(3.W)
      val ld_type = UInt(3.W)
      val pc = UInt(p(AddresWidth).W)
      val inst = UInt(32.W)
      val isBr = Bool()
      val pTaken = Bool()
      val current_rename_state = Vec(64, Bool())
    })))
    val cdb = Vec(2, Flipped(Valid(new CDB)))
  }

  val read = Vec(2, Vec(2, new Bundle {
    val stationIdx = Flipped(Valid(UInt(4.W)))
    val data = Valid(UInt(p(XLen).W))
  }))

  val memRead = Flipped(new MemReadROBIO)

  val memCDB = Flipped(Valid(new MEMCDB))

  // commit to physice register and dcache
  val commit = new Bundle {
    val reg = Vec(2, Valid(new Bundle {
      val prn = UInt(6.W)
      val data = UInt(p(XLen).W)
      val wen = Bool()

      // from branch, difftest use
      val current_rename_state = Vec(64, Bool())
      val isHit = Bool()
//      val right_pc = UInt(p(AddresWidth).W)   // right_pc is the same as data

      // for difftest
      val pc = UInt(p(AddresWidth).W)
      val inst = UInt(32.W)
      val memAddress = UInt(p(AddresWidth).W)
      val isST = Bool()
      val isLD = Bool()
    }))
    val dcache = Flipped(new CacheCPUIO)

    // 这一轮提交的分支预测信息，只update一个分支信息
    val br_info = Valid(new Bundle{
      // to branch
      val current_rename_state = Vec(64, Bool())
      val isHit = Bool()
      val isTaken = Bool()
      val cur_pc = UInt(p(AddresWidth).W)
      val right_pc = UInt(p(AddresWidth).W)   // right_pc is the same as data
    })
  }
  val commit2rename = Vec(2, Valid(UInt(6.W)))
  val commit2station = Vec(2, Valid(new Bundle{
    // 如果wen为真就表示这个prn是prn而不是memAddress， station拿到这个信息更新他的表
    val prn = UInt(6.W)
    val wen = Bool()
  }))
}

class ROBInfo(implicit p: Parameters) extends Bundle {
  val stationIdx = UInt(4.W)

  val pc = UInt(p(AddresWidth).W)
  val inst = UInt(32.W)

  val prdORaddr = UInt(p(AddresWidth).W)
  val data = UInt(p(XLen).W)
  val needData = Bool()
  val isPrd = Bool()    //决定prdORaddr是prn还是memAddress
  val mask = UInt(8.W)
  val wen = Bool()
  val st_type = UInt(3.W)
  val ld_type = UInt(3.W)

  val brHit = Bool()
  val expt = Bool()

  val isBr = Bool()
  val pTaken = Bool()
  val current_rename_state = Vec(64, Bool())

  val state = UInt(2.W)
}

class ROB(implicit p: Parameters) extends Module {
  val io = IO(new ROBIO)

  val S_EMPTY    = 0.U(2.W)
  val S_WAITDATA = 1.U(2.W)
  val S_GETDATA  = 2.U(2.W)
  val S_COMMITED = 3.U(2.W)


  val rob = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new ROBInfo))))

  def write_rob(fromIDport: Int, idx: UInt) = {
    rob(idx).prdORaddr := io.in.fromID(fromIDport).bits.prdORaddr
    rob(idx).needData := io.in.fromID(fromIDport).bits.needData
    rob(idx).isPrd := io.in.fromID(fromIDport).bits.isPrd
    rob(idx).wen := io.in.fromID(fromIDport).bits.wen
    rob(idx).st_type := io.in.fromID(fromIDport).bits.st_type
    rob(idx).ld_type := io.in.fromID(fromIDport).bits.ld_type
    rob(idx).mask := "h00".U
    rob(idx).state := S_WAITDATA
    rob(idx).pc := io.in.fromID(fromIDport).bits.pc
    rob(idx).inst := io.in.fromID(fromIDport).bits.inst
    rob(idx).isBr := io.in.fromID(fromIDport).bits.isBr
    rob(idx).pTaken := io.in.fromID(fromIDport).bits.pTaken
    rob(idx).current_rename_state := io.in.fromID(fromIDport).bits.current_rename_state
  }

  // write rob
  val cnt = Counter(16)
  when(io.in.fromID(0).fire() & io.in.fromID(1).fire()) {
    // 0, 1
    cnt.value := cnt.value + 2.U
    write_rob(0, cnt.value)
    write_rob(1, cnt.value + 1.U)
  }.elsewhen(io.in.fromID(0).fire() & !io.in.fromID(1).fire()) {
    // 0
    cnt.value := cnt.value + 1.U
    write_rob(0, cnt.value)
  }.elsewhen((!io.in.fromID(0).fire()) & io.in.fromID(1).fire()) {
    // 1
    cnt.value := cnt.value + 1.U
    write_rob(1, cnt.value)
  }.otherwise {
    // none
  }

  // getData
  io.in.cdb.foreach(cdb => {
    when(cdb.fire()) {
      rob(cdb.bits.idx).state := S_GETDATA
      rob(cdb.bits.idx).data := cdb.bits.data

      rob(cdb.bits.idx).brHit := cdb.bits.brHit
      rob(cdb.bits.idx).expt := cdb.bits.expt
    }
  })

  // memCDB
  when(io.memCDB.fire()){
    rob(io.memCDB.bits.idx).state := S_GETDATA
    rob(io.memCDB.bits.idx).data := io.memCDB.bits.data
  }

  dontTouch(io.commit)
  def write_prfile(portIdx: Int, rob_info: ROBInfo, valid: Bool) = {
    io.commit.reg(portIdx).bits.prn := rob_info.prdORaddr
    io.commit.reg(portIdx).bits.data := rob_info.data
    io.commit.reg(portIdx).bits.wen := rob_info.wen
    io.commit.reg(portIdx).bits.pc := rob_info.pc
    io.commit.reg(portIdx).bits.inst := rob_info.inst
    io.commit.reg(portIdx).valid := valid
    io.commit.reg(portIdx).bits.current_rename_state := rob_info.current_rename_state
    io.commit.reg(portIdx).bits.isHit := rob_info.brHit

    io.commit.reg(portIdx).bits.memAddress := rob_info.prdORaddr
    io.commit.reg(portIdx).bits.isST := rob_info.st_type.orR()
    io.commit.reg(portIdx).bits.isLD := rob_info.ld_type.orR()

    io.commit2rename(portIdx).valid := rob_info.wen & rob_info.isPrd & valid
    io.commit2rename(portIdx).bits := rob_info.prdORaddr

    io.commit2station(portIdx).valid := valid
    io.commit2station(portIdx).bits.prn := rob_info.prdORaddr
    io.commit2station(portIdx).bits.wen := rob_info.wen & rob_info.isPrd
  }

  def write_dcache(rob_info: ROBInfo, valid: Bool, commitIdx: UInt) = {
    io.commit.dcache.req.valid := valid
    io.commit.dcache.req.bits.addr := rob_info.prdORaddr
    io.commit.dcache.req.bits.data := rob_info.data
    io.commit.dcache.req.bits.mask := rob_info.mask
    io.commit.dcache.req.bits.op := 1.U // must write
  }

  def commit2rename(portIdx: Int, prn: UInt, wen: Bool): Unit = {

  }

//  def br_info(current_state: Vec[Bool], isHit: Bool, pTaken: Bool, cur_pc: UInt, right_pc: UInt, valid: Bool): Unit ={
//    io.commit.br_info.valid := valid
//    io.commit.br_info.bits.current_rename_state := current_state
//    io.commit.br_info.bits.isHit := isHit
//    io.commit.br_info.bits.isTaken := Mux(isHit, pTaken, !pTaken)
//    io.commit.br_info.bits.cur_pc := cur_pc
//    io.commit.br_info.bits.right_pc := right_pc
//  }

  def out_br_info(isHit: Bool, info: ROBInfo): Unit ={
    io.commit.br_info.valid := info.isBr
    io.commit.br_info.bits.current_rename_state := info.current_rename_state
    io.commit.br_info.bits.isHit                := isHit
    io.commit.br_info.bits.isTaken              := Mux(isHit, info.pTaken, !info.pTaken)
    io.commit.br_info.bits.cur_pc               := info.pc
    io.commit.br_info.bits.right_pc             := info.data
  }

  // commit
  val commitIdx = Counter(16)
  when((rob(commitIdx.value).state === S_GETDATA) & (rob(commitIdx.value + 1.U).state === S_GETDATA)) {
    // two inst complete and wait to commit
    val a = rob(commitIdx.value)
    val b = rob(commitIdx.value + 1.U)
    when(rob(commitIdx.value).isPrd & rob(commitIdx.value + 1.U).isPrd) {
      // commit 2 prd inst
      when(a.brHit & b.brHit){
        // a, b 都跳转命中
        commitIdx.value := commitIdx.value + 2.U
        write_prfile(0, a, true.B)
        write_prfile(1, b, true.B)
        write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
        rob(commitIdx.value).state := S_COMMITED
        rob(commitIdx.value + 1.U).state := S_COMMITED

        out_br_info(true.B, a)
      }.elsewhen(a.brHit & !b.brHit){
        // a命中，b没命中,只提交a，也提交b，并且清空rob
        commitIdx.value := 0.U
        write_prfile(0, a, true.B)
        write_prfile(1, b, true.B)
        write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
        rob.foreach(x => {
          x.state := S_EMPTY
        })

        out_br_info(false.B, b)
      }.otherwise{
        // a只要没命中，无论b命中与否，只提交a，并且清空rob
        commitIdx.value := 0.U
        write_prfile(0, a, true.B)
        write_prfile(1, 0.U.asTypeOf(new ROBInfo), false.B)
        write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
        rob.foreach(x => {
          x.state := S_EMPTY
        })

        out_br_info(false.B, a)
      }
    }.elsewhen(rob(commitIdx.value).isPrd & !rob(commitIdx.value + 1.U).isPrd) {
      // commit 1 prd and 1 store, prd才会发生跳转命中或不命中，存储指令不会，因此只要判断prd的命中与否
      when(a.brHit){
        commitIdx.value := commitIdx.value + 2.U
        write_prfile(0, a, true.B)
        write_prfile(1, b, true.B)
        write_dcache(b, true.B, 1.U)
        rob(commitIdx.value).state := S_COMMITED
        rob(commitIdx.value + 1.U).state := S_COMMITED

        out_br_info(true.B, a)
      }.otherwise{
        // a没命中，虽然没命中也还是要提交a,清空rob
        commitIdx.value := 0.U
        write_prfile(0, a, true.B)
        write_prfile(1, 0.U.asTypeOf(new ROBInfo), false.B)
        write_dcache(rob(commitIdx.value + 1.U), false.B, 1.U)
        rob.foreach(x => {
          x.state := S_EMPTY
        })

        out_br_info(false.B,a)
      }
    }.elsewhen((!rob(commitIdx.value).isPrd) & rob(commitIdx.value + 1.U).isPrd) {
      // commit 1 store and prd
      when(b.brHit){
        commitIdx.value := commitIdx.value + 2.U
        write_prfile(0, a, true.B)
        write_prfile(1, b, true.B)
        write_dcache(rob(commitIdx.value), true.B, 0.U)
        rob(commitIdx.value).state := S_COMMITED
        rob(commitIdx.value + 1.U).state := S_COMMITED

        out_br_info(true.B, b)
      }.otherwise{
        // 提交a，虽然b没有hit但是也是要提交的,然后清空rob
        commitIdx.value := 0.U
        write_prfile(0, a, true.B)
        write_prfile(1, b, true.B)
        write_dcache(rob(commitIdx.value), true.B, 0.U)
        rob.foreach(x => {
          x.state := S_EMPTY
        })

        out_br_info(false.B, b)
      }
    }.otherwise {
      // 2 store inst, need commit one by one
      commitIdx.value := commitIdx.value + 1.U
      write_prfile(0, a, true.B)
      write_prfile(1, 0.U.asTypeOf(new ROBInfo), false.B)
      write_dcache(rob(commitIdx.value), true.B, 0.U)
      rob(commitIdx.value).state := S_COMMITED

      out_br_info(true.B, a)
    }
  }.elsewhen((rob(commitIdx.value).state === S_GETDATA) & (rob(commitIdx.value + 1.U).state =/= S_GETDATA)) {
    // one inst complete and want to commit
    val a = rob(commitIdx.value)
    when(rob(commitIdx.value).isPrd) {
      // a prd inst
      when(a.brHit){
        commitIdx.value := commitIdx.value + 1.U
        write_prfile(0, a, true.B)
        write_prfile(1, 0.U.asTypeOf(new ROBInfo), false.B)
        write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
        rob(commitIdx.value).state := S_COMMITED

        out_br_info(true.B, a)
      }.otherwise{
        commitIdx.value := 0.U
        write_prfile(0, a, true.B)
        write_prfile(1, 0.U.asTypeOf(new ROBInfo), false.B)
        write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
        rob.foreach(x => {
          x.state := S_EMPTY
        })

        out_br_info(false.B, a)
      }
    }.otherwise {
      // a store inst
      commitIdx.value := commitIdx.value + 1.U
      write_prfile(0, 0.U.asTypeOf(new ROBInfo), false.B)
      write_prfile(1, 0.U.asTypeOf(new ROBInfo), false.B)
      write_dcache(rob(commitIdx.value), true.B, 0.U)
      rob(commitIdx.value).state := S_COMMITED

      out_br_info(true.B, a)
    }
  }.otherwise {
    write_prfile(0, 0.U.asTypeOf(new ROBInfo), false.B)
    write_prfile(1, 0.U.asTypeOf(new ROBInfo), false.B)
    write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)

    out_br_info(true.B, 0.U.asTypeOf(new ROBInfo))
  }

  // station read rob in issue stage
  for (i <- 0 until 2) {
    for (j <- 0 until 2) {
      when(io.read(i)(j).stationIdx.fire()) {
        io.read(i)(j).data.bits := rob(io.read(i)(j).stationIdx.bits).data
        io.read(i)(j).data.valid := true.B
      }.otherwise{
        io.read(i)(j).data.bits := 0.U
        io.read(i)(j).data.valid := false.B
      }
    }
  }

  // memU can read rob when execute ld inst
  val memQueryResult = rob.map(x => {
    (x.prdORaddr === io.memRead.addr.bits) & !x.isPrd
  })
  val memQueryIdx = PriorityEncoder(memQueryResult)
  when(io.memRead.addr.fire()){
    io.memRead.data.bits := memQueryIdx
    io.memRead.data.valid := Cat(memQueryResult).orR()
  }.otherwise{
    io.memRead.data.bits := 0.U
    io.memRead.data.valid := false.B
  }

  dontTouch(io.in.cdb)
}

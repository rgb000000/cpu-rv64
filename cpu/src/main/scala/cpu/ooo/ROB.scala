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

      // for difftest
      val pc = UInt(p(AddresWidth).W)
      val inst = UInt(32.W)
      val memAddress = UInt(p(AddresWidth).W)
      val isST = Bool()
      val isLD = Bool()
    }))
    val dcache = Flipped(new CacheCPUIO)
  }
  val commit2rename = Vec(2, Valid(UInt(6.W)))
  val commit2station = Vec(2, Valid(UInt(6.W)))
}

class ROBInfo(implicit p: Parameters) extends Bundle {
  val stationIdx = UInt(4.W)

  val pc = UInt(p(AddresWidth).W)
  val inst = UInt(32.W)

  val prdORaddr = UInt(p(AddresWidth).W)
  val data = UInt(p(XLen).W)
  val needData = Bool()
  val isPrd = Bool()
  val mask = UInt(8.W)
  val wen = Bool()
  val st_type = UInt(3.W)
  val ld_type = UInt(3.W)

  val brHit = Bool()
  val expt = Bool()

  val state = UInt(2.W)
}

class ROB(implicit p: Parameters) extends Module {
  val io = IO(new ROBIO)

  val EMPTY    = 0.U(2.W)
  val WAITDATA = 1.U(2.W)
  val GETDATA  = 2.U(2.W)
  val COMMITED = 3.U(2.W)


  val rob = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new ROBInfo))))

  def write_rob(fromIDport: Int, idx: UInt) = {
    rob(idx).prdORaddr := io.in.fromID(fromIDport).bits.prdORaddr
    rob(idx).needData := io.in.fromID(fromIDport).bits.needData
    rob(idx).isPrd := io.in.fromID(fromIDport).bits.isPrd
    rob(idx).wen := io.in.fromID(fromIDport).bits.wen
    rob(idx).st_type := io.in.fromID(fromIDport).bits.st_type
    rob(idx).ld_type := io.in.fromID(fromIDport).bits.ld_type
    rob(idx).mask := "h00".U
    rob(idx).state := WAITDATA
    rob(idx).pc := io.in.fromID(fromIDport).bits.pc
    rob(idx).inst := io.in.fromID(fromIDport).bits.inst
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
      rob(cdb.bits.idx).state := GETDATA
      rob(cdb.bits.idx).data := cdb.bits.data
    }
  })

  // memCDB
  when(io.memCDB.fire()){
    rob(io.memCDB.bits.idx).state := GETDATA
    rob(io.memCDB.bits.idx).data := io.memCDB.bits.data
  }

  def write_prfile(portIdx: Int, rob_info: ROBInfo, valid: Bool) = {
    io.commit.reg(portIdx).bits.prn := rob_info.prdORaddr
    io.commit.reg(portIdx).bits.data := rob_info.data
    io.commit.reg(portIdx).bits.wen := rob_info.wen
    io.commit.reg(portIdx).bits.pc := rob_info.pc
    io.commit.reg(portIdx).bits.inst := rob_info.inst
    io.commit.reg(portIdx).valid := valid

    io.commit.reg(portIdx).bits.memAddress := rob_info.prdORaddr
    io.commit.reg(portIdx).bits.isST := rob_info.st_type.orR()
    io.commit.reg(portIdx).bits.isLD := rob_info.ld_type.orR()

    io.commit2rename(portIdx).valid := rob_info.wen & rob_info.isPrd
    io.commit2rename(portIdx).bits := rob_info.prdORaddr

    io.commit2station(portIdx).valid := rob_info.wen & rob_info.isPrd
    io.commit2station(portIdx).bits := rob_info.prdORaddr
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

  // commit
  val commitIdx = Counter(16)
  when((rob(commitIdx.value).state === GETDATA) & (rob(commitIdx.value + 1.U).state === GETDATA)) {
    // two inst complete and wait to commit
    when(rob(commitIdx.value).isPrd & rob(commitIdx.value + 1.U).isPrd) {
      // commit 2 prd inst
      commitIdx.value := commitIdx.value + 2.U
      write_prfile(0, rob(commitIdx.value), true.B)
      write_prfile(1, rob(commitIdx.value + 1.U), true.B)
      write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
      rob(commitIdx.value).state := COMMITED
      rob(commitIdx.value + 1.U).state := COMMITED
    }.elsewhen(rob(commitIdx.value).isPrd & !rob(commitIdx.value + 1.U).isPrd) {
      // commit 1 prd and 1 store
      commitIdx.value := commitIdx.value + 2.U
      write_prfile(0, rob(commitIdx.value), true.B)
      write_prfile(1, 0.U.asTypeOf(new ROBInfo), true.B)
      write_dcache(rob(commitIdx.value + 1.U), true.B, 1.U)
      rob(commitIdx.value).state := COMMITED
      rob(commitIdx.value + 1.U).state := COMMITED
    }.elsewhen((!rob(commitIdx.value).isPrd) & rob(commitIdx.value + 1.U).isPrd) {
      // commit 1 store and prd
      commitIdx.value := commitIdx.value + 2.U
      write_prfile(0, 0.U.asTypeOf(new ROBInfo), true.B)
      write_prfile(1, rob(commitIdx.value + 1.U), true.B)
      write_dcache(rob(commitIdx.value), true.B, 0.U)
      rob(commitIdx.value).state := COMMITED
      rob(commitIdx.value + 1.U).state := COMMITED
    }.otherwise {
      // 2 store inst, need commit one by one
      commitIdx.value := commitIdx.value + 1.U
      write_prfile(0, 0.U.asTypeOf(new ROBInfo), true.B)
      write_prfile(1, 0.U.asTypeOf(new ROBInfo), false.B)
      write_dcache(rob(commitIdx.value), true.B, 0.U)
      rob(commitIdx.value).state := COMMITED
    }
  }.elsewhen((rob(commitIdx.value).state === GETDATA) & (rob(commitIdx.value + 1.U).state =/= GETDATA)) {
    // one inst complete and want to commit
    when(rob(commitIdx.value).isPrd) {
      // a prd inst
      commitIdx.value := commitIdx.value + 1.U
      write_prfile(0, rob(commitIdx.value), true.B)
      write_prfile(1, 0.U.asTypeOf(new ROBInfo), false.B)
      write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
      rob(commitIdx.value).state := COMMITED
    }.otherwise {
      // a store inst
      commitIdx.value := commitIdx.value + 1.U
      write_prfile(0, 0.U.asTypeOf(new ROBInfo), false.B)
      write_prfile(1, 0.U.asTypeOf(new ROBInfo), false.B)
      write_dcache(rob(commitIdx.value), true.B, 0.U)
      rob(commitIdx.value).state := COMMITED
    }
  }.otherwise {
    write_prfile(0, 0.U.asTypeOf(new ROBInfo), false.B)
    write_prfile(1, 0.U.asTypeOf(new ROBInfo), false.B)
    write_dcache(0.U.asTypeOf(new ROBInfo), false.B, 0.U)
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


}

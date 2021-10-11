package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._

class ROBIO(implicit p: Parameters) extends Bundle {
  val in = new Bundle {
    val fromID = Vec(2, Flipped(Decoupled(new Bundle {
      val stationIdx = UInt(4.W)
      val prdORaddr = UInt(p(AddresWidth).W)
      val needData = Bool()
      val isPrd = Bool()
    })))
    val cdb = Vec(2, Flipped(Decoupled(new CDB)))
    val idxWantCommit = Input(Valid(Vec(2, UInt(4.W))))
  }

  val out = Vec(2, Valid(new Bundle {
    val prdORaddr = UInt(p(AddresWidth).W)
    val isPrd = Bool()
    val data = UInt(p(XLen).W)
  }))

  // commit to physice register and dcache
  val commit = new Bundle {
    val reg = Vec(2, new Bundle {
      val prn = UInt(6.W)
      val data = UInt(p(XLen).W)
      val wen = Bool()
    })
    val dcache = Flipped(new CacheCPUIO)
  }
  val commit2rename = Vec(2, Valid(UInt(6.W)))
}

class ROBInfo(implicit p: Parameters) extends Bundle {
  val stationIdx = UInt(4.W)

  val prdORaddr = UInt(p(AddresWidth).W)
  val data = UInt(p(XLen).W)
  val needData = Bool()
  val isPrd = Bool()
  val mask = UInt(8.W)
  val wen = Bool()

  val brHit = Bool()
  val expt = Bool()

  val state = UInt(2.W)
}

class ROB(implicit p: Parameters) extends Module {
  val io = IO(new ROBIO)

  val EMPTY = 0.U(2.W)
  val WAITDATA = 1.U(2.W)
  val GETDATA = 2.U(2.W)


  val rob = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new ROBInfo))))

  def write_rob(fromIDport: Int, idx: UInt, wen: Bool, mask: UInt) = {
    rob(cnt.value).prdORaddr := io.in.fromID(fromIDport).bits.prdORaddr
    rob(cnt.value).needData  := io.in.fromID(fromIDport).bits.needData
    rob(cnt.value).isPrd     := io.in.fromID(fromIDport).bits.isPrd
    rob(cnt.value).wen       := wen
    rob(cnt.value).mask      := mask
    rob(cnt.value).state     := WAITDATA
  }

  // write rob
  val cnt = Counter(16)
  when(io.in.fromID(0).fire() & io.in.fromID(1).fire()) {
    // 0, 1
    cnt.value := cnt.value + 2.U
    write_rob(0, cnt.value, true.B, "hff".U)
    write_rob(1, cnt.value + 1.U, true.B, "hff".U)
  }.elsewhen(io.in.fromID(0).fire() & !io.in.fromID(1).fire()){
    // 0
    cnt.value := cnt.value + 1.U
    write_rob(0, cnt.value, true.B, "hff".U)
  }.elsewhen((!io.in.fromID(0).fire()) & io.in.fromID(1).fire()){
    // 1
    cnt.value := cnt.value + 1.U
    write_rob(1, cnt.value, true.B, "hff".U)
  }.otherwise{
    // none
  }

  // getData
  io.in.cdb.foreach(cdb => {
    when(cdb.fire()) {
      rob(cdb.bits.idx).state := GETDATA
      rob(cdb.bits.idx).data := cdb.bits.data
    }
  })

  def write_prfile(portIdx: Int, rob_info: ROBInfo) = {
    io.commit.reg(portIdx).prn := rob_info.prdORaddr
    io.commit.reg(portIdx).data := rob_info.data
    io.commit.reg(portIdx).wen := rob_info.wen

    io.commit2rename(portIdx).valid := rob_info.wen & rob_info.isPrd
    io.commit2rename(portIdx).bits := rob_info.prdORaddr
  }

  def write_dcache(rob_info: ROBInfo) = {
    io.commit.dcache.req.valid := rob_info.wen
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
      write_prfile(0, rob(commitIdx.value))
      write_prfile(1, rob(commitIdx.value + 1.U))
      write_dcache(0.U.asTypeOf(new ROBInfo))
    }.elsewhen(rob(commitIdx.value).isPrd & !rob(commitIdx.value + 1.U).isPrd) {
      // commit 1 prd and 1 store
      commitIdx.value := commitIdx.value + 2.U
      write_prfile(0, rob(commitIdx.value))
      write_prfile(1, 0.U.asTypeOf(new ROBInfo))
      write_dcache(rob(commitIdx.value + 1.U))
    }.elsewhen((!rob(commitIdx.value).isPrd) & rob(commitIdx.value + 1.U).isPrd) {
      // commit 1 store and prd
      commitIdx.value := commitIdx.value + 2.U
      write_prfile(0, 0.U.asTypeOf(new ROBInfo))
      write_prfile(1, rob(commitIdx.value + 1.U))
      write_dcache(rob(commitIdx.value))
    }.elsewhen((!rob(commitIdx.value).isPrd) & (!rob(commitIdx.value + 1.U).isPrd)) {
      // 2 store inst, need commit one by one
      commitIdx.value := commitIdx.value + 1.U
      write_prfile(0, 0.U.asTypeOf(new ROBInfo))
      write_prfile(1, 0.U.asTypeOf(new ROBInfo))
      write_dcache(rob(commitIdx.value))
    }
  }.elsewhen((rob(commitIdx.value).state === GETDATA) & (rob(commitIdx.value + 1.U).state =/= GETDATA)) {
    // one inst complete and want to commit
    when(rob(commitIdx.value).isPrd) {
      // a prd inst
      write_prfile(0, rob(commitIdx.value))
      write_prfile(1, 0.U.asTypeOf(new ROBInfo))
      write_dcache(0.U.asTypeOf(new ROBInfo))
    }.otherwise {
      // a store inst
      write_prfile(0, 0.U.asTypeOf(new ROBInfo))
      write_prfile(1, 0.U.asTypeOf(new ROBInfo))
      write_dcache(rob(commitIdx.value))
    }
  }.otherwise {
    write_prfile(0, 0.U.asTypeOf(new ROBInfo))
    write_prfile(1, 0.U.asTypeOf(new ROBInfo))
    write_dcache(0.U.asTypeOf(new ROBInfo))
  }

}
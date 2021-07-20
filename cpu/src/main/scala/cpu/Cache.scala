package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import chisel3.util.random.LFSR

import chisel3.iotesters._

// define in bytes
case object I$Size extends Field[Int]
case object D$Size extends Field[Int]
case object L2$Size extends Field[Int]
case object CacheLineSize extends Field[Int]
case object NWay extends Field[Int]
case object NBank extends Field[Int]


class CacheReq(implicit p: Parameters) extends Bundle {
  //
  //    |--------- tag ---------|---index---|--offset--|
  //
  val addr = UInt(p(XLen).W)
  val data = UInt(p(XLen).W)
  val mask = UInt((p(XLen)/8).W)
  val op = UInt(1.W)  // 0: rd   1: wr
}

class CacheResp(implicit p: Parameters) extends Bundle{
  val data = UInt(p(XLen).W)
}

class MemReq(implicit p: Parameters) extends Bundle {
  //
  val addr = UInt(p(XLen).W)
  val data = UInt(p(CacheLineSize).W)
  val op = UInt(1.W)  // 0: rd   1: wr
}

class MemResp(implicit p: Parameters) extends Bundle{
  val data = UInt(p(CacheLineSize).W)
}

////////////////////  Way /////////////////////////

class Way(val tag_width: Int, val index_width: Int, offset_width: Int)(implicit p: Parameters) extends Module{

  class ret extends Bundle{
    val tag = UInt(tag_width.W)
    val v = UInt(1.W)
    val d = UInt(1.W)
    val datas = Vec(p(NBank), UInt((p(CacheLineSize) / p(NBank)).W))
  }

  val io = IO(new Bundle{
    val out = Valid(new ret)

    val in = Flipped(Valid(new Bundle{
      val index = UInt(index_width.W)
      val mask = UInt(((p(CacheLineSize) / p(NBank)) / 8).W)
      val offset = UInt(offset_width.W)
      val data = UInt(p(XLen).W)
      val op = UInt(1.W)
    }))
  })

  val tag_v = new Bundle{
    UInt(tag_width.W) // tag
    UInt(1.W)         // valid
  }
  val dirty = UInt(1.W)

  val depth = math.pow(2, index_width).toInt

  val tag_v_tab = SyncReadMem(depth, tag_v)
  val dirty_tab = SyncReadMem(depth, dirty)
  val bankn = List.fill(p(NBank))(SyncReadMem(depth, Vec((p(CacheLineSize) / p(NBank)) / 8, UInt(8.W))))

  val result = WireInit(new ret)
  // TODO: check data order
  //            tag,v,   d,    data
  result := Cat(List(tag_v_tab.read(io.in.bits.index, io.in.valid).asUInt()) ++ List(dirty_tab.read(io.in.bits.index, io.in.valid)) ++ bankn.map(_.read(io.in.bits.index, io.in.valid).asUInt())).asTypeOf(new ret)

  io.out.bits := io.out
  io.out.valid := RegNext(io.in.valid, 0.U)

  val bank_sel = WireInit(io.in.bits.offset(log2Ceil(p(XLen)) + log2Ceil(p(NBank)) - 1, log2Ceil(p(XLen))))
  val w_data = io.in.bits.data.asTypeOf( Vec(p(CacheLineSize) / p(NBank) / 8, UInt(8.W)) )
  when(io.in.fire()){
    // wr
    when(io.in.bits.op === 1.U){
      bankn.zipWithIndex.foreach((a) =>{
        val (bank, i) = a
        when(bank_sel === i.U){
          bank.write(io.in.bits.index, w_data, io.in.bits.mask.asBools())
        }
      })
    }
  }
}

////////////////////  Cache /////////////////////////

class Cache(implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val cpu = new Bundle{
      val req = Flipped(Valid(new CacheReq))
      val reps = Valid(new CacheResp)
    }

    val mem = new Bundle{
      val req = Decoupled(new MemReq)
      val reps = Flipped(Valid(new MemResp))
    }
  })
  val offset_width = log2Ceil(p(CacheLineSize))
  val index_width = log2Ceil(p(I$Size) / (p(NWay) * p(CacheLineSize)) )
  val tag_width = p(XLen) - offset_width - index_width

  val infos = new Bundle{
    val tag = UInt(tag_width.W)
    val index = UInt(index_width.W)
    val offset = UInt(offset_width.W)
  }

  val is_wr = WireInit(io.cpu.req.bits.op === 1.U)

  val ways = List.fill(p(NWay))( Module(new Way(tag_width, index_width, offset_width)) )

  // cache logic
  val idle::lookup::miss::replace::refill::Nil = Enum(5)
  val state = RegInit(idle)

  val req_reg = RegInit(0.U.asTypeOf(new CacheReq))
  val is_wr_reg = RegInit(0.U(1.W))
  val req_reg_info = req_reg.asTypeOf(infos)

  // NWay bits

  ways.foreach((way =>{
    way.io.in.bits.index := req_reg_info.index
    way.io.in.valid := io.cpu.req.valid
  }))

  val ways_compare_res = WireInit(Cat(ways.map((way)=>{
      (way.io.out.bits.tag === req_reg_info.tag) & (way.io.out.bits.v === 1.U)
    })))
  val is_miss = ways_compare_res.orR() === 0.U
  assert((p(CacheLineSize) / p(NBank)) == 64)

  // Vec(NWay, 64bit)                              tag      v   d      data
  val ways_ret_datas = Vec(p(NWay), Wire(UInt(( tag_width + 1 + 1 + p(CacheLineSize) ).W))) // must 64 bit
  ways_ret_datas.zip(ways).foreach(a => {
    val (datas, way) = a
    // TODO: datas format need to repaire
    datas := way.io.out.bits.datas(io.cpu.req.bits.addr(log2Ceil((p(CacheLineSize) / p(NBank)) / 8) + log2Ceil(p(NBank)), log2Ceil((p(CacheLineSize) / p(NBank)) / 8)).asUInt())
  })

  val select_data = Mux1H(for(i <- ways_compare_res.asBools().zipWithIndex) yield (i._1, ways_ret_datas(i._2.asUInt())))

  val rand_way = UIntToOH(LFSR(64)(log2Ceil(p(NWay))-1, 0).asUInt())
  val rand_way_data = Mux1H(for(i <- rand_way.asBools().zipWithIndex) yield (i._1, ways_ret_datas(i._2.asUInt())))

  // miss info
  val miss_info = RegInit(0.U.asTypeOf(new Bundle{
    val addr = UInt(p(XLen).W)
    val op = UInt(1.W)
    val data = UInt(p(XLen).W)
  }))


  val replace_buffer = RegInit(0.U.asTypeOf(new Bundle{
    val addr = UInt(p(XLen).W)
    val data = UInt(p(XLen).W)
    val way_num = UInt(p(NWay).W)
    val v = UInt(1.W)
    val d = UInt(1.W)
  }))

  io.mem.req.bits.addr := miss_info.addr
  io.mem.req.bits.op := miss_info.op
  io.mem.req.bits.data := miss_info.data

  // write buffer
  val write_buffer_valid = Wire(UInt(1.W))
  val write_buffer = RegInit(0.U.asTypeOf(new Bundle{
    val tag = UInt(tag_width.W)
    val index = UInt(index_width.W)
    val v = UInt(1.W)
    val d = UInt(1.W)
    val replace_way = UInt(p(NWay).W)
    val offset = UInt(offset_width.W)
    val wmask = Vec((p(CacheLineSize) / p(NBank)) / 8, UInt(1.W))
    val data = UInt(p(XLen).W)
  }))
  val w_idle :: w_write :: Nil = Enum(2)
  val w_state = RegInit(w_idle)



  switch(w_state){
    is(w_idle){
      when(write_buffer_valid === 1.U){
        w_state := w_write
      }.otherwise{
        w_state := w_state
      }
    }

    is(w_write){
      when(write_buffer_valid === 1.U){
        w_state := w_state
      }.otherwise{
        w_state := w_idle
      }
    }
  }

  when(w_state === w_write){

  }


  // write_buffer fsm END


  when(state === idle){
    when(io.cpu.req.fire()){
      req_reg := io.cpu.req.bits
      is_wr_reg := is_wr
    }
  }.elsewhen(state === lookup){
    when(!is_miss){
      when(!is_wr_reg){
        // hit, rd, resp to cpu
        io.cpu.reps.valid := 1.U
        io.cpu.reps.bits.data := Cat(req_reg.mask.asBools().zipWithIndex.map(x => {
          val (valid, i) = x
          val res = Mux(valid,select_data(8*(i+1)-1, 8*i).asUInt(), 0.U(8.W))
          res
        }))
      }.otherwise{
        // hit, wr, fill write_buffer
        write_buffer_valid := 1.U
        write_buffer.index := req_reg.addr(offset_width + index_width - 1, offset_width).asUInt()
        write_buffer.replace_way := ways_compare_res
        write_buffer.offset := req_reg.addr(offset_width - 1, 0).asUInt()
        write_buffer.wmask := req_reg.mask
        write_buffer.data := req_reg.data
      }
    }.otherwise{
      // miss info
      miss_info.addr := req_reg.addr
      miss_info.op := req_reg.op
      miss_info.data := req_reg.data

      // replace info
      replace_buffer.addr := req_reg.addr
      replace_buffer.data := rand_way_data
      replace_buffer.way_num := rand_way
      replace_buffer.v := 1.U
      replace_buffer.d := 1.U

    }
  }.elsewhen(state === miss){
    // send wr mem req to write replace_buffer
    when(io.mem.req.ready === 1.U){
      when(replace_buffer.d === 1.U){
        io.mem.req.valid := 1.U
        io.mem.req.bits.addr := replace_buffer.addr
        io.mem.req.bits.op := 1.U // must write
        io.mem.req.bits.data := replace_buffer.data
      }
    }
  }.elsewhen(state === replace){
    // send wr mem req to wr a replace cacheline
    when(io.mem.req.ready === 1.U){
      io.mem.req.valid := 1.U
      io.mem.req.bits.addr := miss_info.addr
      io.mem.req.bits.op := 0.U // must read
      io.mem.req.bits.data := 0.U
    }
  }.elsewhen(state === refill){
    when(io.mem.reps.valid){
      write_buffer.data := io.mem.reps.bits.data
      write_buffer.tag := miss_info.addr    //TODO: addr to tag and index
      write_buffer.index := miss_info.addr
      write_buffer.offset := miss_info.addr
      write_buffer.v := 1.U
      write_buffer.d := 0.U
      write_buffer.replace_way := replace_buffer.way_num
      write_buffer.wmask := Vec(p(CacheLineSize) / p(NBank), 1.U).asUInt()
    }
  }


  switch(state){
    is(idle){
      when(io.cpu.req.fire()){
        state := lookup
      }.otherwise{
        state := state
      }
    }

    is(lookup){
      when( (!is_miss) & (!io.cpu.req.fire()) ){
        // hit and no new req
        state := idle
      }.elsewhen( (!is_miss) & (io.cpu.req.fire()) ){
        // hit and new req
        state := lookup
      }.otherwise{
        // miss   need to prepare miss_info and replace_info
        state := miss
      }
    }

    is(miss){
      when(io.mem.req.ready === 0.U){
        // next level memory not ready
        state := state
      }.otherwise{
        // send a wr mem req, if D == 1 write replace_info
        state := replace
      }
    }

    is(replace){
      when(io.mem.req.ready === 0.U){
        state := state
      }.otherwise{
        // send a rd mem req, read miss_info
        state := refill
      }
    }

    is(refill){
      when(io.mem.reps.valid === 0.U){
        state := idle
      }.otherwise{
        // receive a rd  mem resp, return cpu resp and write cache
        state := refill
      }
    }
  }


}

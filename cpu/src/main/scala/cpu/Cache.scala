package cpu

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import chisel3.util.random.LFSR

// define in bytes
case object I$Size extends Field[Int]           // 256 * 1024 bits  (256 bits * 4 ways * 256 item)
case object D$Size extends Field[Int]           // 256 * 1024 bits  (256 bits * 4 ways * 256 item)
case object L2$Size extends Field[Int]          // no L2$
case object CacheLineSize extends Field[Int]    // 256bit (64 * 4)
case object NWay extends Field[Int]             // 4
case object NBank extends Field[Int]            // 4
case object IDBits extends Field[Int]           // 1bit 0: inst   1: data


// ====================== L1 to CPU IO =========================
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

// ====================== L1 to L2 IO =========================
class MemReq(implicit p: Parameters) extends Bundle {
  //
  val addr = UInt(p(XLen).W)
  val data = UInt(p(CacheLineSize).W)
  val op = UInt(1.W)  // 0: rd   1: wr
  val id = UInt(p(IDBits).W)
}

class MemResp(implicit p: Parameters) extends Bundle{
  val data = UInt(p(CacheLineSize).W)
  val id = UInt(p(IDBits).W)
}


// ====================== Way IO =========================

class WayOut (val tag_width: Int)(implicit p: Parameters) extends Bundle{
  val tag = UInt(tag_width.W)
  val v = UInt(1.W)
  val d = UInt(1.W)
  val datas = Vec(p(NBank), UInt((p(CacheLineSize) / p(NBank)).W))
}

class WayIn (val tag_width: Int, val index_width: Int, val offset_width: Int)(implicit p: Parameters) extends Bundle{
  val w = Valid(new Bundle{
    val tag = UInt(tag_width.W)
    val index = UInt(index_width.W)
    val offset = UInt(offset_width.W)
    val v = UInt(1.W)
    val d = UInt(1.W)
    val mask = UInt(((p(CacheLineSize) / p(NBank)) / 8).W)
    val data = UInt(p(XLen).W)
    val op = UInt(1.W) // must 1
  })
  val r = Valid(new Bundle{
    val index = UInt(index_width.W)
    val op = UInt(1.W) // must 0
  })
}

class Way(val tag_width: Int, val index_width: Int, offset_width: Int)(implicit p: Parameters) extends Module{

  val io = IO(new Bundle{
    val out = Valid(new WayOut(tag_width))
    val in = Flipped(new WayIn(tag_width, index_width, offset_width))
  })

  val tag_v = new Bundle{
    UInt(tag_width.W) // tag
    UInt(1.W)         // valid
  }
  val dirty = UInt(1.W)

  val depth = math.pow(2, index_width).toInt

  val tag_v_tab = SyncReadMem(depth, tag_v)
  val dirty_tab = SyncReadMem(depth, dirty)
  // nBank * (n * 8bit)
  val bankn = List.fill(p(NBank))(SyncReadMem(depth, Vec((p(CacheLineSize) / p(NBank)) / 8, UInt(8.W))))

  val result = WireInit(new WayOut(tag_width))

  // read logic
  // TODO: check data order in simulator
  //            tag,v,   d,    data
  result := Cat(List(tag_v_tab.read(io.in.r.bits.index, io.in.r.valid).asUInt()) ++
    List(dirty_tab.read(io.in.r.bits.index, io.in.r.valid)) ++
    bankn.map(_.read(io.in.r.bits.index, io.in.r.valid).asUInt())).asTypeOf(new WayOut(tag_width))

  io.out.bits := io.out
  io.out.valid := RegNext(io.in.r.valid, 0.U)

  // write logic
    // write bank data
  val bank_sel = WireInit(io.in.w.bits.offset(log2Ceil(p(XLen) / 8) + log2Ceil(p(NBank)) - 1, log2Ceil(p(XLen) / 8)))
  val w_data = io.in.w.bits.data.asTypeOf( Vec(p(CacheLineSize) / p(NBank) / 8, UInt(8.W)) )
  when(io.in.w.fire()){
    when(io.in.w.bits.op === 1.U){
      // write tag,v
      tag_v_tab.write(io.in.w.bits.index, Cat(io.in.w.bits.tag, io.in.w.bits.v).asTypeOf(tag_v))
      // write d
      dirty_tab.write(io.in.w.bits.d, io.in.w.bits.d)
      // write data
      bankn.zipWithIndex.foreach((a) =>{
        val (bank, i) = a
        when(bank_sel === i.U){
          bank.write(io.in.w.bits.index, w_data, io.in.w.bits.mask.asBools())
        }
      })
    }
  }
}

////////////////////  Cache /////////////////////////

class CacheCPUIO (implicit p: Parameters) extends Bundle{
  val req = Flipped(Valid(new CacheReq))
  val resp = Valid(new CacheResp)
}

class CacheMemIO (implicit p: Parameters) extends Bundle{
  val req = Decoupled(new MemReq)
  val resp = Flipped(Valid(new MemResp))
}

class Cache(val cache_type: String)(implicit p: Parameters) extends Module {
  val io = IO(new Bundle{
    val cpu = new CacheCPUIO
    val mem = new CacheMemIO
  })

  val cache_size = cache_type match {
    case "i" => p(I$Size)
    case "d" => p(D$Size)
    case _ => {println("cache type must 'i' or 'd'");System.exit(1);0}
  }
  val id = cache_type match {
    case "i" => 0.U
    case "d" => 1.U
    case _ => {println("cache type must 'i' or 'd'");System.exit(1);2.U}
  }

  val offset_width = log2Ceil(p(CacheLineSize))
  val index_width = log2Ceil(cache_size / (p(NWay) * p(CacheLineSize)) )
  val tag_width = p(XLen) - offset_width - index_width

  val infos = new Bundle{
    val tag = UInt(tag_width.W)
    val index = UInt(index_width.W)
    val offset = UInt(offset_width.W)
  }

  // instance Nways
  val ways = List.fill(p(NWay))( Module(new Way(tag_width, index_width, offset_width)) )

  // cache main fsm logic
  val idle::lookup::miss::replace::refill::Nil = Enum(5)
  val state = RegInit(idle)

  // save cpu req
  val req_reg = RegInit(0.U.asTypeOf(new CacheReq))
  // req_reg.addr view as {tag, index, offset}
  val req_reg_info = req_reg.addr.asTypeOf(infos)

  // conflict check (conflict with hit write)
  val conflict_hit_write = WireInit(
    io.cpu.req.valid & (io.cpu.req.bits.op ===  0.U) & (write_buffer.valid === 1.U) // req is read op and write_buffer is valid
      (write_buffer.bits.index(
        log2Ceil(p(CacheLineSize) / p(NBank) / 8) + log2Ceil(p(NBank)) - 1, log2Ceil(p(CacheLineSize) / p(NBank) / 8)
      ) === io.cpu.req.bits.addr.asTypeOf(infos).index(
        log2Ceil(p(CacheLineSize) / p(NBank) / 8) + log2Ceil(p(NBank)) - 1, log2Ceil(p(CacheLineSize) / p(NBank) / 8)
      ))  // req bank is equ with wb bank
  )

  // read nways
  ways.foreach((way =>{
    way.io.in.r.bits.index := io.cpu.req.bits.addr.asTypeOf(infos).index
    way.io.in.r.bits.op := 0.U //                | only accept read req
    way.io.in.r.valid := (io.cpu.req.valid) & (io.cpu.req.bits.op === 0.U) & (!conflict_hit_write) // req is valid and not conflict with hit write
  }))

  // compare ways tag, return one hot such {0,0,0,0} or {0,0,1,0}
  val ways_compare_res = WireInit(Cat(ways.map((way)=>{
      (way.io.out.bits.tag === req_reg_info.tag) & (way.io.out.bits.v === 1.U)
    })))
  // ways_compare_res is all 0, {0, 0, 0, 0} means the current req is miss
  val is_miss = ways_compare_res.orR() === 0.U
  assert((p(CacheLineSize) / p(NBank)) == 64)

  // Vec(NWay, (tag_width + v + d + cacheline)bit) tag      v   d      data
//  val ways_ret_datas = Vec(p(NWay), Wire(UInt(( tag_width + 1 + 1 + p(CacheLineSize) ).W)))
  val ways_ret_datas = Vec(p(NWay), Wire(new WayOut(tag_width)))
  // get nway out (all info {tag v d data})
  ways_ret_datas.zip(ways).foreach(a => {
    val (datas, way) = a
    datas := way.io.out.bits //.datas(io.cpu.req.bits.addr(log2Ceil((p(CacheLineSize) / p(NBank)) / 8) + log2Ceil(p(NBank)), log2Ceil((p(CacheLineSize) / p(NBank)) / 8)).asUInt())
  })
  // selected data from all way by tag==tag
  val select_data = Mux1H(for(i <- ways_compare_res.asBools().zipWithIndex) yield (i._1, ways_ret_datas(i._2.asUInt()).datas))
  // use LFSR to generate rand in binary, need to be converted to ont-hot to use as mask
  val rand_way = UIntToOH(LFSR(64)(log2Ceil(p(NWay))-1, 0).asUInt())
  // rand way data (tag, v, d, data)
  val rand_way_data = Mux1H(for(i <- rand_way.asBools().zipWithIndex) yield (i._1, ways_ret_datas(i._2.asUInt())))

  // miss info reg
  val miss_info = RegInit(0.U.asTypeOf(new Bundle{
    val addr = UInt(p(XLen).W)
    val op = UInt(1.W)
    val data = UInt(p(XLen).W)
  }))
  // replace buffer reg
  val replace_buffer = RegInit(0.U.asTypeOf(new Bundle{
    val addr = UInt(p(XLen).W)
    val data = Vec(p(NBank), UInt((p(CacheLineSize) / p(NBank)).W))
    val way_num = UInt(p(NWay).W)
    val v = UInt(1.W)
    val d = UInt(1.W)
  }))

  // write buffer, via this to write cache
  val write_buffer = RegInit(0.U.asTypeOf(Valid(new Bundle{
    val tag = UInt(tag_width.W)
    val index = UInt(index_width.W)
    val offset = UInt(offset_width.W)
    val v = UInt(1.W)
    val d = UInt(1.W)
    val data = UInt(p(XLen).W)
    val replace_way = UInt(p(NWay).W)
    val wmask = Vec((p(CacheLineSize) / p(NBank)) / 8, UInt(1.W))
  })))

  // write_buffer fsm
  val w_idle :: w_write :: Nil = Enum(2)
  val w_state = RegInit(w_idle)

  switch(w_state){
    is(w_idle){
      when(write_buffer.valid === 1.U){
        w_state := w_write
      }.otherwise{
        w_state := w_state
      }
    }

    is(w_write){
      when(write_buffer.valid === 1.U){
        w_state := w_state
      }.otherwise{
        w_state := w_idle
      }
    }
  }
  // write ways
  ways.foreach(way => {
    way.io.in.w.bits.tag := write_buffer.bits.tag
    way.io.in.w.bits.index := write_buffer.bits.index
    way.io.in.w.bits.offset := write_buffer.bits.offset
    way.io.in.w.bits.v := write_buffer.bits.v
    way.io.in.w.bits.d := write_buffer.bits.d
    way.io.in.w.bits.mask := write_buffer.bits.wmask
    way.io.in.w.bits.data := write_buffer.bits.data
    way.io.in.w.bits.op := 1.U // must write op
  })
  ways.zip(write_buffer.bits.replace_way.asBools()).foreach(a => {
    val (way, way_mask) = a
    way.io.in.w.valid := way_mask & write_buffer.valid
  })
  // write_buffer fsm END

  io.mem.req.bits.addr := 0.U
  io.mem.req.bits.op := 0.U
  io.mem.req.bits.data := 0.U
  io.mem.req.bits.id := id

  //  io.mem.req.bits.addr := MuxCase(0.U, Array(
  //    ((state === miss) & (io.mem.req.ready === 1.U)) -> replace_buffer.addr, // write replace_buffer
  //    ((state === replace) & (io.mem.req.ready === 1.U)) -> miss_info.addr,   // read miss_info
  //  ))
  //
  //  io.mem.req.bits.op := MuxCase(0.U, Array(
  //    ((state === miss) & (io.mem.req.ready === 1.U)) -> 1.U, // write replace_buffer
  //    ((state === replace) & (io.mem.req.ready === 1.U)) -> 0.U,   // read miss_info
  //  ))
  //
  //  io.mem.req.bits.data := MuxCase(0.U, Array(
  //    ((state === miss) & (io.mem.req.ready === 1.U)) -> replace_buffer.data, // write replace_buffer
  //    ((state === replace) & (io.mem.req.ready === 1.U)) -> miss_info.data,   // read miss_info
  //  ))

  when(state === idle){
    when(io.cpu.req.fire()){
      // store cpu req and goto lookup
      req_reg := io.cpu.req.bits
    }
  }.elsewhen(state === lookup){
    when(!is_miss){
      when(req_reg.op === 0.U){
        // hit, rd, resp to cpu
        io.cpu.resp.valid := 1.U
        io.cpu.resp.bits.data := Cat(req_reg.mask.asBools().zipWithIndex.map(x => {
          val (valid, i) = x
          // todo: use MuxCase to generate res
          val res = Mux(valid, select_data.asUInt()(8*(i+1)-1, 8*i).asUInt(), 0.U(8.W))
          res
        }))
      }.otherwise{
        // hit, wr, fill write_buffer
        write_buffer.valid := 1.U
        write_buffer.bits.tag := req_reg.addr.asTypeOf(infos).tag
        write_buffer.bits.index := req_reg.addr.asTypeOf(infos).index
        write_buffer.bits.offset := req_reg.addr.asTypeOf(infos).offset
        write_buffer.bits.v := 1.U
        write_buffer.bits.d := 1.U
        write_buffer.bits.data := req_reg.data
        write_buffer.bits.replace_way := ways_compare_res
        write_buffer.bits.wmask := req_reg.mask
      }
    }.otherwise{
      // miss and goto miss state
      // miss info
      miss_info.addr := req_reg.addr
      miss_info.op := req_reg.op
      miss_info.data := req_reg.data

      // replace info, use rand way data
      replace_buffer.addr := Cat(rand_way_data.tag, req_reg.addr.asTypeOf(infos).index, 0.U(offset_width.W))
      replace_buffer.data := rand_way_data.datas
      replace_buffer.way_num := rand_way
      replace_buffer.v := rand_way_data.v
      replace_buffer.d := rand_way_data.d
    }
  }.elsewhen(state === miss){
    // send wr mem req to write replace_buffer
    when(io.mem.req.ready === 1.U){
      // wait l2 is idle
      when(replace_buffer.d === 1.U){
        // if replace is dirty, then send req to write replace_buffer. And goto replace
        io.mem.req.valid := 1.U
        io.mem.req.bits.addr := replace_buffer.addr
        io.mem.req.bits.op := 1.U // must write
        io.mem.req.bits.data := replace_buffer.data
        io.mem.req.bits.id := id
      }
    }
  }.elsewhen(state === replace){
    // send rd mem req to rd miss
    when(io.mem.req.ready === 1.U){
      // wait l2 is idle, then send req to read miss data. And got refill
      io.mem.req.valid := 1.U
      io.mem.req.bits.addr := miss_info.addr
      io.mem.req.bits.op := 0.U // must read
      io.mem.req.bits.data := 0.U // in reading, req data is dontCare
      io.mem.req.bits.id := id
    }
  }.elsewhen(state === refill){
    when(io.mem.resp.valid){
      // get miss data, fill it in write_buffer
      write_buffer.bits.data := io.mem.resp.bits.data
      write_buffer.bits.tag := miss_info.addr    //TODO: addr to tag and index
      write_buffer.bits.index := miss_info.addr
      write_buffer.bits.offset := miss_info.addr
      write_buffer.bits.v := 1.U
      write_buffer.bits.d := 0.U
      write_buffer.bits.replace_way := replace_buffer.way_num
      write_buffer.bits.wmask := Vec(p(CacheLineSize) / p(NBank), 1.U).asUInt()
    }
  }


  switch(state){
    is(idle){
      when(io.cpu.req.fire() & !conflict_hit_write){
        state := lookup
      }.otherwise{
        state := state
      }
    }

    is(lookup){
      when( (!is_miss) & ((!io.cpu.req.fire()) | (io.cpu.req.fire() & conflict_hit_write)) ){
        // (hit and no new req) | (hit and new req is conflicted with hit write)
        state := idle
      }.elsewhen( (!is_miss) & (io.cpu.req.fire() & !conflict_hit_write) ){
        // hit and new req and not conflict with hit write
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
      when(io.mem.resp.valid === 0.U){
        state := idle
      }.otherwise{
        // receive a rd  mem resp, return cpu resp and write cache
        state := refill
      }
    }
  }


}

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
  val cmd = UInt(4.W)
}

// ====================== L1 to L2 IO =========================
object MemCmdConst{
  def ReadOnce    = "b0000".U
  def ReadBurst   = "b0001".U
  def ReadLast    = "b0010".U

  def WriteOnce   = "b1000".U
  def WriteBurst  = "b1001".U
  def WriteLast   = "b1010".U
  def WriteResp   = "b1011".U
  def WriteData   = "b1100".U
}
class MemReq(implicit p: Parameters) extends Bundle {
  //
  val addr = UInt(p(XLen).W)
  val data = UInt(p(XLen).W)
  val cmd = UInt(4.W)   // MemCmdConst
  val len = UInt(2.W)   // 0: 1(64bits)    1: 2   2: 4  3: 8
  val id = UInt(p(IDBits).W)
}

class MemResp(implicit p: Parameters) extends Bundle {
  val data = UInt(p(XLen).W)
  val cmd = UInt(4.W)
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

  val tag = UInt(tag_width.W) // tag
  val v = UInt(1.W)         // valid

  val dirty = UInt(1.W)

  val depth = math.pow(2, index_width).toInt

  val tag_tab = SyncReadMem(depth, tag)
  val v_tab = RegInit(VecInit(Seq.fill(depth)(0.U(1.W))))

  val dirty_tab = RegInit(VecInit(Seq.fill(depth)(0.U(1.W))))
  // nBank * (n * 8bit)
  val bankn = List.fill(p(NBank))(SyncReadMem(depth, Vec((p(CacheLineSize) / p(NBank)) / 8, UInt(8.W))))

  val result = WireInit(0.U.asTypeOf(new WayOut(tag_width)))

  // read logic
  // TODO: check data order in simulator
  //            tag,v,   d,    data
  result := Cat(List(tag_tab.read(io.in.r.bits.index, io.in.r.valid).asUInt()) ++ Seq(RegNext(v_tab(io.in.r.bits.index), 0.U), RegNext(dirty_tab(io.in.r.bits.index), 0.U)) ++
    bankn.map(_.read(io.in.r.bits.index, io.in.r.valid).asUInt())).asTypeOf(new WayOut(tag_width))

  io.out.bits := result
  io.out.valid := RegNext(io.in.r.valid, 0.U)
  dontTouch(io.out.valid)

  // write logic
    // write bank data
  val bank_sel = WireInit(io.in.w.bits.offset(log2Ceil(p(XLen) / 8) + log2Ceil(p(NBank)) - 1, log2Ceil(p(XLen) / 8)))
  val w_data = io.in.w.bits.data.asTypeOf( Vec(p(CacheLineSize) / p(NBank) / 8, UInt(8.W)) )
  when(io.in.w.fire()){
    when(io.in.w.bits.op === 1.U){
      // write tag,v
      tag_tab.write(io.in.w.bits.index, io.in.w.bits.tag)
      v_tab(io.in.w.bits.index) := io.in.w.bits.v
      // write d
      dirty_tab(io.in.w.bits.index) := io.in.w.bits.d
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
  val req = Flipped(Decoupled(new CacheReq))
  val resp = Valid(new CacheResp)
}

class CacheMemIO (implicit p: Parameters) extends Bundle{
  val req = Decoupled(new MemReq)
  val resp = Flipped(Decoupled(new MemResp))
}

class Cache(val cache_type: String)(implicit p: Parameters) extends Module {

  val addressSpace = p(AddressSpace).groupBy(_._3)  // groupBy isCache attribute
  require(addressSpace.keys.toList.length == 2)     // true or false  (cached or uncached)

  val io = IO(new Bundle{
    val cpu = new CacheCPUIO
    val mem = new CacheMemIO
  })

  val cache_size = cache_type match {
    case "i" => {println(s"ICache size is ${p(I$Size) / 8 / 1024} KB"); p(I$Size)}
    case "d" => {println(s"DCache size is ${p(D$Size) / 8 / 1024} KB"); p(D$Size)}
    case _ => {println("cache type must 'i' or 'd'");System.exit(1);0}
  }
  val id = cache_type match {
    case "i" => 0.U
    case "d" => 1.U
    case _ => {println("cache type must 'i' or 'd'");System.exit(1);2.U}
  }

  val offset_width = log2Ceil(p(CacheLineSize) / 8)
  val index_width = log2Ceil(cache_size / (p(NWay) * p(CacheLineSize)) )
  val tag_width = p(XLen) - offset_width - index_width

  require((offset_width + index_width + tag_width) == p(XLen))

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
//  val req_reg = WireInit(0.U.asTypeOf(new CacheReq))
  val req_reg = RegInit(0.U.asTypeOf(new CacheReq))
  val req_isCached = RegInit(false.B)
  // req_reg.addr view as {tag, index, offset}
  val req_reg_info = req_reg.addr.asTypeOf(infos)


  // write buffer, via this to write cache
  val write_buffer = RegInit(0.U.asTypeOf(Valid(new Bundle{
    val tag = UInt(tag_width.W)
    val index = UInt(index_width.W)
    val offset = UInt(offset_width.W)
    val v = UInt(1.W)
    val d = UInt(1.W)
    val data = UInt(p(XLen).W)
    val replace_way = UInt(p(NWay).W)
    val wmask = UInt(((p(CacheLineSize) / p(NBank)) / 8).W)
  })))

  // conflict check (conflict with hit write)
  val conflict_hit_write = WireInit(
    // req is read op and write_buffer is valid
    ((io.cpu.req.bits.op ===  0.U) & (write_buffer.valid === 1.U) &
      (
        (write_buffer.bits.index === io.cpu.req.bits.addr.asTypeOf(infos).index) &
        (write_buffer.bits.tag === io.cpu.req.bits.addr.asTypeOf(infos).tag) &
        (write_buffer.bits.offset(log2Ceil(p(CacheLineSize) / p(NBank) / 8) + log2Ceil(p(NBank)) - 1, log2Ceil(p(CacheLineSize) / p(NBank) / 8)) === io.cpu.req.bits.addr.asTypeOf(infos).index(log2Ceil(p(CacheLineSize) / p(NBank) / 8) + log2Ceil(p(NBank)) - 1, log2Ceil(p(CacheLineSize) / p(NBank) / 8)))
      )) |
      ( // req bank is equ with wb bank
        (state === lookup) & (req_reg.op === 1.U) & (io.cpu.req.bits.op === 0.U) &
        (
          (io.cpu.req.bits.addr.asTypeOf(infos).tag === req_reg.addr.asTypeOf(infos).tag) &
          (io.cpu.req.bits.addr.asTypeOf(infos).index === req_reg.addr.asTypeOf(infos).index) &
          (io.cpu.req.bits.addr.asTypeOf(infos).offset(log2Ceil(p(CacheLineSize) / p(NBank) / 8) + log2Ceil(p(NBank)) - 1, log2Ceil(p(CacheLineSize) / p(NBank) / 8)) === req_reg.addr.asTypeOf(infos).offset(log2Ceil(p(CacheLineSize) / p(NBank) / 8) + log2Ceil(p(NBank)) - 1, log2Ceil(p(CacheLineSize) / p(NBank) / 8)))
        )
      )
  )

  // read nways
  ways.foreach((way =>{
    way.io.in.r.bits.index := io.cpu.req.bits.addr.asTypeOf(infos).index
    way.io.in.r.bits.op := 0.U //                | only accept read req
//    way.io.in.r.valid := (io.cpu.req.valid) & (io.cpu.req.bits.op === 0.U) & (!conflict_hit_write) // req is valid and not conflict with hit write
    way.io.in.r.valid := (io.cpu.req.valid) & (!conflict_hit_write) // req is valid and not conflict with hit write
  }))

  // compare ways tag, return one hot such {0,0,0,0} or {0,0,1,0}
  val ways_compare_res = Cat(ways.map((way)=>{
      (way.io.out.bits.tag === req_reg_info.tag) & (way.io.out.bits.v === 1.U)
    }))  // Cat(high ... low)

  // ways_compare_res is all 0, {0, 0, 0, 0} means the current req is miss
  val is_miss = ((ways_compare_res.orR() === 0.U) & req_isCached) | (!req_isCached)
  assert((p(CacheLineSize) / p(NBank)) == 64)

  // Vec(NWay, (tag_width + v + d + cacheline)bit) tag      v   d      data
//  val ways_ret_datas = Vec(p(NWay), Wire(UInt(( tag_width + 1 + 1 + p(CacheLineSize) ).W)))
  val ways_ret_datas = Wire(Vec(p(NWay), new WayOut(tag_width)))
  // get nway out (all info {tag v d data})
  ways_ret_datas.zip(ways).foreach(a => {
    val (datas, way) = a
    datas := way.io.out.bits //.datas(io.cpu.req.bits.addr(log2Ceil((p(CacheLineSize) / p(NBank)) / 8) + log2Ceil(p(NBank)), log2Ceil((p(CacheLineSize) / p(NBank)) / 8)).asUInt())
  })
  // selected data from all way by tag==tag
  val select_data = Mux1H(for(i <- ways_compare_res.asBools().reverse.zipWithIndex) yield (i._1, ways_ret_datas(i._2).datas)) // todo: check order
  val select_data_rev = Wire(Vec(p(NBank), UInt((p(CacheLineSize) / p(NBank)).W)))
  dontTouch(select_data)
  dontTouch(select_data_rev)
  (select_data_rev, select_data.reverse).zipped.foreach(_ := _)
  // use LFSR to generate rand in binary, need to be converted to ont-hot to use as mask
  val rand_way = UIntToOH(LFSR(128, seed = Some(9987))( log2Ceil(p(NWay))-1 , 0).asUInt())
  // rand way data (tag, v, d, data)
  val rand_way_data = Mux1H(for(i <- rand_way.asBools().zipWithIndex) yield (i._1, ways_ret_datas(i._2)))

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
    val v = Bool()
    val d = Bool()
  }))


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
    dontTouch(way.io.in.w)
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
    way.io.in.w.valid := way_mask & Cat(Seq.fill(p(NWay))(write_buffer.valid))
  })
  // write_buffer fsm END


  // cpu resp
  dontTouch(io.cpu.req.bits.mask)
  dontTouch(io.cpu.resp.bits.data)
  dontTouch(io.cpu.resp.valid)
  dontTouch(req_reg)

  val refill_cnt = Counter(p(NWay))

  val load_ret = RegInit(0.U(64.W))
  when((state === refill) & ((!req_reg.op) & refill_cnt.value === req_reg.addr.asTypeOf(infos).offset(log2Ceil(64 / 8) + log2Ceil(p(NBank)) - 1, log2Ceil(64 / 8)).asUInt()) & io.mem.resp.valid){
    load_ret := io.mem.resp.bits.data
  }

  //                              resp in lookup stage
//  io.cpu.resp.valid := (state === idle) | ((state === lookup) & (!is_miss) & (req_reg.op === 0.U)) |
  io.cpu.resp.valid := (state === idle) | ((state === lookup) & (!is_miss)) |
    //    ((state === refill) & ((!req_reg.op) & refill_cnt.value === req_reg.addr.asTypeOf(infos).offset(log2Ceil(64 / 8) + log2Ceil(p(NBank)) - 1, log2Ceil(64 / 8)).asUInt()) & io.mem.resp.valid) |
    (req_isCached & (((state === refill) & ((!req_reg.op) & (refill_cnt.value === 3.U) & io.mem.resp.valid)) |
                     ((state === refill) & ((req_reg.op) & (refill_cnt.value === 3.U) & io.mem.resp.valid)))) |
    (!req_isCached & ((state === refill) & ((!req_reg.op) & io.mem.resp.valid)))

  when(state === lookup){
    io.cpu.resp.bits.data := Cat(req_reg.mask.asBools().zipWithIndex.map(x => {
      val (valid, i) = x
      val res = Wire(UInt(8.W))
      res := Mux(valid, select_data_rev(req_reg.addr(log2Ceil(p(CacheLineSize) / p(NBank) / 8) + log2Ceil(p(NBank)) - 1, log2Ceil(p(CacheLineSize) / p(NBank) / 8))).asUInt()(8*(i+1)-1, 8*i).asUInt(), 0.U(8.W))
      res
    }).reverse) >> (req_reg.addr(2, 0) << 3.U)
  }.otherwise{
    // 这里的逻辑是为了保证ld的结果在都refill最后一个数据来的时候来放回，目地是为了保证操作的原子性
    val ret = Mux(req_isCached, Mux(req_reg.addr.asTypeOf(infos).offset(log2Ceil(64 / 8) + log2Ceil(p(NBank)) - 1, log2Ceil(64 / 8)).asUInt() === 3.U, io.mem.resp.bits.data, load_ret), io.mem.resp.bits.data)
    io.cpu.resp.bits.data := Cat(req_reg.mask.asBools().zipWithIndex.map(x => {
      val (valid, i) = x
      val res = Wire(UInt(8.W))
      res := Mux(valid, ret(8*(i+1)-1, 8*i).asUInt(), 0.U(8.W))
      res
    }).reverse) >> (req_reg.addr(2, 0) << 3.U)
  }


  io.cpu.resp.bits.cmd := Mux(state === idle, 0.U, Mux(req_reg.op === 1.U, 1.U, 2.U))   // op=1, return 1   op=0, return 2

  when((state=== refill) & io.mem.resp.fire() & req_isCached){
    refill_cnt.inc()
  }.elsewhen(state === idle) {
    refill_cnt.value := 0.U
  }

  // cpu req
  // None

  // mem req
  val w_cnt = Counter(4)
  val r_cnt = Counter(4)

  when((state === lookup) & is_miss & ((req_isCached & ((rand_way_data.v === 1.U) & (rand_way_data.d === 1.U))) |
                                       (!req_isCached & (req_reg.op === 1.U)))
  ){
    // send write burst cmd or write once cmd
    io.mem.req.valid := 1.U
    io.mem.req.bits.addr := Mux(req_isCached, Cat(rand_way_data.tag, req_reg.addr.asTypeOf(infos).index, 0.U(offset_width.W)), req_reg.addr)
    io.mem.req.bits.cmd := Mux(req_isCached, MemCmdConst.WriteBurst, MemCmdConst.WriteOnce)
    io.mem.req.bits.len := Mux(req_isCached, 2.U /* 1.U << 2 = 4*/, 0.U)
    io.mem.req.bits.data := 0.U
    io.mem.req.bits.id := id
  }.elsewhen((state === miss) & ((req_isCached & replace_buffer.v & replace_buffer.d) |
                                 (!req_isCached & (req_reg.op === 1.U)))
  ){
    // send write data 4 times when is Cached or write data 1 time when uncached
    io.mem.req.valid := 1.U
    io.mem.req.bits.addr := Mux(req_isCached, replace_buffer.addr, req_reg.addr)
    io.mem.req.bits.cmd := Mux(req_isCached, Mux(w_cnt.value === 3.U, MemCmdConst.WriteLast, MemCmdConst.WriteData), MemCmdConst.WriteLast)
    io.mem.req.bits.len := Mux(req_isCached, 2.U /* 1.U << 2 = 4*/, 0.U)
    io.mem.req.bits.data := Mux(req_isCached, replace_buffer.data(w_cnt.value), req_reg.data)
    io.mem.req.bits.id := id
    when(io.mem.req.fire() & req_isCached){
      w_cnt.inc()
    }
  }.elsewhen(state === replace & (req_isCached |
                                  (!req_isCached & (req_reg.op === 0.U)))
  ){
    // send read burst cmd
    io.mem.req.valid := 1.U
    io.mem.req.bits.addr := Mux(req_isCached, miss_info.addr & Cat(Seq.fill(tag_width + index_width)(1.U(1.W)) ++ Seq.fill(offset_width)(0.U(1.W))), req_reg.addr)
    io.mem.req.bits.cmd := Mux(req_isCached, MemCmdConst.ReadBurst, MemCmdConst.ReadOnce)
    io.mem.req.bits.len := Mux(req_isCached, 2.U /* 1.U << 2 = 4*/, 0.U)
    io.mem.req.bits.data := 0.U
    io.mem.req.bits.id := id
  }.otherwise{
    // get read data 4 times
    io.mem.req.valid := 0.U
    io.mem.req.bits.addr := 0.U
    io.mem.req.bits.cmd := 0.U
    io.mem.req.bits.len := 0.U // 1.U << 2 = 4
    io.mem.req.bits.data := 0.U
    io.mem.req.bits.id := id
  }


  io.cpu.req.ready := ((state === idle) | ((state === lookup) & (!is_miss))) & !conflict_hit_write
  req_reg := Mux(io.cpu.req.fire(), io.cpu.req.bits, req_reg)
  req_isCached := Mux(io.cpu.req.fire(), addressSpace(true).map(info => {
    val start = info._1
    val range = info._2
    val isCache = info._3
    val port_id = info._4
    (io.cpu.req.bits.addr >= start.U(64.W)) & (io.cpu.req.bits.addr < (start.U(64.W) + range.U(64.W)))
  }).reduce(_ | _), req_isCached)

  when((state === lookup) & is_miss){
    // miss and goto miss state
    // miss info
    miss_info.addr := req_reg.addr
    miss_info.op := req_reg.op
    miss_info.data := req_reg.data

    // replace info, use rand way data
    replace_buffer.addr := Cat(rand_way_data.tag, req_reg.addr.asTypeOf(infos).index, 0.U(offset_width.W))
    replace_buffer.data := rand_way_data.datas.reverse
    replace_buffer.way_num := rand_way
    replace_buffer.v := rand_way_data.v
    replace_buffer.d := rand_way_data.d
  }

  io.mem.resp.ready := (state === refill)
  write_buffer.valid := Mux(((state === refill) & io.mem.resp.fire()) | ((state === lookup)& !is_miss & req_reg.op =/= 0.U), 1.U, 0.U)
  when((state === lookup) & (!is_miss) & (req_reg.op === 1.U)){
      write_buffer.bits.tag := req_reg.addr.asTypeOf(infos).tag
      write_buffer.bits.index := req_reg.addr.asTypeOf(infos).index
      write_buffer.bits.offset := req_reg.addr.asTypeOf(infos).offset
      write_buffer.bits.v := 1.U
      write_buffer.bits.d := 1.U
      write_buffer.bits.data := req_reg.data
      write_buffer.bits.replace_way := Cat(ways_compare_res.asBools()).asUInt() // note: !
      write_buffer.bits.wmask := req_reg.mask
    }.elsewhen((state === refill) & io.mem.resp.fire()){
      when(req_isCached === 1.U){
        when(req_reg.op === 1.U){
          write_buffer.bits.data := Mux(refill_cnt.value === miss_info.addr.asTypeOf(infos).offset(log2Ceil(64 / 8) + log2Ceil(p(NBank)) - 1, log2Ceil(64 / 8)).asUInt(),
            (io.mem.resp.bits.data & (~Cat(req_reg.mask.asBools().reverse.map(x => {
              val res = Wire(UInt(8.W))
              res := Mux(x, "hff".U(8.W), 0.U(8.W))
              res
            }))).asUInt()) | (req_reg.data & Cat(req_reg.mask.asBools().reverse.map(x => {
              val res = Wire(UInt(8.W))
              res := Mux(x, "hff".U(8.W), 0.U(8.W))
              res
            }))), io.mem.resp.bits.data)
        }.otherwise{
          write_buffer.bits.data := io.mem.resp.bits.data
        }

        write_buffer.bits.tag := miss_info.addr.asTypeOf(infos).tag
        write_buffer.bits.index := miss_info.addr.asTypeOf(infos).index
        //      write_buffer.bits.offset := miss_info.addr.asTypeOf(infos).offset + (r_cnt.value << log2Ceil(p(XLen) / 8).U)
        write_buffer.bits.offset :=  (r_cnt.value << log2Ceil(p(XLen) / 8).U).asUInt()
        write_buffer.bits.v := 1.U
        write_buffer.bits.d := Mux(req_reg.op === 1.U, 1.U, 0.U) // if op is write(store inst), dirty is 1
        write_buffer.bits.replace_way := replace_buffer.way_num
        write_buffer.bits.wmask := Cat(Seq.fill((p(CacheLineSize) / p(NBank)) / 8)(1.U))
        r_cnt.inc()
      }.otherwise{
        // uncache

      }
    }


  // fsm state
  switch(state){
    is(idle){
      when(io.cpu.req.fire() & !conflict_hit_write){
        state := lookup
      }.otherwise{
        state := state
      }
    }

    is(lookup){
      when( (!is_miss) & ((!io.cpu.req.fire()) | conflict_hit_write) ){
        // (hit and no new req) | (hit and new req is conflicted with hit write)
        state := idle
      }.elsewhen( (!is_miss) & (io.cpu.req.fire() & !conflict_hit_write) ){
        // hit and new req and not conflict with hit write
        state := lookup
      }.otherwise{
        // miss   need to prepare miss_info and replace_info
        when(io.mem.req.ready === 1.U){
          // send cmd to write replace
          state := miss
        }
      }
    }

    is(miss){
      when(
        (req_isCached & (io.mem.req.fire() & (io.mem.req.bits.cmd === MemCmdConst.WriteLast)) | ((replace_buffer.v === 0.U) | (replace_buffer.d === 0.U))) |
          (!req_isCached & (((req_reg.op === 1.U) & (io.mem.req.fire() & (io.mem.req.bits.cmd === MemCmdConst.WriteLast))) |
                             (req_reg.op === 0.U)))
      ){
        // cached | (uncached & op == 1)    send write data
        state := replace
      }.otherwise{
        // next level memory not ready
        state := state
      }
    }

    is(replace){
      when((req_isCached & (io.mem.req.fire() & (io.mem.req.bits.cmd === MemCmdConst.ReadBurst))) |
            (!req_isCached & ((req_reg.op === 1.U) |
                             ((req_reg.op === 0.U) & (io.mem.req.fire() & (io.mem.req.bits.cmd === MemCmdConst.ReadOnce)))))
      ){
        // send cmd to read miss_info
        state := refill
      }.otherwise{
        state := state
      }
    }

    is(refill){
      when((req_isCached & (io.mem.resp.fire() & (io.mem.resp.bits.cmd === MemCmdConst.ReadLast))) |
           (!req_isCached & ((req_reg.op === 1.U) |
                            ((req_reg.op === 0.U) & (io.mem.resp.fire() & (io.mem.resp.bits.cmd === MemCmdConst.ReadLast)))))

      ){
        // get last read data
        state := idle
      }.otherwise{
        state := state
      }
    }
  }


}

package cpu.ooo

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import chisel3.experimental.ChiselEnum
import chisel3.util.experimental.BoringUtils
import chisel3.util.random.LFSR
import cpu.{CSR, CacheCPUIO}

class VPNBundle extends Bundle {
  val vpn2 = UInt(9.W)
  val vpn1 = UInt(9.W)
  val vpn0 = UInt(9.W)
}

class PPNBundle extends Bundle {
  val ppn2 = UInt(26.W)
  val ppn1 = UInt(9.W)
  val ppn0 = UInt(9.W)
}

class FlagBundle extends Bundle {
  val D = Bool()
  val A = Bool()
  val G = Bool()
  val U = Bool()
  val X = Bool()
  val W = Bool()
  val R = Bool()
  val V = Bool()
}

class TLBLine extends Bundle {
  val vpns = new VPNBundle
  val ppns = new PPNBundle
  val asid = UInt(16.W)
  val vpn_mask = UInt(18.W)  // for big page
  val flags = new FlagBundle // 8bit
//  val pte_addr = UInt(56.W)  // pte addr
}

class PTE extends Bundle { // 64bits
  val N = Bool()           // 1
  val PBMT = UInt(2.W)     // 2
  val Reserved = UInt(7.W) // 7
  val ppns = new PPNBundle // 44 = 26 + 9 + 9
  val rsw = UInt(2.W)      // 2
  val flags = new FlagBundle// 8
}

class TLBWay(val depth: Int)(implicit val p: Parameters) extends Module {
  val io = IO(new Bundle {
    val req = Flipped(Valid(new Bundle {
      val tlbline = new TLBLine
      val op = Bool()
    }))
    val resp = Valid(new Bundle {
      val tlbline = new TLBLine
      val isHit = Bool()
    })
    val sfence_vma = Input(Bool())
  })

  val mem = SyncReadMem(depth, new TLBLine)
  val v_tab = RegInit(VecInit(Seq.fill(depth)(0.U(1.W))))

  // 计算 index 来确定mem读哪一行
  val index = Wire(UInt())
  if (depth == 1){
    index := 0.U
  }else{
    index := io.req.bits.tlbline.vpns.asUInt(log2Ceil(depth)-1, 0)
  }

  // TODO： chisel的mem描述设计的有点局限性，这里如果采用注释的写法，想使用单口ram，rd必须经过一个mux来进行选择，这会引入逻辑环
//  val rd = Wire(new TLBLine)
//  rd := DontCare
//  when(io.req.fire & io.req.bits.op){
//    mem.write(index, io.req.bits.tlbline)
//  }.otherwise{
//    rd := mem.read(index, io.req.fire & !io.req.bits.op)
//  }

  val rd = Wire(new TLBLine)
  val rd_valid = Wire(Bool())
  rd := mem.read(index, io.req.fire & !io.req.bits.op)
  rd_valid := RegNext(v_tab(index))
  when(io.req.fire & io.req.bits.op){
    mem.write(index, io.req.bits.tlbline)
    v_tab(index) := io.req.bits.tlbline.flags.V
  }.elsewhen(io.sfence_vma){
    // sfence_vma clear all v_tab
    v_tab.foreach(_ := 0.U)
  }

  val tag = rd.vpns.asUInt(26, log2Ceil(depth))
  io.resp.bits.isHit := (tag === RegNext(io.req.bits.tlbline.vpns.asUInt(26, log2Ceil(depth)))) & rd.flags.V & rd_valid
  io.resp.bits.tlbline := rd
  io.resp.valid := RegNext(io.req.fire & !io.req.bits.op) // mem has a cycle delay when read
}

class TLBIO(implicit val p: Parameters) extends Bundle {
  val from_cpu = new CacheCPUIO   // req from cpu
  val toCache = Flipped(new CacheCPUIO())  // req to cache

  val ptw = Flipped(new PTWIO)

  val sfence_vma = Input(Bool())
}

// convert cpu vaddr req to paddr and send to cache
class TLB(val ifetch: Boolean, val depth: Int)(implicit val p: Parameters) extends Module {
  val io = IO(new TLBIO)

  val req_reg = RegInit(0.U.asTypeOf(io.from_cpu.req.bits))
  val ptw_reg = RegInit(0.U.asTypeOf(io.ptw.resp.bits))
  val except_reg = RegInit(ExceptType.NO)

  val ways = Seq.fill(4)(Module(new TLBWay(depth)))
  ways.foreach(_.io.sfence_vma := io.sfence_vma)

  val ways_ret_pte = Wire(Vec(4, new TLBLine))
  (ways_ret_pte, ways).zipped.foreach(_ := _.io.resp.bits.tlbline)
  // 通过每个way的isHit来选择出命中的way
  val sel_pte = Mux1H(
    // (bool, index)
    for(i <- ways.map(_.io.resp.bits.isHit).zipWithIndex) yield
      (i._1, ways_ret_pte(i._2))
  )
  val isHit = ways.map(_.io.resp.bits.isHit).reduce(_ | _) & ways.head.io.resp.fire

  // 判断是否启用vm  以及vaddr是否合法
  val isifetch = ifetch.B
  // 异常检查
  val except = Wire(Bool())
  val common_check = Wire(Bool())
//  val bigpage_check = Wire(Bool())
  val update_ad = Wire(Bool())
  val isfetch_except = Wire(Bool())
  val load_except = Wire(Bool())
  val store_except = Wire(Bool())

  val mstatus_mprv = WireInit(false.B)
  val mstatus_mpp  = WireInit(0.U(2.W))
  val mstatus_sum  = WireInit(false.B)
  val mstatus_mxr  = WireInit(false.B)
  val cpu_mode     = WireInit(0.U(2.W))
  val satp_mode    = WireInit(0.U(8.W))
  val satp_ppn     = WireInit(0.U(44.W))
  val satp_asid    = WireInit(0.U(16.W))
  BoringUtils.addSink(mstatus_mprv, "mstatus_mprv")
  BoringUtils.addSink(mstatus_mpp, "mstatus_mpp")
  BoringUtils.addSink(mstatus_sum, "mstatus_sum")
  BoringUtils.addSink(mstatus_mxr, "mstatus_mxr")
  BoringUtils.addSink(cpu_mode, "cpu_mode")
  BoringUtils.addSink(satp_mode, "satp_mode")
  BoringUtils.addSink(satp_ppn, "satp_ppn")
  BoringUtils.addSink(satp_asid, "satp_asid")

  val mode = Mux(mstatus_mprv & !isifetch, mstatus_mpp, cpu_mode)
  common_check := (
    isifetch
      & sel_pte.flags.V
      & !((mode === CSR.PRV_U) & !sel_pte.flags.U)
      & !(sel_pte.flags.U & ((mode === CSR.PRV_S) & (!mstatus_sum | isifetch)))
    )
  isfetch_except := common_check & sel_pte.flags.X
  load_except := common_check & (sel_pte.flags.R | (mstatus_mxr & sel_pte.flags.X))
  // 注意: AMO指令从不出现load异常，因为不可读的page页不可能会写，如果发出load异常也会发出store异常，所以AMO指令发起的是store异常
  store_except := common_check & sel_pte.flags.W

  when(isifetch){
    update_ad := !sel_pte.flags.A
    except := isfetch_except | update_ad
  }.elsewhen((req_reg.op === 0.U) & !isifetch){  // todo: 需要在memU里面判断amo的load1属于store异常
    // load
    update_ad := !sel_pte.flags.A
    except := load_except | update_ad
  }.otherwise{
    // store and amo op
    update_ad := !sel_pte.flags.A | !sel_pte.flags.D
    except := store_except | update_ad
  }


  val vm_enbale = (Mux(mstatus_mprv & !isifetch, mstatus_mpp, cpu_mode) < CSR.PRV_M) & (satp_mode === 8.U)
  // 63-39 must the same as 38 when vm_enable
  val req_addr = io.from_cpu.req.bits.addr
  val va_msbs_ok = ((Mux(req_addr(38), Cat(Seq.fill(63-39+1)(1.U(1.W))), 0.U) === req_addr(63, 39)) & vm_enbale) | !vm_enbale

  val s_idle :: s_lookup :: s_ptw :: s_refill :: s_except :: Nil = Enum(5)
  val state = RegInit(s_idle)

  when(!vm_enbale){
    assert(state === s_idle)
  }

  switch(state){
    is(s_idle){
      when(io.from_cpu.req.fire()){
        when(vm_enbale){
          // 只有vm_enable的时候状态机才工作
          when(va_msbs_ok){
            // vm启用且msbs_ok 查找ways
            state := s_lookup
          }.otherwise{
            // vm启用但是msbs不ok  那么需要抛出异常
            state := s_except
          }
        }.otherwise{
          // vm不启用则状态机不运行
          state := s_idle
        }
      }
    }
    is(s_lookup){
      when(isHit){
        // ptw会过滤掉不合法的page，所以只要way命中那么肯定是合法的page，不需要判
        when(except){
          state := s_except
        }.otherwise{
          // todo: 当lookup并且isHit的时候可以接受下一个req 而不用跳回idle
          state := s_idle
        }
      }.otherwise{
        // 没命中，发送ptw req
        when(io.ptw.req.fire){
          state := s_ptw
        }
      }
    }
    is(s_ptw){
      when(io.ptw.resp.fire){
        when(io.ptw.resp.bits.except =/= ExceptType.NO){
          // ptw显示有异常  转入s_except处理
          state := s_except
        }.otherwise{
          // ptw找到合法的page  进入s_refill填写ways
          state := s_refill
        }
      }
    }
    is(s_refill){
      // 写回了ways  并且发送来cache请求
      when(io.toCache.req.fire){
        state := s_idle
      }
    }
    is(s_except){
      // 返回except
      when(io.from_cpu.resp.fire){
        assert(io.from_cpu.resp.bits.except === true.B)
        state := s_idle
      }
    }
  }

  // from_cpu.req.fire的时候 缓存req到req_reg中
  io.from_cpu.req.ready := (state === s_idle) & io.toCache.req.ready
  when(io.from_cpu.req.fire){
    req_reg := io.from_cpu.req.bits
  }

  // lookup且miss的时候发送ptw的req
  when((state === s_lookup) & !isHit){
    io.ptw.req.valid := true.B
    io.ptw.req.bits.vaddr := req_reg.addr
    io.ptw.req.bits.op_type := req_reg.op  // todo: op如何映射成op_type 主要是amo的映射，需要额外的信息，也可以在memU中处理
    io.ptw.req.bits.isfetch := isifetch
  }.otherwise{
    io.ptw.req.valid := false.B
    io.ptw.req.bits.vaddr := 0.U
    io.ptw.req.bits.op_type := 0.U
    io.ptw.req.bits.isfetch := 0.U
  }

  // ptw
  when((state === s_ptw) & io.ptw.resp.fire & (io.ptw.resp.bits.except === ExceptType.NO)){
    ptw_reg := io.ptw.resp.bits
  }

  // refill 利用lfsr找一个way进行refill
  val rand_num = LFSR(8, seed = Some(8))(1, 0).asUInt
  val rand_way = UIntToOH(rand_num)
  assert(rand_way.orR === 1.U)

  // 用进入refill的上升沿来触发一次tlbway写入操作
  val refill_write_once = (state === s_refill) & !RegNext(state === s_refill)
  when(state === s_refill){
    // write ways
    ways.foreach(_.io.req.bits.op := 1.U)
    ways.foreach({
      case x =>
        x.io.req.bits.tlbline.ppns     := ptw_reg.pte.ppns
        x.io.req.bits.tlbline.vpns     := req_reg.addr(38, 12).asTypeOf(new VPNBundle)
        x.io.req.bits.tlbline.vpn_mask := ptw_reg.vpn_mask
        x.io.req.bits.tlbline.flags     := ptw_reg.pte.flags
        x.io.req.bits.tlbline.asid     := satp_asid
    })
    ways.map(_.io.req.valid).zip(rand_way.asBools).foreach({
      case (l, r) => l := r & refill_write_once
    })
  }.otherwise{
    // read ways
    ways.foreach(_.io.req.bits.op := 0.U)
    ways.foreach({
      case x =>
        x.io.req.bits.tlbline := 0.U.asTypeOf(new TLBLine)
    })
    ways.map(_.io.req.valid).foreach(_ := io.from_cpu.req.fire)
  }

  when(!vm_enbale){
    // 不启用vm  cache 等价于直接和 cpu 连接
    io.toCache.req <> io.from_cpu.req
  }.otherwise{
    // 当lookup 并且 isHit的时候发送cache req
    // 或者 miss了进入refill之后拿到了pte  再发送cache req
    when((state === s_lookup) & isHit & !except){
      io.toCache.req.valid := true.B
      io.toCache.req.bits.op := req_reg.op
      io.toCache.req.bits.addr := Cat(sel_pte.ppns.asUInt, req_reg.addr(11, 0).asUInt).asUInt
      io.toCache.req.bits.data := req_reg.data
      io.toCache.req.bits.mask := req_reg.mask
    }.elsewhen(state === s_refill){
      io.toCache.req.valid := true.B
      io.toCache.req.bits.op := req_reg.op
      io.toCache.req.bits.addr := Cat(ptw_reg.pte.ppns.asUInt, req_reg.addr(11, 0).asUInt).asUInt
      io.toCache.req.bits.data := req_reg.data
      io.toCache.req.bits.mask := req_reg.mask
    }.otherwise{
      io.toCache.req.valid := false.B
      io.toCache.req.bits.op := 0.U
      io.toCache.req.bits.addr := 0.U
      io.toCache.req.bits.data := 0.U
      io.toCache.req.bits.mask := 0.U
    }
  }

  // except logic
  when((state === s_lookup) & isHit & except){
    except_reg := MuxLookup(req_reg.op, ExceptType.SPF, Seq(
      0.U -> ExceptType.LPF
    ))
  }.elsewhen((state === s_ptw) & io.ptw.resp.fire){
    except_reg := io.ptw.resp.bits.except
  }

  //当异常的时候会返回异常resp   否则返回cache的reso，cache的resp不会产生异常
  when(state === s_except){
    io.from_cpu.resp.valid := true.B
    io.from_cpu.resp.bits.data := Cat("h0000_0013".U(32.W), "h0000_0013".U(32.W)).asUInt
    io.from_cpu.resp.bits.cmd := Mux(req_reg.op === 1.U, 1.U, 2.U)
    io.from_cpu.resp.bits.except := true.B
  }.otherwise{
    io.toCache.resp <> io.from_cpu.resp
  }

  io.ptw.resp.ready := state === s_ptw
}


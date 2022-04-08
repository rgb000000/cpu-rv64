package cpu.ooo

import chisel3._
import chisel3.util._
import chipsalliance.rocketchip.config._
import chisel3.experimental.ChiselEnum
import chisel3.util.experimental.BoringUtils
import cpu.{CSR, CacheCPUIO}

object OpType {
  val LD_OP  = 0.U(2.W)
  val ST_OP  = 1.U(2.W)
  val AMO_OP = 2.U(2.W)
}
object ExceptType {
  val NO  = 0.U(2.W)
  val IPF = 1.U(2.W)
  val LPF = 2.U(2.W)
  val SPF = 3.U(2.W)
}

class PTWIO(implicit val p: Parameters) extends Bundle {
  val req = Flipped(Decoupled(new Bundle{
    val vaddr = UInt(64.W)
    val op_type = UInt(2.W)  // OpType
    val isfetch = Bool()
  }))

  val resp = Decoupled(new Bundle {
    val pte = new PTE
    val vpn_mask = UInt(18.W)
    val except = UInt(2.W)  // ExceptType
  })
}

class PTWCrossBarN21(val N: Int)(implicit val p: Parameters) extends Module {
  // n reqs to one req, logic is the same as CPUCacheCrossBarN21
  val io = IO(new Bundle {
    val in = Vec(N, new PTWIO)
    val out = Flipped(new PTWIO())
  })

  val arb = Module(new Arbiter(chiselTypeOf(io.in.head.req.bits), N))
  val lock = RegInit(false.B)
  val s_idle :: s_lock :: Nil = Enum(2)
  val state = RegInit(s_idle)
  val cur_idx = RegInit(0.U(log2Ceil(N).W))

  (io.in.map(_.req), arb.io.in).zipped.foreach(_ <> _)
  io.out.req <> arb.io.out

  switch(state){
    is(s_idle){
      when(arb.io.out.fire){
        state := s_lock
        cur_idx := arb.io.chosen
      }
    }
    is(s_lock){
      when(io.out.resp.fire & io.out.req.fire){
        state := s_lock
        cur_idx := arb.io.chosen
      }.elsewhen(io.out.resp.fire & !io.out.req.fire){
        state := s_idle
      }
    }
  }

  io.in.foreach(x => {
    x.resp.bits := 0.U.asTypeOf(x.resp.bits)
    x.resp.valid := 0.U
  })
  io.in(cur_idx).resp <> io.out.resp
}

class PTW(val N: Int)(implicit val p: Parameters) extends Module {
  val io = IO(new Bundle{
    val ins = Vec(N, new PTWIO())
    val toCache = Flipped(new CacheCPUIO)
  })
  val cur_ppn = RegInit(0.U(44.W))
  val req_data = RegInit(0.U.asTypeOf(io.ins.head.req.bits))

  // arbiter
  val xbar = Module(new PTWCrossBarN21(N))
  (xbar.io.in, io.ins).zipped.foreach(_ <> _)
  val sel_in = xbar.io.out   // 处理sel_in  就可以了

  val s_idle :: s_find_pte :: s_wait_pte :: s_ret :: s_except :: Nil = Enum(5)
  val state = RegInit(s_idle)
  val level = RegInit(0.U(2.W))

  // toCache的resp 会在cmd =/= 0.U的时候出现， req op=1 返回1    req op=0 返回2
  val cache_resp_fire = io.toCache.resp.fire & (io.toCache.resp.bits.cmd === 2.U)

  // page合法性检查
  val illedge_page = Wire(Bool())
  val get_leaf_ptw = Wire(Bool())

  // 权限检查
  val except = Wire(Bool())
  val common_check = Wire(Bool())
  val bigpage_check = Wire(Bool())
  val update_ad = Wire(Bool())
  val isfetch_except = Wire(Bool())
  val load_except = Wire(Bool())
  val store_except = Wire(Bool())

  // ptw 过程中页表flag异常
  // 1. V == 0
  // 2. R==0 & W==1
  // 当V==1 & （R==1 | X==1） 则pte是leaf page
  val pte = io.toCache.resp.bits.data.asTypeOf(new PTE)
  illedge_page := (!pte.flags.V) | (!pte.flags.R & pte.flags.W)
  get_leaf_ptw := pte.flags.V | (pte.flags.R | pte.flags.X)

  val pte_reg = RegInit(0.U.asTypeOf(new PTE))
  val vpn_mask_reg = RegInit(0.U(18.W))
  val except_type = Wire(UInt(2.W))

  // 检查页表权限是否合法
  // isfetch的时候根据cpu.mode来判断，(pte.v) & (如果在U模型pte.u是否set) & ()
  val mstatus_mprv = WireInit(false.B)
  val mstatus_mpp  = WireInit(0.U(2.W))
  val mstatus_sum  = WireInit(false.B)
  val mstatus_mxr  = WireInit(false.B)
  val cpu_mode     = WireInit(0.U(2.W))
  val satp_mode    = WireInit(0.U(8.W))
  val satp_ppn     = WireInit(0.U(44.W))
  BoringUtils.addSink(mstatus_mprv, "mstatus_mprv")
  BoringUtils.addSink(mstatus_mpp, "mstatus_mpp")
  BoringUtils.addSink(mstatus_sum, "mstatus_sum")
  BoringUtils.addSink(mstatus_mxr, "mstatus_mxr")
  BoringUtils.addSink(cpu_mode, "cpu_mode")
  BoringUtils.addSink(satp_mode, "satp_mode")
  BoringUtils.addSink(satp_ppn, "satp_ppn")
  val mode = Mux(mstatus_mprv & !req_data.isfetch, mstatus_mpp, cpu_mode)
  common_check := (
    req_data.isfetch
      & pte.flags.V
      & !((mode === CSR.PRV_U) & !pte.flags.U)
      & !(pte.flags.U & ((mode === CSR.PRV_S) & (!mstatus_sum | req_data.isfetch)))
    )
  isfetch_except := common_check & pte.flags.X
  load_except := common_check & (pte.flags.R | (mstatus_mxr & pte.flags.X))
  // 注意: AMO指令从不出现load异常，因为不可读的page页不可能会写，如果发出load异常也会发出store异常，所以AMO指令发起的是store异常
  store_except := common_check & pte.flags.W

  val pg_mask = MuxLookup(level, 0.U, Seq(
    0.U -> "h3ffff".U(18.W),
    1.U -> "h1ff".U(18.W)
  ))
  bigpage_check := (pte.ppns.asUInt & pg_mask) === 0.U // bigpage ppn need aligned

  // 权限不满足产生异常，根据不同的req op_type进行不同的异常判断
  when(req_data.isfetch){
    update_ad := !pte.flags.A
    except := isfetch_except | update_ad
  }.elsewhen((req_data.op_type === OpType.LD_OP) & !req_data.isfetch){
    // load
    update_ad := !pte.flags.A
    except := load_except | update_ad
  }.otherwise{
    // store and amo op
    update_ad := !pte.flags.A | !pte.flags.D
    except := store_except | update_ad
  }

  switch(state){
    is(s_idle){
      // send req to find pte
      when(sel_in.req.fire){
        state := s_wait_pte
      }
    }
    is(s_wait_pte){
      when(cache_resp_fire){
        when(illedge_page){
          // 先判断是否是合法页
          state := s_except
        }.elsewhen(get_leaf_ptw){
          // 找到了合法leaf page  需要进行权限和super page检查
          when(except | !bigpage_check){
            state := s_except
          }.otherwise{
            // success   缓存找到的pte和vpn_mask
            pte_reg := pte
            vpn_mask_reg := pg_mask
            state := s_ret
          }
        }.elsewhen(level < 2.U){
          // 没有非法page 也没有找到leaf page 并且3级页表没有遍历完，就继续遍历
          state := s_find_pte
        }.elsewhen(level === 2.U){
          // 3级页表已经遍历完，但是还有没有get_leaf_ptw ｜ except  那么也是不正常的
          state := s_except
        }
      }
    }
    is(s_find_pte){
      // send req to find pte
      when(io.toCache.req.fire){
        state := s_wait_pte
      }
    }
    is(s_ret){
      when(sel_in.resp.fire){
        state := s_idle
      }
    }
    is(s_except){
      when(sel_in.resp.fire){
        state := s_idle
      }
    }
  }

  // except_type 的逻辑   wire类型  直接在s_except状态下产生
  when(state === s_except){
    except_type := Mux(req_data.isfetch, ExceptType.IPF, MuxLookup(req_data.op_type, ExceptType.SPF, Seq(
      OpType.LD_OP  -> ExceptType.LPF,
      OpType.ST_OP  -> ExceptType.SPF,
      OpType.AMO_OP -> ExceptType.SPF
    )))
  }.otherwise{
    except_type := 0.U
  }

  // level的逻辑
  when(cache_resp_fire){
    level := level + 1.U
  }.elsewhen(state === s_idle){
    level := 0.U
  }

  // 当拿到cache的resp时候存储ppn 44bit
  when(cache_resp_fire){
    cur_ppn := io.toCache.resp.bits.data(53, 10)
  }

  // 当有req的时候 缓存到req_data里面
  when(sel_in.req.fire){
    req_data := sel_in.req.bits
  }


  // cache req的逻辑
  io.toCache.req.bits.data := 0.U       // TLB don't write data to cache
  io.toCache.req.bits.mask := "hff".U   // sv39 pte is 64bit
  io.toCache.req.bits.op := 0.U         // read
  sel_in.req.ready := state === s_idle
  when(state === s_idle){
    // idle的时候如果有req 就发送cache req
    io.toCache.req.valid := sel_in.req.valid
    // 2级页表用satp作为ppn
    io.toCache.req.bits.addr := (satp_ppn << 12).asUInt + (sel_in.req.bits.vaddr(38, 30) << 3).asUInt
  }.elsewhen(state === s_find_pte){
    // 在s_find_pte状态中发送cache req
    io.toCache.req.valid := true.B
    io.toCache.req.bits.addr := (cur_ppn << 12).asUInt + (MuxLookup(level, 0.U, Seq(
      0.U -> req_data.vaddr(38, 30).asUInt,
      1.U -> req_data.vaddr(29, 21).asUInt,
      2.U -> req_data.vaddr(20, 12).asUInt,
    )) << 3)
  }.otherwise{
    // s_wait_pte and s_ret
    io.toCache.req.valid := false.B
    io.toCache.req.bits.addr := 0.U
  }

  // sel_in resp 的逻辑
  when(state === s_ret){
    sel_in.resp.valid := true.B
    sel_in.resp.bits.pte := pte_reg
    sel_in.resp.bits.vpn_mask := vpn_mask_reg
    sel_in.resp.bits.except := 0.U
    assert(except_type === ExceptType.NO)
  }.elsewhen(state === s_except){
    sel_in.resp.valid := true.B
    sel_in.resp.bits.pte := 0.U.asTypeOf(new PTE)
    sel_in.resp.bits.vpn_mask := 0.U
    sel_in.resp.bits.except := except_type
    assert(except_type =/= ExceptType.NO)
  }.otherwise{
    sel_in.resp.valid := false.B
    sel_in.resp.bits.pte := 0.U.asTypeOf(new PTE)
    sel_in.resp.bits.vpn_mask := 0.U
    sel_in.resp.bits.except := 0.U
  }

}

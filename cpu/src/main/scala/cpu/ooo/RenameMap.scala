package cpu

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import chipsalliance.rocketchip.config._

class QueryAllocate(implicit p: Parameters) extends Bundle {
  val query_a = new Bundle {
    val lr = Flipped(Valid(UInt(5.W))) // logic register
    val pr = Valid(new Bundle {
      val idx = UInt(6.W)
      val isReady = Bool()

      val robIdx = UInt(4.W)
      val inROB = Bool()
    }) // physics register
  }

  val query_b = new Bundle {
    val lr = Flipped(Valid(UInt(5.W)))
    val pr = Valid(new Bundle {
      val idx = UInt(6.W)
      val isReady = Bool()

      val robIdx = UInt(4.W)
      val inROB = Bool()
    })
  }

  val allocate_c = new Bundle {
    val lr = Flipped(Valid(UInt(5.W))) // logic register
    val pr = Valid(UInt(6.W)) // physics register
    val current_rename_state = Valid(Vec(64, Bool()))
  }

  val valid = Input(Bool())
}

class RenameMap(implicit p: Parameters) extends Module {
  val io = IO(new Bundle {
    val port = Vec(2, new QueryAllocate)

    val cdb = Vec(2, Flipped(Valid(new CDB))) // wb
    val robCommit = new Bundle {
      val reg = Vec(2, Flipped(Valid(UInt(6.W)))) // commit
      val br_info = Flipped(Valid(new Bundle {
        val current_rename_state = Vec(64, Bool())
        val isHit = Bool()
      }))
    }


    val difftest = if (p(Difftest)) {
      Some(new Bundle {
        val toInstCommit = Vec(2, new Bundle {
          // query a reg
          val rename_state = Flipped(Valid(Vec(64, Bool())))
          val pr = Flipped(Valid(UInt(6.W)))
          val lr = Valid(UInt(5.W))
        })

        val toArchReg = Vec(2, new Bundle {
          // output 32 arch regs' prn
          val pr = Flipped(Valid(UInt(6.W)))
          val lr = Valid(UInt(5.W))
        })
      })
    } else {
      None
    }
  })

  val STATECONST = new Bundle {
    val EMPRY = 0.U(2.W)
    val MAPPED = 1.U(2.W)
    val WB = 2.U(2.W)
    val COMMIT = 3.U(2.W)
  }

  val info = new Bundle {
    val LRIdx = UInt(5.W)
    val valid = Bool()
    val state = UInt(2.W)
    val robIdx = UInt(4.W)
  }

  // 初始化的时候 逻辑寄存器0-31对应物理寄存器的0-31
  val cam = RegInit(VecInit(Seq.tabulate(32)(n => {
    val tmp = Wire(info.cloneType)
    tmp.LRIdx := n.U
    tmp.valid := true.B
    tmp.state := STATECONST.COMMIT
    tmp.robIdx := 0.U
    tmp
  }) ++ Seq.tabulate(32)(n => {
    val tmp = Wire(info.cloneType)
    tmp.LRIdx := 0.U
    tmp.valid := false.B
    tmp.state := STATECONST.EMPRY
    tmp.robIdx := 0.U
    tmp
  })))

  def quert_a_and_b(port: QueryAllocate, portIdx: Int): Unit = {
    if (portIdx > 0) {
      // 需将将port0的allocate结果前馈过来作为查询结果
      val port0_allocate_a = io.port(0).allocate_c.lr.valid & (io.port(0).allocate_c.lr.bits === port.query_a.lr.bits)
      val query_a = WireInit(VecInit(cam.map(x => x.valid & (x.LRIdx === port.query_a.lr.bits))))
      val query_a_idx = PriorityEncoder(query_a)
      port.query_a.pr.bits.idx := Mux(port0_allocate_a, io.port(0).allocate_c.pr.bits, query_a_idx)
      port.query_a.pr.bits.isReady := Mux(port0_allocate_a, false.B, (cam(query_a_idx).state === STATECONST.WB) | (cam(query_a_idx).state === STATECONST.COMMIT))
      port.query_a.pr.bits.inROB := Mux(port0_allocate_a, false.B, cam(query_a_idx).state === STATECONST.WB)
      port.query_a.pr.bits.robIdx := Mux(port0_allocate_a, 0.U, cam(query_a_idx).robIdx)
      port.query_a.pr.valid := port.query_a.lr.fire()

      val port0_allocate_b = io.port(0).allocate_c.lr.valid & (io.port(0).allocate_c.lr.bits === port.query_b.lr.bits)
      val query_b = WireInit(VecInit(cam.map(x => x.valid & (x.LRIdx === port.query_b.lr.bits))))
      val query_b_idx = PriorityEncoder(query_b)
      port.query_b.pr.bits.idx := Mux(port0_allocate_b, io.port(0).allocate_c.pr.bits, query_b_idx)
      port.query_b.pr.bits.isReady := Mux(port0_allocate_b, false.B, (cam(query_b_idx).state === STATECONST.WB) | (cam(query_b_idx).state === STATECONST.COMMIT))
      port.query_b.pr.bits.inROB := Mux(port0_allocate_b, false.B, cam(query_b_idx).state === STATECONST.WB)
      port.query_b.pr.bits.robIdx := Mux(port0_allocate_b, 0.U, cam(query_b_idx).robIdx)
      port.query_b.pr.valid := port.query_b.lr.fire()
    } else {
      // 正常查询
      // query a
      val query_a = WireInit(VecInit(cam.map(x => x.valid & (x.LRIdx === port.query_a.lr.bits))))
      val query_a_idx = PriorityEncoder(query_a)
      port.query_a.pr.bits.idx := query_a_idx
      port.query_a.pr.bits.isReady := (cam(query_a_idx).state === STATECONST.WB) | (cam(query_a_idx).state === STATECONST.COMMIT)
      port.query_a.pr.bits.inROB := cam(query_a_idx).state === STATECONST.WB
      port.query_a.pr.bits.robIdx := cam(query_a_idx).robIdx
      port.query_a.pr.valid := port.query_a.lr.fire()

      // quary b
      val query_b = WireInit(VecInit(cam.map(x => x.valid & (x.LRIdx === port.query_b.lr.bits))))
      val query_b_idx = PriorityEncoder(query_b)
      port.query_b.pr.bits.idx := query_b_idx
      port.query_b.pr.bits.isReady := (cam(query_b_idx).state === STATECONST.WB) | (cam(query_b_idx).state === STATECONST.COMMIT)
      port.query_b.pr.bits.inROB := cam(query_b_idx).state === STATECONST.WB
      port.query_b.pr.bits.robIdx := cam(query_b_idx).robIdx
      port.query_b.pr.valid := port.query_b.lr.fire()
    }
  }

  // 这里有个推测，我觉得64个物理寄存器中，必定每时每刻valid数目都是32,也就是每时每刻所有lr都有其唯一对应的pr
  val valid_64 = Wire(Vec(64, UInt(1.W)))
  (valid_64, cam.map(_.valid)).zipped.foreach(_ := _.asUInt())
  val valid_sum = Wire(UInt(8.W))
  valid_sum := valid_64.reduce(_ +& _) // + vs. +&
  val valid_value = Wire(UInt(64.W))
  dontTouch(valid_value)
  valid_value := Cat(cam.map(_.valid).reverse).asUInt()

  def allocate_c_c(emptyIdx_0: UInt, emptyIdx_1: UInt) = {
    val port0 = io.port(0).allocate_c
    val port1 = io.port(1).allocate_c

    val port0_fire_notZero = port0.lr.fire() & (port0.lr.bits =/= 0.U)
    val port1_fire_notZero = port1.lr.fire() & (port1.lr.bits =/= 0.U)

    when(port0_fire_notZero & port1_fire_notZero) {
      // allocate for 0 and 1
      when((port0.lr.bits === port1.lr.bits)) {
        // port0 and port1 allocate the same lr
        cam.foreach(x => {
          when((x.LRIdx === port0.lr.bits) | (x.LRIdx === port1.lr.bits)) {
            x.valid := false.B
          }
        })

        cam(emptyIdx_0).state := STATECONST.MAPPED
        cam(emptyIdx_0).LRIdx := port0.lr.bits
        cam(emptyIdx_0).valid := false.B

        cam(emptyIdx_1).state := STATECONST.MAPPED
        cam(emptyIdx_1).LRIdx := port1.lr.bits
        cam(emptyIdx_1).valid := true.B

        port0.pr.bits := emptyIdx_0
        port0.pr.valid := true.B

        port1.pr.bits := emptyIdx_1
        port1.pr.valid := true.B
      }.otherwise {
        cam.foreach(x => {
          when((x.LRIdx === port0.lr.bits) | (x.LRIdx === port1.lr.bits)) {
            x.valid := false.B
          }
        })

        cam(emptyIdx_0).state := STATECONST.MAPPED
        cam(emptyIdx_0).LRIdx := port0.lr.bits
        cam(emptyIdx_0).valid := true.B

        cam(emptyIdx_1).state := STATECONST.MAPPED
        cam(emptyIdx_1).LRIdx := port1.lr.bits
        cam(emptyIdx_1).valid := true.B

        port0.pr.bits := emptyIdx_0
        port0.pr.valid := true.B

        port1.pr.bits := emptyIdx_1
        port1.pr.valid := true.B
      }
      //      printf("valid_64 = %x\n", valid_64.asUInt())
      //      printf("valid_sum = %d\n", valid_sum)
      assert(valid_sum === 32.U)
    }.elsewhen(port0_fire_notZero & !port1_fire_notZero) {
      // allocate for 0
      // clear valid
      cam.foreach(x => {
        when((x.LRIdx === port0.lr.bits)) {
          x.valid := false.B
        }
      })
      cam(emptyIdx_0).state := STATECONST.MAPPED
      cam(emptyIdx_0).LRIdx := port0.lr.bits
      cam(emptyIdx_0).valid := true.B

      port0.pr.bits := emptyIdx_0
      port0.pr.valid := true.B

      port1.pr.bits := emptyIdx_1
      port1.pr.valid := false.B

      assert(valid_sum === 32.U)
    }.elsewhen((!port0_fire_notZero) & port1_fire_notZero) {
      // allocate for 1
      // clear valid
      cam.foreach(x => {
        when((x.LRIdx === port1.lr.bits)) {
          x.valid := false.B
        }
      })
      cam(emptyIdx_1).state := STATECONST.MAPPED
      cam(emptyIdx_1).LRIdx := port1.lr.bits
      cam(emptyIdx_1).valid := true.B

      port0.pr.bits := emptyIdx_0
      port0.pr.valid := false.B

      port1.pr.bits := emptyIdx_1
      port1.pr.valid := true.B

      assert(valid_sum === 32.U)
    }.otherwise {
      // none
      port0.pr.bits := emptyIdx_0
      port0.pr.valid := false.B

      port1.pr.bits := emptyIdx_1
      port1.pr.valid := false.B
    }
  }

  // query port a and b
  io.port.zipWithIndex.foreach(_ match {
    case (port, portIdx) => quert_a_and_b(port, portIdx)
  })

  // allocate port a and b
  val emptyPR = WireInit(VecInit(cam.map(x => {
    // 这里有问题解决不了， 新的映射关系只查找状态为empty的，并且在提交的时候释放之前的commit状态的
    // (x.state === STATECONST.EMPRY) | ((x.state === STATECONST.COMMIT) & !x.valid)
    x.state === STATECONST.EMPRY
  })))
  val emptyPRIdx_0 = PriorityEncoder(emptyPR)
  val emptyPRIdx_1 = 63.U - PriorityEncoder(emptyPR.reverse)
  assert(emptyPRIdx_0 =/= emptyPRIdx_1)
  allocate_c_c(emptyPRIdx_0, emptyPRIdx_1)



  // 输出当前valid状态，用于提交时候锁定体系结构寄存器，也可能会被branch指令预测失败使用
  // 有几个推测，当前inst没有提交，那么为其分配的寄存器状态一定会保持 MAPPED，WB两个状态之一
  // 所以分配emptyPR时候，(STATE===EMPTY) | (STATE === COMMIT & !valid)

  (io.port(0).allocate_c.current_rename_state.bits, cam.map(_.valid)).zipped.foreach(_ := _)
  io.port(0).allocate_c.current_rename_state.valid := io.port(0).allocate_c.lr.fire()

  (io.port(1).allocate_c.current_rename_state.bits, cam.map(_.valid)).zipped.foreach(_ := _)
  io.port(1).allocate_c.current_rename_state.valid := io.port(1).allocate_c.lr.fire()

  io.cdb.foreach(cdb => {
    when(cdb.fire() & (cdb.bits.prn =/= 0.U)) {
      cam(cdb.bits.prn).state := STATECONST.WB
      cam(cdb.bits.prn).robIdx := cdb.bits.idx
    }
  })

  io.robCommit.reg.foreach(robcommit => {
    when(robcommit.fire() & (robcommit.bits =/= 0.U)) {
      // 释放之前对lr建立的映射
      cam.foreach(x => {
        when((x.LRIdx === cam(robcommit.bits).LRIdx) & (x.state === STATECONST.COMMIT)){
          x.state := STATECONST.EMPRY
        }
      })
      // 建立新的映射, state为commit的是体系结构寄存器(逻辑寄存器)
      cam(robcommit.bits).state := STATECONST.COMMIT
    }
  })
  // commit状态的映射，每时每刻只能存在32个,分别对应32个体系结构寄存器
  assert(cam.map(_.state === STATECONST.COMMIT).map(_.asUInt()).reduce(_ +& _) === 32.U)

  when(io.robCommit.br_info.valid & !io.robCommit.br_info.bits.isHit){
    for(i <- 0 until 64){
      cam(i).valid := io.robCommit.br_info.bits.current_rename_state(i)
      cam(i).state := Mux(io.robCommit.br_info.bits.current_rename_state(i), STATECONST.COMMIT, STATECONST.EMPRY)
    }
  }

  def findCAM_LR(LRIdx: UInt, state: Vec[Bool]): UInt = {
    val query = Wire(Vec(64, Bool()))
    for (i <- 0 until 64) {
      query(i) := (cam(i).LRIdx === LRIdx) & state(i)
    }
    val idx = PriorityEncoder(query)
    idx
  }

  def findCAM_PR(PRIdx: UInt): UInt = {
    cam(PRIdx).LRIdx
  }

  if (p(Difftest)) {
    // toInstCommit  通过PR查找LR
    io.difftest.get.toInstCommit(0).lr.bits := findCAM_PR(io.difftest.get.toInstCommit(0).pr.bits)
    io.difftest.get.toInstCommit(0).lr.valid := io.difftest.get.toInstCommit(0).pr.valid
    io.difftest.get.toInstCommit(1).lr.bits := findCAM_PR(io.difftest.get.toInstCommit(1).pr.bits)
    io.difftest.get.toInstCommit(1).lr.valid := io.difftest.get.toInstCommit(1).pr.valid

    // to arch registers   通过LR找PR
    for (i <- 0 until 2) {
      io.difftest.get.toArchReg(i).lr.bits := cam(io.difftest.get.toArchReg(i).pr.bits).LRIdx
      io.difftest.get.toArchReg(i).lr.valid := io.difftest.get.toArchReg(i).pr.valid
    }
  }
}

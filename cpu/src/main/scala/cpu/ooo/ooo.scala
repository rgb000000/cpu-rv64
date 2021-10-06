import chisel3._
import chisel3.util._

class OOO(implicit p: Parameters) extends Module{
    val io = IO(new Bundle{
        val icacahe = Flipped(new CacheCPUIO)
        val dcache = Flipped(new CacheCPUIO)

        val control = Flipped(new ControlIO)
        val time_interrupt = Input(Bool())
    })

    // ifet
    val ifet = Module(new IF)
    // id
    val id = Module(new ID)
    val control = Module(new Control)
    val rename = Module(new RenameMap)
    // issue
    val station = Module(new Station)
    // ex
    val fixPointU = Module(new FixPointU)
    val mem = Module(new MemU)
    // commit
    val rob = Module(new ROB)


    // ifet
    ifet.io.icache <> io.icache

    // decoder
    control.io.inst := ifet.io.out.inst
    id.io.inst := ifet.io.out.inst
    id.io.imm_sel := control.io.
}
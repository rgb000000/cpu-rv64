module ysyx_210013_BTB(
  input         clock,
  input         reset,
  input         io_query_pc_valid,
  input  [63:0] io_query_pc_bits,
  output        io_query_res_valid,
  output [63:0] io_query_res_bits_tgt,
  output [1:0]  io_query_res_bits_bht,
  output        io_query_res_bits_is_miss,
  input         io_update_valid,
  input  [63:0] io_update_bits_pc,
  input  [63:0] io_update_bits_tgt,
  input         io_update_bits_isTaken
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [63:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [63:0] _RAND_21;
  reg [63:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [63:0] _RAND_24;
  reg [63:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [63:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [63:0] _RAND_30;
  reg [63:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [63:0] _RAND_33;
  reg [63:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [63:0] _RAND_36;
  reg [63:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [63:0] _RAND_39;
  reg [63:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [63:0] _RAND_42;
  reg [63:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [63:0] _RAND_45;
  reg [63:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] cam_0_pc; // @[Branch.scala 65:20]
  reg [63:0] cam_0_tgt; // @[Branch.scala 65:20]
  reg [1:0] cam_0_bht; // @[Branch.scala 65:20]
  reg [63:0] cam_1_pc; // @[Branch.scala 65:20]
  reg [63:0] cam_1_tgt; // @[Branch.scala 65:20]
  reg [1:0] cam_1_bht; // @[Branch.scala 65:20]
  reg [63:0] cam_2_pc; // @[Branch.scala 65:20]
  reg [63:0] cam_2_tgt; // @[Branch.scala 65:20]
  reg [1:0] cam_2_bht; // @[Branch.scala 65:20]
  reg [63:0] cam_3_pc; // @[Branch.scala 65:20]
  reg [63:0] cam_3_tgt; // @[Branch.scala 65:20]
  reg [1:0] cam_3_bht; // @[Branch.scala 65:20]
  reg [63:0] cam_4_pc; // @[Branch.scala 65:20]
  reg [63:0] cam_4_tgt; // @[Branch.scala 65:20]
  reg [1:0] cam_4_bht; // @[Branch.scala 65:20]
  reg [63:0] cam_5_pc; // @[Branch.scala 65:20]
  reg [63:0] cam_5_tgt; // @[Branch.scala 65:20]
  reg [1:0] cam_5_bht; // @[Branch.scala 65:20]
  reg [63:0] cam_6_pc; // @[Branch.scala 65:20]
  reg [63:0] cam_6_tgt; // @[Branch.scala 65:20]
  reg [1:0] cam_6_bht; // @[Branch.scala 65:20]
  reg [63:0] cam_7_pc; // @[Branch.scala 65:20]
  reg [63:0] cam_7_tgt; // @[Branch.scala 65:20]
  reg [1:0] cam_7_bht; // @[Branch.scala 65:20]
  reg [63:0] cam_8_pc; // @[Branch.scala 65:20]
  reg [63:0] cam_8_tgt; // @[Branch.scala 65:20]
  reg [1:0] cam_8_bht; // @[Branch.scala 65:20]
  reg [63:0] cam_9_pc; // @[Branch.scala 65:20]
  reg [63:0] cam_9_tgt; // @[Branch.scala 65:20]
  reg [1:0] cam_9_bht; // @[Branch.scala 65:20]
  reg [63:0] cam_10_pc; // @[Branch.scala 65:20]
  reg [63:0] cam_10_tgt; // @[Branch.scala 65:20]
  reg [1:0] cam_10_bht; // @[Branch.scala 65:20]
  reg [63:0] cam_11_pc; // @[Branch.scala 65:20]
  reg [63:0] cam_11_tgt; // @[Branch.scala 65:20]
  reg [1:0] cam_11_bht; // @[Branch.scala 65:20]
  reg [63:0] cam_12_pc; // @[Branch.scala 65:20]
  reg [63:0] cam_12_tgt; // @[Branch.scala 65:20]
  reg [1:0] cam_12_bht; // @[Branch.scala 65:20]
  reg [63:0] cam_13_pc; // @[Branch.scala 65:20]
  reg [63:0] cam_13_tgt; // @[Branch.scala 65:20]
  reg [1:0] cam_13_bht; // @[Branch.scala 65:20]
  reg [63:0] cam_14_pc; // @[Branch.scala 65:20]
  reg [63:0] cam_14_tgt; // @[Branch.scala 65:20]
  reg [1:0] cam_14_bht; // @[Branch.scala 65:20]
  reg [63:0] cam_15_pc; // @[Branch.scala 65:20]
  reg [63:0] cam_15_tgt; // @[Branch.scala 65:20]
  reg [1:0] cam_15_bht; // @[Branch.scala 65:20]
  reg [3:0] value; // @[Counter.scala 60:40]
  wire  query_compare_res_lo_lo_lo_lo = cam_0_pc == io_query_pc_bits; // @[Branch.scala 69:51]
  wire  query_compare_res_lo_lo_lo_hi = cam_1_pc == io_query_pc_bits; // @[Branch.scala 69:51]
  wire  query_compare_res_lo_lo_hi_lo = cam_2_pc == io_query_pc_bits; // @[Branch.scala 69:51]
  wire  query_compare_res_lo_lo_hi_hi = cam_3_pc == io_query_pc_bits; // @[Branch.scala 69:51]
  wire  query_compare_res_lo_hi_lo_lo = cam_4_pc == io_query_pc_bits; // @[Branch.scala 69:51]
  wire  query_compare_res_lo_hi_lo_hi = cam_5_pc == io_query_pc_bits; // @[Branch.scala 69:51]
  wire  query_compare_res_lo_hi_hi_lo = cam_6_pc == io_query_pc_bits; // @[Branch.scala 69:51]
  wire  query_compare_res_lo_hi_hi_hi = cam_7_pc == io_query_pc_bits; // @[Branch.scala 69:51]
  wire  query_compare_res_hi_lo_lo_lo = cam_8_pc == io_query_pc_bits; // @[Branch.scala 69:51]
  wire  query_compare_res_hi_lo_lo_hi = cam_9_pc == io_query_pc_bits; // @[Branch.scala 69:51]
  wire  query_compare_res_hi_lo_hi_lo = cam_10_pc == io_query_pc_bits; // @[Branch.scala 69:51]
  wire  query_compare_res_hi_lo_hi_hi = cam_11_pc == io_query_pc_bits; // @[Branch.scala 69:51]
  wire  query_compare_res_hi_hi_lo_lo = cam_12_pc == io_query_pc_bits; // @[Branch.scala 69:51]
  wire  query_compare_res_hi_hi_lo_hi = cam_13_pc == io_query_pc_bits; // @[Branch.scala 69:51]
  wire  query_compare_res_hi_hi_hi_lo = cam_14_pc == io_query_pc_bits; // @[Branch.scala 69:51]
  wire  query_compare_res_hi_hi_hi_hi = cam_15_pc == io_query_pc_bits; // @[Branch.scala 69:51]
  wire [7:0] query_compare_res_lo = {query_compare_res_lo_hi_hi_hi,query_compare_res_lo_hi_hi_lo,
    query_compare_res_lo_hi_lo_hi,query_compare_res_lo_hi_lo_lo,query_compare_res_lo_lo_hi_hi,
    query_compare_res_lo_lo_hi_lo,query_compare_res_lo_lo_lo_hi,query_compare_res_lo_lo_lo_lo}; // @[Cat.scala 30:58]
  wire [15:0] query_compare_res = {query_compare_res_hi_hi_hi_hi,query_compare_res_hi_hi_hi_lo,
    query_compare_res_hi_hi_lo_hi,query_compare_res_hi_hi_lo_lo,query_compare_res_hi_lo_hi_hi,
    query_compare_res_hi_lo_hi_lo,query_compare_res_hi_lo_lo_hi,query_compare_res_hi_lo_lo_lo,query_compare_res_lo}; // @[Cat.scala 30:58]
  wire [1:0] _query_select_data_T_16 = query_compare_res[0] ? cam_0_bht : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_17 = query_compare_res[1] ? cam_1_bht : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_18 = query_compare_res[2] ? cam_2_bht : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_19 = query_compare_res[3] ? cam_3_bht : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_20 = query_compare_res[4] ? cam_4_bht : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_21 = query_compare_res[5] ? cam_5_bht : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_22 = query_compare_res[6] ? cam_6_bht : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_23 = query_compare_res[7] ? cam_7_bht : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_24 = query_compare_res[8] ? cam_8_bht : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_25 = query_compare_res[9] ? cam_9_bht : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_26 = query_compare_res[10] ? cam_10_bht : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_27 = query_compare_res[11] ? cam_11_bht : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_28 = query_compare_res[12] ? cam_12_bht : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_29 = query_compare_res[13] ? cam_13_bht : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_30 = query_compare_res[14] ? cam_14_bht : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_31 = query_compare_res[15] ? cam_15_bht : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_32 = _query_select_data_T_16 | _query_select_data_T_17; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_33 = _query_select_data_T_32 | _query_select_data_T_18; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_34 = _query_select_data_T_33 | _query_select_data_T_19; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_35 = _query_select_data_T_34 | _query_select_data_T_20; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_36 = _query_select_data_T_35 | _query_select_data_T_21; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_37 = _query_select_data_T_36 | _query_select_data_T_22; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_38 = _query_select_data_T_37 | _query_select_data_T_23; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_39 = _query_select_data_T_38 | _query_select_data_T_24; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_40 = _query_select_data_T_39 | _query_select_data_T_25; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_41 = _query_select_data_T_40 | _query_select_data_T_26; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_42 = _query_select_data_T_41 | _query_select_data_T_27; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_43 = _query_select_data_T_42 | _query_select_data_T_28; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_44 = _query_select_data_T_43 | _query_select_data_T_29; // @[Mux.scala 27:72]
  wire [1:0] _query_select_data_T_45 = _query_select_data_T_44 | _query_select_data_T_30; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_47 = query_compare_res[0] ? cam_0_tgt : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_48 = query_compare_res[1] ? cam_1_tgt : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_49 = query_compare_res[2] ? cam_2_tgt : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_50 = query_compare_res[3] ? cam_3_tgt : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_51 = query_compare_res[4] ? cam_4_tgt : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_52 = query_compare_res[5] ? cam_5_tgt : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_53 = query_compare_res[6] ? cam_6_tgt : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_54 = query_compare_res[7] ? cam_7_tgt : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_55 = query_compare_res[8] ? cam_8_tgt : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_56 = query_compare_res[9] ? cam_9_tgt : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_57 = query_compare_res[10] ? cam_10_tgt : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_58 = query_compare_res[11] ? cam_11_tgt : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_59 = query_compare_res[12] ? cam_12_tgt : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_60 = query_compare_res[13] ? cam_13_tgt : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_61 = query_compare_res[14] ? cam_14_tgt : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_62 = query_compare_res[15] ? cam_15_tgt : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_63 = _query_select_data_T_47 | _query_select_data_T_48; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_64 = _query_select_data_T_63 | _query_select_data_T_49; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_65 = _query_select_data_T_64 | _query_select_data_T_50; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_66 = _query_select_data_T_65 | _query_select_data_T_51; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_67 = _query_select_data_T_66 | _query_select_data_T_52; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_68 = _query_select_data_T_67 | _query_select_data_T_53; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_69 = _query_select_data_T_68 | _query_select_data_T_54; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_70 = _query_select_data_T_69 | _query_select_data_T_55; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_71 = _query_select_data_T_70 | _query_select_data_T_56; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_72 = _query_select_data_T_71 | _query_select_data_T_57; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_73 = _query_select_data_T_72 | _query_select_data_T_58; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_74 = _query_select_data_T_73 | _query_select_data_T_59; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_75 = _query_select_data_T_74 | _query_select_data_T_60; // @[Mux.scala 27:72]
  wire [63:0] _query_select_data_T_76 = _query_select_data_T_75 | _query_select_data_T_61; // @[Mux.scala 27:72]
  wire  update_compare_res_hi_hi_hi_hi = cam_0_pc == io_update_bits_pc; // @[Branch.scala 78:52]
  wire  update_compare_res_hi_hi_hi_lo = cam_1_pc == io_update_bits_pc; // @[Branch.scala 78:52]
  wire  update_compare_res_hi_hi_lo_hi = cam_2_pc == io_update_bits_pc; // @[Branch.scala 78:52]
  wire  update_compare_res_hi_hi_lo_lo = cam_3_pc == io_update_bits_pc; // @[Branch.scala 78:52]
  wire  update_compare_res_hi_lo_hi_hi = cam_4_pc == io_update_bits_pc; // @[Branch.scala 78:52]
  wire  update_compare_res_hi_lo_hi_lo = cam_5_pc == io_update_bits_pc; // @[Branch.scala 78:52]
  wire  update_compare_res_hi_lo_lo_hi = cam_6_pc == io_update_bits_pc; // @[Branch.scala 78:52]
  wire  update_compare_res_hi_lo_lo_lo = cam_7_pc == io_update_bits_pc; // @[Branch.scala 78:52]
  wire  update_compare_res_lo_hi_hi_hi = cam_8_pc == io_update_bits_pc; // @[Branch.scala 78:52]
  wire  update_compare_res_lo_hi_hi_lo = cam_9_pc == io_update_bits_pc; // @[Branch.scala 78:52]
  wire  update_compare_res_lo_hi_lo_hi = cam_10_pc == io_update_bits_pc; // @[Branch.scala 78:52]
  wire  update_compare_res_lo_hi_lo_lo = cam_11_pc == io_update_bits_pc; // @[Branch.scala 78:52]
  wire  update_compare_res_lo_lo_hi_hi = cam_12_pc == io_update_bits_pc; // @[Branch.scala 78:52]
  wire  update_compare_res_lo_lo_hi_lo = cam_13_pc == io_update_bits_pc; // @[Branch.scala 78:52]
  wire  update_compare_res_lo_lo_lo_hi = cam_14_pc == io_update_bits_pc; // @[Branch.scala 78:52]
  wire  update_compare_res_lo_lo_lo_lo = cam_15_pc == io_update_bits_pc; // @[Branch.scala 78:52]
  wire [7:0] update_compare_res_lo = {update_compare_res_lo_hi_hi_hi,update_compare_res_lo_hi_hi_lo,
    update_compare_res_lo_hi_lo_hi,update_compare_res_lo_hi_lo_lo,update_compare_res_lo_lo_hi_hi,
    update_compare_res_lo_lo_hi_lo,update_compare_res_lo_lo_lo_hi,update_compare_res_lo_lo_lo_lo}; // @[Cat.scala 30:58]
  wire [15:0] update_compare_res = {update_compare_res_hi_hi_hi_hi,update_compare_res_hi_hi_hi_lo,
    update_compare_res_hi_hi_lo_hi,update_compare_res_hi_hi_lo_lo,update_compare_res_hi_lo_hi_hi,
    update_compare_res_hi_lo_hi_lo,update_compare_res_hi_lo_lo_hi,update_compare_res_hi_lo_lo_lo,update_compare_res_lo}; // @[Cat.scala 30:58]
  wire  update_is_miss = ~(|update_compare_res); // @[Branch.scala 79:49]
  wire  update_index_lo_lo_lo_lo = update_compare_res[0]; // @[Branch.scala 80:70]
  wire  update_index_lo_lo_lo_hi = update_compare_res[1]; // @[Branch.scala 80:70]
  wire  update_index_lo_lo_hi_lo = update_compare_res[2]; // @[Branch.scala 80:70]
  wire  update_index_lo_lo_hi_hi = update_compare_res[3]; // @[Branch.scala 80:70]
  wire  update_index_lo_hi_lo_lo = update_compare_res[4]; // @[Branch.scala 80:70]
  wire  update_index_lo_hi_lo_hi = update_compare_res[5]; // @[Branch.scala 80:70]
  wire  update_index_lo_hi_hi_lo = update_compare_res[6]; // @[Branch.scala 80:70]
  wire  update_index_lo_hi_hi_hi = update_compare_res[7]; // @[Branch.scala 80:70]
  wire  update_index_hi_lo_lo_lo = update_compare_res[8]; // @[Branch.scala 80:70]
  wire  update_index_hi_lo_lo_hi = update_compare_res[9]; // @[Branch.scala 80:70]
  wire  update_index_hi_lo_hi_lo = update_compare_res[10]; // @[Branch.scala 80:70]
  wire  update_index_hi_lo_hi_hi = update_compare_res[11]; // @[Branch.scala 80:70]
  wire  update_index_hi_hi_lo_lo = update_compare_res[12]; // @[Branch.scala 80:70]
  wire  update_index_hi_hi_lo_hi = update_compare_res[13]; // @[Branch.scala 80:70]
  wire  update_index_hi_hi_hi_lo = update_compare_res[14]; // @[Branch.scala 80:70]
  wire  update_index_hi_hi_hi_hi = update_compare_res[15]; // @[Branch.scala 80:70]
  wire [7:0] update_index_lo = {update_index_lo_hi_hi_hi,update_index_lo_hi_hi_lo,update_index_lo_hi_lo_hi,
    update_index_lo_hi_lo_lo,update_index_lo_lo_hi_hi,update_index_lo_lo_hi_lo,update_index_lo_lo_lo_hi,
    update_index_lo_lo_lo_lo}; // @[Cat.scala 30:58]
  wire [15:0] _update_index_T = {update_index_hi_hi_hi_hi,update_index_hi_hi_hi_lo,update_index_hi_hi_lo_hi,
    update_index_hi_hi_lo_lo,update_index_hi_lo_hi_hi,update_index_hi_lo_hi_lo,update_index_hi_lo_lo_hi,
    update_index_hi_lo_lo_lo,update_index_lo}; // @[Cat.scala 30:58]
  wire [15:0] _update_index_T_17 = _update_index_T[15] ? 16'h8000 : 16'h0; // @[Mux.scala 47:69]
  wire [15:0] _update_index_T_18 = _update_index_T[14] ? 16'h4000 : _update_index_T_17; // @[Mux.scala 47:69]
  wire [15:0] _update_index_T_19 = _update_index_T[13] ? 16'h2000 : _update_index_T_18; // @[Mux.scala 47:69]
  wire [15:0] _update_index_T_20 = _update_index_T[12] ? 16'h1000 : _update_index_T_19; // @[Mux.scala 47:69]
  wire [15:0] _update_index_T_21 = _update_index_T[11] ? 16'h800 : _update_index_T_20; // @[Mux.scala 47:69]
  wire [15:0] _update_index_T_22 = _update_index_T[10] ? 16'h400 : _update_index_T_21; // @[Mux.scala 47:69]
  wire [15:0] _update_index_T_23 = _update_index_T[9] ? 16'h200 : _update_index_T_22; // @[Mux.scala 47:69]
  wire [15:0] _update_index_T_24 = _update_index_T[8] ? 16'h100 : _update_index_T_23; // @[Mux.scala 47:69]
  wire [15:0] _update_index_T_25 = _update_index_T[7] ? 16'h80 : _update_index_T_24; // @[Mux.scala 47:69]
  wire [15:0] _update_index_T_26 = _update_index_T[6] ? 16'h40 : _update_index_T_25; // @[Mux.scala 47:69]
  wire [15:0] _update_index_T_27 = _update_index_T[5] ? 16'h20 : _update_index_T_26; // @[Mux.scala 47:69]
  wire [15:0] _update_index_T_28 = _update_index_T[4] ? 16'h10 : _update_index_T_27; // @[Mux.scala 47:69]
  wire [15:0] _update_index_T_29 = _update_index_T[3] ? 16'h8 : _update_index_T_28; // @[Mux.scala 47:69]
  wire [15:0] _update_index_T_30 = _update_index_T[2] ? 16'h4 : _update_index_T_29; // @[Mux.scala 47:69]
  wire [15:0] _update_index_T_31 = _update_index_T[1] ? 16'h2 : _update_index_T_30; // @[Mux.scala 47:69]
  wire [15:0] update_index = _update_index_T[0] ? 16'h1 : _update_index_T_31; // @[Mux.scala 47:69]
  wire [1:0] _GEN_17 = 4'h1 == update_index[3:0] ? cam_1_bht : cam_0_bht; // @[Branch.scala 84:58 Branch.scala 84:58]
  wire [1:0] _GEN_18 = 4'h2 == update_index[3:0] ? cam_2_bht : _GEN_17; // @[Branch.scala 84:58 Branch.scala 84:58]
  wire [1:0] _GEN_19 = 4'h3 == update_index[3:0] ? cam_3_bht : _GEN_18; // @[Branch.scala 84:58 Branch.scala 84:58]
  wire [1:0] _GEN_20 = 4'h4 == update_index[3:0] ? cam_4_bht : _GEN_19; // @[Branch.scala 84:58 Branch.scala 84:58]
  wire [1:0] _GEN_21 = 4'h5 == update_index[3:0] ? cam_5_bht : _GEN_20; // @[Branch.scala 84:58 Branch.scala 84:58]
  wire [1:0] _GEN_22 = 4'h6 == update_index[3:0] ? cam_6_bht : _GEN_21; // @[Branch.scala 84:58 Branch.scala 84:58]
  wire [1:0] _GEN_23 = 4'h7 == update_index[3:0] ? cam_7_bht : _GEN_22; // @[Branch.scala 84:58 Branch.scala 84:58]
  wire [1:0] _GEN_24 = 4'h8 == update_index[3:0] ? cam_8_bht : _GEN_23; // @[Branch.scala 84:58 Branch.scala 84:58]
  wire [1:0] _GEN_25 = 4'h9 == update_index[3:0] ? cam_9_bht : _GEN_24; // @[Branch.scala 84:58 Branch.scala 84:58]
  wire [1:0] _GEN_26 = 4'ha == update_index[3:0] ? cam_10_bht : _GEN_25; // @[Branch.scala 84:58 Branch.scala 84:58]
  wire [1:0] _GEN_27 = 4'hb == update_index[3:0] ? cam_11_bht : _GEN_26; // @[Branch.scala 84:58 Branch.scala 84:58]
  wire [1:0] _GEN_28 = 4'hc == update_index[3:0] ? cam_12_bht : _GEN_27; // @[Branch.scala 84:58 Branch.scala 84:58]
  wire [1:0] _GEN_29 = 4'hd == update_index[3:0] ? cam_13_bht : _GEN_28; // @[Branch.scala 84:58 Branch.scala 84:58]
  wire [1:0] _GEN_30 = 4'he == update_index[3:0] ? cam_14_bht : _GEN_29; // @[Branch.scala 84:58 Branch.scala 84:58]
  wire [1:0] _GEN_31 = 4'hf == update_index[3:0] ? cam_15_bht : _GEN_30; // @[Branch.scala 84:58 Branch.scala 84:58]
  wire [1:0] _cam_bht_T_2 = _GEN_31 + 2'h1; // @[Branch.scala 85:54]
  wire [1:0] _cam_bht_T_5 = _GEN_31 - 2'h1; // @[Branch.scala 87:54]
  wire [1:0] _GEN_96 = 4'h0 == update_index[3:0] ? _cam_bht_T_5 : cam_0_bht; // @[Branch.scala 87:29 Branch.scala 87:29 Branch.scala 65:20]
  wire [1:0] _GEN_97 = 4'h1 == update_index[3:0] ? _cam_bht_T_5 : cam_1_bht; // @[Branch.scala 87:29 Branch.scala 87:29 Branch.scala 65:20]
  wire [1:0] _GEN_98 = 4'h2 == update_index[3:0] ? _cam_bht_T_5 : cam_2_bht; // @[Branch.scala 87:29 Branch.scala 87:29 Branch.scala 65:20]
  wire [1:0] _GEN_99 = 4'h3 == update_index[3:0] ? _cam_bht_T_5 : cam_3_bht; // @[Branch.scala 87:29 Branch.scala 87:29 Branch.scala 65:20]
  wire [1:0] _GEN_100 = 4'h4 == update_index[3:0] ? _cam_bht_T_5 : cam_4_bht; // @[Branch.scala 87:29 Branch.scala 87:29 Branch.scala 65:20]
  wire [1:0] _GEN_101 = 4'h5 == update_index[3:0] ? _cam_bht_T_5 : cam_5_bht; // @[Branch.scala 87:29 Branch.scala 87:29 Branch.scala 65:20]
  wire [1:0] _GEN_102 = 4'h6 == update_index[3:0] ? _cam_bht_T_5 : cam_6_bht; // @[Branch.scala 87:29 Branch.scala 87:29 Branch.scala 65:20]
  wire [1:0] _GEN_103 = 4'h7 == update_index[3:0] ? _cam_bht_T_5 : cam_7_bht; // @[Branch.scala 87:29 Branch.scala 87:29 Branch.scala 65:20]
  wire [1:0] _GEN_104 = 4'h8 == update_index[3:0] ? _cam_bht_T_5 : cam_8_bht; // @[Branch.scala 87:29 Branch.scala 87:29 Branch.scala 65:20]
  wire [1:0] _GEN_105 = 4'h9 == update_index[3:0] ? _cam_bht_T_5 : cam_9_bht; // @[Branch.scala 87:29 Branch.scala 87:29 Branch.scala 65:20]
  wire [1:0] _GEN_106 = 4'ha == update_index[3:0] ? _cam_bht_T_5 : cam_10_bht; // @[Branch.scala 87:29 Branch.scala 87:29 Branch.scala 65:20]
  wire [1:0] _GEN_107 = 4'hb == update_index[3:0] ? _cam_bht_T_5 : cam_11_bht; // @[Branch.scala 87:29 Branch.scala 87:29 Branch.scala 65:20]
  wire [1:0] _GEN_108 = 4'hc == update_index[3:0] ? _cam_bht_T_5 : cam_12_bht; // @[Branch.scala 87:29 Branch.scala 87:29 Branch.scala 65:20]
  wire [1:0] _GEN_109 = 4'hd == update_index[3:0] ? _cam_bht_T_5 : cam_13_bht; // @[Branch.scala 87:29 Branch.scala 87:29 Branch.scala 65:20]
  wire [1:0] _GEN_110 = 4'he == update_index[3:0] ? _cam_bht_T_5 : cam_14_bht; // @[Branch.scala 87:29 Branch.scala 87:29 Branch.scala 65:20]
  wire [1:0] _GEN_111 = 4'hf == update_index[3:0] ? _cam_bht_T_5 : cam_15_bht; // @[Branch.scala 87:29 Branch.scala 87:29 Branch.scala 65:20]
  wire [1:0] _cam_bht_T_6 = io_update_bits_isTaken ? 2'h2 : 2'h1; // @[Branch.scala 93:30]
  wire [3:0] _value_T_1 = value + 4'h1; // @[Counter.scala 76:24]
  assign io_query_res_valid = io_query_pc_valid; // @[Branch.scala 72:22]
  assign io_query_res_bits_tgt = _query_select_data_T_76 | _query_select_data_T_62; // @[Mux.scala 27:72]
  assign io_query_res_bits_bht = _query_select_data_T_45 | _query_select_data_T_31; // @[Mux.scala 27:72]
  assign io_query_res_bits_is_miss = ~(|query_compare_res); // @[Branch.scala 70:47]
  always @(posedge clock) begin
    if (reset) begin // @[Branch.scala 65:20]
      cam_0_pc <= 64'h0; // @[Branch.scala 65:20]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        if (4'h0 == value) begin // @[Branch.scala 91:23]
          cam_0_pc <= io_update_bits_pc; // @[Branch.scala 91:23]
        end
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_0_tgt <= 64'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (4'h0 == update_index[3:0]) begin // @[Branch.scala 83:27]
        cam_0_tgt <= io_update_bits_tgt; // @[Branch.scala 83:27]
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h0 == value) begin // @[Branch.scala 92:24]
        cam_0_tgt <= io_update_bits_tgt; // @[Branch.scala 92:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_0_bht <= 2'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (io_update_bits_isTaken & _GEN_31 != 2'h3) begin // @[Branch.scala 84:71]
        if (4'h0 == update_index[3:0]) begin // @[Branch.scala 85:29]
          cam_0_bht <= _cam_bht_T_2; // @[Branch.scala 85:29]
        end
      end else if (~io_update_bits_isTaken & _GEN_31 != 2'h0) begin // @[Branch.scala 86:78]
        cam_0_bht <= _GEN_96;
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h0 == value) begin // @[Branch.scala 93:24]
        cam_0_bht <= _cam_bht_T_6; // @[Branch.scala 93:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_1_pc <= 64'h0; // @[Branch.scala 65:20]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        if (4'h1 == value) begin // @[Branch.scala 91:23]
          cam_1_pc <= io_update_bits_pc; // @[Branch.scala 91:23]
        end
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_1_tgt <= 64'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (4'h1 == update_index[3:0]) begin // @[Branch.scala 83:27]
        cam_1_tgt <= io_update_bits_tgt; // @[Branch.scala 83:27]
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h1 == value) begin // @[Branch.scala 92:24]
        cam_1_tgt <= io_update_bits_tgt; // @[Branch.scala 92:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_1_bht <= 2'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (io_update_bits_isTaken & _GEN_31 != 2'h3) begin // @[Branch.scala 84:71]
        if (4'h1 == update_index[3:0]) begin // @[Branch.scala 85:29]
          cam_1_bht <= _cam_bht_T_2; // @[Branch.scala 85:29]
        end
      end else if (~io_update_bits_isTaken & _GEN_31 != 2'h0) begin // @[Branch.scala 86:78]
        cam_1_bht <= _GEN_97;
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h1 == value) begin // @[Branch.scala 93:24]
        cam_1_bht <= _cam_bht_T_6; // @[Branch.scala 93:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_2_pc <= 64'h0; // @[Branch.scala 65:20]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        if (4'h2 == value) begin // @[Branch.scala 91:23]
          cam_2_pc <= io_update_bits_pc; // @[Branch.scala 91:23]
        end
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_2_tgt <= 64'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (4'h2 == update_index[3:0]) begin // @[Branch.scala 83:27]
        cam_2_tgt <= io_update_bits_tgt; // @[Branch.scala 83:27]
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h2 == value) begin // @[Branch.scala 92:24]
        cam_2_tgt <= io_update_bits_tgt; // @[Branch.scala 92:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_2_bht <= 2'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (io_update_bits_isTaken & _GEN_31 != 2'h3) begin // @[Branch.scala 84:71]
        if (4'h2 == update_index[3:0]) begin // @[Branch.scala 85:29]
          cam_2_bht <= _cam_bht_T_2; // @[Branch.scala 85:29]
        end
      end else if (~io_update_bits_isTaken & _GEN_31 != 2'h0) begin // @[Branch.scala 86:78]
        cam_2_bht <= _GEN_98;
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h2 == value) begin // @[Branch.scala 93:24]
        cam_2_bht <= _cam_bht_T_6; // @[Branch.scala 93:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_3_pc <= 64'h0; // @[Branch.scala 65:20]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        if (4'h3 == value) begin // @[Branch.scala 91:23]
          cam_3_pc <= io_update_bits_pc; // @[Branch.scala 91:23]
        end
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_3_tgt <= 64'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (4'h3 == update_index[3:0]) begin // @[Branch.scala 83:27]
        cam_3_tgt <= io_update_bits_tgt; // @[Branch.scala 83:27]
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h3 == value) begin // @[Branch.scala 92:24]
        cam_3_tgt <= io_update_bits_tgt; // @[Branch.scala 92:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_3_bht <= 2'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (io_update_bits_isTaken & _GEN_31 != 2'h3) begin // @[Branch.scala 84:71]
        if (4'h3 == update_index[3:0]) begin // @[Branch.scala 85:29]
          cam_3_bht <= _cam_bht_T_2; // @[Branch.scala 85:29]
        end
      end else if (~io_update_bits_isTaken & _GEN_31 != 2'h0) begin // @[Branch.scala 86:78]
        cam_3_bht <= _GEN_99;
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h3 == value) begin // @[Branch.scala 93:24]
        cam_3_bht <= _cam_bht_T_6; // @[Branch.scala 93:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_4_pc <= 64'h0; // @[Branch.scala 65:20]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        if (4'h4 == value) begin // @[Branch.scala 91:23]
          cam_4_pc <= io_update_bits_pc; // @[Branch.scala 91:23]
        end
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_4_tgt <= 64'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (4'h4 == update_index[3:0]) begin // @[Branch.scala 83:27]
        cam_4_tgt <= io_update_bits_tgt; // @[Branch.scala 83:27]
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h4 == value) begin // @[Branch.scala 92:24]
        cam_4_tgt <= io_update_bits_tgt; // @[Branch.scala 92:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_4_bht <= 2'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (io_update_bits_isTaken & _GEN_31 != 2'h3) begin // @[Branch.scala 84:71]
        if (4'h4 == update_index[3:0]) begin // @[Branch.scala 85:29]
          cam_4_bht <= _cam_bht_T_2; // @[Branch.scala 85:29]
        end
      end else if (~io_update_bits_isTaken & _GEN_31 != 2'h0) begin // @[Branch.scala 86:78]
        cam_4_bht <= _GEN_100;
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h4 == value) begin // @[Branch.scala 93:24]
        cam_4_bht <= _cam_bht_T_6; // @[Branch.scala 93:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_5_pc <= 64'h0; // @[Branch.scala 65:20]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        if (4'h5 == value) begin // @[Branch.scala 91:23]
          cam_5_pc <= io_update_bits_pc; // @[Branch.scala 91:23]
        end
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_5_tgt <= 64'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (4'h5 == update_index[3:0]) begin // @[Branch.scala 83:27]
        cam_5_tgt <= io_update_bits_tgt; // @[Branch.scala 83:27]
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h5 == value) begin // @[Branch.scala 92:24]
        cam_5_tgt <= io_update_bits_tgt; // @[Branch.scala 92:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_5_bht <= 2'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (io_update_bits_isTaken & _GEN_31 != 2'h3) begin // @[Branch.scala 84:71]
        if (4'h5 == update_index[3:0]) begin // @[Branch.scala 85:29]
          cam_5_bht <= _cam_bht_T_2; // @[Branch.scala 85:29]
        end
      end else if (~io_update_bits_isTaken & _GEN_31 != 2'h0) begin // @[Branch.scala 86:78]
        cam_5_bht <= _GEN_101;
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h5 == value) begin // @[Branch.scala 93:24]
        cam_5_bht <= _cam_bht_T_6; // @[Branch.scala 93:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_6_pc <= 64'h0; // @[Branch.scala 65:20]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        if (4'h6 == value) begin // @[Branch.scala 91:23]
          cam_6_pc <= io_update_bits_pc; // @[Branch.scala 91:23]
        end
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_6_tgt <= 64'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (4'h6 == update_index[3:0]) begin // @[Branch.scala 83:27]
        cam_6_tgt <= io_update_bits_tgt; // @[Branch.scala 83:27]
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h6 == value) begin // @[Branch.scala 92:24]
        cam_6_tgt <= io_update_bits_tgt; // @[Branch.scala 92:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_6_bht <= 2'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (io_update_bits_isTaken & _GEN_31 != 2'h3) begin // @[Branch.scala 84:71]
        if (4'h6 == update_index[3:0]) begin // @[Branch.scala 85:29]
          cam_6_bht <= _cam_bht_T_2; // @[Branch.scala 85:29]
        end
      end else if (~io_update_bits_isTaken & _GEN_31 != 2'h0) begin // @[Branch.scala 86:78]
        cam_6_bht <= _GEN_102;
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h6 == value) begin // @[Branch.scala 93:24]
        cam_6_bht <= _cam_bht_T_6; // @[Branch.scala 93:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_7_pc <= 64'h0; // @[Branch.scala 65:20]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        if (4'h7 == value) begin // @[Branch.scala 91:23]
          cam_7_pc <= io_update_bits_pc; // @[Branch.scala 91:23]
        end
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_7_tgt <= 64'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (4'h7 == update_index[3:0]) begin // @[Branch.scala 83:27]
        cam_7_tgt <= io_update_bits_tgt; // @[Branch.scala 83:27]
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h7 == value) begin // @[Branch.scala 92:24]
        cam_7_tgt <= io_update_bits_tgt; // @[Branch.scala 92:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_7_bht <= 2'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (io_update_bits_isTaken & _GEN_31 != 2'h3) begin // @[Branch.scala 84:71]
        if (4'h7 == update_index[3:0]) begin // @[Branch.scala 85:29]
          cam_7_bht <= _cam_bht_T_2; // @[Branch.scala 85:29]
        end
      end else if (~io_update_bits_isTaken & _GEN_31 != 2'h0) begin // @[Branch.scala 86:78]
        cam_7_bht <= _GEN_103;
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h7 == value) begin // @[Branch.scala 93:24]
        cam_7_bht <= _cam_bht_T_6; // @[Branch.scala 93:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_8_pc <= 64'h0; // @[Branch.scala 65:20]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        if (4'h8 == value) begin // @[Branch.scala 91:23]
          cam_8_pc <= io_update_bits_pc; // @[Branch.scala 91:23]
        end
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_8_tgt <= 64'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (4'h8 == update_index[3:0]) begin // @[Branch.scala 83:27]
        cam_8_tgt <= io_update_bits_tgt; // @[Branch.scala 83:27]
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h8 == value) begin // @[Branch.scala 92:24]
        cam_8_tgt <= io_update_bits_tgt; // @[Branch.scala 92:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_8_bht <= 2'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (io_update_bits_isTaken & _GEN_31 != 2'h3) begin // @[Branch.scala 84:71]
        if (4'h8 == update_index[3:0]) begin // @[Branch.scala 85:29]
          cam_8_bht <= _cam_bht_T_2; // @[Branch.scala 85:29]
        end
      end else if (~io_update_bits_isTaken & _GEN_31 != 2'h0) begin // @[Branch.scala 86:78]
        cam_8_bht <= _GEN_104;
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h8 == value) begin // @[Branch.scala 93:24]
        cam_8_bht <= _cam_bht_T_6; // @[Branch.scala 93:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_9_pc <= 64'h0; // @[Branch.scala 65:20]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        if (4'h9 == value) begin // @[Branch.scala 91:23]
          cam_9_pc <= io_update_bits_pc; // @[Branch.scala 91:23]
        end
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_9_tgt <= 64'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (4'h9 == update_index[3:0]) begin // @[Branch.scala 83:27]
        cam_9_tgt <= io_update_bits_tgt; // @[Branch.scala 83:27]
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h9 == value) begin // @[Branch.scala 92:24]
        cam_9_tgt <= io_update_bits_tgt; // @[Branch.scala 92:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_9_bht <= 2'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (io_update_bits_isTaken & _GEN_31 != 2'h3) begin // @[Branch.scala 84:71]
        if (4'h9 == update_index[3:0]) begin // @[Branch.scala 85:29]
          cam_9_bht <= _cam_bht_T_2; // @[Branch.scala 85:29]
        end
      end else if (~io_update_bits_isTaken & _GEN_31 != 2'h0) begin // @[Branch.scala 86:78]
        cam_9_bht <= _GEN_105;
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'h9 == value) begin // @[Branch.scala 93:24]
        cam_9_bht <= _cam_bht_T_6; // @[Branch.scala 93:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_10_pc <= 64'h0; // @[Branch.scala 65:20]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        if (4'ha == value) begin // @[Branch.scala 91:23]
          cam_10_pc <= io_update_bits_pc; // @[Branch.scala 91:23]
        end
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_10_tgt <= 64'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (4'ha == update_index[3:0]) begin // @[Branch.scala 83:27]
        cam_10_tgt <= io_update_bits_tgt; // @[Branch.scala 83:27]
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'ha == value) begin // @[Branch.scala 92:24]
        cam_10_tgt <= io_update_bits_tgt; // @[Branch.scala 92:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_10_bht <= 2'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (io_update_bits_isTaken & _GEN_31 != 2'h3) begin // @[Branch.scala 84:71]
        if (4'ha == update_index[3:0]) begin // @[Branch.scala 85:29]
          cam_10_bht <= _cam_bht_T_2; // @[Branch.scala 85:29]
        end
      end else if (~io_update_bits_isTaken & _GEN_31 != 2'h0) begin // @[Branch.scala 86:78]
        cam_10_bht <= _GEN_106;
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'ha == value) begin // @[Branch.scala 93:24]
        cam_10_bht <= _cam_bht_T_6; // @[Branch.scala 93:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_11_pc <= 64'h0; // @[Branch.scala 65:20]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        if (4'hb == value) begin // @[Branch.scala 91:23]
          cam_11_pc <= io_update_bits_pc; // @[Branch.scala 91:23]
        end
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_11_tgt <= 64'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (4'hb == update_index[3:0]) begin // @[Branch.scala 83:27]
        cam_11_tgt <= io_update_bits_tgt; // @[Branch.scala 83:27]
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'hb == value) begin // @[Branch.scala 92:24]
        cam_11_tgt <= io_update_bits_tgt; // @[Branch.scala 92:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_11_bht <= 2'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (io_update_bits_isTaken & _GEN_31 != 2'h3) begin // @[Branch.scala 84:71]
        if (4'hb == update_index[3:0]) begin // @[Branch.scala 85:29]
          cam_11_bht <= _cam_bht_T_2; // @[Branch.scala 85:29]
        end
      end else if (~io_update_bits_isTaken & _GEN_31 != 2'h0) begin // @[Branch.scala 86:78]
        cam_11_bht <= _GEN_107;
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'hb == value) begin // @[Branch.scala 93:24]
        cam_11_bht <= _cam_bht_T_6; // @[Branch.scala 93:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_12_pc <= 64'h0; // @[Branch.scala 65:20]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        if (4'hc == value) begin // @[Branch.scala 91:23]
          cam_12_pc <= io_update_bits_pc; // @[Branch.scala 91:23]
        end
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_12_tgt <= 64'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (4'hc == update_index[3:0]) begin // @[Branch.scala 83:27]
        cam_12_tgt <= io_update_bits_tgt; // @[Branch.scala 83:27]
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'hc == value) begin // @[Branch.scala 92:24]
        cam_12_tgt <= io_update_bits_tgt; // @[Branch.scala 92:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_12_bht <= 2'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (io_update_bits_isTaken & _GEN_31 != 2'h3) begin // @[Branch.scala 84:71]
        if (4'hc == update_index[3:0]) begin // @[Branch.scala 85:29]
          cam_12_bht <= _cam_bht_T_2; // @[Branch.scala 85:29]
        end
      end else if (~io_update_bits_isTaken & _GEN_31 != 2'h0) begin // @[Branch.scala 86:78]
        cam_12_bht <= _GEN_108;
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'hc == value) begin // @[Branch.scala 93:24]
        cam_12_bht <= _cam_bht_T_6; // @[Branch.scala 93:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_13_pc <= 64'h0; // @[Branch.scala 65:20]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        if (4'hd == value) begin // @[Branch.scala 91:23]
          cam_13_pc <= io_update_bits_pc; // @[Branch.scala 91:23]
        end
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_13_tgt <= 64'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (4'hd == update_index[3:0]) begin // @[Branch.scala 83:27]
        cam_13_tgt <= io_update_bits_tgt; // @[Branch.scala 83:27]
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'hd == value) begin // @[Branch.scala 92:24]
        cam_13_tgt <= io_update_bits_tgt; // @[Branch.scala 92:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_13_bht <= 2'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (io_update_bits_isTaken & _GEN_31 != 2'h3) begin // @[Branch.scala 84:71]
        if (4'hd == update_index[3:0]) begin // @[Branch.scala 85:29]
          cam_13_bht <= _cam_bht_T_2; // @[Branch.scala 85:29]
        end
      end else if (~io_update_bits_isTaken & _GEN_31 != 2'h0) begin // @[Branch.scala 86:78]
        cam_13_bht <= _GEN_109;
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'hd == value) begin // @[Branch.scala 93:24]
        cam_13_bht <= _cam_bht_T_6; // @[Branch.scala 93:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_14_pc <= 64'h0; // @[Branch.scala 65:20]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        if (4'he == value) begin // @[Branch.scala 91:23]
          cam_14_pc <= io_update_bits_pc; // @[Branch.scala 91:23]
        end
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_14_tgt <= 64'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (4'he == update_index[3:0]) begin // @[Branch.scala 83:27]
        cam_14_tgt <= io_update_bits_tgt; // @[Branch.scala 83:27]
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'he == value) begin // @[Branch.scala 92:24]
        cam_14_tgt <= io_update_bits_tgt; // @[Branch.scala 92:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_14_bht <= 2'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (io_update_bits_isTaken & _GEN_31 != 2'h3) begin // @[Branch.scala 84:71]
        if (4'he == update_index[3:0]) begin // @[Branch.scala 85:29]
          cam_14_bht <= _cam_bht_T_2; // @[Branch.scala 85:29]
        end
      end else if (~io_update_bits_isTaken & _GEN_31 != 2'h0) begin // @[Branch.scala 86:78]
        cam_14_bht <= _GEN_110;
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'he == value) begin // @[Branch.scala 93:24]
        cam_14_bht <= _cam_bht_T_6; // @[Branch.scala 93:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_15_pc <= 64'h0; // @[Branch.scala 65:20]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        if (4'hf == value) begin // @[Branch.scala 91:23]
          cam_15_pc <= io_update_bits_pc; // @[Branch.scala 91:23]
        end
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_15_tgt <= 64'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (4'hf == update_index[3:0]) begin // @[Branch.scala 83:27]
        cam_15_tgt <= io_update_bits_tgt; // @[Branch.scala 83:27]
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'hf == value) begin // @[Branch.scala 92:24]
        cam_15_tgt <= io_update_bits_tgt; // @[Branch.scala 92:24]
      end
    end
    if (reset) begin // @[Branch.scala 65:20]
      cam_15_bht <= 2'h0; // @[Branch.scala 65:20]
    end else if (io_update_valid & ~update_is_miss) begin // @[Branch.scala 81:42]
      if (io_update_bits_isTaken & _GEN_31 != 2'h3) begin // @[Branch.scala 84:71]
        if (4'hf == update_index[3:0]) begin // @[Branch.scala 85:29]
          cam_15_bht <= _cam_bht_T_2; // @[Branch.scala 85:29]
        end
      end else if (~io_update_bits_isTaken & _GEN_31 != 2'h0) begin // @[Branch.scala 86:78]
        cam_15_bht <= _GEN_111;
      end
    end else if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
      if (4'hf == value) begin // @[Branch.scala 93:24]
        cam_15_bht <= _cam_bht_T_6; // @[Branch.scala 93:24]
      end
    end
    if (reset) begin // @[Counter.scala 60:40]
      value <= 4'h0; // @[Counter.scala 60:40]
    end else if (!(io_update_valid & ~update_is_miss)) begin // @[Branch.scala 81:42]
      if (io_update_valid & update_is_miss) begin // @[Branch.scala 89:47]
        value <= _value_T_1; // @[Counter.scala 76:15]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  cam_0_pc = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  cam_0_tgt = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  cam_0_bht = _RAND_2[1:0];
  _RAND_3 = {2{`RANDOM}};
  cam_1_pc = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  cam_1_tgt = _RAND_4[63:0];
  _RAND_5 = {1{`RANDOM}};
  cam_1_bht = _RAND_5[1:0];
  _RAND_6 = {2{`RANDOM}};
  cam_2_pc = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  cam_2_tgt = _RAND_7[63:0];
  _RAND_8 = {1{`RANDOM}};
  cam_2_bht = _RAND_8[1:0];
  _RAND_9 = {2{`RANDOM}};
  cam_3_pc = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  cam_3_tgt = _RAND_10[63:0];
  _RAND_11 = {1{`RANDOM}};
  cam_3_bht = _RAND_11[1:0];
  _RAND_12 = {2{`RANDOM}};
  cam_4_pc = _RAND_12[63:0];
  _RAND_13 = {2{`RANDOM}};
  cam_4_tgt = _RAND_13[63:0];
  _RAND_14 = {1{`RANDOM}};
  cam_4_bht = _RAND_14[1:0];
  _RAND_15 = {2{`RANDOM}};
  cam_5_pc = _RAND_15[63:0];
  _RAND_16 = {2{`RANDOM}};
  cam_5_tgt = _RAND_16[63:0];
  _RAND_17 = {1{`RANDOM}};
  cam_5_bht = _RAND_17[1:0];
  _RAND_18 = {2{`RANDOM}};
  cam_6_pc = _RAND_18[63:0];
  _RAND_19 = {2{`RANDOM}};
  cam_6_tgt = _RAND_19[63:0];
  _RAND_20 = {1{`RANDOM}};
  cam_6_bht = _RAND_20[1:0];
  _RAND_21 = {2{`RANDOM}};
  cam_7_pc = _RAND_21[63:0];
  _RAND_22 = {2{`RANDOM}};
  cam_7_tgt = _RAND_22[63:0];
  _RAND_23 = {1{`RANDOM}};
  cam_7_bht = _RAND_23[1:0];
  _RAND_24 = {2{`RANDOM}};
  cam_8_pc = _RAND_24[63:0];
  _RAND_25 = {2{`RANDOM}};
  cam_8_tgt = _RAND_25[63:0];
  _RAND_26 = {1{`RANDOM}};
  cam_8_bht = _RAND_26[1:0];
  _RAND_27 = {2{`RANDOM}};
  cam_9_pc = _RAND_27[63:0];
  _RAND_28 = {2{`RANDOM}};
  cam_9_tgt = _RAND_28[63:0];
  _RAND_29 = {1{`RANDOM}};
  cam_9_bht = _RAND_29[1:0];
  _RAND_30 = {2{`RANDOM}};
  cam_10_pc = _RAND_30[63:0];
  _RAND_31 = {2{`RANDOM}};
  cam_10_tgt = _RAND_31[63:0];
  _RAND_32 = {1{`RANDOM}};
  cam_10_bht = _RAND_32[1:0];
  _RAND_33 = {2{`RANDOM}};
  cam_11_pc = _RAND_33[63:0];
  _RAND_34 = {2{`RANDOM}};
  cam_11_tgt = _RAND_34[63:0];
  _RAND_35 = {1{`RANDOM}};
  cam_11_bht = _RAND_35[1:0];
  _RAND_36 = {2{`RANDOM}};
  cam_12_pc = _RAND_36[63:0];
  _RAND_37 = {2{`RANDOM}};
  cam_12_tgt = _RAND_37[63:0];
  _RAND_38 = {1{`RANDOM}};
  cam_12_bht = _RAND_38[1:0];
  _RAND_39 = {2{`RANDOM}};
  cam_13_pc = _RAND_39[63:0];
  _RAND_40 = {2{`RANDOM}};
  cam_13_tgt = _RAND_40[63:0];
  _RAND_41 = {1{`RANDOM}};
  cam_13_bht = _RAND_41[1:0];
  _RAND_42 = {2{`RANDOM}};
  cam_14_pc = _RAND_42[63:0];
  _RAND_43 = {2{`RANDOM}};
  cam_14_tgt = _RAND_43[63:0];
  _RAND_44 = {1{`RANDOM}};
  cam_14_bht = _RAND_44[1:0];
  _RAND_45 = {2{`RANDOM}};
  cam_15_pc = _RAND_45[63:0];
  _RAND_46 = {2{`RANDOM}};
  cam_15_tgt = _RAND_46[63:0];
  _RAND_47 = {1{`RANDOM}};
  cam_15_bht = _RAND_47[1:0];
  _RAND_48 = {1{`RANDOM}};
  value = _RAND_48[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_210013_IF(
  input         clock,
  input         reset,
  output        io_out_valid,
  output [63:0] io_out_bits_pc,
  output [31:0] io_out_bits_inst,
  output        io_out_bits_pTaken,
  output [63:0] io_out_bits_pPC,
  input  [63:0] io_pc_alu,
  input  [63:0] io_pc_epc,
  input  [1:0]  io_pc_sel,
  input         io_br_info_valid,
  input         io_br_info_bits_isHit,
  input         io_br_info_bits_isTaken,
  input  [63:0] io_br_info_bits_cur_pc,
  input         io_pc_except_entry_valid,
  input  [63:0] io_pc_except_entry_bits,
  input         io_stall,
  input         io_kill,
  input         io_icache_req_ready,
  output        io_icache_req_valid,
  output [63:0] io_icache_req_bits_addr,
  output [63:0] io_icache_req_bits_data,
  output [7:0]  io_icache_req_bits_mask,
  output        io_icache_req_bits_op,
  input         io_icache_resp_valid,
  input  [63:0] io_icache_resp_bits_data,
  input  [3:0]  io_icache_resp_bits_cmd,
  input         io_fence_i_done,
  input  [31:0] io_fence_pc,
  input         io_fence_i_do
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  wire  btb_clock; // @[IF.scala 41:19]
  wire  btb_reset; // @[IF.scala 41:19]
  wire  btb_io_query_pc_valid; // @[IF.scala 41:19]
  wire [63:0] btb_io_query_pc_bits; // @[IF.scala 41:19]
  wire  btb_io_query_res_valid; // @[IF.scala 41:19]
  wire [63:0] btb_io_query_res_bits_tgt; // @[IF.scala 41:19]
  wire [1:0] btb_io_query_res_bits_bht; // @[IF.scala 41:19]
  wire  btb_io_query_res_bits_is_miss; // @[IF.scala 41:19]
  wire  btb_io_update_valid; // @[IF.scala 41:19]
  wire [63:0] btb_io_update_bits_pc; // @[IF.scala 41:19]
  wire [63:0] btb_io_update_bits_tgt; // @[IF.scala 41:19]
  wire  btb_io_update_bits_isTaken; // @[IF.scala 41:19]
  wire [63:0] _cur_pc_T_1 = 64'h30000000 - 64'h4; // @[IF.scala 43:53]
  reg [63:0] cur_pc; // @[IF.scala 43:23]
  reg [31:0] inst; // @[IF.scala 44:21]
  wire  pTaken = btb_io_query_res_bits_is_miss ? 1'h0 : btb_io_query_res_bits_bht[1]; // @[IF.scala 57:20]
  wire [63:0] _pc_next_T_3 = io_br_info_bits_cur_pc + 64'h4; // @[IF.scala 61:134]
  wire [63:0] _pc_next_T_4 = io_br_info_bits_isTaken ? io_pc_alu : _pc_next_T_3; // @[IF.scala 61:74]
  wire  _pc_next_T_7 = pTaken & btb_io_query_res_valid; // @[IF.scala 62:91]
  wire [63:0] _pc_next_T_9 = cur_pc + 64'h4; // @[IF.scala 62:131]
  wire [63:0] _pc_next_T_10 = pTaken & btb_io_query_res_valid ? btb_io_query_res_bits_tgt : _pc_next_T_9; // @[IF.scala 62:73]
  reg [31:0] pc_next_r; // @[Reg.scala 27:20]
  wire [31:0] _pc_next_T_12 = pc_next_r + 32'h4; // @[IF.scala 63:89]
  wire [63:0] _pc_next_T_18 = 2'h0 == io_pc_sel ? _pc_next_T_9 : cur_pc; // @[Mux.scala 80:57]
  wire [63:0] _pc_next_T_20 = 2'h1 == io_pc_sel ? io_pc_alu : _pc_next_T_18; // @[Mux.scala 80:57]
  wire [63:0] _pc_next_T_22 = 2'h3 == io_pc_sel ? io_pc_epc : _pc_next_T_20; // @[Mux.scala 80:57]
  wire [63:0] _pc_next_T_23 = _pc_next_T_7 ? btb_io_query_res_bits_tgt : _pc_next_T_22; // @[IF.scala 64:30]
  wire [63:0] _pc_next_T_24 = io_fence_i_done ? {{32'd0}, _pc_next_T_12} : _pc_next_T_23; // @[IF.scala 63:28]
  wire [63:0] _pc_next_T_25 = io_br_info_valid & io_br_info_bits_isHit ? _pc_next_T_10 : _pc_next_T_24; // @[IF.scala 62:26]
  wire [63:0] _pc_next_T_26 = io_br_info_valid & ~io_br_info_bits_isHit ? _pc_next_T_4 : _pc_next_T_25; // @[IF.scala 61:24]
  wire [63:0] _pc_next_T_27 = io_pc_except_entry_valid ? io_pc_except_entry_bits : _pc_next_T_26; // @[IF.scala 60:22]
  wire [63:0] pc_next = io_stall ? cur_pc : _pc_next_T_27; // @[IF.scala 59:20]
  wire  _io_icache_req_valid_T = ~io_stall; // @[IF.scala 72:26]
  wire  _cur_pc_T_2 = io_icache_req_ready & io_icache_req_valid; // @[Decoupled.scala 40:37]
  wire [63:0] _cur_pc_T_8 = pc_next - 64'h4; // @[IF.scala 82:132]
  wire  _inst_T_1 = io_icache_resp_valid & io_icache_resp_bits_cmd != 4'h0; // @[IF.scala 83:37]
  wire [63:0] _inst_T_2 = io_icache_resp_valid & io_icache_resp_bits_cmd != 4'h0 ? io_icache_resp_bits_data : {{32'd0},
    inst}; // @[IF.scala 83:14]
  reg  stall_negedge_REG; // @[IF.scala 86:44]
  wire  stall_negedge = _io_icache_req_valid_T & stall_negedge_REG; // @[IF.scala 86:35]
  reg  is_valid_when_stall; // @[IF.scala 87:36]
  wire  _GEN_1 = stall_negedge ? 1'h0 : is_valid_when_stall; // @[IF.scala 90:28 IF.scala 91:25 IF.scala 87:36]
  wire  _GEN_2 = io_stall & io_out_valid | _GEN_1; // @[IF.scala 88:32 IF.scala 89:25]
  wire  _io_out_valid_T_2 = io_kill ? 1'h0 : _inst_T_1; // @[IF.scala 104:22]
  ysyx_210013_BTB btb ( // @[IF.scala 41:19]
    .clock(btb_clock),
    .reset(btb_reset),
    .io_query_pc_valid(btb_io_query_pc_valid),
    .io_query_pc_bits(btb_io_query_pc_bits),
    .io_query_res_valid(btb_io_query_res_valid),
    .io_query_res_bits_tgt(btb_io_query_res_bits_tgt),
    .io_query_res_bits_bht(btb_io_query_res_bits_bht),
    .io_query_res_bits_is_miss(btb_io_query_res_bits_is_miss),
    .io_update_valid(btb_io_update_valid),
    .io_update_bits_pc(btb_io_update_bits_pc),
    .io_update_bits_tgt(btb_io_update_bits_tgt),
    .io_update_bits_isTaken(btb_io_update_bits_isTaken)
  );
  assign io_out_valid = _io_out_valid_T_2 | is_valid_when_stall & stall_negedge; // @[IF.scala 104:96]
  assign io_out_bits_pc = cur_pc; // @[IF.scala 101:18]
  assign io_out_bits_inst = _inst_T_2[31:0]; // @[IF.scala 100:20]
  assign io_out_bits_pTaken = btb_io_query_res_bits_is_miss ? 1'h0 : btb_io_query_res_bits_bht[1]; // @[IF.scala 57:20]
  assign io_out_bits_pPC = btb_io_query_res_bits_is_miss ? 64'h0 : btb_io_query_res_bits_tgt; // @[IF.scala 103:25]
  assign io_icache_req_valid = ~io_stall; // @[IF.scala 72:26]
  assign io_icache_req_bits_addr = pc_next; // @[IF.scala 74:27]
  assign io_icache_req_bits_data = 64'h0; // @[IF.scala 76:27]
  assign io_icache_req_bits_mask = io_icache_req_bits_addr[2] ? 8'hf0 : 8'hf; // @[IF.scala 75:33]
  assign io_icache_req_bits_op = 1'h0; // @[IF.scala 73:25]
  assign btb_clock = clock;
  assign btb_reset = reset;
  assign btb_io_query_pc_valid = io_out_valid; // @[IF.scala 55:25]
  assign btb_io_query_pc_bits = io_out_bits_pc; // @[IF.scala 54:24]
  assign btb_io_update_valid = io_br_info_valid; // @[IF.scala 95:23]
  assign btb_io_update_bits_pc = io_br_info_bits_cur_pc; // @[IF.scala 96:25]
  assign btb_io_update_bits_tgt = io_br_info_bits_isTaken ? io_pc_alu : _pc_next_T_3; // @[IF.scala 97:32]
  assign btb_io_update_bits_isTaken = io_br_info_bits_isTaken; // @[IF.scala 98:30]
  always @(posedge clock) begin
    if (reset) begin // @[IF.scala 43:23]
      cur_pc <= _cur_pc_T_1; // @[IF.scala 43:23]
    end else if (_cur_pc_T_2) begin // @[IF.scala 82:16]
      cur_pc <= io_icache_req_bits_addr;
    end else if (io_icache_req_valid & ~io_icache_req_ready & _io_icache_req_valid_T) begin // @[IF.scala 82:67]
      cur_pc <= _cur_pc_T_8;
    end
    if (reset) begin // @[IF.scala 44:21]
      inst <= 32'h13; // @[IF.scala 44:21]
    end else begin
      inst <= _inst_T_2[31:0]; // @[IF.scala 83:8]
    end
    if (reset) begin // @[Reg.scala 27:20]
      pc_next_r <= 32'h0; // @[Reg.scala 27:20]
    end else if (io_fence_i_do) begin // @[Reg.scala 28:19]
      pc_next_r <= io_fence_pc; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[IF.scala 86:44]
      stall_negedge_REG <= 1'h0; // @[IF.scala 86:44]
    end else begin
      stall_negedge_REG <= io_stall; // @[IF.scala 86:44]
    end
    if (reset) begin // @[IF.scala 87:36]
      is_valid_when_stall <= 1'h0; // @[IF.scala 87:36]
    end else begin
      is_valid_when_stall <= _GEN_2;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  cur_pc = _RAND_0[63:0];
  _RAND_1 = {1{`RANDOM}};
  inst = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  pc_next_r = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  stall_negedge_REG = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  is_valid_when_stall = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_210013_ImmGen(
  input  [63:0] io_inst,
  input  [2:0]  io_sel,
  output [63:0] io_out
);
  wire [11:0] _Iimm_T_1 = io_inst[31:20]; // @[ID.scala 22:33]
  wire [6:0] Simm_hi = io_inst[31:25]; // @[ID.scala 23:22]
  wire [4:0] Simm_lo = io_inst[11:7]; // @[ID.scala 23:39]
  wire [11:0] _Simm_T_1 = {Simm_hi,Simm_lo}; // @[ID.scala 23:47]
  wire  Bimm_hi_hi_hi = io_inst[31]; // @[ID.scala 24:22]
  wire  Bimm_hi_hi_lo = io_inst[7]; // @[ID.scala 24:35]
  wire [5:0] Bimm_hi_lo = io_inst[30:25]; // @[ID.scala 24:47]
  wire [3:0] Bimm_lo_hi = io_inst[11:8]; // @[ID.scala 24:64]
  wire [12:0] _Bimm_T_1 = {Bimm_hi_hi_hi,Bimm_hi_hi_lo,Bimm_hi_lo,Bimm_lo_hi,1'h0}; // @[ID.scala 24:83]
  wire [19:0] Uimm_hi = io_inst[31:12]; // @[ID.scala 25:22]
  wire [31:0] _Uimm_T_1 = {Uimm_hi,12'h0}; // @[ID.scala 25:43]
  wire [7:0] Jimm_hi_hi_lo = io_inst[19:12]; // @[ID.scala 26:35]
  wire  Jimm_hi_lo = io_inst[20]; // @[ID.scala 26:52]
  wire [3:0] Jimm_lo_hi_lo = io_inst[24:21]; // @[ID.scala 26:82]
  wire [20:0] _Jimm_T_1 = {Bimm_hi_hi_hi,Jimm_hi_hi_lo,Jimm_hi_lo,Bimm_hi_lo,Jimm_lo_hi_lo,1'h0}; // @[ID.scala 26:102]
  wire [5:0] _Zimm_T_1 = {1'b0,$signed(io_inst[19:15])}; // @[ID.scala 27:27]
  wire [63:0] Iimm = {{52{_Iimm_T_1[11]}},_Iimm_T_1}; // @[ID.scala 15:18 ID.scala 22:8]
  wire [63:0] _io_out_T_1 = $signed(Iimm) & -64'sh2; // @[ID.scala 29:36]
  wire [63:0] _io_out_T_3 = 3'h1 == io_sel ? $signed(Iimm) : $signed(_io_out_T_1); // @[Mux.scala 80:57]
  wire [63:0] Simm = {{52{_Simm_T_1[11]}},_Simm_T_1}; // @[ID.scala 16:18 ID.scala 23:8]
  wire [63:0] _io_out_T_5 = 3'h2 == io_sel ? $signed(Simm) : $signed(_io_out_T_3); // @[Mux.scala 80:57]
  wire [63:0] Bimm = {{51{_Bimm_T_1[12]}},_Bimm_T_1}; // @[ID.scala 17:18 ID.scala 24:8]
  wire [63:0] _io_out_T_7 = 3'h5 == io_sel ? $signed(Bimm) : $signed(_io_out_T_5); // @[Mux.scala 80:57]
  wire [63:0] Uimm = {{32{_Uimm_T_1[31]}},_Uimm_T_1}; // @[ID.scala 18:18 ID.scala 25:8]
  wire [63:0] _io_out_T_9 = 3'h3 == io_sel ? $signed(Uimm) : $signed(_io_out_T_7); // @[Mux.scala 80:57]
  wire [63:0] Jimm = {{43{_Jimm_T_1[20]}},_Jimm_T_1}; // @[ID.scala 19:18 ID.scala 26:8]
  wire [63:0] _io_out_T_11 = 3'h4 == io_sel ? $signed(Jimm) : $signed(_io_out_T_9); // @[Mux.scala 80:57]
  wire [63:0] Zimm = {{58{_Zimm_T_1[5]}},_Zimm_T_1}; // @[ID.scala 20:18 ID.scala 27:8]
  assign io_out = 3'h6 == io_sel ? $signed(Zimm) : $signed(_io_out_T_11); // @[ID.scala 36:12]
endmodule
module ysyx_210013_ID(
  input  [31:0] io_inst,
  output [4:0]  io_rd_addr,
  output [4:0]  io_rs1_addr,
  output [4:0]  io_rs2_addr,
  input  [2:0]  io_imm_sel,
  output [63:0] io_imm
);
  wire [63:0] immgen_io_inst; // @[ID.scala 57:22]
  wire [2:0] immgen_io_sel; // @[ID.scala 57:22]
  wire [63:0] immgen_io_out; // @[ID.scala 57:22]
  ysyx_210013_ImmGen immgen ( // @[ID.scala 57:22]
    .io_inst(immgen_io_inst),
    .io_sel(immgen_io_sel),
    .io_out(immgen_io_out)
  );
  assign io_rd_addr = io_inst[11:7]; // @[ID.scala 51:33]
  assign io_rs1_addr = io_inst[19:15]; // @[ID.scala 52:34]
  assign io_rs2_addr = io_inst[24:20]; // @[ID.scala 53:34]
  assign io_imm = immgen_io_out; // @[ID.scala 60:10]
  assign immgen_io_inst = {{32'd0}, io_inst}; // @[ID.scala 58:18]
  assign immgen_io_sel = io_imm_sel; // @[ID.scala 59:17]
endmodule
module ysyx_210013_ALU(
  input  [63:0] io_rs1,
  input  [63:0] io_rs2,
  input  [4:0]  io_alu_op,
  output [63:0] io_out
);
  wire [5:0] shamt_6 = io_rs2[5:0]; // @[EX.scala 46:32]
  wire [4:0] shamt_5 = io_rs2[4:0]; // @[EX.scala 47:32]
  wire [63:0] _out_T_1 = io_rs1 + io_rs2; // @[EX.scala 58:27]
  wire [63:0] _out_T_3 = io_rs1 - io_rs2; // @[EX.scala 59:27]
  wire [63:0] _out_T_6 = $signed(io_rs1) >>> shamt_6; // @[EX.scala 60:46]
  wire [63:0] _out_T_7 = io_rs1 >> shamt_6; // @[EX.scala 61:27]
  wire [126:0] _GEN_0 = {{63'd0}, io_rs1}; // @[EX.scala 62:27]
  wire [126:0] _out_T_8 = _GEN_0 << shamt_6; // @[EX.scala 62:27]
  wire  _out_T_11 = $signed(io_rs1) < $signed(io_rs2); // @[EX.scala 63:34]
  wire  _out_T_12 = io_rs1 < io_rs2; // @[EX.scala 64:27]
  wire [63:0] _out_T_13 = io_rs1 & io_rs2; // @[EX.scala 65:27]
  wire [63:0] _out_T_14 = io_rs1 | io_rs2; // @[EX.scala 66:27]
  wire [63:0] _out_T_15 = io_rs1 ^ io_rs2; // @[EX.scala 67:27]
  wire [94:0] _GEN_1 = {{31'd0}, io_rs1}; // @[EX.scala 70:42]
  wire [94:0] _out_T_17 = _GEN_1 << shamt_5; // @[EX.scala 70:42]
  wire [31:0] out_lo_lo_lo_lo_lo = _out_T_17[31:0]; // @[EX.scala 70:67]
  wire  out_hi_hi_hi_hi_hi_hi = out_lo_lo_lo_lo_lo[31]; // @[EX.scala 51:17]
  wire [38:0] out_lo_lo = {out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,
    out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_lo_lo_lo_lo_lo}; // @[Cat.scala 30:58]
  wire [7:0] out_lo_hi = {out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,
    out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi}; // @[Cat.scala 30:58]
  wire [16:0] out_hi = {out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,
    out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,
    out_lo_hi}; // @[Cat.scala 30:58]
  wire [63:0] _out_T_18 = {out_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,
    out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,out_hi_hi_hi_hi_hi_hi,
    out_lo_lo}; // @[Cat.scala 30:58]
  wire [31:0] out_lo_lo_lo_lo_lo_1 = io_rs1[31:0] >> shamt_5; // @[EX.scala 71:58]
  wire  out_hi_hi_hi_hi_hi_hi_1 = out_lo_lo_lo_lo_lo_1[31]; // @[EX.scala 51:17]
  wire [38:0] out_lo_lo_1 = {out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,
    out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,out_lo_lo_lo_lo_lo_1
    }; // @[Cat.scala 30:58]
  wire [7:0] out_lo_hi_1 = {out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,
    out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,
    out_hi_hi_hi_hi_hi_hi_1}; // @[Cat.scala 30:58]
  wire [16:0] out_hi_1 = {out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,
    out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,
    out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,out_lo_hi_1}; // @[Cat.scala 30:58]
  wire [63:0] _out_T_20 = {out_hi_1,out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,
    out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,out_hi_hi_hi_hi_hi_hi_1,
    out_hi_hi_hi_hi_hi_hi_1,out_lo_lo_1}; // @[Cat.scala 30:58]
  wire [31:0] _out_T_22 = io_rs1[31:0]; // @[EX.scala 72:55]
  wire [31:0] out_lo_lo_lo_lo_lo_2 = $signed(_out_T_22) >>> shamt_5; // @[EX.scala 72:76]
  wire  out_hi_hi_hi_hi_hi_hi_2 = out_lo_lo_lo_lo_lo_2[31]; // @[EX.scala 51:17]
  wire [38:0] out_lo_lo_2 = {out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,
    out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,out_lo_lo_lo_lo_lo_2
    }; // @[Cat.scala 30:58]
  wire [7:0] out_lo_hi_2 = {out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,
    out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,
    out_hi_hi_hi_hi_hi_hi_2}; // @[Cat.scala 30:58]
  wire [16:0] out_hi_2 = {out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,
    out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,
    out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,out_lo_hi_2}; // @[Cat.scala 30:58]
  wire [63:0] _out_T_24 = {out_hi_2,out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,
    out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,out_hi_hi_hi_hi_hi_hi_2,
    out_hi_hi_hi_hi_hi_hi_2,out_lo_lo_2}; // @[Cat.scala 30:58]
  wire [31:0] out_lo_lo_lo_lo_lo_3 = _out_T_1[31:0]; // @[EX.scala 73:51]
  wire  out_hi_hi_hi_hi_hi_hi_3 = out_lo_lo_lo_lo_lo_3[31]; // @[EX.scala 51:17]
  wire [38:0] out_lo_lo_3 = {out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,
    out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,out_lo_lo_lo_lo_lo_3
    }; // @[Cat.scala 30:58]
  wire [7:0] out_lo_hi_3 = {out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,
    out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,
    out_hi_hi_hi_hi_hi_hi_3}; // @[Cat.scala 30:58]
  wire [16:0] out_hi_3 = {out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,
    out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,
    out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,out_lo_hi_3}; // @[Cat.scala 30:58]
  wire [63:0] _out_T_27 = {out_hi_3,out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,
    out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,out_hi_hi_hi_hi_hi_hi_3,
    out_hi_hi_hi_hi_hi_hi_3,out_lo_lo_3}; // @[Cat.scala 30:58]
  wire [31:0] out_lo_lo_lo_lo_lo_4 = _out_T_3[31:0]; // @[EX.scala 74:51]
  wire  out_hi_hi_hi_hi_hi_hi_4 = out_lo_lo_lo_lo_lo_4[31]; // @[EX.scala 51:17]
  wire [38:0] out_lo_lo_4 = {out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,
    out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,out_lo_lo_lo_lo_lo_4
    }; // @[Cat.scala 30:58]
  wire [7:0] out_lo_hi_4 = {out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,
    out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,
    out_hi_hi_hi_hi_hi_hi_4}; // @[Cat.scala 30:58]
  wire [16:0] out_hi_4 = {out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,
    out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,
    out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,out_lo_hi_4}; // @[Cat.scala 30:58]
  wire [63:0] _out_T_30 = {out_hi_4,out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,
    out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,out_hi_hi_hi_hi_hi_hi_4,
    out_hi_hi_hi_hi_hi_hi_4,out_lo_lo_4}; // @[Cat.scala 30:58]
  wire [31:0] out_lo_lo_lo_lo_lo_5 = _out_T_8[31:0]; // @[EX.scala 75:53]
  wire  out_hi_hi_hi_hi_hi_hi_5 = out_lo_lo_lo_lo_lo_5[31]; // @[EX.scala 51:17]
  wire [38:0] out_lo_lo_5 = {out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,
    out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,out_lo_lo_lo_lo_lo_5
    }; // @[Cat.scala 30:58]
  wire [7:0] out_lo_hi_5 = {out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,
    out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,
    out_hi_hi_hi_hi_hi_hi_5}; // @[Cat.scala 30:58]
  wire [16:0] out_hi_5 = {out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,
    out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,
    out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,out_lo_hi_5}; // @[Cat.scala 30:58]
  wire [63:0] _out_T_32 = {out_hi_5,out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,
    out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,out_hi_hi_hi_hi_hi_hi_5,
    out_hi_hi_hi_hi_hi_hi_5,out_lo_lo_5}; // @[Cat.scala 30:58]
  wire [31:0] out_lo_lo_lo_lo_lo_6 = io_rs1[31:0] >> shamt_6; // @[EX.scala 76:58]
  wire  out_hi_hi_hi_hi_hi_hi_6 = out_lo_lo_lo_lo_lo_6[31]; // @[EX.scala 51:17]
  wire [38:0] out_lo_lo_6 = {out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,
    out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,out_lo_lo_lo_lo_lo_6
    }; // @[Cat.scala 30:58]
  wire [7:0] out_lo_hi_6 = {out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,
    out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,
    out_hi_hi_hi_hi_hi_hi_6}; // @[Cat.scala 30:58]
  wire [16:0] out_hi_6 = {out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,
    out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,
    out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,out_lo_hi_6}; // @[Cat.scala 30:58]
  wire [63:0] _out_T_34 = {out_hi_6,out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,
    out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,out_hi_hi_hi_hi_hi_hi_6,
    out_hi_hi_hi_hi_hi_hi_6,out_lo_lo_6}; // @[Cat.scala 30:58]
  wire [31:0] out_lo_lo_lo_lo_lo_7 = $signed(_out_T_22) >>> shamt_6; // @[EX.scala 77:76]
  wire  out_hi_hi_hi_hi_hi_hi_7 = out_lo_lo_lo_lo_lo_7[31]; // @[EX.scala 51:17]
  wire [38:0] out_lo_lo_7 = {out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,
    out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,out_lo_lo_lo_lo_lo_7
    }; // @[Cat.scala 30:58]
  wire [7:0] out_lo_hi_7 = {out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,
    out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,
    out_hi_hi_hi_hi_hi_hi_7}; // @[Cat.scala 30:58]
  wire [16:0] out_hi_7 = {out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,
    out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,
    out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,out_lo_hi_7}; // @[Cat.scala 30:58]
  wire [63:0] _out_T_38 = {out_hi_7,out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,
    out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,out_hi_hi_hi_hi_hi_hi_7,
    out_hi_hi_hi_hi_hi_hi_7,out_lo_lo_7}; // @[Cat.scala 30:58]
  wire [63:0] _out_T_43 = 5'h0 == io_alu_op ? _out_T_1 : io_rs2; // @[Mux.scala 80:57]
  wire [63:0] _out_T_45 = 5'h1 == io_alu_op ? _out_T_3 : _out_T_43; // @[Mux.scala 80:57]
  wire [63:0] _out_T_47 = 5'h9 == io_alu_op ? _out_T_6 : _out_T_45; // @[Mux.scala 80:57]
  wire [63:0] _out_T_49 = 5'h8 == io_alu_op ? _out_T_7 : _out_T_47; // @[Mux.scala 80:57]
  wire [126:0] _out_T_51 = 5'h6 == io_alu_op ? _out_T_8 : {{63'd0}, _out_T_49}; // @[Mux.scala 80:57]
  wire [126:0] _out_T_53 = 5'h5 == io_alu_op ? {{126'd0}, _out_T_11} : _out_T_51; // @[Mux.scala 80:57]
  wire [126:0] _out_T_55 = 5'h7 == io_alu_op ? {{126'd0}, _out_T_12} : _out_T_53; // @[Mux.scala 80:57]
  wire [126:0] _out_T_57 = 5'h2 == io_alu_op ? {{63'd0}, _out_T_13} : _out_T_55; // @[Mux.scala 80:57]
  wire [126:0] _out_T_59 = 5'h3 == io_alu_op ? {{63'd0}, _out_T_14} : _out_T_57; // @[Mux.scala 80:57]
  wire [126:0] _out_T_61 = 5'h4 == io_alu_op ? {{63'd0}, _out_T_15} : _out_T_59; // @[Mux.scala 80:57]
  wire [126:0] _out_T_63 = 5'ha == io_alu_op ? {{63'd0}, io_rs1} : _out_T_61; // @[Mux.scala 80:57]
  wire [126:0] _out_T_65 = 5'hb == io_alu_op ? {{63'd0}, io_rs2} : _out_T_63; // @[Mux.scala 80:57]
  wire [126:0] _out_T_67 = 5'hc == io_alu_op ? {{63'd0}, _out_T_18} : _out_T_65; // @[Mux.scala 80:57]
  wire [126:0] _out_T_69 = 5'hd == io_alu_op ? {{63'd0}, _out_T_20} : _out_T_67; // @[Mux.scala 80:57]
  wire [126:0] _out_T_71 = 5'he == io_alu_op ? {{63'd0}, _out_T_24} : _out_T_69; // @[Mux.scala 80:57]
  wire [126:0] _out_T_73 = 5'hf == io_alu_op ? {{63'd0}, _out_T_27} : _out_T_71; // @[Mux.scala 80:57]
  wire [126:0] _out_T_75 = 5'h10 == io_alu_op ? {{63'd0}, _out_T_30} : _out_T_73; // @[Mux.scala 80:57]
  wire [126:0] _out_T_77 = 5'h11 == io_alu_op ? {{63'd0}, _out_T_32} : _out_T_75; // @[Mux.scala 80:57]
  wire [126:0] _out_T_79 = 5'h12 == io_alu_op ? {{63'd0}, _out_T_34} : _out_T_77; // @[Mux.scala 80:57]
  wire [126:0] _out_T_81 = 5'h13 == io_alu_op ? {{63'd0}, _out_T_38} : _out_T_79; // @[Mux.scala 80:57]
  wire [126:0] _out_T_83 = 5'h14 == io_alu_op ? {{63'd0}, _out_T_27} : _out_T_81; // @[Mux.scala 80:57]
  assign io_out = _out_T_83[63:0]; // @[EX.scala 55:17 EX.scala 57:7]
endmodule
module ysyx_210013_EX(
  input  [63:0] io_rs1,
  input  [63:0] io_rs2,
  input  [4:0]  io_alu_op,
  output [63:0] io_out
);
  wire [63:0] alu_io_rs1; // @[EX.scala 93:19]
  wire [63:0] alu_io_rs2; // @[EX.scala 93:19]
  wire [4:0] alu_io_alu_op; // @[EX.scala 93:19]
  wire [63:0] alu_io_out; // @[EX.scala 93:19]
  ysyx_210013_ALU alu ( // @[EX.scala 93:19]
    .io_rs1(alu_io_rs1),
    .io_rs2(alu_io_rs2),
    .io_alu_op(alu_io_alu_op),
    .io_out(alu_io_out)
  );
  assign io_out = alu_io_out; // @[EX.scala 99:10]
  assign alu_io_rs1 = io_rs1; // @[EX.scala 95:14]
  assign alu_io_rs2 = io_rs2; // @[EX.scala 96:14]
  assign alu_io_alu_op = io_alu_op; // @[EX.scala 97:17]
endmodule
module ysyx_210013_MEM(
  input         clock,
  input         reset,
  input         io_dcache_req_ready,
  output        io_dcache_req_valid,
  output [63:0] io_dcache_req_bits_addr,
  output [63:0] io_dcache_req_bits_data,
  output [7:0]  io_dcache_req_bits_mask,
  output        io_dcache_req_bits_op,
  input         io_dcache_resp_valid,
  input  [63:0] io_dcache_resp_bits_data,
  input  [3:0]  io_dcache_resp_bits_cmd,
  input  [2:0]  io_ld_type,
  input  [2:0]  io_st_type,
  input  [63:0] io_s_data,
  input  [63:0] io_alu_res,
  output [63:0] io_l_data_bits,
  output        io_s_complete,
  input         io_stall,
  input         io_inst_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg  dcache_ready_reg; // @[MEM.scala 28:33]
  reg [2:0] ld_type; // @[MEM.scala 30:24]
  wire  _io_dcache_req_valid_T_2 = ~io_stall; // @[MEM.scala 37:73]
  wire [10:0] _io_dcache_req_bits_mask_T_1 = 11'hf << io_alu_res[2:0]; // @[MEM.scala 41:33]
  wire [8:0] _io_dcache_req_bits_mask_T_3 = 9'h3 << io_alu_res[2:0]; // @[MEM.scala 42:33]
  wire [7:0] _io_dcache_req_bits_mask_T_5 = 8'h1 << io_alu_res[2:0]; // @[MEM.scala 43:33]
  wire [7:0] _io_dcache_req_bits_mask_T_13 = 3'h1 == io_ld_type ? 8'hff : 8'h0; // @[Mux.scala 80:57]
  wire [10:0] _io_dcache_req_bits_mask_T_15 = 3'h2 == io_ld_type ? _io_dcache_req_bits_mask_T_1 : {{3'd0},
    _io_dcache_req_bits_mask_T_13}; // @[Mux.scala 80:57]
  wire [10:0] _io_dcache_req_bits_mask_T_17 = 3'h3 == io_ld_type ? {{2'd0}, _io_dcache_req_bits_mask_T_3} :
    _io_dcache_req_bits_mask_T_15; // @[Mux.scala 80:57]
  wire [10:0] _io_dcache_req_bits_mask_T_19 = 3'h4 == io_ld_type ? {{3'd0}, _io_dcache_req_bits_mask_T_5} :
    _io_dcache_req_bits_mask_T_17; // @[Mux.scala 80:57]
  wire [10:0] _io_dcache_req_bits_mask_T_21 = 3'h5 == io_ld_type ? _io_dcache_req_bits_mask_T_1 :
    _io_dcache_req_bits_mask_T_19; // @[Mux.scala 80:57]
  wire [10:0] _io_dcache_req_bits_mask_T_23 = 3'h6 == io_ld_type ? {{2'd0}, _io_dcache_req_bits_mask_T_3} :
    _io_dcache_req_bits_mask_T_21; // @[Mux.scala 80:57]
  wire [10:0] _io_dcache_req_bits_mask_T_25 = 3'h7 == io_ld_type ? {{3'd0}, _io_dcache_req_bits_mask_T_5} :
    _io_dcache_req_bits_mask_T_23; // @[Mux.scala 80:57]
  wire  _T_1 = io_st_type != 3'h0; // @[MEM.scala 51:25]
  wire [7:0] _io_dcache_req_bits_mask_T_33 = 3'h1 == io_st_type ? 8'hff : 8'h0; // @[Mux.scala 80:57]
  wire [10:0] _io_dcache_req_bits_mask_T_35 = 3'h2 == io_st_type ? _io_dcache_req_bits_mask_T_1 : {{3'd0},
    _io_dcache_req_bits_mask_T_33}; // @[Mux.scala 80:57]
  wire [10:0] _io_dcache_req_bits_mask_T_37 = 3'h3 == io_st_type ? {{2'd0}, _io_dcache_req_bits_mask_T_3} :
    _io_dcache_req_bits_mask_T_35; // @[Mux.scala 80:57]
  wire [10:0] _io_dcache_req_bits_mask_T_39 = 3'h4 == io_st_type ? {{3'd0}, _io_dcache_req_bits_mask_T_5} :
    _io_dcache_req_bits_mask_T_37; // @[Mux.scala 80:57]
  wire [5:0] _io_dcache_req_bits_data_T_1 = {io_alu_res[2:0], 3'h0}; // @[MEM.scala 63:62]
  wire [126:0] _GEN_19 = {{63'd0}, io_s_data}; // @[MEM.scala 63:42]
  wire [126:0] _io_dcache_req_bits_data_T_2 = _GEN_19 << _io_dcache_req_bits_data_T_1; // @[MEM.scala 63:42]
  wire  _GEN_0 = io_st_type != 3'h0 & (io_inst_valid & _io_dcache_req_valid_T_2); // @[MEM.scala 51:33 MEM.scala 54:25 MEM.scala 67:25]
  wire [63:0] _GEN_1 = io_st_type != 3'h0 ? io_alu_res : 64'h0; // @[MEM.scala 51:33 MEM.scala 55:29 MEM.scala 68:29]
  wire [10:0] _GEN_2 = io_st_type != 3'h0 ? _io_dcache_req_bits_mask_T_39 : 11'h0; // @[MEM.scala 51:33 MEM.scala 56:29 MEM.scala 69:29]
  wire [126:0] _GEN_4 = io_st_type != 3'h0 ? _io_dcache_req_bits_data_T_2 : 127'h0; // @[MEM.scala 51:33 MEM.scala 63:29 MEM.scala 71:29]
  wire [10:0] _GEN_8 = io_ld_type != 3'h0 ? _io_dcache_req_bits_mask_T_25 : _GEN_2; // @[MEM.scala 34:27 MEM.scala 39:29]
  wire [126:0] _GEN_10 = io_ld_type != 3'h0 ? 127'h0 : _GEN_4; // @[MEM.scala 34:27 MEM.scala 49:29]
  wire  _stall_data_valid_T_1 = io_dcache_resp_valid & io_dcache_resp_bits_cmd == 4'h2; // @[MEM.scala 76:48]
  wire  stall_data_valid = io_dcache_resp_valid & io_dcache_resp_bits_cmd == 4'h2 & io_stall; // @[MEM.scala 76:84]
  reg  stall_data_valid_posedge_REG; // @[MEM.scala 77:61]
  wire  stall_data_valid_posedge = stall_data_valid & ~stall_data_valid_posedge_REG; // @[MEM.scala 77:51]
  reg [63:0] l_data; // @[Reg.scala 27:20]
  reg  stall_negedge_REG; // @[MEM.scala 82:42]
  wire  stall_negedge = _io_dcache_req_valid_T_2 & stall_negedge_REG; // @[MEM.scala 82:33]
  wire [31:0] _io_l_data_bits_T_3 = io_dcache_resp_bits_data[31:0]; // @[MEM.scala 91:65]
  wire [15:0] _io_l_data_bits_T_5 = io_dcache_resp_bits_data[15:0]; // @[MEM.scala 92:65]
  wire [7:0] _io_l_data_bits_T_7 = io_dcache_resp_bits_data[7:0]; // @[MEM.scala 93:65]
  wire [32:0] _io_l_data_bits_T_9 = {1'b0,$signed(io_dcache_resp_bits_data[31:0])}; // @[MEM.scala 94:63]
  wire [16:0] _io_l_data_bits_T_11 = {1'b0,$signed(io_dcache_resp_bits_data[15:0])}; // @[MEM.scala 95:63]
  wire [8:0] _io_l_data_bits_T_13 = {1'b0,$signed(io_dcache_resp_bits_data[7:0])}; // @[MEM.scala 96:63]
  wire [63:0] _io_l_data_bits_T_15 = 3'h1 == ld_type ? $signed(io_dcache_resp_bits_data) : $signed(64'sh0); // @[Mux.scala 80:57]
  wire [63:0] _io_l_data_bits_T_17 = 3'h2 == ld_type ? $signed({{32{_io_l_data_bits_T_3[31]}},_io_l_data_bits_T_3}) :
    $signed(_io_l_data_bits_T_15); // @[Mux.scala 80:57]
  wire [63:0] _io_l_data_bits_T_19 = 3'h3 == ld_type ? $signed({{48{_io_l_data_bits_T_5[15]}},_io_l_data_bits_T_5}) :
    $signed(_io_l_data_bits_T_17); // @[Mux.scala 80:57]
  wire [63:0] _io_l_data_bits_T_21 = 3'h4 == ld_type ? $signed({{56{_io_l_data_bits_T_7[7]}},_io_l_data_bits_T_7}) :
    $signed(_io_l_data_bits_T_19); // @[Mux.scala 80:57]
  wire [63:0] _io_l_data_bits_T_23 = 3'h5 == ld_type ? $signed({{31{_io_l_data_bits_T_9[32]}},_io_l_data_bits_T_9}) :
    $signed(_io_l_data_bits_T_21); // @[Mux.scala 80:57]
  wire [63:0] _io_l_data_bits_T_25 = 3'h6 == ld_type ? $signed({{47{_io_l_data_bits_T_11[16]}},_io_l_data_bits_T_11}) :
    $signed(_io_l_data_bits_T_23); // @[Mux.scala 80:57]
  wire [63:0] _io_l_data_bits_T_28 = 3'h7 == ld_type ? $signed({{55{_io_l_data_bits_T_13[8]}},_io_l_data_bits_T_13}) :
    $signed(_io_l_data_bits_T_25); // @[MEM.scala 97:16]
  wire [63:0] _GEN_15 = _stall_data_valid_T_1 ? _io_l_data_bits_T_28 : 64'h0; // @[MEM.scala 87:68 MEM.scala 89:22 MEM.scala 100:22]
  assign io_dcache_req_valid = io_ld_type != 3'h0 ? (io_inst_valid | dcache_ready_reg) & ~io_stall : _GEN_0; // @[MEM.scala 34:27 MEM.scala 37:25]
  assign io_dcache_req_bits_addr = io_ld_type != 3'h0 ? io_alu_res : _GEN_1; // @[MEM.scala 34:27 MEM.scala 38:29]
  assign io_dcache_req_bits_data = _GEN_10[63:0];
  assign io_dcache_req_bits_mask = _GEN_8[7:0];
  assign io_dcache_req_bits_op = io_ld_type != 3'h0 ? 1'h0 : _T_1; // @[MEM.scala 34:27 MEM.scala 48:27]
  assign io_l_data_bits = stall_negedge ? l_data : _GEN_15; // @[MEM.scala 83:22 MEM.scala 84:20]
  assign io_s_complete = io_dcache_resp_valid & io_dcache_resp_bits_cmd == 4'h1; // @[MEM.scala 106:47]
  always @(posedge clock) begin
    if (reset) begin // @[MEM.scala 28:33]
      dcache_ready_reg <= 1'h0; // @[MEM.scala 28:33]
    end else begin
      dcache_ready_reg <= io_dcache_req_valid & ~io_dcache_req_ready; // @[MEM.scala 28:33]
    end
    if (reset) begin // @[MEM.scala 30:24]
      ld_type <= 3'h0; // @[MEM.scala 30:24]
    end else if (io_ld_type != 3'h0) begin // @[MEM.scala 34:27]
      if (_io_dcache_req_valid_T_2) begin // @[MEM.scala 50:19]
        ld_type <= io_ld_type;
      end
    end
    if (reset) begin // @[MEM.scala 77:61]
      stall_data_valid_posedge_REG <= 1'h0; // @[MEM.scala 77:61]
    end else begin
      stall_data_valid_posedge_REG <= stall_data_valid; // @[MEM.scala 77:61]
    end
    if (reset) begin // @[Reg.scala 27:20]
      l_data <= 64'h0; // @[Reg.scala 27:20]
    end else if (stall_data_valid_posedge) begin // @[Reg.scala 28:19]
      l_data <= io_l_data_bits; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[MEM.scala 82:42]
      stall_negedge_REG <= 1'h0; // @[MEM.scala 82:42]
    end else begin
      stall_negedge_REG <= io_stall; // @[MEM.scala 82:42]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  dcache_ready_reg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  ld_type = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  stall_data_valid_posedge_REG = _RAND_2[0:0];
  _RAND_3 = {2{`RANDOM}};
  l_data = _RAND_3[63:0];
  _RAND_4 = {1{`RANDOM}};
  stall_negedge_REG = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_210013_Branch(
  input  [63:0] io_rs1,
  input  [63:0] io_rs2,
  input  [2:0]  io_br_type,
  output        io_taken
);
  wire  eq = io_rs1 == io_rs2; // @[Branch.scala 20:19]
  wire  neq = ~eq; // @[Branch.scala 21:13]
  wire  less = $signed(io_rs1) < $signed(io_rs2); // @[Branch.scala 22:30]
  wire  greater_eq = ~less; // @[Branch.scala 23:20]
  wire  less_u = io_rs1 < io_rs2; // @[Branch.scala 24:23]
  wire  greater_eq_u = ~less_u; // @[Branch.scala 25:22]
  wire  _io_taken_T_3 = io_br_type == 3'h6 & neq; // @[Branch.scala 29:37]
  wire  _io_taken_T_4 = io_br_type == 3'h3 & eq | _io_taken_T_3; // @[Branch.scala 28:44]
  wire  _io_taken_T_6 = io_br_type == 3'h2 & less; // @[Branch.scala 30:37]
  wire  _io_taken_T_7 = _io_taken_T_4 | _io_taken_T_6; // @[Branch.scala 29:45]
  wire  _io_taken_T_9 = io_br_type == 3'h5 & greater_eq; // @[Branch.scala 31:37]
  wire  _io_taken_T_10 = _io_taken_T_7 | _io_taken_T_9; // @[Branch.scala 30:46]
  wire  _io_taken_T_12 = io_br_type == 3'h1 & less_u; // @[Branch.scala 32:38]
  wire  _io_taken_T_13 = _io_taken_T_10 | _io_taken_T_12; // @[Branch.scala 31:52]
  wire  _io_taken_T_15 = io_br_type == 3'h4 & greater_eq_u; // @[Branch.scala 33:38]
  wire  _io_taken_T_16 = _io_taken_T_13 | _io_taken_T_15; // @[Branch.scala 32:49]
  wire  _io_taken_T_17 = io_br_type == 3'h7; // @[Branch.scala 34:18]
  assign io_taken = _io_taken_T_16 | _io_taken_T_17; // @[Branch.scala 33:55]
endmodule
module ysyx_210013_RegisterFile(
  input         clock,
  input         reset,
  input  [4:0]  io_raddr1,
  input  [4:0]  io_raddr2,
  output [63:0] io_rdata1,
  output [63:0] io_rdata2,
  input         io_wen,
  input  [4:0]  io_waddr,
  input  [63:0] io_wdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [63:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [63:0] _RAND_19;
  reg [63:0] _RAND_20;
  reg [63:0] _RAND_21;
  reg [63:0] _RAND_22;
  reg [63:0] _RAND_23;
  reg [63:0] _RAND_24;
  reg [63:0] _RAND_25;
  reg [63:0] _RAND_26;
  reg [63:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [63:0] _RAND_29;
  reg [63:0] _RAND_30;
  reg [63:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] registers_0; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_1; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_2; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_3; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_4; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_5; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_6; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_7; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_8; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_9; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_10; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_11; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_12; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_13; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_14; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_15; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_16; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_17; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_18; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_19; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_20; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_21; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_22; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_23; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_24; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_25; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_26; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_27; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_28; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_29; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_30; // @[RegisterFile.scala 25:26]
  reg [63:0] registers_31; // @[RegisterFile.scala 25:26]
  wire [63:0] _GEN_1 = 5'h1 == io_raddr1 ? registers_1 : registers_0; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_2 = 5'h2 == io_raddr1 ? registers_2 : _GEN_1; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_3 = 5'h3 == io_raddr1 ? registers_3 : _GEN_2; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_4 = 5'h4 == io_raddr1 ? registers_4 : _GEN_3; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_5 = 5'h5 == io_raddr1 ? registers_5 : _GEN_4; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_6 = 5'h6 == io_raddr1 ? registers_6 : _GEN_5; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_7 = 5'h7 == io_raddr1 ? registers_7 : _GEN_6; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_8 = 5'h8 == io_raddr1 ? registers_8 : _GEN_7; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_9 = 5'h9 == io_raddr1 ? registers_9 : _GEN_8; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_10 = 5'ha == io_raddr1 ? registers_10 : _GEN_9; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_11 = 5'hb == io_raddr1 ? registers_11 : _GEN_10; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_12 = 5'hc == io_raddr1 ? registers_12 : _GEN_11; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_13 = 5'hd == io_raddr1 ? registers_13 : _GEN_12; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_14 = 5'he == io_raddr1 ? registers_14 : _GEN_13; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_15 = 5'hf == io_raddr1 ? registers_15 : _GEN_14; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_16 = 5'h10 == io_raddr1 ? registers_16 : _GEN_15; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_17 = 5'h11 == io_raddr1 ? registers_17 : _GEN_16; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_18 = 5'h12 == io_raddr1 ? registers_18 : _GEN_17; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_19 = 5'h13 == io_raddr1 ? registers_19 : _GEN_18; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_20 = 5'h14 == io_raddr1 ? registers_20 : _GEN_19; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_21 = 5'h15 == io_raddr1 ? registers_21 : _GEN_20; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_22 = 5'h16 == io_raddr1 ? registers_22 : _GEN_21; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_23 = 5'h17 == io_raddr1 ? registers_23 : _GEN_22; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_24 = 5'h18 == io_raddr1 ? registers_24 : _GEN_23; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_25 = 5'h19 == io_raddr1 ? registers_25 : _GEN_24; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_26 = 5'h1a == io_raddr1 ? registers_26 : _GEN_25; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_27 = 5'h1b == io_raddr1 ? registers_27 : _GEN_26; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_28 = 5'h1c == io_raddr1 ? registers_28 : _GEN_27; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_29 = 5'h1d == io_raddr1 ? registers_29 : _GEN_28; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_30 = 5'h1e == io_raddr1 ? registers_30 : _GEN_29; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _GEN_31 = 5'h1f == io_raddr1 ? registers_31 : _GEN_30; // @[RegisterFile.scala 27:53 RegisterFile.scala 27:53]
  wire [63:0] _io_rdata1_T_4 = io_wen & io_waddr == io_raddr1 ? io_wdata : _GEN_31; // @[RegisterFile.scala 27:53]
  wire [63:0] _GEN_33 = 5'h1 == io_raddr2 ? registers_1 : registers_0; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_34 = 5'h2 == io_raddr2 ? registers_2 : _GEN_33; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_35 = 5'h3 == io_raddr2 ? registers_3 : _GEN_34; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_36 = 5'h4 == io_raddr2 ? registers_4 : _GEN_35; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_37 = 5'h5 == io_raddr2 ? registers_5 : _GEN_36; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_38 = 5'h6 == io_raddr2 ? registers_6 : _GEN_37; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_39 = 5'h7 == io_raddr2 ? registers_7 : _GEN_38; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_40 = 5'h8 == io_raddr2 ? registers_8 : _GEN_39; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_41 = 5'h9 == io_raddr2 ? registers_9 : _GEN_40; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_42 = 5'ha == io_raddr2 ? registers_10 : _GEN_41; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_43 = 5'hb == io_raddr2 ? registers_11 : _GEN_42; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_44 = 5'hc == io_raddr2 ? registers_12 : _GEN_43; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_45 = 5'hd == io_raddr2 ? registers_13 : _GEN_44; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_46 = 5'he == io_raddr2 ? registers_14 : _GEN_45; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_47 = 5'hf == io_raddr2 ? registers_15 : _GEN_46; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_48 = 5'h10 == io_raddr2 ? registers_16 : _GEN_47; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_49 = 5'h11 == io_raddr2 ? registers_17 : _GEN_48; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_50 = 5'h12 == io_raddr2 ? registers_18 : _GEN_49; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_51 = 5'h13 == io_raddr2 ? registers_19 : _GEN_50; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_52 = 5'h14 == io_raddr2 ? registers_20 : _GEN_51; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_53 = 5'h15 == io_raddr2 ? registers_21 : _GEN_52; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_54 = 5'h16 == io_raddr2 ? registers_22 : _GEN_53; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_55 = 5'h17 == io_raddr2 ? registers_23 : _GEN_54; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_56 = 5'h18 == io_raddr2 ? registers_24 : _GEN_55; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_57 = 5'h19 == io_raddr2 ? registers_25 : _GEN_56; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_58 = 5'h1a == io_raddr2 ? registers_26 : _GEN_57; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_59 = 5'h1b == io_raddr2 ? registers_27 : _GEN_58; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_60 = 5'h1c == io_raddr2 ? registers_28 : _GEN_59; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_61 = 5'h1d == io_raddr2 ? registers_29 : _GEN_60; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_62 = 5'h1e == io_raddr2 ? registers_30 : _GEN_61; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _GEN_63 = 5'h1f == io_raddr2 ? registers_31 : _GEN_62; // @[RegisterFile.scala 28:53 RegisterFile.scala 28:53]
  wire [63:0] _io_rdata2_T_4 = io_wen & io_waddr == io_raddr2 ? io_wdata : _GEN_63; // @[RegisterFile.scala 28:53]
  assign io_rdata1 = ~(|io_raddr1) ? 64'h0 : _io_rdata1_T_4; // @[RegisterFile.scala 27:19]
  assign io_rdata2 = ~(|io_raddr2) ? 64'h0 : _io_rdata2_T_4; // @[RegisterFile.scala 28:19]
  always @(posedge clock) begin
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_0 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h0 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_0 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_1 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h1 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_1 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_2 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h2 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_2 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_3 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h3 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_3 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_4 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h4 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_4 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_5 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h5 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_5 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_6 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h6 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_6 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_7 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h7 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_7 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_8 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h8 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_8 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_9 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h9 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_9 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_10 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'ha == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_10 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_11 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'hb == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_11 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_12 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'hc == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_12 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_13 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'hd == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_13 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_14 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'he == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_14 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_15 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'hf == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_15 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_16 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h10 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_16 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_17 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h11 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_17 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_18 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h12 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_18 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_19 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h13 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_19 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_20 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h14 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_20 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_21 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h15 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_21 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_22 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h16 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_22 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_23 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h17 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_23 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_24 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h18 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_24 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_25 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h19 == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_25 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_26 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h1a == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_26 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_27 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h1b == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_27 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_28 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h1c == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_28 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_29 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h1d == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_29 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_30 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h1e == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_30 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
    if (reset) begin // @[RegisterFile.scala 25:26]
      registers_31 <= 64'h0; // @[RegisterFile.scala 25:26]
    end else if (io_wen & |io_waddr) begin // @[RegisterFile.scala 30:48]
      if (5'h1f == io_waddr) begin // @[RegisterFile.scala 31:25]
        registers_31 <= io_wdata; // @[RegisterFile.scala 31:25]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  registers_0 = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  registers_1 = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  registers_2 = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  registers_3 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  registers_4 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  registers_5 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  registers_6 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  registers_7 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  registers_8 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  registers_9 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  registers_10 = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  registers_11 = _RAND_11[63:0];
  _RAND_12 = {2{`RANDOM}};
  registers_12 = _RAND_12[63:0];
  _RAND_13 = {2{`RANDOM}};
  registers_13 = _RAND_13[63:0];
  _RAND_14 = {2{`RANDOM}};
  registers_14 = _RAND_14[63:0];
  _RAND_15 = {2{`RANDOM}};
  registers_15 = _RAND_15[63:0];
  _RAND_16 = {2{`RANDOM}};
  registers_16 = _RAND_16[63:0];
  _RAND_17 = {2{`RANDOM}};
  registers_17 = _RAND_17[63:0];
  _RAND_18 = {2{`RANDOM}};
  registers_18 = _RAND_18[63:0];
  _RAND_19 = {2{`RANDOM}};
  registers_19 = _RAND_19[63:0];
  _RAND_20 = {2{`RANDOM}};
  registers_20 = _RAND_20[63:0];
  _RAND_21 = {2{`RANDOM}};
  registers_21 = _RAND_21[63:0];
  _RAND_22 = {2{`RANDOM}};
  registers_22 = _RAND_22[63:0];
  _RAND_23 = {2{`RANDOM}};
  registers_23 = _RAND_23[63:0];
  _RAND_24 = {2{`RANDOM}};
  registers_24 = _RAND_24[63:0];
  _RAND_25 = {2{`RANDOM}};
  registers_25 = _RAND_25[63:0];
  _RAND_26 = {2{`RANDOM}};
  registers_26 = _RAND_26[63:0];
  _RAND_27 = {2{`RANDOM}};
  registers_27 = _RAND_27[63:0];
  _RAND_28 = {2{`RANDOM}};
  registers_28 = _RAND_28[63:0];
  _RAND_29 = {2{`RANDOM}};
  registers_29 = _RAND_29[63:0];
  _RAND_30 = {2{`RANDOM}};
  registers_30 = _RAND_30[63:0];
  _RAND_31 = {2{`RANDOM}};
  registers_31 = _RAND_31[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_210013_ByPass(
  input  [4:0] io_ex_rs1,
  input  [4:0] io_ex_rs2,
  input  [4:0] io_mem_rd,
  input        io_mem_valid,
  input  [4:0] io_wb_rd,
  input        io_wb_valid,
  output [1:0] io_forwardA,
  output [1:0] io_forwardB
);
  wire  _T_1 = io_ex_rs1 != 5'h0; // @[DataPath.scala 33:62]
  wire [1:0] _GEN_0 = io_ex_rs1 == io_wb_rd & _T_1 & io_wb_valid ? 2'h3 : 2'h0; // @[DataPath.scala 35:91 DataPath.scala 36:17 DataPath.scala 38:17]
  wire  _T_11 = io_ex_rs2 != 5'h0; // @[DataPath.scala 41:62]
  wire [1:0] _GEN_2 = io_ex_rs2 == io_wb_rd & _T_11 & io_wb_valid ? 2'h3 : 2'h0; // @[DataPath.scala 43:89 DataPath.scala 44:17 DataPath.scala 46:17]
  assign io_forwardA = io_ex_rs1 == io_mem_rd & io_ex_rs1 != 5'h0 & io_mem_valid ? 2'h1 : _GEN_0; // @[DataPath.scala 33:87 DataPath.scala 34:17]
  assign io_forwardB = io_ex_rs2 == io_mem_rd & io_ex_rs2 != 5'h0 & io_mem_valid ? 2'h1 : _GEN_2; // @[DataPath.scala 41:87 DataPath.scala 42:17]
endmodule
module ysyx_210013_LoadRisk(
  input        io_id_valid,
  input  [4:0] io_id_rs1,
  input  [4:0] io_id_rs2,
  input        io_ex_valid,
  input        io_ex_isLoad,
  input  [4:0] io_ex_rd,
  output       io_stall
);
  assign io_stall = io_id_valid & io_ex_valid & io_ex_isLoad & (io_id_rs1 == io_ex_rd | io_id_rs2 == io_ex_rd); // @[DataPath.scala 65:49]
endmodule
module ysyx_210013_CSR(
  input         clock,
  input         reset,
  input         io_stall,
  input  [2:0]  io_cmd,
  input  [63:0] io_in,
  output [63:0] io_out,
  input         io_ctrl_signal_valid,
  input  [63:0] io_ctrl_signal_pc,
  input  [63:0] io_ctrl_signal_addr,
  input  [63:0] io_ctrl_signal_inst,
  input         io_ctrl_signal_illegal,
  input  [2:0]  io_ctrl_signal_st_type,
  input  [2:0]  io_ctrl_signal_ld_type,
  input         io_pc_check,
  output        io_expt,
  output [63:0] io_exvec,
  output [63:0] io_epc,
  input         io_interrupt_time,
  output        time_interrupt_enable_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [63:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
`endif // RANDOMIZE_REG_INIT
  wire [11:0] csr_addr = io_ctrl_signal_inst[31:20]; // @[CSR.scala 117:34]
  reg [63:0] mscratch; // @[CSR.scala 120:25]
  reg [63:0] mtvec; // @[CSR.scala 122:24]
  reg [63:0] mepc; // @[CSR.scala 123:24]
  reg [63:0] mcause; // @[CSR.scala 124:24]
  reg [63:0] mcycle; // @[CSR.scala 125:24]
  wire [63:0] _mcycle_T_1 = mcycle + 64'h1; // @[CSR.scala 127:20]
  reg [1:0] mstatus_prv; // @[CSR.scala 132:24]
  reg  mstatus_sd; // @[CSR.scala 132:24]
  reg [26:0] mstatus_ZERO0; // @[CSR.scala 132:24]
  reg [1:0] mstatus_sxl; // @[CSR.scala 132:24]
  reg [1:0] mstatus_uxl; // @[CSR.scala 132:24]
  reg [8:0] mstatus_ZERO1; // @[CSR.scala 132:24]
  reg  mstatus_tsr; // @[CSR.scala 132:24]
  reg  mstatus_tw; // @[CSR.scala 132:24]
  reg  mstatus_tvm; // @[CSR.scala 132:24]
  reg  mstatus_mxr; // @[CSR.scala 132:24]
  reg  mstatus_sum; // @[CSR.scala 132:24]
  reg  mstatus_mprv; // @[CSR.scala 132:24]
  reg [1:0] mstatus_xs; // @[CSR.scala 132:24]
  reg [1:0] mstatus_fs; // @[CSR.scala 132:24]
  reg [1:0] mstatus_mpp; // @[CSR.scala 132:24]
  reg [1:0] mstatus_ZERO2; // @[CSR.scala 132:24]
  reg  mstatus_spp; // @[CSR.scala 132:24]
  reg  mstatus_mpie; // @[CSR.scala 132:24]
  reg  mstatus_ZERO3; // @[CSR.scala 132:24]
  reg  mstatus_spie; // @[CSR.scala 132:24]
  reg  mstatus_upie; // @[CSR.scala 132:24]
  reg  mstatus_mie; // @[CSR.scala 132:24]
  reg  mstatus_ZERO4; // @[CSR.scala 132:24]
  reg  mstatus_sie; // @[CSR.scala 132:24]
  reg  mstatus_uie; // @[CSR.scala 132:24]
  reg [51:0] mie_ZERO0; // @[CSR.scala 134:20]
  reg  mie_meie; // @[CSR.scala 134:20]
  reg  mie_ZERO1; // @[CSR.scala 134:20]
  reg  mie_seie; // @[CSR.scala 134:20]
  reg  mie_ueie; // @[CSR.scala 134:20]
  reg  mie_mtie; // @[CSR.scala 134:20]
  reg  mie_ZERO2; // @[CSR.scala 134:20]
  reg  mie_stie; // @[CSR.scala 134:20]
  reg  mie_utie; // @[CSR.scala 134:20]
  reg  mie_msie; // @[CSR.scala 134:20]
  reg  mie_ZERO3; // @[CSR.scala 134:20]
  reg  mie_ssie; // @[CSR.scala 134:20]
  reg  mie_usie; // @[CSR.scala 134:20]
  wire [5:0] lo_lo = {mstatus_spie,mstatus_upie,mstatus_mie,mstatus_ZERO4,mstatus_sie,mstatus_uie}; // @[CSR.scala 146:52]
  wire [14:0] lo = {mstatus_fs,mstatus_mpp,mstatus_ZERO2,mstatus_spp,mstatus_mpie,mstatus_ZERO3,lo_lo}; // @[CSR.scala 146:52]
  wire [6:0] hi_lo = {mstatus_tw,mstatus_tvm,mstatus_mxr,mstatus_sum,mstatus_mprv,mstatus_xs}; // @[CSR.scala 146:52]
  wire [65:0] _T = {mstatus_prv,mstatus_sd,mstatus_ZERO0,mstatus_sxl,mstatus_uxl,mstatus_ZERO1,mstatus_tsr,hi_lo,lo}; // @[CSR.scala 146:52]
  wire  _mip_WIRE_ZERO3 = 1'h0; // @[CSR.scala 135:34 CSR.scala 135:34]
  wire  mip_ZERO3 = 1'h0; // @[CSR.scala 135:34 CSR.scala 135:34]
  wire  mip_ssip = 1'h0; // @[CSR.scala 135:34 CSR.scala 135:34]
  wire  mip_usip = 1'h0; // @[CSR.scala 135:34 CSR.scala 135:34]
  wire  mip_stip = 1'h0; // @[CSR.scala 135:34 CSR.scala 135:34]
  wire  mip_utip = 1'h0; // @[CSR.scala 135:34 CSR.scala 135:34]
  wire  mip_msip = 1'h0; // @[CSR.scala 135:34 CSR.scala 135:34]
  wire [5:0] lo_1 = {_mip_WIRE_ZERO3,_mip_WIRE_ZERO3,_mip_WIRE_ZERO3,_mip_WIRE_ZERO3,_mip_WIRE_ZERO3,_mip_WIRE_ZERO3}; // @[CSR.scala 150:48]
  wire  mip_ueip = 1'h0; // @[CSR.scala 135:34 CSR.scala 135:34]
  wire  mip_mtip = io_interrupt_time;
  wire  mip_ZERO2 = 1'h0; // @[CSR.scala 135:34 CSR.scala 135:34]
  wire  mip_ZERO1 = 1'h0; // @[CSR.scala 135:34 CSR.scala 135:34]
  wire  mip_seip = 1'h0; // @[CSR.scala 135:34 CSR.scala 135:34]
  wire [51:0] _mip_WIRE_ZERO0 = 52'h0; // @[CSR.scala 135:34 CSR.scala 135:34]
  wire [51:0] mip_ZERO0 = 52'h0; // @[CSR.scala 135:34 CSR.scala 135:34]
  wire  mip_meip = 1'h0; // @[CSR.scala 135:34 CSR.scala 135:34]
  wire [63:0] _T_1 = {_mip_WIRE_ZERO0,_mip_WIRE_ZERO3,_mip_WIRE_ZERO3,_mip_WIRE_ZERO3,_mip_WIRE_ZERO3,mip_mtip,
    _mip_WIRE_ZERO3,lo_1}; // @[CSR.scala 150:48]
  wire [5:0] lo_2 = {mie_stie,mie_utie,mie_msie,mie_ZERO3,mie_ssie,mie_usie}; // @[CSR.scala 151:48]
  wire [63:0] _T_2 = {mie_ZERO0,mie_meie,mie_ZERO1,mie_seie,mie_ueie,mie_mtie,mie_ZERO2,lo_2}; // @[CSR.scala 151:48]
  wire  _io_out_T_1 = 12'h300 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_3 = 12'h305 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_5 = 12'h341 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_7 = 12'h342 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_9 = 12'h344 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_11 = 12'h304 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_13 = 12'hb00 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_15 = 12'hf14 == csr_addr; // @[Lookup.scala 31:38]
  wire  _io_out_T_17 = 12'h340 == csr_addr; // @[Lookup.scala 31:38]
  wire [63:0] _io_out_T_18 = _io_out_T_17 ? mscratch : 64'h0; // @[Lookup.scala 33:37]
  wire [63:0] _io_out_T_19 = _io_out_T_15 ? 64'h0 : _io_out_T_18; // @[Lookup.scala 33:37]
  wire [63:0] _io_out_T_20 = _io_out_T_13 ? mcycle : _io_out_T_19; // @[Lookup.scala 33:37]
  wire [63:0] _io_out_T_21 = _io_out_T_11 ? _T_2 : _io_out_T_20; // @[Lookup.scala 33:37]
  wire [63:0] _io_out_T_22 = _io_out_T_9 ? _T_1 : _io_out_T_21; // @[Lookup.scala 33:37]
  wire [63:0] _io_out_T_23 = _io_out_T_7 ? mcause : _io_out_T_22; // @[Lookup.scala 33:37]
  wire [63:0] _io_out_T_24 = _io_out_T_5 ? mepc : _io_out_T_23; // @[Lookup.scala 33:37]
  wire [63:0] _io_out_T_25 = _io_out_T_3 ? mtvec : _io_out_T_24; // @[Lookup.scala 33:37]
  wire [65:0] _io_out_T_26 = _io_out_T_1 ? _T : {{2'd0}, _io_out_T_25}; // @[Lookup.scala 33:37]
  wire  privInst = io_cmd == 3'h4; // @[CSR.scala 160:26]
  wire  _isEcall_T_4 = csr_addr[9:8] == 2'h0; // @[CSR.scala 161:97]
  wire  isEcall = privInst & csr_addr[1:0] == 2'h0 & csr_addr[9:8] == 2'h0; // @[CSR.scala 161:69]
  wire  isEbreak = privInst & csr_addr[1:0] == 2'h1 & _isEcall_T_4; // @[CSR.scala 162:69]
  wire  _isMret_T_2 = privInst & csr_addr[1:0] == 2'h2; // @[CSR.scala 163:28]
  wire  isMret = privInst & csr_addr[1:0] == 2'h2 & csr_addr[9:8] == 2'h3; // @[CSR.scala 163:69]
  wire  isSret = _isMret_T_2 & csr_addr[9:8] == 2'h1; // @[CSR.scala 164:69]
  wire  _csrRO_T_2 = csr_addr == 12'h305; // @[CSR.scala 166:53]
  wire  wen = io_cmd == 3'h1 | io_cmd == 3'h2 | io_cmd == 3'h3; // @[CSR.scala 167:59]
  wire [63:0] _wdata_T = io_out | io_in; // @[CSR.scala 170:22]
  wire [63:0] _wdata_T_1 = ~io_in; // @[CSR.scala 171:25]
  wire [63:0] _wdata_T_2 = io_out & _wdata_T_1; // @[CSR.scala 171:22]
  wire [63:0] _wdata_T_4 = 3'h1 == io_cmd ? io_in : 64'h0; // @[Mux.scala 80:57]
  wire [63:0] _wdata_T_6 = 3'h2 == io_cmd ? _wdata_T : _wdata_T_4; // @[Mux.scala 80:57]
  wire [63:0] wdata = 3'h3 == io_cmd ? _wdata_T_2 : _wdata_T_6; // @[Mux.scala 80:57]
  wire  time_interrupt_enable = mie_mtie & mstatus_mie; // @[CSR.scala 174:49]
  wire  time_interrupt = mip_mtip & time_interrupt_enable; // @[CSR.scala 176:33]
  wire  iaddrInvalid = io_pc_check & io_ctrl_signal_addr[1]; // @[CSR.scala 178:34]
  wire  _laddrInvalid_T_1 = |io_ctrl_signal_addr[1:0]; // @[CSR.scala 180:48]
  wire  _laddrInvalid_T_7 = 3'h3 == io_ctrl_signal_ld_type ? io_ctrl_signal_addr[0] : 3'h2 == io_ctrl_signal_ld_type &
    _laddrInvalid_T_1; // @[Mux.scala 80:57]
  wire  laddrInvalid = 3'h6 == io_ctrl_signal_ld_type ? io_ctrl_signal_addr[0] : _laddrInvalid_T_7; // @[Mux.scala 80:57]
  wire  saddrInvalid = 3'h3 == io_ctrl_signal_st_type ? io_ctrl_signal_addr[0] : 3'h2 == io_ctrl_signal_st_type &
    _laddrInvalid_T_1; // @[Mux.scala 80:57]
  wire  _io_expt_T_2 = io_ctrl_signal_illegal | iaddrInvalid | laddrInvalid | saddrInvalid; // @[CSR.scala 183:70]
  wire [63:0] _mepc_T_1 = {io_ctrl_signal_pc[63:2], 2'h0}; // @[CSR.scala 191:40]
  wire [3:0] _GEN_110 = {{2'd0}, mstatus_prv}; // @[CSR.scala 196:71]
  wire [3:0] _mcause_T_3 = 4'h8 + _GEN_110; // @[CSR.scala 196:71]
  wire [1:0] _mcause_T_4 = isEbreak ? 2'h3 : 2'h2; // @[CSR.scala 197:20]
  wire [3:0] _mcause_T_5 = isEcall ? _mcause_T_3 : {{2'd0}, _mcause_T_4}; // @[CSR.scala 196:20]
  wire [3:0] _mcause_T_6 = saddrInvalid ? 4'h6 : _mcause_T_5; // @[CSR.scala 195:20]
  wire [3:0] _mcause_T_7 = laddrInvalid ? 4'h4 : _mcause_T_6; // @[CSR.scala 194:20]
  wire [3:0] _mcause_T_8 = iaddrInvalid ? 4'h0 : _mcause_T_7; // @[CSR.scala 193:20]
  wire [65:0] _tmp_mstatus_WIRE = {{2'd0}, wdata};
  wire  tmp_mstatus_mie = _tmp_mstatus_WIRE[3]; // @[CSR.scala 212:41]
  wire  tmp_mstatus_mpie = _tmp_mstatus_WIRE[7]; // @[CSR.scala 212:41]
  wire [1:0] tmp_mstatus_mpp = _tmp_mstatus_WIRE[12:11]; // @[CSR.scala 212:41]
  wire [1:0] tmp_mstatus_fs = _tmp_mstatus_WIRE[14:13]; // @[CSR.scala 212:41]
  wire [1:0] tmp_mstatus_xs = _tmp_mstatus_WIRE[16:15]; // @[CSR.scala 212:41]
  wire  tmp_mie_msie = wdata[3]; // @[CSR.scala 226:37]
  wire  tmp_mie_mtie = wdata[7]; // @[CSR.scala 226:37]
  wire [63:0] _mepc_T_2 = {{2'd0}, wdata[63:2]}; // @[CSR.scala 230:59]
  wire [65:0] _GEN_112 = {_mepc_T_2, 2'h0}; // @[CSR.scala 230:66]
  wire [66:0] _mepc_T_3 = {{1'd0}, _GEN_112}; // @[CSR.scala 230:66]
  wire [63:0] _mcause_T_10 = wdata & 64'h800000000000000f; // @[CSR.scala 231:63]
  wire [63:0] _GEN_1 = csr_addr == 12'h340 ? wdata : mscratch; // @[CSR.scala 234:46 CSR.scala 234:57 CSR.scala 120:25]
  wire [63:0] _GEN_2 = csr_addr == 12'hb00 ? wdata : _mcycle_T_1; // @[CSR.scala 233:44 CSR.scala 233:53 CSR.scala 127:10]
  wire [63:0] _GEN_3 = csr_addr == 12'hb00 ? mscratch : _GEN_1; // @[CSR.scala 233:44 CSR.scala 120:25]
  wire [63:0] _GEN_4 = _csrRO_T_2 ? wdata : mtvec; // @[CSR.scala 232:44 CSR.scala 232:52 CSR.scala 122:24]
  wire [63:0] _GEN_5 = _csrRO_T_2 ? _mcycle_T_1 : _GEN_2; // @[CSR.scala 232:44 CSR.scala 127:10]
  wire [63:0] _GEN_6 = _csrRO_T_2 ? mscratch : _GEN_3; // @[CSR.scala 232:44 CSR.scala 120:25]
  wire [63:0] _GEN_7 = csr_addr == 12'h342 ? _mcause_T_10 : mcause; // @[CSR.scala 231:45 CSR.scala 231:54 CSR.scala 124:24]
  wire [63:0] _GEN_8 = csr_addr == 12'h342 ? mtvec : _GEN_4; // @[CSR.scala 231:45 CSR.scala 122:24]
  wire [63:0] _GEN_9 = csr_addr == 12'h342 ? _mcycle_T_1 : _GEN_5; // @[CSR.scala 231:45 CSR.scala 127:10]
  wire [63:0] _GEN_10 = csr_addr == 12'h342 ? mscratch : _GEN_6; // @[CSR.scala 231:45 CSR.scala 120:25]
  wire [66:0] _GEN_11 = csr_addr == 12'h341 ? _mepc_T_3 : {{3'd0}, mepc}; // @[CSR.scala 230:43 CSR.scala 230:50 CSR.scala 123:24]
  wire [63:0] _GEN_12 = csr_addr == 12'h341 ? mcause : _GEN_7; // @[CSR.scala 230:43 CSR.scala 124:24]
  wire [63:0] _GEN_13 = csr_addr == 12'h341 ? mtvec : _GEN_8; // @[CSR.scala 230:43 CSR.scala 122:24]
  wire [63:0] _GEN_14 = csr_addr == 12'h341 ? _mcycle_T_1 : _GEN_9; // @[CSR.scala 230:43 CSR.scala 127:10]
  wire [63:0] _GEN_15 = csr_addr == 12'h341 ? mscratch : _GEN_10; // @[CSR.scala 230:43 CSR.scala 120:25]
  wire  _GEN_16 = csr_addr == 12'h304 ? tmp_mie_mtie : mie_mtie; // @[CSR.scala 225:42 CSR.scala 227:18 CSR.scala 134:20]
  wire  _GEN_17 = csr_addr == 12'h304 ? tmp_mie_msie : mie_msie; // @[CSR.scala 225:42 CSR.scala 228:18 CSR.scala 134:20]
  wire [66:0] _GEN_18 = csr_addr == 12'h304 ? {{3'd0}, mepc} : _GEN_11; // @[CSR.scala 225:42 CSR.scala 123:24]
  wire [63:0] _GEN_19 = csr_addr == 12'h304 ? mcause : _GEN_12; // @[CSR.scala 225:42 CSR.scala 124:24]
  wire [63:0] _GEN_20 = csr_addr == 12'h304 ? mtvec : _GEN_13; // @[CSR.scala 225:42 CSR.scala 122:24]
  wire [63:0] _GEN_21 = csr_addr == 12'h304 ? _mcycle_T_1 : _GEN_14; // @[CSR.scala 225:42 CSR.scala 127:10]
  wire [63:0] _GEN_22 = csr_addr == 12'h304 ? mscratch : _GEN_15; // @[CSR.scala 225:42 CSR.scala 120:25]
  wire  _GEN_23 = csr_addr == 12'h344 ? mie_mtie : _GEN_16; // @[CSR.scala 220:42 CSR.scala 134:20]
  wire  _GEN_24 = csr_addr == 12'h344 ? mie_msie : _GEN_17; // @[CSR.scala 220:42 CSR.scala 134:20]
  wire [66:0] _GEN_25 = csr_addr == 12'h344 ? {{3'd0}, mepc} : _GEN_18; // @[CSR.scala 220:42 CSR.scala 123:24]
  wire [63:0] _GEN_26 = csr_addr == 12'h344 ? mcause : _GEN_19; // @[CSR.scala 220:42 CSR.scala 124:24]
  wire [63:0] _GEN_27 = csr_addr == 12'h344 ? mtvec : _GEN_20; // @[CSR.scala 220:42 CSR.scala 122:24]
  wire [63:0] _GEN_28 = csr_addr == 12'h344 ? _mcycle_T_1 : _GEN_21; // @[CSR.scala 220:42 CSR.scala 127:10]
  wire [63:0] _GEN_29 = csr_addr == 12'h344 ? mscratch : _GEN_22; // @[CSR.scala 220:42 CSR.scala 120:25]
  wire  _GEN_30 = csr_addr == 12'h300 ? tmp_mstatus_mie : mstatus_mie; // @[CSR.scala 211:41 CSR.scala 213:21 CSR.scala 132:24]
  wire  _GEN_31 = csr_addr == 12'h300 ? tmp_mstatus_mpie : mstatus_mpie; // @[CSR.scala 211:41 CSR.scala 214:22 CSR.scala 132:24]
  wire [1:0] _GEN_32 = csr_addr == 12'h300 ? tmp_mstatus_xs : mstatus_xs; // @[CSR.scala 211:41 CSR.scala 215:20 CSR.scala 132:24]
  wire [1:0] _GEN_33 = csr_addr == 12'h300 ? tmp_mstatus_fs : mstatus_fs; // @[CSR.scala 211:41 CSR.scala 216:20 CSR.scala 132:24]
  wire [1:0] _GEN_34 = csr_addr == 12'h300 ? tmp_mstatus_mpp : mstatus_mpp; // @[CSR.scala 211:41 CSR.scala 217:21 CSR.scala 132:24]
  wire  _GEN_35 = csr_addr == 12'h300 ? &tmp_mstatus_xs | &tmp_mstatus_fs : mstatus_sd; // @[CSR.scala 211:41 CSR.scala 218:20 CSR.scala 132:24]
  wire  _GEN_36 = csr_addr == 12'h300 ? mie_mtie : _GEN_23; // @[CSR.scala 211:41 CSR.scala 134:20]
  wire  _GEN_37 = csr_addr == 12'h300 ? mie_msie : _GEN_24; // @[CSR.scala 211:41 CSR.scala 134:20]
  wire [66:0] _GEN_38 = csr_addr == 12'h300 ? {{3'd0}, mepc} : _GEN_25; // @[CSR.scala 211:41 CSR.scala 123:24]
  wire [63:0] _GEN_39 = csr_addr == 12'h300 ? mcause : _GEN_26; // @[CSR.scala 211:41 CSR.scala 124:24]
  wire [63:0] _GEN_40 = csr_addr == 12'h300 ? mtvec : _GEN_27; // @[CSR.scala 211:41 CSR.scala 122:24]
  wire [63:0] _GEN_41 = csr_addr == 12'h300 ? _mcycle_T_1 : _GEN_28; // @[CSR.scala 211:41 CSR.scala 127:10]
  wire [63:0] _GEN_42 = csr_addr == 12'h300 ? mscratch : _GEN_29; // @[CSR.scala 211:41 CSR.scala 120:25]
  wire  _GEN_43 = wen ? _GEN_30 : mstatus_mie; // @[CSR.scala 210:20 CSR.scala 132:24]
  wire  _GEN_44 = wen ? _GEN_31 : mstatus_mpie; // @[CSR.scala 210:20 CSR.scala 132:24]
  wire [1:0] _GEN_45 = wen ? _GEN_32 : mstatus_xs; // @[CSR.scala 210:20 CSR.scala 132:24]
  wire [1:0] _GEN_46 = wen ? _GEN_33 : mstatus_fs; // @[CSR.scala 210:20 CSR.scala 132:24]
  wire [1:0] _GEN_47 = wen ? _GEN_34 : mstatus_mpp; // @[CSR.scala 210:20 CSR.scala 132:24]
  wire  _GEN_48 = wen ? _GEN_35 : mstatus_sd; // @[CSR.scala 210:20 CSR.scala 132:24]
  wire  _GEN_49 = wen ? _GEN_36 : mie_mtie; // @[CSR.scala 210:20 CSR.scala 134:20]
  wire  _GEN_50 = wen ? _GEN_37 : mie_msie; // @[CSR.scala 210:20 CSR.scala 134:20]
  wire [66:0] _GEN_51 = wen ? _GEN_38 : {{3'd0}, mepc}; // @[CSR.scala 210:20 CSR.scala 123:24]
  wire [63:0] _GEN_52 = wen ? _GEN_39 : mcause; // @[CSR.scala 210:20 CSR.scala 124:24]
  wire [63:0] _GEN_53 = wen ? _GEN_40 : mtvec; // @[CSR.scala 210:20 CSR.scala 122:24]
  wire [63:0] _GEN_54 = wen ? _GEN_41 : _mcycle_T_1; // @[CSR.scala 210:20 CSR.scala 127:10]
  wire [63:0] _GEN_55 = wen ? _GEN_42 : mscratch; // @[CSR.scala 210:20 CSR.scala 120:25]
  wire  _GEN_56 = isSret ? mstatus_mpie : _GEN_43; // @[CSR.scala 206:23 CSR.scala 207:17]
  wire  _GEN_57 = isSret | _GEN_44; // @[CSR.scala 206:23 CSR.scala 208:18]
  wire [1:0] _GEN_58 = isSret ? mstatus_xs : _GEN_45; // @[CSR.scala 206:23 CSR.scala 132:24]
  wire [1:0] _GEN_59 = isSret ? mstatus_fs : _GEN_46; // @[CSR.scala 206:23 CSR.scala 132:24]
  wire [1:0] _GEN_60 = isSret ? mstatus_mpp : _GEN_47; // @[CSR.scala 206:23 CSR.scala 132:24]
  wire  _GEN_61 = isSret ? mstatus_sd : _GEN_48; // @[CSR.scala 206:23 CSR.scala 132:24]
  wire  _GEN_62 = isSret ? mie_mtie : _GEN_49; // @[CSR.scala 206:23 CSR.scala 134:20]
  wire  _GEN_63 = isSret ? mie_msie : _GEN_50; // @[CSR.scala 206:23 CSR.scala 134:20]
  wire [66:0] _GEN_64 = isSret ? {{3'd0}, mepc} : _GEN_51; // @[CSR.scala 206:23 CSR.scala 123:24]
  wire [63:0] _GEN_65 = isSret ? mcause : _GEN_52; // @[CSR.scala 206:23 CSR.scala 124:24]
  wire [63:0] _GEN_66 = isSret ? mtvec : _GEN_53; // @[CSR.scala 206:23 CSR.scala 122:24]
  wire [63:0] _GEN_67 = isSret ? _mcycle_T_1 : _GEN_54; // @[CSR.scala 206:23 CSR.scala 127:10]
  wire [63:0] _GEN_68 = isSret ? mscratch : _GEN_55; // @[CSR.scala 206:23 CSR.scala 120:25]
  wire  _GEN_70 = isMret | _GEN_57; // @[CSR.scala 203:23 CSR.scala 205:20]
  wire [66:0] _GEN_77 = isMret ? {{3'd0}, mepc} : _GEN_64; // @[CSR.scala 203:23 CSR.scala 123:24]
  wire [66:0] _GEN_82 = io_expt ? {{3'd0}, _mepc_T_1} : _GEN_77; // @[CSR.scala 190:19 CSR.scala 191:14]
  wire [66:0] _GEN_96 = ~io_stall & io_ctrl_signal_valid ? _GEN_82 : {{3'd0}, mepc}; // @[CSR.scala 189:42 CSR.scala 123:24]
  assign io_out = _io_out_T_26[63:0]; // @[CSR.scala 157:10]
  assign io_expt = (_io_expt_T_2 | isEcall | isEbreak | time_interrupt) & io_ctrl_signal_valid; // @[CSR.scala 185:83]
  assign io_exvec = mtvec; // @[CSR.scala 186:12]
  assign io_epc = mepc; // @[CSR.scala 187:11]
  assign time_interrupt_enable_0 = time_interrupt_enable;
  always @(posedge clock) begin
    if (reset) begin // @[CSR.scala 120:25]
      mscratch <= 64'h0; // @[CSR.scala 120:25]
    end else if (~io_stall & io_ctrl_signal_valid) begin // @[CSR.scala 189:42]
      if (!(io_expt)) begin // @[CSR.scala 190:19]
        if (!(isMret)) begin // @[CSR.scala 203:23]
          mscratch <= _GEN_68;
        end
      end
    end
    if (reset) begin // @[CSR.scala 122:24]
      mtvec <= 64'h90000000; // @[CSR.scala 122:24]
    end else if (~io_stall & io_ctrl_signal_valid) begin // @[CSR.scala 189:42]
      if (!(io_expt)) begin // @[CSR.scala 190:19]
        if (!(isMret)) begin // @[CSR.scala 203:23]
          mtvec <= _GEN_66;
        end
      end
    end
    if (reset) begin // @[CSR.scala 123:24]
      mepc <= 64'h0; // @[CSR.scala 123:24]
    end else begin
      mepc <= _GEN_96[63:0];
    end
    if (reset) begin // @[CSR.scala 124:24]
      mcause <= 64'h0; // @[CSR.scala 124:24]
    end else if (~io_stall & io_ctrl_signal_valid) begin // @[CSR.scala 189:42]
      if (io_expt) begin // @[CSR.scala 190:19]
        if (time_interrupt) begin // @[CSR.scala 192:20]
          mcause <= 64'h8000000000000007;
        end else begin
          mcause <= {{60'd0}, _mcause_T_8};
        end
      end else if (!(isMret)) begin // @[CSR.scala 203:23]
        mcause <= _GEN_65;
      end
    end
    if (reset) begin // @[CSR.scala 125:24]
      mcycle <= 64'h0; // @[CSR.scala 125:24]
    end else if (~io_stall & io_ctrl_signal_valid) begin // @[CSR.scala 189:42]
      if (io_expt) begin // @[CSR.scala 190:19]
        mcycle <= _mcycle_T_1; // @[CSR.scala 127:10]
      end else if (isMret) begin // @[CSR.scala 203:23]
        mcycle <= _mcycle_T_1; // @[CSR.scala 127:10]
      end else begin
        mcycle <= _GEN_67;
      end
    end else begin
      mcycle <= _mcycle_T_1; // @[CSR.scala 127:10]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_prv <= 2'h3; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_sd <= 1'h0; // @[CSR.scala 132:24]
    end else if (~io_stall & io_ctrl_signal_valid) begin // @[CSR.scala 189:42]
      if (!(io_expt)) begin // @[CSR.scala 190:19]
        if (!(isMret)) begin // @[CSR.scala 203:23]
          mstatus_sd <= _GEN_61;
        end
      end
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_ZERO0 <= 27'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_sxl <= 2'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_uxl <= 2'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_ZERO1 <= 9'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_tsr <= 1'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_tw <= 1'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_tvm <= 1'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_mxr <= 1'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_sum <= 1'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_mprv <= 1'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_xs <= 2'h0; // @[CSR.scala 132:24]
    end else if (~io_stall & io_ctrl_signal_valid) begin // @[CSR.scala 189:42]
      if (!(io_expt)) begin // @[CSR.scala 190:19]
        if (!(isMret)) begin // @[CSR.scala 203:23]
          mstatus_xs <= _GEN_58;
        end
      end
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_fs <= 2'h0; // @[CSR.scala 132:24]
    end else if (~io_stall & io_ctrl_signal_valid) begin // @[CSR.scala 189:42]
      if (!(io_expt)) begin // @[CSR.scala 190:19]
        if (!(isMret)) begin // @[CSR.scala 203:23]
          mstatus_fs <= _GEN_59;
        end
      end
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_mpp <= 2'h3; // @[CSR.scala 132:24]
    end else if (~io_stall & io_ctrl_signal_valid) begin // @[CSR.scala 189:42]
      if (!(io_expt)) begin // @[CSR.scala 190:19]
        if (!(isMret)) begin // @[CSR.scala 203:23]
          mstatus_mpp <= _GEN_60;
        end
      end
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_ZERO2 <= 2'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_spp <= 1'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_mpie <= 1'h0; // @[CSR.scala 132:24]
    end else if (~io_stall & io_ctrl_signal_valid) begin // @[CSR.scala 189:42]
      if (io_expt) begin // @[CSR.scala 190:19]
        mstatus_mpie <= mstatus_mie; // @[CSR.scala 199:20]
      end else begin
        mstatus_mpie <= _GEN_70;
      end
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_ZERO3 <= 1'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_spie <= 1'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_upie <= 1'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_mie <= 1'h0; // @[CSR.scala 132:24]
    end else if (~io_stall & io_ctrl_signal_valid) begin // @[CSR.scala 189:42]
      if (io_expt) begin // @[CSR.scala 190:19]
        mstatus_mie <= 1'h0; // @[CSR.scala 200:19]
      end else if (isMret) begin // @[CSR.scala 203:23]
        mstatus_mie <= mstatus_mpie; // @[CSR.scala 204:19]
      end else begin
        mstatus_mie <= _GEN_56;
      end
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_ZERO4 <= 1'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_sie <= 1'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 132:24]
      mstatus_uie <= 1'h0; // @[CSR.scala 132:24]
    end
    if (reset) begin // @[CSR.scala 134:20]
      mie_ZERO0 <= 52'h0; // @[CSR.scala 134:20]
    end
    if (reset) begin // @[CSR.scala 134:20]
      mie_meie <= 1'h0; // @[CSR.scala 134:20]
    end
    if (reset) begin // @[CSR.scala 134:20]
      mie_ZERO1 <= 1'h0; // @[CSR.scala 134:20]
    end
    if (reset) begin // @[CSR.scala 134:20]
      mie_seie <= 1'h0; // @[CSR.scala 134:20]
    end
    if (reset) begin // @[CSR.scala 134:20]
      mie_ueie <= 1'h0; // @[CSR.scala 134:20]
    end
    if (reset) begin // @[CSR.scala 134:20]
      mie_mtie <= 1'h0; // @[CSR.scala 134:20]
    end else if (~io_stall & io_ctrl_signal_valid) begin // @[CSR.scala 189:42]
      if (!(io_expt)) begin // @[CSR.scala 190:19]
        if (!(isMret)) begin // @[CSR.scala 203:23]
          mie_mtie <= _GEN_62;
        end
      end
    end
    if (reset) begin // @[CSR.scala 134:20]
      mie_ZERO2 <= 1'h0; // @[CSR.scala 134:20]
    end
    if (reset) begin // @[CSR.scala 134:20]
      mie_stie <= 1'h0; // @[CSR.scala 134:20]
    end
    if (reset) begin // @[CSR.scala 134:20]
      mie_utie <= 1'h0; // @[CSR.scala 134:20]
    end
    if (reset) begin // @[CSR.scala 134:20]
      mie_msie <= 1'h0; // @[CSR.scala 134:20]
    end else if (~io_stall & io_ctrl_signal_valid) begin // @[CSR.scala 189:42]
      if (!(io_expt)) begin // @[CSR.scala 190:19]
        if (!(isMret)) begin // @[CSR.scala 203:23]
          mie_msie <= _GEN_63;
        end
      end
    end
    if (reset) begin // @[CSR.scala 134:20]
      mie_ZERO3 <= 1'h0; // @[CSR.scala 134:20]
    end
    if (reset) begin // @[CSR.scala 134:20]
      mie_ssie <= 1'h0; // @[CSR.scala 134:20]
    end
    if (reset) begin // @[CSR.scala 134:20]
      mie_usie <= 1'h0; // @[CSR.scala 134:20]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  mscratch = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  mtvec = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  mepc = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  mcause = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  mcycle = _RAND_4[63:0];
  _RAND_5 = {1{`RANDOM}};
  mstatus_prv = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  mstatus_sd = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  mstatus_ZERO0 = _RAND_7[26:0];
  _RAND_8 = {1{`RANDOM}};
  mstatus_sxl = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  mstatus_uxl = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  mstatus_ZERO1 = _RAND_10[8:0];
  _RAND_11 = {1{`RANDOM}};
  mstatus_tsr = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  mstatus_tw = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  mstatus_tvm = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  mstatus_mxr = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  mstatus_sum = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  mstatus_mprv = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  mstatus_xs = _RAND_17[1:0];
  _RAND_18 = {1{`RANDOM}};
  mstatus_fs = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  mstatus_mpp = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  mstatus_ZERO2 = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  mstatus_spp = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  mstatus_mpie = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  mstatus_ZERO3 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  mstatus_spie = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  mstatus_upie = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  mstatus_mie = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  mstatus_ZERO4 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  mstatus_sie = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  mstatus_uie = _RAND_29[0:0];
  _RAND_30 = {2{`RANDOM}};
  mie_ZERO0 = _RAND_30[51:0];
  _RAND_31 = {1{`RANDOM}};
  mie_meie = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  mie_ZERO1 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  mie_seie = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  mie_ueie = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  mie_mtie = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  mie_ZERO2 = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  mie_stie = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  mie_utie = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  mie_msie = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  mie_ZERO3 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  mie_ssie = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  mie_usie = _RAND_42[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_210013_DataPath(
  input         clock,
  input         reset,
  input         io_icacahe_req_ready,
  output        io_icacahe_req_valid,
  output [63:0] io_icacahe_req_bits_addr,
  output [63:0] io_icacahe_req_bits_data,
  output [7:0]  io_icacahe_req_bits_mask,
  output        io_icacahe_req_bits_op,
  input         io_icacahe_resp_valid,
  input  [63:0] io_icacahe_resp_bits_data,
  input  [3:0]  io_icacahe_resp_bits_cmd,
  input         io_dcache_req_ready,
  output        io_dcache_req_valid,
  output [63:0] io_dcache_req_bits_addr,
  output [63:0] io_dcache_req_bits_data,
  output [7:0]  io_dcache_req_bits_mask,
  output        io_dcache_req_bits_op,
  input         io_dcache_resp_valid,
  input  [63:0] io_dcache_resp_bits_data,
  input  [3:0]  io_dcache_resp_bits_cmd,
  output [31:0] io_control_inst,
  input  [1:0]  io_control_signal_pc_sel,
  input         io_control_signal_a_sel,
  input         io_control_signal_b_sel,
  input  [2:0]  io_control_signal_imm_sel,
  input  [4:0]  io_control_signal_alu_op,
  input  [2:0]  io_control_signal_br_type,
  input         io_control_signal_kill,
  input  [2:0]  io_control_signal_st_type,
  input  [2:0]  io_control_signal_ld_type,
  input  [1:0]  io_control_signal_wb_type,
  input         io_control_signal_wen,
  input  [2:0]  io_control_signal_csr_cmd,
  input         io_control_signal_illegal,
  input         io_time_interrupt,
  output        io_fence_i_do,
  input         io_fence_i_done
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [63:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [63:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [63:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [63:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [63:0] _RAND_33;
  reg [63:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [63:0] _RAND_37;
  reg [63:0] _RAND_38;
`endif // RANDOMIZE_REG_INIT
  wire  ifet_clock; // @[DataPath.scala 86:20]
  wire  ifet_reset; // @[DataPath.scala 86:20]
  wire  ifet_io_out_valid; // @[DataPath.scala 86:20]
  wire [63:0] ifet_io_out_bits_pc; // @[DataPath.scala 86:20]
  wire [31:0] ifet_io_out_bits_inst; // @[DataPath.scala 86:20]
  wire  ifet_io_out_bits_pTaken; // @[DataPath.scala 86:20]
  wire [63:0] ifet_io_out_bits_pPC; // @[DataPath.scala 86:20]
  wire [63:0] ifet_io_pc_alu; // @[DataPath.scala 86:20]
  wire [63:0] ifet_io_pc_epc; // @[DataPath.scala 86:20]
  wire [1:0] ifet_io_pc_sel; // @[DataPath.scala 86:20]
  wire  ifet_io_br_info_valid; // @[DataPath.scala 86:20]
  wire  ifet_io_br_info_bits_isHit; // @[DataPath.scala 86:20]
  wire  ifet_io_br_info_bits_isTaken; // @[DataPath.scala 86:20]
  wire [63:0] ifet_io_br_info_bits_cur_pc; // @[DataPath.scala 86:20]
  wire  ifet_io_pc_except_entry_valid; // @[DataPath.scala 86:20]
  wire [63:0] ifet_io_pc_except_entry_bits; // @[DataPath.scala 86:20]
  wire  ifet_io_stall; // @[DataPath.scala 86:20]
  wire  ifet_io_kill; // @[DataPath.scala 86:20]
  wire  ifet_io_icache_req_ready; // @[DataPath.scala 86:20]
  wire  ifet_io_icache_req_valid; // @[DataPath.scala 86:20]
  wire [63:0] ifet_io_icache_req_bits_addr; // @[DataPath.scala 86:20]
  wire [63:0] ifet_io_icache_req_bits_data; // @[DataPath.scala 86:20]
  wire [7:0] ifet_io_icache_req_bits_mask; // @[DataPath.scala 86:20]
  wire  ifet_io_icache_req_bits_op; // @[DataPath.scala 86:20]
  wire  ifet_io_icache_resp_valid; // @[DataPath.scala 86:20]
  wire [63:0] ifet_io_icache_resp_bits_data; // @[DataPath.scala 86:20]
  wire [3:0] ifet_io_icache_resp_bits_cmd; // @[DataPath.scala 86:20]
  wire  ifet_io_fence_i_done; // @[DataPath.scala 86:20]
  wire [31:0] ifet_io_fence_pc; // @[DataPath.scala 86:20]
  wire  ifet_io_fence_i_do; // @[DataPath.scala 86:20]
  wire [31:0] id_io_inst; // @[DataPath.scala 87:18]
  wire [4:0] id_io_rd_addr; // @[DataPath.scala 87:18]
  wire [4:0] id_io_rs1_addr; // @[DataPath.scala 87:18]
  wire [4:0] id_io_rs2_addr; // @[DataPath.scala 87:18]
  wire [2:0] id_io_imm_sel; // @[DataPath.scala 87:18]
  wire [63:0] id_io_imm; // @[DataPath.scala 87:18]
  wire [63:0] ex_io_rs1; // @[DataPath.scala 88:18]
  wire [63:0] ex_io_rs2; // @[DataPath.scala 88:18]
  wire [4:0] ex_io_alu_op; // @[DataPath.scala 88:18]
  wire [63:0] ex_io_out; // @[DataPath.scala 88:18]
  wire  mem_clock; // @[DataPath.scala 89:19]
  wire  mem_reset; // @[DataPath.scala 89:19]
  wire  mem_io_dcache_req_ready; // @[DataPath.scala 89:19]
  wire  mem_io_dcache_req_valid; // @[DataPath.scala 89:19]
  wire [63:0] mem_io_dcache_req_bits_addr; // @[DataPath.scala 89:19]
  wire [63:0] mem_io_dcache_req_bits_data; // @[DataPath.scala 89:19]
  wire [7:0] mem_io_dcache_req_bits_mask; // @[DataPath.scala 89:19]
  wire  mem_io_dcache_req_bits_op; // @[DataPath.scala 89:19]
  wire  mem_io_dcache_resp_valid; // @[DataPath.scala 89:19]
  wire [63:0] mem_io_dcache_resp_bits_data; // @[DataPath.scala 89:19]
  wire [3:0] mem_io_dcache_resp_bits_cmd; // @[DataPath.scala 89:19]
  wire [2:0] mem_io_ld_type; // @[DataPath.scala 89:19]
  wire [2:0] mem_io_st_type; // @[DataPath.scala 89:19]
  wire [63:0] mem_io_s_data; // @[DataPath.scala 89:19]
  wire [63:0] mem_io_alu_res; // @[DataPath.scala 89:19]
  wire [63:0] mem_io_l_data_bits; // @[DataPath.scala 89:19]
  wire  mem_io_s_complete; // @[DataPath.scala 89:19]
  wire  mem_io_stall; // @[DataPath.scala 89:19]
  wire  mem_io_inst_valid; // @[DataPath.scala 89:19]
  wire [63:0] br_io_rs1; // @[DataPath.scala 91:18]
  wire [63:0] br_io_rs2; // @[DataPath.scala 91:18]
  wire [2:0] br_io_br_type; // @[DataPath.scala 91:18]
  wire  br_io_taken; // @[DataPath.scala 91:18]
  wire  regs_clock; // @[DataPath.scala 93:20]
  wire  regs_reset; // @[DataPath.scala 93:20]
  wire [4:0] regs_io_raddr1; // @[DataPath.scala 93:20]
  wire [4:0] regs_io_raddr2; // @[DataPath.scala 93:20]
  wire [63:0] regs_io_rdata1; // @[DataPath.scala 93:20]
  wire [63:0] regs_io_rdata2; // @[DataPath.scala 93:20]
  wire  regs_io_wen; // @[DataPath.scala 93:20]
  wire [4:0] regs_io_waddr; // @[DataPath.scala 93:20]
  wire [63:0] regs_io_wdata; // @[DataPath.scala 93:20]
  wire [4:0] bypass_io_ex_rs1; // @[DataPath.scala 97:22]
  wire [4:0] bypass_io_ex_rs2; // @[DataPath.scala 97:22]
  wire [4:0] bypass_io_mem_rd; // @[DataPath.scala 97:22]
  wire  bypass_io_mem_valid; // @[DataPath.scala 97:22]
  wire [4:0] bypass_io_wb_rd; // @[DataPath.scala 97:22]
  wire  bypass_io_wb_valid; // @[DataPath.scala 97:22]
  wire [1:0] bypass_io_forwardA; // @[DataPath.scala 97:22]
  wire [1:0] bypass_io_forwardB; // @[DataPath.scala 97:22]
  wire  loadrisk_io_id_valid; // @[DataPath.scala 98:24]
  wire [4:0] loadrisk_io_id_rs1; // @[DataPath.scala 98:24]
  wire [4:0] loadrisk_io_id_rs2; // @[DataPath.scala 98:24]
  wire  loadrisk_io_ex_valid; // @[DataPath.scala 98:24]
  wire  loadrisk_io_ex_isLoad; // @[DataPath.scala 98:24]
  wire [4:0] loadrisk_io_ex_rd; // @[DataPath.scala 98:24]
  wire  loadrisk_io_stall; // @[DataPath.scala 98:24]
  wire  csr_clock; // @[DataPath.scala 100:19]
  wire  csr_reset; // @[DataPath.scala 100:19]
  wire  csr_io_stall; // @[DataPath.scala 100:19]
  wire [2:0] csr_io_cmd; // @[DataPath.scala 100:19]
  wire [63:0] csr_io_in; // @[DataPath.scala 100:19]
  wire [63:0] csr_io_out; // @[DataPath.scala 100:19]
  wire  csr_io_ctrl_signal_valid; // @[DataPath.scala 100:19]
  wire [63:0] csr_io_ctrl_signal_pc; // @[DataPath.scala 100:19]
  wire [63:0] csr_io_ctrl_signal_addr; // @[DataPath.scala 100:19]
  wire [63:0] csr_io_ctrl_signal_inst; // @[DataPath.scala 100:19]
  wire  csr_io_ctrl_signal_illegal; // @[DataPath.scala 100:19]
  wire [2:0] csr_io_ctrl_signal_st_type; // @[DataPath.scala 100:19]
  wire [2:0] csr_io_ctrl_signal_ld_type; // @[DataPath.scala 100:19]
  wire  csr_io_pc_check; // @[DataPath.scala 100:19]
  wire  csr_io_expt; // @[DataPath.scala 100:19]
  wire [63:0] csr_io_exvec; // @[DataPath.scala 100:19]
  wire [63:0] csr_io_epc; // @[DataPath.scala 100:19]
  wire  csr_io_interrupt_time; // @[DataPath.scala 100:19]
  wire  csr_time_interrupt_enable_0; // @[DataPath.scala 100:19]
  wire  stall = ~io_icacahe_resp_valid | ~io_dcache_resp_valid | ~io_dcache_req_ready; // @[DataPath.scala 104:63]
  wire  _if_pc_T = ~stall; // @[DataPath.scala 136:80]
  wire  _if_pc_T_2 = ~stall & ~loadrisk_io_stall; // @[DataPath.scala 136:87]
  reg [63:0] if_pc; // @[Reg.scala 27:20]
  reg  if_pTaken; // @[Reg.scala 27:20]
  reg [63:0] if_pPC; // @[Reg.scala 27:20]
  reg [31:0] if_inst; // @[Reg.scala 27:20]
  reg [28:0] ex_ctrl; // @[Reg.scala 27:20]
  reg  ex_valid; // @[Reg.scala 27:20]
  wire  br_infoValid_from_mem = ex_valid & |ex_ctrl[16:14]; // @[DataPath.scala 234:37]
  reg  ex_taken; // @[Reg.scala 27:20]
  reg  ex_pTaken; // @[Reg.scala 27:20]
  reg [63:0] ex_alu_out; // @[Reg.scala 27:20]
  reg [63:0] ex_pPC; // @[Reg.scala 27:20]
  reg [63:0] ex_pc; // @[Reg.scala 27:20]
  wire [63:0] _br_isHit_from_mem_T_6 = ex_pc + 64'h4; // @[DataPath.scala 232:138]
  wire  br_isHit_from_mem = (ex_taken == ex_pTaken & ex_alu_out == ex_pPC & ex_taken | ex_taken == ex_pTaken & ex_pPC
     == _br_isHit_from_mem_T_6 & ~ex_taken) & ex_valid; // @[DataPath.scala 232:160]
  wire  csr_except = csr_io_expt & ex_valid; // @[DataPath.scala 295:31]
  reg [31:0] ex_inst; // @[Reg.scala 27:20]
  reg  mem_fence_i_REG; // @[DataPath.scala 237:76]
  wire  mem_fence_i = ex_valid & 32'h100f == ex_inst & _if_pc_T & ~mem_fence_i_REG; // @[DataPath.scala 237:66]
  wire  mem_kill = (ex_ctrl[13] | br_infoValid_from_mem & ~br_isHit_from_mem | csr_except | mem_fence_i) & ex_valid; // @[DataPath.scala 297:131]
  reg  if_valid; // @[Reg.scala 27:20]
  wire  _loadrisk_io_id_valid_T = ~mem_kill; // @[DataPath.scala 151:38]
  reg [4:0] id_rs1; // @[Reg.scala 27:20]
  reg [4:0] id_rs2; // @[Reg.scala 27:20]
  reg [63:0] id_rdata1; // @[Reg.scala 27:20]
  reg [63:0] id_rdata2; // @[Reg.scala 27:20]
  reg [63:0] id_A; // @[Reg.scala 27:20]
  reg [63:0] id_B; // @[Reg.scala 27:20]
  reg [4:0] id_rd; // @[Reg.scala 27:20]
  wire [12:0] id_ctrl_lo = {io_control_signal_st_type,io_control_signal_ld_type,io_control_signal_wb_type,
    io_control_signal_wen,io_control_signal_csr_cmd,io_control_signal_illegal}; // @[DataPath.scala 162:39]
  wire [28:0] _id_ctrl_T = {io_control_signal_pc_sel,io_control_signal_a_sel,io_control_signal_b_sel,
    io_control_signal_imm_sel,io_control_signal_alu_op,io_control_signal_br_type,io_control_signal_kill,id_ctrl_lo}; // @[DataPath.scala 162:39]
  reg [28:0] id_ctrl; // @[Reg.scala 27:20]
  reg [31:0] id_inst; // @[Reg.scala 27:20]
  reg [63:0] id_pc; // @[Reg.scala 27:20]
  reg  id_pTaken; // @[Reg.scala 27:20]
  reg [63:0] id_pPC; // @[Reg.scala 27:20]
  reg  id_valid; // @[Reg.scala 27:20]
  wire  time_interrupt_enable_0 = csr_time_interrupt_enable_0;
  wire  _id_interrupt_T = io_time_interrupt & time_interrupt_enable_0; // @[DataPath.scala 168:50]
  reg  id_interrupt; // @[Reg.scala 27:20]
  reg [63:0] ex_pc4; // @[Reg.scala 27:20]
  wire [63:0] _bypass_ex_alu_out_T_14 = ex_alu_out; // @[Mux.scala 80:57]
  wire [63:0] bypass_ex_alu_out = 2'h2 == ex_ctrl[6:5] ? ex_pc4 : ex_alu_out; // @[Mux.scala 80:57]
  wire [63:0] _ex_io_rs1_T_17 = 2'h1 == bypass_io_forwardA ? bypass_ex_alu_out : id_A; // @[Mux.scala 80:57]
  wire [63:0] bypass_mem_l_data = regs_io_wdata; // @[DataPath.scala 184:31 DataPath.scala 306:21]
  wire [63:0] _ex_io_rs1_T_19 = 2'h3 == bypass_io_forwardA ? bypass_mem_l_data : _ex_io_rs1_T_17; // @[Mux.scala 80:57]
  wire [63:0] _ex_io_rs2_T_17 = 2'h1 == bypass_io_forwardB ? bypass_ex_alu_out : id_B; // @[Mux.scala 80:57]
  wire [63:0] _ex_io_rs2_T_19 = 2'h3 == bypass_io_forwardB ? bypass_mem_l_data : _ex_io_rs2_T_17; // @[Mux.scala 80:57]
  wire [63:0] _br_io_rs1_T_3 = 2'h1 == bypass_io_forwardA ? bypass_ex_alu_out : id_rdata1; // @[Mux.scala 80:57]
  wire [63:0] _br_io_rs2_T_3 = 2'h1 == bypass_io_forwardB ? bypass_ex_alu_out : id_rdata2; // @[Mux.scala 80:57]
  reg [4:0] ex_rd; // @[Reg.scala 27:20]
  wire [63:0] _ex_pc4_T_1 = id_pc + 64'h4; // @[DataPath.scala 217:36]
  reg  ex_interrupt; // @[Reg.scala 27:20]
  reg  mem_valid_true; // @[Reg.scala 27:20]
  reg  mem_csr_except; // @[Reg.scala 27:20]
  wire  mem_wb_interrupt = ex_interrupt & ex_valid | csr_io_expt | mem_valid_true & mem_csr_except; // @[DataPath.scala 308:65]
  reg [63:0] mem_alu_out; // @[Reg.scala 27:20]
  reg [63:0] mem_l_data_bits; // @[Reg.scala 27:20]
  reg [4:0] mem_rd; // @[Reg.scala 27:20]
  reg [28:0] mem_ctrl; // @[Reg.scala 27:20]
  reg [63:0] mem_pc4; // @[Reg.scala 27:20]
  reg [63:0] mem_csr; // @[Reg.scala 27:20]
  wire  mem_valid = mem_valid_true & ~mem_csr_except; // @[DataPath.scala 290:34]
  wire [63:0] _regs_io_wdata_T_14 = 2'h1 == mem_ctrl[6:5] ? mem_l_data_bits : mem_alu_out; // @[Mux.scala 80:57]
  wire [63:0] _regs_io_wdata_T_16 = 2'h2 == mem_ctrl[6:5] ? mem_pc4 : _regs_io_wdata_T_14; // @[Mux.scala 80:57]
  wire [1:0] mem2if_pc_sel = ex_valid ? ex_ctrl[28:27] : 2'h0; // @[DataPath.scala 298:23]
  wire [63:0] mem2if_pc_alu = ex_alu_out; // @[DataPath.scala 107:27 DataPath.scala 299:17]
  wire [31:0] br_curPC_from_mem = ex_pc[31:0]; // @[DataPath.scala 124:31 DataPath.scala 233:21]
  wire  commit_valid = mem_valid & _if_pc_T; // @[DataPath.scala 320:53]
  ysyx_210013_IF ifet ( // @[DataPath.scala 86:20]
    .clock(ifet_clock),
    .reset(ifet_reset),
    .io_out_valid(ifet_io_out_valid),
    .io_out_bits_pc(ifet_io_out_bits_pc),
    .io_out_bits_inst(ifet_io_out_bits_inst),
    .io_out_bits_pTaken(ifet_io_out_bits_pTaken),
    .io_out_bits_pPC(ifet_io_out_bits_pPC),
    .io_pc_alu(ifet_io_pc_alu),
    .io_pc_epc(ifet_io_pc_epc),
    .io_pc_sel(ifet_io_pc_sel),
    .io_br_info_valid(ifet_io_br_info_valid),
    .io_br_info_bits_isHit(ifet_io_br_info_bits_isHit),
    .io_br_info_bits_isTaken(ifet_io_br_info_bits_isTaken),
    .io_br_info_bits_cur_pc(ifet_io_br_info_bits_cur_pc),
    .io_pc_except_entry_valid(ifet_io_pc_except_entry_valid),
    .io_pc_except_entry_bits(ifet_io_pc_except_entry_bits),
    .io_stall(ifet_io_stall),
    .io_kill(ifet_io_kill),
    .io_icache_req_ready(ifet_io_icache_req_ready),
    .io_icache_req_valid(ifet_io_icache_req_valid),
    .io_icache_req_bits_addr(ifet_io_icache_req_bits_addr),
    .io_icache_req_bits_data(ifet_io_icache_req_bits_data),
    .io_icache_req_bits_mask(ifet_io_icache_req_bits_mask),
    .io_icache_req_bits_op(ifet_io_icache_req_bits_op),
    .io_icache_resp_valid(ifet_io_icache_resp_valid),
    .io_icache_resp_bits_data(ifet_io_icache_resp_bits_data),
    .io_icache_resp_bits_cmd(ifet_io_icache_resp_bits_cmd),
    .io_fence_i_done(ifet_io_fence_i_done),
    .io_fence_pc(ifet_io_fence_pc),
    .io_fence_i_do(ifet_io_fence_i_do)
  );
  ysyx_210013_ID id ( // @[DataPath.scala 87:18]
    .io_inst(id_io_inst),
    .io_rd_addr(id_io_rd_addr),
    .io_rs1_addr(id_io_rs1_addr),
    .io_rs2_addr(id_io_rs2_addr),
    .io_imm_sel(id_io_imm_sel),
    .io_imm(id_io_imm)
  );
  ysyx_210013_EX ex ( // @[DataPath.scala 88:18]
    .io_rs1(ex_io_rs1),
    .io_rs2(ex_io_rs2),
    .io_alu_op(ex_io_alu_op),
    .io_out(ex_io_out)
  );
  ysyx_210013_MEM mem ( // @[DataPath.scala 89:19]
    .clock(mem_clock),
    .reset(mem_reset),
    .io_dcache_req_ready(mem_io_dcache_req_ready),
    .io_dcache_req_valid(mem_io_dcache_req_valid),
    .io_dcache_req_bits_addr(mem_io_dcache_req_bits_addr),
    .io_dcache_req_bits_data(mem_io_dcache_req_bits_data),
    .io_dcache_req_bits_mask(mem_io_dcache_req_bits_mask),
    .io_dcache_req_bits_op(mem_io_dcache_req_bits_op),
    .io_dcache_resp_valid(mem_io_dcache_resp_valid),
    .io_dcache_resp_bits_data(mem_io_dcache_resp_bits_data),
    .io_dcache_resp_bits_cmd(mem_io_dcache_resp_bits_cmd),
    .io_ld_type(mem_io_ld_type),
    .io_st_type(mem_io_st_type),
    .io_s_data(mem_io_s_data),
    .io_alu_res(mem_io_alu_res),
    .io_l_data_bits(mem_io_l_data_bits),
    .io_s_complete(mem_io_s_complete),
    .io_stall(mem_io_stall),
    .io_inst_valid(mem_io_inst_valid)
  );
  ysyx_210013_Branch br ( // @[DataPath.scala 91:18]
    .io_rs1(br_io_rs1),
    .io_rs2(br_io_rs2),
    .io_br_type(br_io_br_type),
    .io_taken(br_io_taken)
  );
  ysyx_210013_RegisterFile regs ( // @[DataPath.scala 93:20]
    .clock(regs_clock),
    .reset(regs_reset),
    .io_raddr1(regs_io_raddr1),
    .io_raddr2(regs_io_raddr2),
    .io_rdata1(regs_io_rdata1),
    .io_rdata2(regs_io_rdata2),
    .io_wen(regs_io_wen),
    .io_waddr(regs_io_waddr),
    .io_wdata(regs_io_wdata)
  );
  ysyx_210013_ByPass bypass ( // @[DataPath.scala 97:22]
    .io_ex_rs1(bypass_io_ex_rs1),
    .io_ex_rs2(bypass_io_ex_rs2),
    .io_mem_rd(bypass_io_mem_rd),
    .io_mem_valid(bypass_io_mem_valid),
    .io_wb_rd(bypass_io_wb_rd),
    .io_wb_valid(bypass_io_wb_valid),
    .io_forwardA(bypass_io_forwardA),
    .io_forwardB(bypass_io_forwardB)
  );
  ysyx_210013_LoadRisk loadrisk ( // @[DataPath.scala 98:24]
    .io_id_valid(loadrisk_io_id_valid),
    .io_id_rs1(loadrisk_io_id_rs1),
    .io_id_rs2(loadrisk_io_id_rs2),
    .io_ex_valid(loadrisk_io_ex_valid),
    .io_ex_isLoad(loadrisk_io_ex_isLoad),
    .io_ex_rd(loadrisk_io_ex_rd),
    .io_stall(loadrisk_io_stall)
  );
  ysyx_210013_CSR csr ( // @[DataPath.scala 100:19]
    .clock(csr_clock),
    .reset(csr_reset),
    .io_stall(csr_io_stall),
    .io_cmd(csr_io_cmd),
    .io_in(csr_io_in),
    .io_out(csr_io_out),
    .io_ctrl_signal_valid(csr_io_ctrl_signal_valid),
    .io_ctrl_signal_pc(csr_io_ctrl_signal_pc),
    .io_ctrl_signal_addr(csr_io_ctrl_signal_addr),
    .io_ctrl_signal_inst(csr_io_ctrl_signal_inst),
    .io_ctrl_signal_illegal(csr_io_ctrl_signal_illegal),
    .io_ctrl_signal_st_type(csr_io_ctrl_signal_st_type),
    .io_ctrl_signal_ld_type(csr_io_ctrl_signal_ld_type),
    .io_pc_check(csr_io_pc_check),
    .io_expt(csr_io_expt),
    .io_exvec(csr_io_exvec),
    .io_epc(csr_io_epc),
    .io_interrupt_time(csr_io_interrupt_time),
    .time_interrupt_enable_0(csr_time_interrupt_enable_0)
  );
  assign io_icacahe_req_valid = ifet_io_icache_req_valid; // @[DataPath.scala 117:18]
  assign io_icacahe_req_bits_addr = ifet_io_icache_req_bits_addr; // @[DataPath.scala 117:18]
  assign io_icacahe_req_bits_data = ifet_io_icache_req_bits_data; // @[DataPath.scala 117:18]
  assign io_icacahe_req_bits_mask = ifet_io_icache_req_bits_mask; // @[DataPath.scala 117:18]
  assign io_icacahe_req_bits_op = ifet_io_icache_req_bits_op; // @[DataPath.scala 117:18]
  assign io_dcache_req_valid = mem_io_dcache_req_valid; // @[DataPath.scala 244:17]
  assign io_dcache_req_bits_addr = mem_io_dcache_req_bits_addr; // @[DataPath.scala 244:17]
  assign io_dcache_req_bits_data = mem_io_dcache_req_bits_data; // @[DataPath.scala 244:17]
  assign io_dcache_req_bits_mask = mem_io_dcache_req_bits_mask; // @[DataPath.scala 244:17]
  assign io_dcache_req_bits_op = mem_io_dcache_req_bits_op; // @[DataPath.scala 244:17]
  assign io_control_inst = if_inst; // @[DataPath.scala 143:19]
  assign io_fence_i_do = ex_valid & 32'h100f == ex_inst & _if_pc_T & ~mem_fence_i_REG; // @[DataPath.scala 237:66]
  assign ifet_clock = clock;
  assign ifet_reset = reset;
  assign ifet_io_pc_alu = _bypass_ex_alu_out_T_14; // @[DataPath.scala 119:18]
  assign ifet_io_pc_epc = csr_io_epc; // @[DataPath.scala 120:18]
  assign ifet_io_pc_sel = mem2if_pc_sel; // @[DataPath.scala 118:18]
  assign ifet_io_br_info_valid = ex_valid & |ex_ctrl[16:14]; // @[DataPath.scala 234:37]
  assign ifet_io_br_info_bits_isHit = (ex_taken == ex_pTaken & ex_alu_out == ex_pPC & ex_taken | ex_taken == ex_pTaken
     & ex_pPC == _br_isHit_from_mem_T_6 & ~ex_taken) & ex_valid; // @[DataPath.scala 232:160]
  assign ifet_io_br_info_bits_isTaken = ex_taken & ex_valid; // @[DataPath.scala 231:33]
  assign ifet_io_br_info_bits_cur_pc = {{32'd0}, br_curPC_from_mem}; // @[DataPath.scala 124:31 DataPath.scala 233:21]
  assign ifet_io_pc_except_entry_valid = csr_io_expt & ex_valid; // @[DataPath.scala 295:31]
  assign ifet_io_pc_except_entry_bits = csr_io_exvec; // @[DataPath.scala 133:32]
  assign ifet_io_stall = stall | loadrisk_io_stall; // @[DataPath.scala 121:26]
  assign ifet_io_kill = (ex_ctrl[13] | br_infoValid_from_mem & ~br_isHit_from_mem | csr_except | mem_fence_i) & ex_valid
    ; // @[DataPath.scala 297:131]
  assign ifet_io_icache_req_ready = io_icacahe_req_ready; // @[DataPath.scala 117:18]
  assign ifet_io_icache_resp_valid = io_icacahe_resp_valid; // @[DataPath.scala 117:18]
  assign ifet_io_icache_resp_bits_data = io_icacahe_resp_bits_data; // @[DataPath.scala 117:18]
  assign ifet_io_icache_resp_bits_cmd = io_icacahe_resp_bits_cmd; // @[DataPath.scala 117:18]
  assign ifet_io_fence_i_done = io_fence_i_done; // @[DataPath.scala 134:24]
  assign ifet_io_fence_pc = ex_pc[31:0]; // @[DataPath.scala 238:20]
  assign ifet_io_fence_i_do = ex_valid & 32'h100f == ex_inst & _if_pc_T & ~mem_fence_i_REG; // @[DataPath.scala 237:66]
  assign id_io_inst = if_inst; // @[DataPath.scala 145:14]
  assign id_io_imm_sel = io_control_signal_imm_sel; // @[DataPath.scala 146:17]
  assign ex_io_rs1 = ~id_ctrl[26] ? id_A : _ex_io_rs1_T_19; // @[DataPath.scala 185:19]
  assign ex_io_rs2 = ~id_ctrl[25] ? id_B : _ex_io_rs2_T_19; // @[DataPath.scala 190:19]
  assign ex_io_alu_op = id_ctrl[21:17]; // @[DataPath.scala 181:35]
  assign mem_clock = clock;
  assign mem_reset = reset;
  assign mem_io_dcache_req_ready = io_dcache_req_ready; // @[DataPath.scala 244:17]
  assign mem_io_dcache_resp_valid = io_dcache_resp_valid; // @[DataPath.scala 244:17]
  assign mem_io_dcache_resp_bits_data = io_dcache_resp_bits_data; // @[DataPath.scala 244:17]
  assign mem_io_dcache_resp_bits_cmd = io_dcache_resp_bits_cmd; // @[DataPath.scala 244:17]
  assign mem_io_ld_type = id_ctrl[9:7]; // @[DataPath.scala 246:40]
  assign mem_io_st_type = mem_wb_interrupt ? 3'h0 : id_ctrl[12:10]; // @[DataPath.scala 248:27]
  assign mem_io_s_data = br_io_rs2; // @[DataPath.scala 249:21]
  assign mem_io_alu_res = ex_io_out; // @[DataPath.scala 250:21]
  assign mem_io_stall = ~io_icacahe_resp_valid | ~io_dcache_resp_valid | ~io_dcache_req_ready; // @[DataPath.scala 104:63]
  assign mem_io_inst_valid = mem_kill | id_interrupt ? 1'h0 : id_valid; // @[DataPath.scala 251:27]
  assign br_io_rs1 = 2'h3 == bypass_io_forwardA ? bypass_mem_l_data : _br_io_rs1_T_3; // @[Mux.scala 80:57]
  assign br_io_rs2 = 2'h3 == bypass_io_forwardB ? bypass_mem_l_data : _br_io_rs2_T_3; // @[Mux.scala 80:57]
  assign br_io_br_type = id_valid ? id_ctrl[16:14] : 3'h0; // @[DataPath.scala 206:23]
  assign regs_clock = clock;
  assign regs_reset = reset;
  assign regs_io_raddr1 = id_io_rs1_addr; // @[DataPath.scala 148:18]
  assign regs_io_raddr2 = id_io_rs2_addr; // @[DataPath.scala 149:18]
  assign regs_io_wen = mem_ctrl[4] & _if_pc_T & mem_valid; // @[DataPath.scala 317:66]
  assign regs_io_waddr = mem_rd; // @[DataPath.scala 310:17]
  assign regs_io_wdata = 2'h3 == mem_ctrl[6:5] ? mem_csr : _regs_io_wdata_T_16; // @[Mux.scala 80:57]
  assign bypass_io_ex_rs1 = id_rs1; // @[DataPath.scala 173:22]
  assign bypass_io_ex_rs2 = id_rs2; // @[DataPath.scala 174:22]
  assign bypass_io_mem_rd = ex_rd; // @[DataPath.scala 241:20]
  assign bypass_io_mem_valid = ex_valid & ex_ctrl[4]; // @[DataPath.scala 242:35]
  assign bypass_io_wb_rd = mem_rd; // @[DataPath.scala 304:19]
  assign bypass_io_wb_valid = mem_valid & mem_ctrl[4]; // @[DataPath.scala 305:35]
  assign loadrisk_io_id_valid = if_valid & ~mem_kill; // @[DataPath.scala 151:36]
  assign loadrisk_io_id_rs1 = id_io_rs1_addr; // @[DataPath.scala 152:22]
  assign loadrisk_io_id_rs2 = id_io_rs2_addr; // @[DataPath.scala 153:22]
  assign loadrisk_io_ex_valid = id_valid & _loadrisk_io_id_valid_T; // @[DataPath.scala 177:36]
  assign loadrisk_io_ex_isLoad = |id_ctrl[9:7] | |id_ctrl[2:1]; // @[DataPath.scala 179:75]
  assign loadrisk_io_ex_rd = id_rd; // @[DataPath.scala 178:21]
  assign csr_clock = clock;
  assign csr_reset = reset;
  assign csr_io_stall = ~io_icacahe_resp_valid | ~io_dcache_resp_valid | ~io_dcache_req_ready; // @[DataPath.scala 104:63]
  assign csr_io_cmd = ex_ctrl[3:1]; // @[DataPath.scala 259:33]
  assign csr_io_in = ex_alu_out; // @[DataPath.scala 260:14]
  assign csr_io_ctrl_signal_valid = ex_valid; // @[DataPath.scala 271:30]
  assign csr_io_ctrl_signal_pc = ex_pc; // @[DataPath.scala 261:25]
  assign csr_io_ctrl_signal_addr = ex_alu_out; // @[DataPath.scala 262:27]
  assign csr_io_ctrl_signal_inst = {{32'd0}, ex_inst}; // @[DataPath.scala 263:27]
  assign csr_io_ctrl_signal_illegal = ex_ctrl[0]; // @[DataPath.scala 267:51]
  assign csr_io_ctrl_signal_st_type = ex_ctrl[12:10]; // @[DataPath.scala 269:49]
  assign csr_io_ctrl_signal_ld_type = ex_ctrl[9:7]; // @[DataPath.scala 270:49]
  assign csr_io_pc_check = ex_ctrl[28:27] == 2'h1 & ex_valid; // @[DataPath.scala 272:75]
  assign csr_io_interrupt_time = ex_interrupt & ex_valid; // @[DataPath.scala 274:45]
  always @(posedge clock) begin
    if (reset) begin // @[Reg.scala 27:20]
      if_pc <= 64'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T_2) begin // @[Reg.scala 28:19]
      if_pc <= ifet_io_out_bits_pc; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      if_pTaken <= 1'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T_2) begin // @[Reg.scala 28:19]
      if_pTaken <= ifet_io_out_bits_pTaken; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      if_pPC <= 64'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T_2) begin // @[Reg.scala 28:19]
      if_pPC <= ifet_io_out_bits_pPC; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      if_inst <= 32'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T_2) begin // @[Reg.scala 28:19]
      if_inst <= ifet_io_out_bits_inst; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      ex_ctrl <= 29'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      ex_ctrl <= id_ctrl; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      ex_valid <= 1'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      if (mem_kill) begin // @[DataPath.scala 220:33]
        ex_valid <= 1'h0;
      end else begin
        ex_valid <= id_valid;
      end
    end
    if (reset) begin // @[Reg.scala 27:20]
      ex_taken <= 1'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      ex_taken <= br_io_taken; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      ex_pTaken <= 1'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      ex_pTaken <= id_pTaken; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      ex_alu_out <= 64'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      ex_alu_out <= ex_io_out; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      ex_pPC <= 64'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      ex_pPC <= id_pPC; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      ex_pc <= 64'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      ex_pc <= id_pc; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      ex_inst <= 32'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      ex_inst <= id_inst; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[DataPath.scala 237:76]
      mem_fence_i_REG <= 1'h0; // @[DataPath.scala 237:76]
    end else begin
      mem_fence_i_REG <= ex_valid & 32'h100f == ex_inst & _if_pc_T; // @[DataPath.scala 237:76]
    end
    if (reset) begin // @[Reg.scala 27:20]
      if_valid <= 1'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T_2) begin // @[Reg.scala 28:19]
      if (mem_kill) begin // @[DataPath.scala 140:31]
        if_valid <= 1'h0;
      end else begin
        if_valid <= ifet_io_out_valid;
      end
    end
    if (reset) begin // @[Reg.scala 27:20]
      id_rs1 <= 5'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      id_rs1 <= id_io_rs1_addr; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      id_rs2 <= 5'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      id_rs2 <= id_io_rs2_addr; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      id_rdata1 <= 64'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      id_rdata1 <= regs_io_rdata1; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      id_rdata2 <= 64'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      id_rdata2 <= regs_io_rdata2; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      id_A <= 64'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      if (~io_control_signal_a_sel) begin // @[DataPath.scala 159:31]
        id_A <= if_pc;
      end else begin
        id_A <= regs_io_rdata1;
      end
    end
    if (reset) begin // @[Reg.scala 27:20]
      id_B <= 64'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      if (~io_control_signal_b_sel) begin // @[DataPath.scala 160:31]
        id_B <= id_io_imm;
      end else begin
        id_B <= regs_io_rdata2;
      end
    end
    if (reset) begin // @[Reg.scala 27:20]
      id_rd <= 5'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      id_rd <= id_io_rd_addr; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      id_ctrl <= 29'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      id_ctrl <= _id_ctrl_T; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      id_inst <= 32'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      id_inst <= if_inst; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      id_pc <= 64'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      id_pc <= if_pc; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      id_pTaken <= 1'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      id_pTaken <= if_pTaken; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      id_pPC <= 64'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      id_pPC <= if_pPC; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      id_valid <= 1'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      if (mem_kill | loadrisk_io_stall) begin // @[DataPath.scala 167:31]
        id_valid <= 1'h0;
      end else begin
        id_valid <= if_valid;
      end
    end
    if (reset) begin // @[Reg.scala 27:20]
      id_interrupt <= 1'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      id_interrupt <= _id_interrupt_T; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      ex_pc4 <= 64'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      ex_pc4 <= _ex_pc4_T_1; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      ex_rd <= 5'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      ex_rd <= id_rd; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      ex_interrupt <= 1'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      ex_interrupt <= id_interrupt; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      mem_valid_true <= 1'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      mem_valid_true <= ex_valid; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      mem_csr_except <= 1'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      mem_csr_except <= csr_except; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      mem_alu_out <= 64'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      mem_alu_out <= ex_alu_out; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      mem_l_data_bits <= 64'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      mem_l_data_bits <= mem_io_l_data_bits; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      mem_rd <= 5'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      mem_rd <= ex_rd; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      mem_ctrl <= 29'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      mem_ctrl <= ex_ctrl; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      mem_pc4 <= 64'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      mem_pc4 <= ex_pc4; // @[Reg.scala 28:23]
    end
    if (reset) begin // @[Reg.scala 27:20]
      mem_csr <= 64'h0; // @[Reg.scala 27:20]
    end else if (_if_pc_T) begin // @[Reg.scala 28:19]
      mem_csr <= csr_io_out; // @[Reg.scala 28:23]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  if_pc = _RAND_0[63:0];
  _RAND_1 = {1{`RANDOM}};
  if_pTaken = _RAND_1[0:0];
  _RAND_2 = {2{`RANDOM}};
  if_pPC = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  if_inst = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  ex_ctrl = _RAND_4[28:0];
  _RAND_5 = {1{`RANDOM}};
  ex_valid = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  ex_taken = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  ex_pTaken = _RAND_7[0:0];
  _RAND_8 = {2{`RANDOM}};
  ex_alu_out = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  ex_pPC = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  ex_pc = _RAND_10[63:0];
  _RAND_11 = {1{`RANDOM}};
  ex_inst = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  mem_fence_i_REG = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  if_valid = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  id_rs1 = _RAND_14[4:0];
  _RAND_15 = {1{`RANDOM}};
  id_rs2 = _RAND_15[4:0];
  _RAND_16 = {2{`RANDOM}};
  id_rdata1 = _RAND_16[63:0];
  _RAND_17 = {2{`RANDOM}};
  id_rdata2 = _RAND_17[63:0];
  _RAND_18 = {2{`RANDOM}};
  id_A = _RAND_18[63:0];
  _RAND_19 = {2{`RANDOM}};
  id_B = _RAND_19[63:0];
  _RAND_20 = {1{`RANDOM}};
  id_rd = _RAND_20[4:0];
  _RAND_21 = {1{`RANDOM}};
  id_ctrl = _RAND_21[28:0];
  _RAND_22 = {1{`RANDOM}};
  id_inst = _RAND_22[31:0];
  _RAND_23 = {2{`RANDOM}};
  id_pc = _RAND_23[63:0];
  _RAND_24 = {1{`RANDOM}};
  id_pTaken = _RAND_24[0:0];
  _RAND_25 = {2{`RANDOM}};
  id_pPC = _RAND_25[63:0];
  _RAND_26 = {1{`RANDOM}};
  id_valid = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  id_interrupt = _RAND_27[0:0];
  _RAND_28 = {2{`RANDOM}};
  ex_pc4 = _RAND_28[63:0];
  _RAND_29 = {1{`RANDOM}};
  ex_rd = _RAND_29[4:0];
  _RAND_30 = {1{`RANDOM}};
  ex_interrupt = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  mem_valid_true = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  mem_csr_except = _RAND_32[0:0];
  _RAND_33 = {2{`RANDOM}};
  mem_alu_out = _RAND_33[63:0];
  _RAND_34 = {2{`RANDOM}};
  mem_l_data_bits = _RAND_34[63:0];
  _RAND_35 = {1{`RANDOM}};
  mem_rd = _RAND_35[4:0];
  _RAND_36 = {1{`RANDOM}};
  mem_ctrl = _RAND_36[28:0];
  _RAND_37 = {2{`RANDOM}};
  mem_pc4 = _RAND_37[63:0];
  _RAND_38 = {2{`RANDOM}};
  mem_csr = _RAND_38[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_210013_Way(
  input          clock,
  input          reset,
  output         io_out_valid,
  output [53:0]  io_out_bits_tag,
  output         io_out_bits_v,
  output         io_out_bits_d,
  output [127:0] io_out_bits_datas,
  input          io_in_w_valid,
  input  [53:0]  io_in_w_bits_tag,
  input  [5:0]   io_in_w_bits_index,
  input  [3:0]   io_in_w_bits_offset,
  input          io_in_w_bits_v,
  input          io_in_w_bits_d,
  input  [7:0]   io_in_w_bits_mask,
  input  [63:0]  io_in_w_bits_data,
  input          io_in_w_bits_op,
  input          io_in_r_valid,
  input  [5:0]   io_in_r_bits_index,
  input          io_fence_invalid
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [63:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [63:0] _RAND_19;
  reg [63:0] _RAND_20;
  reg [63:0] _RAND_21;
  reg [63:0] _RAND_22;
  reg [63:0] _RAND_23;
  reg [63:0] _RAND_24;
  reg [63:0] _RAND_25;
  reg [63:0] _RAND_26;
  reg [63:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [63:0] _RAND_29;
  reg [63:0] _RAND_30;
  reg [63:0] _RAND_31;
  reg [63:0] _RAND_32;
  reg [63:0] _RAND_33;
  reg [63:0] _RAND_34;
  reg [63:0] _RAND_35;
  reg [63:0] _RAND_36;
  reg [63:0] _RAND_37;
  reg [63:0] _RAND_38;
  reg [63:0] _RAND_39;
  reg [63:0] _RAND_40;
  reg [63:0] _RAND_41;
  reg [63:0] _RAND_42;
  reg [63:0] _RAND_43;
  reg [63:0] _RAND_44;
  reg [63:0] _RAND_45;
  reg [63:0] _RAND_46;
  reg [63:0] _RAND_47;
  reg [63:0] _RAND_48;
  reg [63:0] _RAND_49;
  reg [63:0] _RAND_50;
  reg [63:0] _RAND_51;
  reg [63:0] _RAND_52;
  reg [63:0] _RAND_53;
  reg [63:0] _RAND_54;
  reg [63:0] _RAND_55;
  reg [63:0] _RAND_56;
  reg [63:0] _RAND_57;
  reg [63:0] _RAND_58;
  reg [63:0] _RAND_59;
  reg [63:0] _RAND_60;
  reg [63:0] _RAND_61;
  reg [63:0] _RAND_62;
  reg [63:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
  reg [31:0] _RAND_128;
  reg [31:0] _RAND_129;
  reg [31:0] _RAND_130;
  reg [31:0] _RAND_131;
  reg [31:0] _RAND_132;
  reg [31:0] _RAND_133;
  reg [31:0] _RAND_134;
  reg [31:0] _RAND_135;
  reg [31:0] _RAND_136;
  reg [31:0] _RAND_137;
  reg [31:0] _RAND_138;
  reg [31:0] _RAND_139;
  reg [31:0] _RAND_140;
  reg [31:0] _RAND_141;
  reg [31:0] _RAND_142;
  reg [31:0] _RAND_143;
  reg [31:0] _RAND_144;
  reg [31:0] _RAND_145;
  reg [31:0] _RAND_146;
  reg [31:0] _RAND_147;
  reg [31:0] _RAND_148;
  reg [31:0] _RAND_149;
  reg [31:0] _RAND_150;
  reg [31:0] _RAND_151;
  reg [31:0] _RAND_152;
  reg [31:0] _RAND_153;
  reg [31:0] _RAND_154;
  reg [31:0] _RAND_155;
  reg [31:0] _RAND_156;
  reg [31:0] _RAND_157;
  reg [31:0] _RAND_158;
  reg [31:0] _RAND_159;
  reg [31:0] _RAND_160;
  reg [31:0] _RAND_161;
  reg [31:0] _RAND_162;
  reg [31:0] _RAND_163;
  reg [31:0] _RAND_164;
  reg [31:0] _RAND_165;
  reg [31:0] _RAND_166;
  reg [31:0] _RAND_167;
  reg [31:0] _RAND_168;
  reg [31:0] _RAND_169;
  reg [31:0] _RAND_170;
  reg [31:0] _RAND_171;
  reg [31:0] _RAND_172;
  reg [31:0] _RAND_173;
  reg [31:0] _RAND_174;
  reg [31:0] _RAND_175;
  reg [31:0] _RAND_176;
  reg [31:0] _RAND_177;
  reg [31:0] _RAND_178;
  reg [31:0] _RAND_179;
  reg [31:0] _RAND_180;
  reg [31:0] _RAND_181;
  reg [31:0] _RAND_182;
  reg [31:0] _RAND_183;
  reg [31:0] _RAND_184;
  reg [31:0] _RAND_185;
  reg [31:0] _RAND_186;
  reg [31:0] _RAND_187;
  reg [31:0] _RAND_188;
  reg [31:0] _RAND_189;
  reg [31:0] _RAND_190;
  reg [31:0] _RAND_191;
  reg [63:0] _RAND_192;
  reg [31:0] _RAND_193;
  reg [31:0] _RAND_194;
  reg [31:0] _RAND_195;
`endif // RANDOMIZE_REG_INIT
  wire [127:0] bankn_Q; // @[Cache.scala 113:21]
  wire  bankn_CLK; // @[Cache.scala 113:21]
  wire  bankn_CEN; // @[Cache.scala 113:21]
  wire  bankn_WEN; // @[Cache.scala 113:21]
  wire [127:0] bankn_BWEN; // @[Cache.scala 113:21]
  wire [5:0] bankn_A; // @[Cache.scala 113:21]
  wire [127:0] bankn_D; // @[Cache.scala 113:21]
  reg [53:0] tag_tab_0; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_1; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_2; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_3; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_4; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_5; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_6; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_7; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_8; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_9; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_10; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_11; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_12; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_13; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_14; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_15; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_16; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_17; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_18; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_19; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_20; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_21; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_22; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_23; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_24; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_25; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_26; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_27; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_28; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_29; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_30; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_31; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_32; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_33; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_34; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_35; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_36; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_37; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_38; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_39; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_40; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_41; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_42; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_43; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_44; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_45; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_46; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_47; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_48; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_49; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_50; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_51; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_52; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_53; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_54; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_55; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_56; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_57; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_58; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_59; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_60; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_61; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_62; // @[Cache.scala 107:24]
  reg [53:0] tag_tab_63; // @[Cache.scala 107:24]
  reg  v_tab_0; // @[Cache.scala 108:22]
  reg  v_tab_1; // @[Cache.scala 108:22]
  reg  v_tab_2; // @[Cache.scala 108:22]
  reg  v_tab_3; // @[Cache.scala 108:22]
  reg  v_tab_4; // @[Cache.scala 108:22]
  reg  v_tab_5; // @[Cache.scala 108:22]
  reg  v_tab_6; // @[Cache.scala 108:22]
  reg  v_tab_7; // @[Cache.scala 108:22]
  reg  v_tab_8; // @[Cache.scala 108:22]
  reg  v_tab_9; // @[Cache.scala 108:22]
  reg  v_tab_10; // @[Cache.scala 108:22]
  reg  v_tab_11; // @[Cache.scala 108:22]
  reg  v_tab_12; // @[Cache.scala 108:22]
  reg  v_tab_13; // @[Cache.scala 108:22]
  reg  v_tab_14; // @[Cache.scala 108:22]
  reg  v_tab_15; // @[Cache.scala 108:22]
  reg  v_tab_16; // @[Cache.scala 108:22]
  reg  v_tab_17; // @[Cache.scala 108:22]
  reg  v_tab_18; // @[Cache.scala 108:22]
  reg  v_tab_19; // @[Cache.scala 108:22]
  reg  v_tab_20; // @[Cache.scala 108:22]
  reg  v_tab_21; // @[Cache.scala 108:22]
  reg  v_tab_22; // @[Cache.scala 108:22]
  reg  v_tab_23; // @[Cache.scala 108:22]
  reg  v_tab_24; // @[Cache.scala 108:22]
  reg  v_tab_25; // @[Cache.scala 108:22]
  reg  v_tab_26; // @[Cache.scala 108:22]
  reg  v_tab_27; // @[Cache.scala 108:22]
  reg  v_tab_28; // @[Cache.scala 108:22]
  reg  v_tab_29; // @[Cache.scala 108:22]
  reg  v_tab_30; // @[Cache.scala 108:22]
  reg  v_tab_31; // @[Cache.scala 108:22]
  reg  v_tab_32; // @[Cache.scala 108:22]
  reg  v_tab_33; // @[Cache.scala 108:22]
  reg  v_tab_34; // @[Cache.scala 108:22]
  reg  v_tab_35; // @[Cache.scala 108:22]
  reg  v_tab_36; // @[Cache.scala 108:22]
  reg  v_tab_37; // @[Cache.scala 108:22]
  reg  v_tab_38; // @[Cache.scala 108:22]
  reg  v_tab_39; // @[Cache.scala 108:22]
  reg  v_tab_40; // @[Cache.scala 108:22]
  reg  v_tab_41; // @[Cache.scala 108:22]
  reg  v_tab_42; // @[Cache.scala 108:22]
  reg  v_tab_43; // @[Cache.scala 108:22]
  reg  v_tab_44; // @[Cache.scala 108:22]
  reg  v_tab_45; // @[Cache.scala 108:22]
  reg  v_tab_46; // @[Cache.scala 108:22]
  reg  v_tab_47; // @[Cache.scala 108:22]
  reg  v_tab_48; // @[Cache.scala 108:22]
  reg  v_tab_49; // @[Cache.scala 108:22]
  reg  v_tab_50; // @[Cache.scala 108:22]
  reg  v_tab_51; // @[Cache.scala 108:22]
  reg  v_tab_52; // @[Cache.scala 108:22]
  reg  v_tab_53; // @[Cache.scala 108:22]
  reg  v_tab_54; // @[Cache.scala 108:22]
  reg  v_tab_55; // @[Cache.scala 108:22]
  reg  v_tab_56; // @[Cache.scala 108:22]
  reg  v_tab_57; // @[Cache.scala 108:22]
  reg  v_tab_58; // @[Cache.scala 108:22]
  reg  v_tab_59; // @[Cache.scala 108:22]
  reg  v_tab_60; // @[Cache.scala 108:22]
  reg  v_tab_61; // @[Cache.scala 108:22]
  reg  v_tab_62; // @[Cache.scala 108:22]
  reg  v_tab_63; // @[Cache.scala 108:22]
  reg  dirty_tab_0; // @[Cache.scala 110:26]
  reg  dirty_tab_1; // @[Cache.scala 110:26]
  reg  dirty_tab_2; // @[Cache.scala 110:26]
  reg  dirty_tab_3; // @[Cache.scala 110:26]
  reg  dirty_tab_4; // @[Cache.scala 110:26]
  reg  dirty_tab_5; // @[Cache.scala 110:26]
  reg  dirty_tab_6; // @[Cache.scala 110:26]
  reg  dirty_tab_7; // @[Cache.scala 110:26]
  reg  dirty_tab_8; // @[Cache.scala 110:26]
  reg  dirty_tab_9; // @[Cache.scala 110:26]
  reg  dirty_tab_10; // @[Cache.scala 110:26]
  reg  dirty_tab_11; // @[Cache.scala 110:26]
  reg  dirty_tab_12; // @[Cache.scala 110:26]
  reg  dirty_tab_13; // @[Cache.scala 110:26]
  reg  dirty_tab_14; // @[Cache.scala 110:26]
  reg  dirty_tab_15; // @[Cache.scala 110:26]
  reg  dirty_tab_16; // @[Cache.scala 110:26]
  reg  dirty_tab_17; // @[Cache.scala 110:26]
  reg  dirty_tab_18; // @[Cache.scala 110:26]
  reg  dirty_tab_19; // @[Cache.scala 110:26]
  reg  dirty_tab_20; // @[Cache.scala 110:26]
  reg  dirty_tab_21; // @[Cache.scala 110:26]
  reg  dirty_tab_22; // @[Cache.scala 110:26]
  reg  dirty_tab_23; // @[Cache.scala 110:26]
  reg  dirty_tab_24; // @[Cache.scala 110:26]
  reg  dirty_tab_25; // @[Cache.scala 110:26]
  reg  dirty_tab_26; // @[Cache.scala 110:26]
  reg  dirty_tab_27; // @[Cache.scala 110:26]
  reg  dirty_tab_28; // @[Cache.scala 110:26]
  reg  dirty_tab_29; // @[Cache.scala 110:26]
  reg  dirty_tab_30; // @[Cache.scala 110:26]
  reg  dirty_tab_31; // @[Cache.scala 110:26]
  reg  dirty_tab_32; // @[Cache.scala 110:26]
  reg  dirty_tab_33; // @[Cache.scala 110:26]
  reg  dirty_tab_34; // @[Cache.scala 110:26]
  reg  dirty_tab_35; // @[Cache.scala 110:26]
  reg  dirty_tab_36; // @[Cache.scala 110:26]
  reg  dirty_tab_37; // @[Cache.scala 110:26]
  reg  dirty_tab_38; // @[Cache.scala 110:26]
  reg  dirty_tab_39; // @[Cache.scala 110:26]
  reg  dirty_tab_40; // @[Cache.scala 110:26]
  reg  dirty_tab_41; // @[Cache.scala 110:26]
  reg  dirty_tab_42; // @[Cache.scala 110:26]
  reg  dirty_tab_43; // @[Cache.scala 110:26]
  reg  dirty_tab_44; // @[Cache.scala 110:26]
  reg  dirty_tab_45; // @[Cache.scala 110:26]
  reg  dirty_tab_46; // @[Cache.scala 110:26]
  reg  dirty_tab_47; // @[Cache.scala 110:26]
  reg  dirty_tab_48; // @[Cache.scala 110:26]
  reg  dirty_tab_49; // @[Cache.scala 110:26]
  reg  dirty_tab_50; // @[Cache.scala 110:26]
  reg  dirty_tab_51; // @[Cache.scala 110:26]
  reg  dirty_tab_52; // @[Cache.scala 110:26]
  reg  dirty_tab_53; // @[Cache.scala 110:26]
  reg  dirty_tab_54; // @[Cache.scala 110:26]
  reg  dirty_tab_55; // @[Cache.scala 110:26]
  reg  dirty_tab_56; // @[Cache.scala 110:26]
  reg  dirty_tab_57; // @[Cache.scala 110:26]
  reg  dirty_tab_58; // @[Cache.scala 110:26]
  reg  dirty_tab_59; // @[Cache.scala 110:26]
  reg  dirty_tab_60; // @[Cache.scala 110:26]
  reg  dirty_tab_61; // @[Cache.scala 110:26]
  reg  dirty_tab_62; // @[Cache.scala 110:26]
  reg  dirty_tab_63; // @[Cache.scala 110:26]
  reg [53:0] result_hi_hi; // @[Cache.scala 122:16]
  wire [53:0] _GEN_1 = 6'h1 == io_in_r_bits_index ? tag_tab_1 : tag_tab_0; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_2 = 6'h2 == io_in_r_bits_index ? tag_tab_2 : _GEN_1; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_3 = 6'h3 == io_in_r_bits_index ? tag_tab_3 : _GEN_2; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_4 = 6'h4 == io_in_r_bits_index ? tag_tab_4 : _GEN_3; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_5 = 6'h5 == io_in_r_bits_index ? tag_tab_5 : _GEN_4; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_6 = 6'h6 == io_in_r_bits_index ? tag_tab_6 : _GEN_5; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_7 = 6'h7 == io_in_r_bits_index ? tag_tab_7 : _GEN_6; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_8 = 6'h8 == io_in_r_bits_index ? tag_tab_8 : _GEN_7; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_9 = 6'h9 == io_in_r_bits_index ? tag_tab_9 : _GEN_8; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_10 = 6'ha == io_in_r_bits_index ? tag_tab_10 : _GEN_9; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_11 = 6'hb == io_in_r_bits_index ? tag_tab_11 : _GEN_10; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_12 = 6'hc == io_in_r_bits_index ? tag_tab_12 : _GEN_11; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_13 = 6'hd == io_in_r_bits_index ? tag_tab_13 : _GEN_12; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_14 = 6'he == io_in_r_bits_index ? tag_tab_14 : _GEN_13; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_15 = 6'hf == io_in_r_bits_index ? tag_tab_15 : _GEN_14; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_16 = 6'h10 == io_in_r_bits_index ? tag_tab_16 : _GEN_15; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_17 = 6'h11 == io_in_r_bits_index ? tag_tab_17 : _GEN_16; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_18 = 6'h12 == io_in_r_bits_index ? tag_tab_18 : _GEN_17; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_19 = 6'h13 == io_in_r_bits_index ? tag_tab_19 : _GEN_18; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_20 = 6'h14 == io_in_r_bits_index ? tag_tab_20 : _GEN_19; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_21 = 6'h15 == io_in_r_bits_index ? tag_tab_21 : _GEN_20; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_22 = 6'h16 == io_in_r_bits_index ? tag_tab_22 : _GEN_21; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_23 = 6'h17 == io_in_r_bits_index ? tag_tab_23 : _GEN_22; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_24 = 6'h18 == io_in_r_bits_index ? tag_tab_24 : _GEN_23; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_25 = 6'h19 == io_in_r_bits_index ? tag_tab_25 : _GEN_24; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_26 = 6'h1a == io_in_r_bits_index ? tag_tab_26 : _GEN_25; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_27 = 6'h1b == io_in_r_bits_index ? tag_tab_27 : _GEN_26; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_28 = 6'h1c == io_in_r_bits_index ? tag_tab_28 : _GEN_27; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_29 = 6'h1d == io_in_r_bits_index ? tag_tab_29 : _GEN_28; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_30 = 6'h1e == io_in_r_bits_index ? tag_tab_30 : _GEN_29; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_31 = 6'h1f == io_in_r_bits_index ? tag_tab_31 : _GEN_30; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_32 = 6'h20 == io_in_r_bits_index ? tag_tab_32 : _GEN_31; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_33 = 6'h21 == io_in_r_bits_index ? tag_tab_33 : _GEN_32; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_34 = 6'h22 == io_in_r_bits_index ? tag_tab_34 : _GEN_33; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_35 = 6'h23 == io_in_r_bits_index ? tag_tab_35 : _GEN_34; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_36 = 6'h24 == io_in_r_bits_index ? tag_tab_36 : _GEN_35; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_37 = 6'h25 == io_in_r_bits_index ? tag_tab_37 : _GEN_36; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_38 = 6'h26 == io_in_r_bits_index ? tag_tab_38 : _GEN_37; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_39 = 6'h27 == io_in_r_bits_index ? tag_tab_39 : _GEN_38; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_40 = 6'h28 == io_in_r_bits_index ? tag_tab_40 : _GEN_39; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_41 = 6'h29 == io_in_r_bits_index ? tag_tab_41 : _GEN_40; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_42 = 6'h2a == io_in_r_bits_index ? tag_tab_42 : _GEN_41; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_43 = 6'h2b == io_in_r_bits_index ? tag_tab_43 : _GEN_42; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_44 = 6'h2c == io_in_r_bits_index ? tag_tab_44 : _GEN_43; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_45 = 6'h2d == io_in_r_bits_index ? tag_tab_45 : _GEN_44; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_46 = 6'h2e == io_in_r_bits_index ? tag_tab_46 : _GEN_45; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_47 = 6'h2f == io_in_r_bits_index ? tag_tab_47 : _GEN_46; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_48 = 6'h30 == io_in_r_bits_index ? tag_tab_48 : _GEN_47; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_49 = 6'h31 == io_in_r_bits_index ? tag_tab_49 : _GEN_48; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_50 = 6'h32 == io_in_r_bits_index ? tag_tab_50 : _GEN_49; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_51 = 6'h33 == io_in_r_bits_index ? tag_tab_51 : _GEN_50; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_52 = 6'h34 == io_in_r_bits_index ? tag_tab_52 : _GEN_51; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_53 = 6'h35 == io_in_r_bits_index ? tag_tab_53 : _GEN_52; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_54 = 6'h36 == io_in_r_bits_index ? tag_tab_54 : _GEN_53; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_55 = 6'h37 == io_in_r_bits_index ? tag_tab_55 : _GEN_54; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_56 = 6'h38 == io_in_r_bits_index ? tag_tab_56 : _GEN_55; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_57 = 6'h39 == io_in_r_bits_index ? tag_tab_57 : _GEN_56; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_58 = 6'h3a == io_in_r_bits_index ? tag_tab_58 : _GEN_57; // @[Cache.scala 122:16 Cache.scala 122:16]
  wire [53:0] _GEN_59 = 6'h3b == io_in_r_bits_index ? tag_tab_59 : _GEN_58; // @[Cache.scala 122:16 Cache.scala 122:16]
  reg  result_hi_lo; // @[Cache.scala 123:18]
  wire  _GEN_65 = 6'h1 == io_in_r_bits_index ? v_tab_1 : v_tab_0; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_66 = 6'h2 == io_in_r_bits_index ? v_tab_2 : _GEN_65; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_67 = 6'h3 == io_in_r_bits_index ? v_tab_3 : _GEN_66; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_68 = 6'h4 == io_in_r_bits_index ? v_tab_4 : _GEN_67; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_69 = 6'h5 == io_in_r_bits_index ? v_tab_5 : _GEN_68; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_70 = 6'h6 == io_in_r_bits_index ? v_tab_6 : _GEN_69; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_71 = 6'h7 == io_in_r_bits_index ? v_tab_7 : _GEN_70; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_72 = 6'h8 == io_in_r_bits_index ? v_tab_8 : _GEN_71; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_73 = 6'h9 == io_in_r_bits_index ? v_tab_9 : _GEN_72; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_74 = 6'ha == io_in_r_bits_index ? v_tab_10 : _GEN_73; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_75 = 6'hb == io_in_r_bits_index ? v_tab_11 : _GEN_74; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_76 = 6'hc == io_in_r_bits_index ? v_tab_12 : _GEN_75; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_77 = 6'hd == io_in_r_bits_index ? v_tab_13 : _GEN_76; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_78 = 6'he == io_in_r_bits_index ? v_tab_14 : _GEN_77; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_79 = 6'hf == io_in_r_bits_index ? v_tab_15 : _GEN_78; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_80 = 6'h10 == io_in_r_bits_index ? v_tab_16 : _GEN_79; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_81 = 6'h11 == io_in_r_bits_index ? v_tab_17 : _GEN_80; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_82 = 6'h12 == io_in_r_bits_index ? v_tab_18 : _GEN_81; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_83 = 6'h13 == io_in_r_bits_index ? v_tab_19 : _GEN_82; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_84 = 6'h14 == io_in_r_bits_index ? v_tab_20 : _GEN_83; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_85 = 6'h15 == io_in_r_bits_index ? v_tab_21 : _GEN_84; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_86 = 6'h16 == io_in_r_bits_index ? v_tab_22 : _GEN_85; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_87 = 6'h17 == io_in_r_bits_index ? v_tab_23 : _GEN_86; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_88 = 6'h18 == io_in_r_bits_index ? v_tab_24 : _GEN_87; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_89 = 6'h19 == io_in_r_bits_index ? v_tab_25 : _GEN_88; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_90 = 6'h1a == io_in_r_bits_index ? v_tab_26 : _GEN_89; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_91 = 6'h1b == io_in_r_bits_index ? v_tab_27 : _GEN_90; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_92 = 6'h1c == io_in_r_bits_index ? v_tab_28 : _GEN_91; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_93 = 6'h1d == io_in_r_bits_index ? v_tab_29 : _GEN_92; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_94 = 6'h1e == io_in_r_bits_index ? v_tab_30 : _GEN_93; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_95 = 6'h1f == io_in_r_bits_index ? v_tab_31 : _GEN_94; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_96 = 6'h20 == io_in_r_bits_index ? v_tab_32 : _GEN_95; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_97 = 6'h21 == io_in_r_bits_index ? v_tab_33 : _GEN_96; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_98 = 6'h22 == io_in_r_bits_index ? v_tab_34 : _GEN_97; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_99 = 6'h23 == io_in_r_bits_index ? v_tab_35 : _GEN_98; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_100 = 6'h24 == io_in_r_bits_index ? v_tab_36 : _GEN_99; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_101 = 6'h25 == io_in_r_bits_index ? v_tab_37 : _GEN_100; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_102 = 6'h26 == io_in_r_bits_index ? v_tab_38 : _GEN_101; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_103 = 6'h27 == io_in_r_bits_index ? v_tab_39 : _GEN_102; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_104 = 6'h28 == io_in_r_bits_index ? v_tab_40 : _GEN_103; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_105 = 6'h29 == io_in_r_bits_index ? v_tab_41 : _GEN_104; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_106 = 6'h2a == io_in_r_bits_index ? v_tab_42 : _GEN_105; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_107 = 6'h2b == io_in_r_bits_index ? v_tab_43 : _GEN_106; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_108 = 6'h2c == io_in_r_bits_index ? v_tab_44 : _GEN_107; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_109 = 6'h2d == io_in_r_bits_index ? v_tab_45 : _GEN_108; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_110 = 6'h2e == io_in_r_bits_index ? v_tab_46 : _GEN_109; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_111 = 6'h2f == io_in_r_bits_index ? v_tab_47 : _GEN_110; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_112 = 6'h30 == io_in_r_bits_index ? v_tab_48 : _GEN_111; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_113 = 6'h31 == io_in_r_bits_index ? v_tab_49 : _GEN_112; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_114 = 6'h32 == io_in_r_bits_index ? v_tab_50 : _GEN_113; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_115 = 6'h33 == io_in_r_bits_index ? v_tab_51 : _GEN_114; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_116 = 6'h34 == io_in_r_bits_index ? v_tab_52 : _GEN_115; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_117 = 6'h35 == io_in_r_bits_index ? v_tab_53 : _GEN_116; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_118 = 6'h36 == io_in_r_bits_index ? v_tab_54 : _GEN_117; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_119 = 6'h37 == io_in_r_bits_index ? v_tab_55 : _GEN_118; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_120 = 6'h38 == io_in_r_bits_index ? v_tab_56 : _GEN_119; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_121 = 6'h39 == io_in_r_bits_index ? v_tab_57 : _GEN_120; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_122 = 6'h3a == io_in_r_bits_index ? v_tab_58 : _GEN_121; // @[Cache.scala 123:18 Cache.scala 123:18]
  wire  _GEN_123 = 6'h3b == io_in_r_bits_index ? v_tab_59 : _GEN_122; // @[Cache.scala 123:18 Cache.scala 123:18]
  reg  result_lo_hi; // @[Cache.scala 124:18]
  wire  _GEN_129 = 6'h1 == io_in_r_bits_index ? dirty_tab_1 : dirty_tab_0; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_130 = 6'h2 == io_in_r_bits_index ? dirty_tab_2 : _GEN_129; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_131 = 6'h3 == io_in_r_bits_index ? dirty_tab_3 : _GEN_130; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_132 = 6'h4 == io_in_r_bits_index ? dirty_tab_4 : _GEN_131; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_133 = 6'h5 == io_in_r_bits_index ? dirty_tab_5 : _GEN_132; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_134 = 6'h6 == io_in_r_bits_index ? dirty_tab_6 : _GEN_133; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_135 = 6'h7 == io_in_r_bits_index ? dirty_tab_7 : _GEN_134; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_136 = 6'h8 == io_in_r_bits_index ? dirty_tab_8 : _GEN_135; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_137 = 6'h9 == io_in_r_bits_index ? dirty_tab_9 : _GEN_136; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_138 = 6'ha == io_in_r_bits_index ? dirty_tab_10 : _GEN_137; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_139 = 6'hb == io_in_r_bits_index ? dirty_tab_11 : _GEN_138; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_140 = 6'hc == io_in_r_bits_index ? dirty_tab_12 : _GEN_139; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_141 = 6'hd == io_in_r_bits_index ? dirty_tab_13 : _GEN_140; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_142 = 6'he == io_in_r_bits_index ? dirty_tab_14 : _GEN_141; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_143 = 6'hf == io_in_r_bits_index ? dirty_tab_15 : _GEN_142; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_144 = 6'h10 == io_in_r_bits_index ? dirty_tab_16 : _GEN_143; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_145 = 6'h11 == io_in_r_bits_index ? dirty_tab_17 : _GEN_144; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_146 = 6'h12 == io_in_r_bits_index ? dirty_tab_18 : _GEN_145; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_147 = 6'h13 == io_in_r_bits_index ? dirty_tab_19 : _GEN_146; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_148 = 6'h14 == io_in_r_bits_index ? dirty_tab_20 : _GEN_147; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_149 = 6'h15 == io_in_r_bits_index ? dirty_tab_21 : _GEN_148; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_150 = 6'h16 == io_in_r_bits_index ? dirty_tab_22 : _GEN_149; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_151 = 6'h17 == io_in_r_bits_index ? dirty_tab_23 : _GEN_150; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_152 = 6'h18 == io_in_r_bits_index ? dirty_tab_24 : _GEN_151; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_153 = 6'h19 == io_in_r_bits_index ? dirty_tab_25 : _GEN_152; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_154 = 6'h1a == io_in_r_bits_index ? dirty_tab_26 : _GEN_153; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_155 = 6'h1b == io_in_r_bits_index ? dirty_tab_27 : _GEN_154; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_156 = 6'h1c == io_in_r_bits_index ? dirty_tab_28 : _GEN_155; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_157 = 6'h1d == io_in_r_bits_index ? dirty_tab_29 : _GEN_156; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_158 = 6'h1e == io_in_r_bits_index ? dirty_tab_30 : _GEN_157; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_159 = 6'h1f == io_in_r_bits_index ? dirty_tab_31 : _GEN_158; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_160 = 6'h20 == io_in_r_bits_index ? dirty_tab_32 : _GEN_159; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_161 = 6'h21 == io_in_r_bits_index ? dirty_tab_33 : _GEN_160; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_162 = 6'h22 == io_in_r_bits_index ? dirty_tab_34 : _GEN_161; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_163 = 6'h23 == io_in_r_bits_index ? dirty_tab_35 : _GEN_162; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_164 = 6'h24 == io_in_r_bits_index ? dirty_tab_36 : _GEN_163; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_165 = 6'h25 == io_in_r_bits_index ? dirty_tab_37 : _GEN_164; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_166 = 6'h26 == io_in_r_bits_index ? dirty_tab_38 : _GEN_165; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_167 = 6'h27 == io_in_r_bits_index ? dirty_tab_39 : _GEN_166; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_168 = 6'h28 == io_in_r_bits_index ? dirty_tab_40 : _GEN_167; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_169 = 6'h29 == io_in_r_bits_index ? dirty_tab_41 : _GEN_168; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_170 = 6'h2a == io_in_r_bits_index ? dirty_tab_42 : _GEN_169; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_171 = 6'h2b == io_in_r_bits_index ? dirty_tab_43 : _GEN_170; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_172 = 6'h2c == io_in_r_bits_index ? dirty_tab_44 : _GEN_171; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_173 = 6'h2d == io_in_r_bits_index ? dirty_tab_45 : _GEN_172; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_174 = 6'h2e == io_in_r_bits_index ? dirty_tab_46 : _GEN_173; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_175 = 6'h2f == io_in_r_bits_index ? dirty_tab_47 : _GEN_174; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_176 = 6'h30 == io_in_r_bits_index ? dirty_tab_48 : _GEN_175; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_177 = 6'h31 == io_in_r_bits_index ? dirty_tab_49 : _GEN_176; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_178 = 6'h32 == io_in_r_bits_index ? dirty_tab_50 : _GEN_177; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_179 = 6'h33 == io_in_r_bits_index ? dirty_tab_51 : _GEN_178; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_180 = 6'h34 == io_in_r_bits_index ? dirty_tab_52 : _GEN_179; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_181 = 6'h35 == io_in_r_bits_index ? dirty_tab_53 : _GEN_180; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_182 = 6'h36 == io_in_r_bits_index ? dirty_tab_54 : _GEN_181; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_183 = 6'h37 == io_in_r_bits_index ? dirty_tab_55 : _GEN_182; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_184 = 6'h38 == io_in_r_bits_index ? dirty_tab_56 : _GEN_183; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_185 = 6'h39 == io_in_r_bits_index ? dirty_tab_57 : _GEN_184; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_186 = 6'h3a == io_in_r_bits_index ? dirty_tab_58 : _GEN_185; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire  _GEN_187 = 6'h3b == io_in_r_bits_index ? dirty_tab_59 : _GEN_186; // @[Cache.scala 124:18 Cache.scala 124:18]
  wire [183:0] _result_T = {result_hi_hi,result_hi_lo,result_lo_hi,bankn_Q}; // @[Cat.scala 30:58]
  reg  io_out_valid_REG; // @[Cache.scala 129:26]
  wire  bank_sel = io_in_w_bits_offset[3]; // @[Cache.scala 134:46]
  wire [127:0] _GEN_915 = {io_in_w_bits_data, 64'h0}; // @[Cache.scala 146:37]
  wire [190:0] _w_data_T = {{63'd0}, _GEN_915}; // @[Cache.scala 146:37]
  wire [15:0] _GEN_916 = {io_in_w_bits_mask, 8'h0}; // @[Cache.scala 147:37]
  wire [22:0] _w_mask_T = {{7'd0}, _GEN_916}; // @[Cache.scala 147:37]
  wire [190:0] _GEN_384 = bank_sel ? _w_data_T : {{127'd0}, io_in_w_bits_data}; // @[Cache.scala 145:29 Cache.scala 146:16 Cache.scala 149:16]
  wire [22:0] _GEN_385 = bank_sel ? _w_mask_T : {{15'd0}, io_in_w_bits_mask}; // @[Cache.scala 145:29 Cache.scala 147:16 Cache.scala 150:16]
  wire [22:0] _GEN_579 = io_in_w_bits_op ? _GEN_385 : 23'h0; // @[Cache.scala 138:34]
  wire [22:0] _GEN_909 = io_in_w_valid ? _GEN_579 : 23'h0; // @[Cache.scala 137:23]
  wire [15:0] w_mask = _GEN_909[15:0];
  wire [7:0] bankn_io_BWEN_lo_lo_lo_lo = w_mask[0] ? 8'h0 : 8'hff; // @[RAMSim.scala 28:10]
  wire [7:0] bankn_io_BWEN_lo_lo_lo_hi = w_mask[1] ? 8'h0 : 8'hff; // @[RAMSim.scala 28:10]
  wire [7:0] bankn_io_BWEN_lo_lo_hi_lo = w_mask[2] ? 8'h0 : 8'hff; // @[RAMSim.scala 28:10]
  wire [7:0] bankn_io_BWEN_lo_lo_hi_hi = w_mask[3] ? 8'h0 : 8'hff; // @[RAMSim.scala 28:10]
  wire [7:0] bankn_io_BWEN_lo_hi_lo_lo = w_mask[4] ? 8'h0 : 8'hff; // @[RAMSim.scala 28:10]
  wire [7:0] bankn_io_BWEN_lo_hi_lo_hi = w_mask[5] ? 8'h0 : 8'hff; // @[RAMSim.scala 28:10]
  wire [7:0] bankn_io_BWEN_lo_hi_hi_lo = w_mask[6] ? 8'h0 : 8'hff; // @[RAMSim.scala 28:10]
  wire [7:0] bankn_io_BWEN_lo_hi_hi_hi = w_mask[7] ? 8'h0 : 8'hff; // @[RAMSim.scala 28:10]
  wire [7:0] bankn_io_BWEN_hi_lo_lo_lo = w_mask[8] ? 8'h0 : 8'hff; // @[RAMSim.scala 28:10]
  wire [7:0] bankn_io_BWEN_hi_lo_lo_hi = w_mask[9] ? 8'h0 : 8'hff; // @[RAMSim.scala 28:10]
  wire [7:0] bankn_io_BWEN_hi_lo_hi_lo = w_mask[10] ? 8'h0 : 8'hff; // @[RAMSim.scala 28:10]
  wire [7:0] bankn_io_BWEN_hi_lo_hi_hi = w_mask[11] ? 8'h0 : 8'hff; // @[RAMSim.scala 28:10]
  wire [7:0] bankn_io_BWEN_hi_hi_lo_lo = w_mask[12] ? 8'h0 : 8'hff; // @[RAMSim.scala 28:10]
  wire [7:0] bankn_io_BWEN_hi_hi_lo_hi = w_mask[13] ? 8'h0 : 8'hff; // @[RAMSim.scala 28:10]
  wire [7:0] bankn_io_BWEN_hi_hi_hi_lo = w_mask[14] ? 8'h0 : 8'hff; // @[RAMSim.scala 28:10]
  wire [7:0] bankn_io_BWEN_hi_hi_hi_hi = w_mask[15] ? 8'h0 : 8'hff; // @[RAMSim.scala 28:10]
  wire [63:0] bankn_io_BWEN_lo = {bankn_io_BWEN_lo_hi_hi_hi,bankn_io_BWEN_lo_hi_hi_lo,bankn_io_BWEN_lo_hi_lo_hi,
    bankn_io_BWEN_lo_hi_lo_lo,bankn_io_BWEN_lo_lo_hi_hi,bankn_io_BWEN_lo_lo_hi_lo,bankn_io_BWEN_lo_lo_lo_hi,
    bankn_io_BWEN_lo_lo_lo_lo}; // @[Cat.scala 30:58]
  wire [127:0] _bankn_io_BWEN_T_16 = {bankn_io_BWEN_hi_hi_hi_hi,bankn_io_BWEN_hi_hi_hi_lo,bankn_io_BWEN_hi_hi_lo_hi,
    bankn_io_BWEN_hi_hi_lo_lo,bankn_io_BWEN_hi_lo_hi_hi,bankn_io_BWEN_hi_lo_hi_lo,bankn_io_BWEN_hi_lo_lo_hi,
    bankn_io_BWEN_hi_lo_lo_lo,bankn_io_BWEN_lo}; // @[Cat.scala 30:58]
  wire [190:0] _GEN_578 = io_in_w_bits_op ? _GEN_384 : 191'h0; // @[Cache.scala 138:34]
  wire [190:0] _GEN_908 = io_in_w_valid ? _GEN_578 : 191'h0; // @[Cache.scala 137:23]
  wire [127:0] w_data = _GEN_908[127:0];
  S011HD1P_X32Y2D128_BW bankn ( // @[Cache.scala 113:21]
    .Q(bankn_Q),
    .CLK(bankn_CLK),
    .CEN(bankn_CEN),
    .WEN(bankn_WEN),
    .BWEN(bankn_BWEN),
    .A(bankn_A),
    .D(bankn_D)
  );
  assign io_out_valid = io_out_valid_REG; // @[Cache.scala 129:16]
  assign io_out_bits_tag = _result_T[183:130]; // @[Cache.scala 126:22]
  assign io_out_bits_v = _result_T[129]; // @[Cache.scala 126:22]
  assign io_out_bits_d = _result_T[128]; // @[Cache.scala 126:22]
  assign io_out_bits_datas = _result_T[127:0]; // @[Cache.scala 126:22]
  assign bankn_CLK = clock; // @[Cache.scala 114:16]
  assign bankn_CEN = 1'h0; // @[Cache.scala 137:23]
  assign bankn_WEN = io_in_w_valid ? 1'h0 : 1'h1; // @[Cache.scala 137:23]
  assign bankn_BWEN = io_in_w_valid ? _bankn_io_BWEN_T_16 : 128'hffffffffffffffffffffffffffffffff; // @[Cache.scala 137:23]
  assign bankn_A = io_in_w_valid ? io_in_w_bits_index : io_in_r_bits_index; // @[Cache.scala 137:23]
  assign bankn_D = io_in_w_valid ? w_data : 128'h0; // @[Cache.scala 137:23]
  always @(posedge clock) begin
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_0 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h0 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_0 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_1 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_1 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_2 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_2 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_3 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_3 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_4 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h4 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_4 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_5 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h5 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_5 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_6 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h6 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_6 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_7 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h7 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_7 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_8 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h8 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_8 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_9 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h9 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_9 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_10 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'ha == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_10 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_11 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'hb == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_11 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_12 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'hc == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_12 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_13 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'hd == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_13 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_14 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'he == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_14 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_15 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'hf == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_15 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_16 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h10 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_16 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_17 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h11 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_17 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_18 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h12 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_18 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_19 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h13 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_19 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_20 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h14 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_20 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_21 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h15 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_21 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_22 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h16 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_22 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_23 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h17 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_23 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_24 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h18 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_24 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_25 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h19 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_25 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_26 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1a == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_26 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_27 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1b == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_27 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_28 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1c == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_28 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_29 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1d == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_29 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_30 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1e == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_30 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_31 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1f == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_31 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_32 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h20 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_32 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_33 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h21 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_33 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_34 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h22 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_34 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_35 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h23 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_35 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_36 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h24 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_36 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_37 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h25 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_37 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_38 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h26 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_38 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_39 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h27 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_39 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_40 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h28 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_40 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_41 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h29 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_41 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_42 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2a == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_42 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_43 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2b == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_43 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_44 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2c == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_44 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_45 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2d == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_45 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_46 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2e == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_46 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_47 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2f == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_47 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_48 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h30 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_48 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_49 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h31 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_49 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_50 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h32 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_50 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_51 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h33 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_51 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_52 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h34 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_52 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_53 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h35 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_53 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_54 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h36 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_54 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_55 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h37 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_55 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_56 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h38 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_56 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_57 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h39 == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_57 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_58 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3a == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_58 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_59 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3b == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_59 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_60 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3c == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_60 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_61 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3d == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_61 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_62 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3e == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_62 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 107:24]
      tag_tab_63 <= 54'h0; // @[Cache.scala 107:24]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3f == io_in_w_bits_index) begin // @[Cache.scala 140:35]
          tag_tab_63 <= io_in_w_bits_tag; // @[Cache.scala 140:35]
        end
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_0 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h0 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_0 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_0 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_1 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_1 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_1 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_2 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_2 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_2 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_3 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_3 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_3 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_4 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h4 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_4 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_4 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_5 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h5 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_5 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_5 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_6 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h6 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_6 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_6 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_7 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h7 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_7 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_7 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_8 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h8 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_8 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_8 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_9 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h9 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_9 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_9 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_10 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'ha == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_10 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_10 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_11 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'hb == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_11 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_11 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_12 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'hc == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_12 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_12 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_13 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'hd == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_13 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_13 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_14 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'he == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_14 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_14 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_15 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'hf == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_15 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_15 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_16 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h10 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_16 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_16 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_17 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h11 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_17 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_17 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_18 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h12 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_18 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_18 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_19 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h13 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_19 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_19 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_20 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h14 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_20 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_20 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_21 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h15 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_21 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_21 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_22 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h16 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_22 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_22 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_23 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h17 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_23 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_23 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_24 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h18 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_24 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_24 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_25 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h19 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_25 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_25 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_26 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1a == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_26 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_26 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_27 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1b == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_27 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_27 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_28 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1c == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_28 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_28 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_29 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1d == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_29 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_29 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_30 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1e == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_30 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_30 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_31 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1f == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_31 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_31 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_32 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h20 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_32 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_32 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_33 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h21 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_33 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_33 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_34 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h22 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_34 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_34 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_35 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h23 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_35 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_35 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_36 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h24 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_36 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_36 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_37 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h25 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_37 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_37 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_38 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h26 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_38 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_38 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_39 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h27 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_39 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_39 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_40 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h28 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_40 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_40 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_41 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h29 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_41 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_41 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_42 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2a == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_42 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_42 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_43 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2b == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_43 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_43 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_44 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2c == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_44 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_44 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_45 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2d == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_45 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_45 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_46 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2e == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_46 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_46 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_47 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2f == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_47 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_47 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_48 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h30 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_48 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_48 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_49 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h31 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_49 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_49 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_50 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h32 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_50 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_50 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_51 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h33 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_51 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_51 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_52 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h34 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_52 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_52 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_53 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h35 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_53 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_53 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_54 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h36 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_54 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_54 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_55 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h37 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_55 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_55 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_56 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h38 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_56 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_56 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_57 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h39 == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_57 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_57 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_58 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3a == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_58 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_58 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_59 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3b == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_59 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_59 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_60 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3c == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_60 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_60 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_61 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3d == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_61 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_61 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_62 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3e == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_62 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_62 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 108:22]
      v_tab_63 <= 1'h0; // @[Cache.scala 108:22]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3f == io_in_w_bits_index) begin // @[Cache.scala 141:33]
          v_tab_63 <= io_in_w_bits_v; // @[Cache.scala 141:33]
        end
      end
    end else if (!(io_in_r_valid)) begin // @[Cache.scala 154:29]
      if (io_fence_invalid) begin // @[Cache.scala 156:31]
        v_tab_63 <= 1'h0; // @[Cache.scala 157:11]
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_0 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h0 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_0 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_1 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_1 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_2 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_2 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_3 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_3 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_4 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h4 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_4 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_5 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h5 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_5 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_6 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h6 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_6 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_7 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h7 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_7 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_8 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h8 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_8 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_9 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h9 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_9 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_10 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'ha == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_10 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_11 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'hb == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_11 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_12 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'hc == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_12 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_13 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'hd == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_13 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_14 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'he == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_14 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_15 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'hf == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_15 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_16 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h10 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_16 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_17 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h11 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_17 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_18 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h12 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_18 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_19 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h13 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_19 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_20 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h14 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_20 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_21 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h15 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_21 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_22 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h16 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_22 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_23 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h17 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_23 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_24 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h18 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_24 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_25 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h19 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_25 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_26 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1a == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_26 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_27 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1b == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_27 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_28 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1c == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_28 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_29 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1d == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_29 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_30 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1e == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_30 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_31 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h1f == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_31 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_32 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h20 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_32 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_33 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h21 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_33 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_34 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h22 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_34 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_35 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h23 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_35 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_36 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h24 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_36 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_37 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h25 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_37 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_38 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h26 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_38 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_39 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h27 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_39 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_40 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h28 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_40 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_41 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h29 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_41 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_42 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2a == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_42 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_43 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2b == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_43 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_44 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2c == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_44 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_45 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2d == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_45 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_46 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2e == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_46 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_47 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h2f == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_47 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_48 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h30 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_48 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_49 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h31 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_49 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_50 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h32 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_50 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_51 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h33 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_51 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_52 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h34 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_52 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_53 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h35 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_53 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_54 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h36 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_54 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_55 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h37 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_55 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_56 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h38 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_56 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_57 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h39 == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_57 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_58 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3a == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_58 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_59 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3b == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_59 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_60 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3c == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_60 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_61 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3d == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_61 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_62 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3e == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_62 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (reset) begin // @[Cache.scala 110:26]
      dirty_tab_63 <= 1'h0; // @[Cache.scala 110:26]
    end else if (io_in_w_valid) begin // @[Cache.scala 137:23]
      if (io_in_w_bits_op) begin // @[Cache.scala 138:34]
        if (6'h3f == io_in_w_bits_index) begin // @[Cache.scala 143:37]
          dirty_tab_63 <= io_in_w_bits_d; // @[Cache.scala 143:37]
        end
      end
    end
    if (6'h3f == io_in_r_bits_index) begin // @[Cache.scala 122:16]
      result_hi_hi <= tag_tab_63; // @[Cache.scala 122:16]
    end else if (6'h3e == io_in_r_bits_index) begin // @[Cache.scala 122:16]
      result_hi_hi <= tag_tab_62; // @[Cache.scala 122:16]
    end else if (6'h3d == io_in_r_bits_index) begin // @[Cache.scala 122:16]
      result_hi_hi <= tag_tab_61; // @[Cache.scala 122:16]
    end else if (6'h3c == io_in_r_bits_index) begin // @[Cache.scala 122:16]
      result_hi_hi <= tag_tab_60; // @[Cache.scala 122:16]
    end else begin
      result_hi_hi <= _GEN_59;
    end
    if (6'h3f == io_in_r_bits_index) begin // @[Cache.scala 123:18]
      result_hi_lo <= v_tab_63; // @[Cache.scala 123:18]
    end else if (6'h3e == io_in_r_bits_index) begin // @[Cache.scala 123:18]
      result_hi_lo <= v_tab_62; // @[Cache.scala 123:18]
    end else if (6'h3d == io_in_r_bits_index) begin // @[Cache.scala 123:18]
      result_hi_lo <= v_tab_61; // @[Cache.scala 123:18]
    end else if (6'h3c == io_in_r_bits_index) begin // @[Cache.scala 123:18]
      result_hi_lo <= v_tab_60; // @[Cache.scala 123:18]
    end else begin
      result_hi_lo <= _GEN_123;
    end
    if (6'h3f == io_in_r_bits_index) begin // @[Cache.scala 124:18]
      result_lo_hi <= dirty_tab_63; // @[Cache.scala 124:18]
    end else if (6'h3e == io_in_r_bits_index) begin // @[Cache.scala 124:18]
      result_lo_hi <= dirty_tab_62; // @[Cache.scala 124:18]
    end else if (6'h3d == io_in_r_bits_index) begin // @[Cache.scala 124:18]
      result_lo_hi <= dirty_tab_61; // @[Cache.scala 124:18]
    end else if (6'h3c == io_in_r_bits_index) begin // @[Cache.scala 124:18]
      result_lo_hi <= dirty_tab_60; // @[Cache.scala 124:18]
    end else begin
      result_lo_hi <= _GEN_187;
    end
    if (reset) begin // @[Cache.scala 129:26]
      io_out_valid_REG <= 1'h0; // @[Cache.scala 129:26]
    end else begin
      io_out_valid_REG <= io_in_r_valid; // @[Cache.scala 129:26]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  tag_tab_0 = _RAND_0[53:0];
  _RAND_1 = {2{`RANDOM}};
  tag_tab_1 = _RAND_1[53:0];
  _RAND_2 = {2{`RANDOM}};
  tag_tab_2 = _RAND_2[53:0];
  _RAND_3 = {2{`RANDOM}};
  tag_tab_3 = _RAND_3[53:0];
  _RAND_4 = {2{`RANDOM}};
  tag_tab_4 = _RAND_4[53:0];
  _RAND_5 = {2{`RANDOM}};
  tag_tab_5 = _RAND_5[53:0];
  _RAND_6 = {2{`RANDOM}};
  tag_tab_6 = _RAND_6[53:0];
  _RAND_7 = {2{`RANDOM}};
  tag_tab_7 = _RAND_7[53:0];
  _RAND_8 = {2{`RANDOM}};
  tag_tab_8 = _RAND_8[53:0];
  _RAND_9 = {2{`RANDOM}};
  tag_tab_9 = _RAND_9[53:0];
  _RAND_10 = {2{`RANDOM}};
  tag_tab_10 = _RAND_10[53:0];
  _RAND_11 = {2{`RANDOM}};
  tag_tab_11 = _RAND_11[53:0];
  _RAND_12 = {2{`RANDOM}};
  tag_tab_12 = _RAND_12[53:0];
  _RAND_13 = {2{`RANDOM}};
  tag_tab_13 = _RAND_13[53:0];
  _RAND_14 = {2{`RANDOM}};
  tag_tab_14 = _RAND_14[53:0];
  _RAND_15 = {2{`RANDOM}};
  tag_tab_15 = _RAND_15[53:0];
  _RAND_16 = {2{`RANDOM}};
  tag_tab_16 = _RAND_16[53:0];
  _RAND_17 = {2{`RANDOM}};
  tag_tab_17 = _RAND_17[53:0];
  _RAND_18 = {2{`RANDOM}};
  tag_tab_18 = _RAND_18[53:0];
  _RAND_19 = {2{`RANDOM}};
  tag_tab_19 = _RAND_19[53:0];
  _RAND_20 = {2{`RANDOM}};
  tag_tab_20 = _RAND_20[53:0];
  _RAND_21 = {2{`RANDOM}};
  tag_tab_21 = _RAND_21[53:0];
  _RAND_22 = {2{`RANDOM}};
  tag_tab_22 = _RAND_22[53:0];
  _RAND_23 = {2{`RANDOM}};
  tag_tab_23 = _RAND_23[53:0];
  _RAND_24 = {2{`RANDOM}};
  tag_tab_24 = _RAND_24[53:0];
  _RAND_25 = {2{`RANDOM}};
  tag_tab_25 = _RAND_25[53:0];
  _RAND_26 = {2{`RANDOM}};
  tag_tab_26 = _RAND_26[53:0];
  _RAND_27 = {2{`RANDOM}};
  tag_tab_27 = _RAND_27[53:0];
  _RAND_28 = {2{`RANDOM}};
  tag_tab_28 = _RAND_28[53:0];
  _RAND_29 = {2{`RANDOM}};
  tag_tab_29 = _RAND_29[53:0];
  _RAND_30 = {2{`RANDOM}};
  tag_tab_30 = _RAND_30[53:0];
  _RAND_31 = {2{`RANDOM}};
  tag_tab_31 = _RAND_31[53:0];
  _RAND_32 = {2{`RANDOM}};
  tag_tab_32 = _RAND_32[53:0];
  _RAND_33 = {2{`RANDOM}};
  tag_tab_33 = _RAND_33[53:0];
  _RAND_34 = {2{`RANDOM}};
  tag_tab_34 = _RAND_34[53:0];
  _RAND_35 = {2{`RANDOM}};
  tag_tab_35 = _RAND_35[53:0];
  _RAND_36 = {2{`RANDOM}};
  tag_tab_36 = _RAND_36[53:0];
  _RAND_37 = {2{`RANDOM}};
  tag_tab_37 = _RAND_37[53:0];
  _RAND_38 = {2{`RANDOM}};
  tag_tab_38 = _RAND_38[53:0];
  _RAND_39 = {2{`RANDOM}};
  tag_tab_39 = _RAND_39[53:0];
  _RAND_40 = {2{`RANDOM}};
  tag_tab_40 = _RAND_40[53:0];
  _RAND_41 = {2{`RANDOM}};
  tag_tab_41 = _RAND_41[53:0];
  _RAND_42 = {2{`RANDOM}};
  tag_tab_42 = _RAND_42[53:0];
  _RAND_43 = {2{`RANDOM}};
  tag_tab_43 = _RAND_43[53:0];
  _RAND_44 = {2{`RANDOM}};
  tag_tab_44 = _RAND_44[53:0];
  _RAND_45 = {2{`RANDOM}};
  tag_tab_45 = _RAND_45[53:0];
  _RAND_46 = {2{`RANDOM}};
  tag_tab_46 = _RAND_46[53:0];
  _RAND_47 = {2{`RANDOM}};
  tag_tab_47 = _RAND_47[53:0];
  _RAND_48 = {2{`RANDOM}};
  tag_tab_48 = _RAND_48[53:0];
  _RAND_49 = {2{`RANDOM}};
  tag_tab_49 = _RAND_49[53:0];
  _RAND_50 = {2{`RANDOM}};
  tag_tab_50 = _RAND_50[53:0];
  _RAND_51 = {2{`RANDOM}};
  tag_tab_51 = _RAND_51[53:0];
  _RAND_52 = {2{`RANDOM}};
  tag_tab_52 = _RAND_52[53:0];
  _RAND_53 = {2{`RANDOM}};
  tag_tab_53 = _RAND_53[53:0];
  _RAND_54 = {2{`RANDOM}};
  tag_tab_54 = _RAND_54[53:0];
  _RAND_55 = {2{`RANDOM}};
  tag_tab_55 = _RAND_55[53:0];
  _RAND_56 = {2{`RANDOM}};
  tag_tab_56 = _RAND_56[53:0];
  _RAND_57 = {2{`RANDOM}};
  tag_tab_57 = _RAND_57[53:0];
  _RAND_58 = {2{`RANDOM}};
  tag_tab_58 = _RAND_58[53:0];
  _RAND_59 = {2{`RANDOM}};
  tag_tab_59 = _RAND_59[53:0];
  _RAND_60 = {2{`RANDOM}};
  tag_tab_60 = _RAND_60[53:0];
  _RAND_61 = {2{`RANDOM}};
  tag_tab_61 = _RAND_61[53:0];
  _RAND_62 = {2{`RANDOM}};
  tag_tab_62 = _RAND_62[53:0];
  _RAND_63 = {2{`RANDOM}};
  tag_tab_63 = _RAND_63[53:0];
  _RAND_64 = {1{`RANDOM}};
  v_tab_0 = _RAND_64[0:0];
  _RAND_65 = {1{`RANDOM}};
  v_tab_1 = _RAND_65[0:0];
  _RAND_66 = {1{`RANDOM}};
  v_tab_2 = _RAND_66[0:0];
  _RAND_67 = {1{`RANDOM}};
  v_tab_3 = _RAND_67[0:0];
  _RAND_68 = {1{`RANDOM}};
  v_tab_4 = _RAND_68[0:0];
  _RAND_69 = {1{`RANDOM}};
  v_tab_5 = _RAND_69[0:0];
  _RAND_70 = {1{`RANDOM}};
  v_tab_6 = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  v_tab_7 = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  v_tab_8 = _RAND_72[0:0];
  _RAND_73 = {1{`RANDOM}};
  v_tab_9 = _RAND_73[0:0];
  _RAND_74 = {1{`RANDOM}};
  v_tab_10 = _RAND_74[0:0];
  _RAND_75 = {1{`RANDOM}};
  v_tab_11 = _RAND_75[0:0];
  _RAND_76 = {1{`RANDOM}};
  v_tab_12 = _RAND_76[0:0];
  _RAND_77 = {1{`RANDOM}};
  v_tab_13 = _RAND_77[0:0];
  _RAND_78 = {1{`RANDOM}};
  v_tab_14 = _RAND_78[0:0];
  _RAND_79 = {1{`RANDOM}};
  v_tab_15 = _RAND_79[0:0];
  _RAND_80 = {1{`RANDOM}};
  v_tab_16 = _RAND_80[0:0];
  _RAND_81 = {1{`RANDOM}};
  v_tab_17 = _RAND_81[0:0];
  _RAND_82 = {1{`RANDOM}};
  v_tab_18 = _RAND_82[0:0];
  _RAND_83 = {1{`RANDOM}};
  v_tab_19 = _RAND_83[0:0];
  _RAND_84 = {1{`RANDOM}};
  v_tab_20 = _RAND_84[0:0];
  _RAND_85 = {1{`RANDOM}};
  v_tab_21 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  v_tab_22 = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  v_tab_23 = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  v_tab_24 = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  v_tab_25 = _RAND_89[0:0];
  _RAND_90 = {1{`RANDOM}};
  v_tab_26 = _RAND_90[0:0];
  _RAND_91 = {1{`RANDOM}};
  v_tab_27 = _RAND_91[0:0];
  _RAND_92 = {1{`RANDOM}};
  v_tab_28 = _RAND_92[0:0];
  _RAND_93 = {1{`RANDOM}};
  v_tab_29 = _RAND_93[0:0];
  _RAND_94 = {1{`RANDOM}};
  v_tab_30 = _RAND_94[0:0];
  _RAND_95 = {1{`RANDOM}};
  v_tab_31 = _RAND_95[0:0];
  _RAND_96 = {1{`RANDOM}};
  v_tab_32 = _RAND_96[0:0];
  _RAND_97 = {1{`RANDOM}};
  v_tab_33 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  v_tab_34 = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  v_tab_35 = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  v_tab_36 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  v_tab_37 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  v_tab_38 = _RAND_102[0:0];
  _RAND_103 = {1{`RANDOM}};
  v_tab_39 = _RAND_103[0:0];
  _RAND_104 = {1{`RANDOM}};
  v_tab_40 = _RAND_104[0:0];
  _RAND_105 = {1{`RANDOM}};
  v_tab_41 = _RAND_105[0:0];
  _RAND_106 = {1{`RANDOM}};
  v_tab_42 = _RAND_106[0:0];
  _RAND_107 = {1{`RANDOM}};
  v_tab_43 = _RAND_107[0:0];
  _RAND_108 = {1{`RANDOM}};
  v_tab_44 = _RAND_108[0:0];
  _RAND_109 = {1{`RANDOM}};
  v_tab_45 = _RAND_109[0:0];
  _RAND_110 = {1{`RANDOM}};
  v_tab_46 = _RAND_110[0:0];
  _RAND_111 = {1{`RANDOM}};
  v_tab_47 = _RAND_111[0:0];
  _RAND_112 = {1{`RANDOM}};
  v_tab_48 = _RAND_112[0:0];
  _RAND_113 = {1{`RANDOM}};
  v_tab_49 = _RAND_113[0:0];
  _RAND_114 = {1{`RANDOM}};
  v_tab_50 = _RAND_114[0:0];
  _RAND_115 = {1{`RANDOM}};
  v_tab_51 = _RAND_115[0:0];
  _RAND_116 = {1{`RANDOM}};
  v_tab_52 = _RAND_116[0:0];
  _RAND_117 = {1{`RANDOM}};
  v_tab_53 = _RAND_117[0:0];
  _RAND_118 = {1{`RANDOM}};
  v_tab_54 = _RAND_118[0:0];
  _RAND_119 = {1{`RANDOM}};
  v_tab_55 = _RAND_119[0:0];
  _RAND_120 = {1{`RANDOM}};
  v_tab_56 = _RAND_120[0:0];
  _RAND_121 = {1{`RANDOM}};
  v_tab_57 = _RAND_121[0:0];
  _RAND_122 = {1{`RANDOM}};
  v_tab_58 = _RAND_122[0:0];
  _RAND_123 = {1{`RANDOM}};
  v_tab_59 = _RAND_123[0:0];
  _RAND_124 = {1{`RANDOM}};
  v_tab_60 = _RAND_124[0:0];
  _RAND_125 = {1{`RANDOM}};
  v_tab_61 = _RAND_125[0:0];
  _RAND_126 = {1{`RANDOM}};
  v_tab_62 = _RAND_126[0:0];
  _RAND_127 = {1{`RANDOM}};
  v_tab_63 = _RAND_127[0:0];
  _RAND_128 = {1{`RANDOM}};
  dirty_tab_0 = _RAND_128[0:0];
  _RAND_129 = {1{`RANDOM}};
  dirty_tab_1 = _RAND_129[0:0];
  _RAND_130 = {1{`RANDOM}};
  dirty_tab_2 = _RAND_130[0:0];
  _RAND_131 = {1{`RANDOM}};
  dirty_tab_3 = _RAND_131[0:0];
  _RAND_132 = {1{`RANDOM}};
  dirty_tab_4 = _RAND_132[0:0];
  _RAND_133 = {1{`RANDOM}};
  dirty_tab_5 = _RAND_133[0:0];
  _RAND_134 = {1{`RANDOM}};
  dirty_tab_6 = _RAND_134[0:0];
  _RAND_135 = {1{`RANDOM}};
  dirty_tab_7 = _RAND_135[0:0];
  _RAND_136 = {1{`RANDOM}};
  dirty_tab_8 = _RAND_136[0:0];
  _RAND_137 = {1{`RANDOM}};
  dirty_tab_9 = _RAND_137[0:0];
  _RAND_138 = {1{`RANDOM}};
  dirty_tab_10 = _RAND_138[0:0];
  _RAND_139 = {1{`RANDOM}};
  dirty_tab_11 = _RAND_139[0:0];
  _RAND_140 = {1{`RANDOM}};
  dirty_tab_12 = _RAND_140[0:0];
  _RAND_141 = {1{`RANDOM}};
  dirty_tab_13 = _RAND_141[0:0];
  _RAND_142 = {1{`RANDOM}};
  dirty_tab_14 = _RAND_142[0:0];
  _RAND_143 = {1{`RANDOM}};
  dirty_tab_15 = _RAND_143[0:0];
  _RAND_144 = {1{`RANDOM}};
  dirty_tab_16 = _RAND_144[0:0];
  _RAND_145 = {1{`RANDOM}};
  dirty_tab_17 = _RAND_145[0:0];
  _RAND_146 = {1{`RANDOM}};
  dirty_tab_18 = _RAND_146[0:0];
  _RAND_147 = {1{`RANDOM}};
  dirty_tab_19 = _RAND_147[0:0];
  _RAND_148 = {1{`RANDOM}};
  dirty_tab_20 = _RAND_148[0:0];
  _RAND_149 = {1{`RANDOM}};
  dirty_tab_21 = _RAND_149[0:0];
  _RAND_150 = {1{`RANDOM}};
  dirty_tab_22 = _RAND_150[0:0];
  _RAND_151 = {1{`RANDOM}};
  dirty_tab_23 = _RAND_151[0:0];
  _RAND_152 = {1{`RANDOM}};
  dirty_tab_24 = _RAND_152[0:0];
  _RAND_153 = {1{`RANDOM}};
  dirty_tab_25 = _RAND_153[0:0];
  _RAND_154 = {1{`RANDOM}};
  dirty_tab_26 = _RAND_154[0:0];
  _RAND_155 = {1{`RANDOM}};
  dirty_tab_27 = _RAND_155[0:0];
  _RAND_156 = {1{`RANDOM}};
  dirty_tab_28 = _RAND_156[0:0];
  _RAND_157 = {1{`RANDOM}};
  dirty_tab_29 = _RAND_157[0:0];
  _RAND_158 = {1{`RANDOM}};
  dirty_tab_30 = _RAND_158[0:0];
  _RAND_159 = {1{`RANDOM}};
  dirty_tab_31 = _RAND_159[0:0];
  _RAND_160 = {1{`RANDOM}};
  dirty_tab_32 = _RAND_160[0:0];
  _RAND_161 = {1{`RANDOM}};
  dirty_tab_33 = _RAND_161[0:0];
  _RAND_162 = {1{`RANDOM}};
  dirty_tab_34 = _RAND_162[0:0];
  _RAND_163 = {1{`RANDOM}};
  dirty_tab_35 = _RAND_163[0:0];
  _RAND_164 = {1{`RANDOM}};
  dirty_tab_36 = _RAND_164[0:0];
  _RAND_165 = {1{`RANDOM}};
  dirty_tab_37 = _RAND_165[0:0];
  _RAND_166 = {1{`RANDOM}};
  dirty_tab_38 = _RAND_166[0:0];
  _RAND_167 = {1{`RANDOM}};
  dirty_tab_39 = _RAND_167[0:0];
  _RAND_168 = {1{`RANDOM}};
  dirty_tab_40 = _RAND_168[0:0];
  _RAND_169 = {1{`RANDOM}};
  dirty_tab_41 = _RAND_169[0:0];
  _RAND_170 = {1{`RANDOM}};
  dirty_tab_42 = _RAND_170[0:0];
  _RAND_171 = {1{`RANDOM}};
  dirty_tab_43 = _RAND_171[0:0];
  _RAND_172 = {1{`RANDOM}};
  dirty_tab_44 = _RAND_172[0:0];
  _RAND_173 = {1{`RANDOM}};
  dirty_tab_45 = _RAND_173[0:0];
  _RAND_174 = {1{`RANDOM}};
  dirty_tab_46 = _RAND_174[0:0];
  _RAND_175 = {1{`RANDOM}};
  dirty_tab_47 = _RAND_175[0:0];
  _RAND_176 = {1{`RANDOM}};
  dirty_tab_48 = _RAND_176[0:0];
  _RAND_177 = {1{`RANDOM}};
  dirty_tab_49 = _RAND_177[0:0];
  _RAND_178 = {1{`RANDOM}};
  dirty_tab_50 = _RAND_178[0:0];
  _RAND_179 = {1{`RANDOM}};
  dirty_tab_51 = _RAND_179[0:0];
  _RAND_180 = {1{`RANDOM}};
  dirty_tab_52 = _RAND_180[0:0];
  _RAND_181 = {1{`RANDOM}};
  dirty_tab_53 = _RAND_181[0:0];
  _RAND_182 = {1{`RANDOM}};
  dirty_tab_54 = _RAND_182[0:0];
  _RAND_183 = {1{`RANDOM}};
  dirty_tab_55 = _RAND_183[0:0];
  _RAND_184 = {1{`RANDOM}};
  dirty_tab_56 = _RAND_184[0:0];
  _RAND_185 = {1{`RANDOM}};
  dirty_tab_57 = _RAND_185[0:0];
  _RAND_186 = {1{`RANDOM}};
  dirty_tab_58 = _RAND_186[0:0];
  _RAND_187 = {1{`RANDOM}};
  dirty_tab_59 = _RAND_187[0:0];
  _RAND_188 = {1{`RANDOM}};
  dirty_tab_60 = _RAND_188[0:0];
  _RAND_189 = {1{`RANDOM}};
  dirty_tab_61 = _RAND_189[0:0];
  _RAND_190 = {1{`RANDOM}};
  dirty_tab_62 = _RAND_190[0:0];
  _RAND_191 = {1{`RANDOM}};
  dirty_tab_63 = _RAND_191[0:0];
  _RAND_192 = {2{`RANDOM}};
  result_hi_hi = _RAND_192[53:0];
  _RAND_193 = {1{`RANDOM}};
  result_hi_lo = _RAND_193[0:0];
  _RAND_194 = {1{`RANDOM}};
  result_lo_hi = _RAND_194[0:0];
  _RAND_195 = {1{`RANDOM}};
  io_out_valid_REG = _RAND_195[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_210013_MaxPeriodFibonacciLFSR(
  input   clock,
  input   reset,
  output  io_out_0,
  output  io_out_1,
  output  io_out_2,
  output  io_out_3,
  output  io_out_4,
  output  io_out_5,
  output  io_out_6,
  output  io_out_7,
  output  io_out_8,
  output  io_out_9,
  output  io_out_10,
  output  io_out_11,
  output  io_out_12,
  output  io_out_13,
  output  io_out_14,
  output  io_out_15,
  output  io_out_16,
  output  io_out_17,
  output  io_out_18,
  output  io_out_19,
  output  io_out_20,
  output  io_out_21,
  output  io_out_22,
  output  io_out_23,
  output  io_out_24,
  output  io_out_25,
  output  io_out_26,
  output  io_out_27,
  output  io_out_28,
  output  io_out_29,
  output  io_out_30,
  output  io_out_31,
  output  io_out_32,
  output  io_out_33,
  output  io_out_34,
  output  io_out_35,
  output  io_out_36,
  output  io_out_37,
  output  io_out_38,
  output  io_out_39,
  output  io_out_40,
  output  io_out_41,
  output  io_out_42,
  output  io_out_43,
  output  io_out_44,
  output  io_out_45,
  output  io_out_46,
  output  io_out_47,
  output  io_out_48,
  output  io_out_49,
  output  io_out_50,
  output  io_out_51,
  output  io_out_52,
  output  io_out_53,
  output  io_out_54,
  output  io_out_55,
  output  io_out_56,
  output  io_out_57,
  output  io_out_58,
  output  io_out_59,
  output  io_out_60,
  output  io_out_61,
  output  io_out_62,
  output  io_out_63,
  output  io_out_64,
  output  io_out_65,
  output  io_out_66,
  output  io_out_67,
  output  io_out_68,
  output  io_out_69,
  output  io_out_70,
  output  io_out_71,
  output  io_out_72,
  output  io_out_73,
  output  io_out_74,
  output  io_out_75,
  output  io_out_76,
  output  io_out_77,
  output  io_out_78,
  output  io_out_79,
  output  io_out_80,
  output  io_out_81,
  output  io_out_82,
  output  io_out_83,
  output  io_out_84,
  output  io_out_85,
  output  io_out_86,
  output  io_out_87,
  output  io_out_88,
  output  io_out_89,
  output  io_out_90,
  output  io_out_91,
  output  io_out_92,
  output  io_out_93,
  output  io_out_94,
  output  io_out_95,
  output  io_out_96,
  output  io_out_97,
  output  io_out_98,
  output  io_out_99,
  output  io_out_100,
  output  io_out_101,
  output  io_out_102,
  output  io_out_103,
  output  io_out_104,
  output  io_out_105,
  output  io_out_106,
  output  io_out_107,
  output  io_out_108,
  output  io_out_109,
  output  io_out_110,
  output  io_out_111,
  output  io_out_112,
  output  io_out_113,
  output  io_out_114,
  output  io_out_115,
  output  io_out_116,
  output  io_out_117,
  output  io_out_118,
  output  io_out_119,
  output  io_out_120,
  output  io_out_121,
  output  io_out_122,
  output  io_out_123,
  output  io_out_124,
  output  io_out_125,
  output  io_out_126,
  output  io_out_127
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
`endif // RANDOMIZE_REG_INIT
  reg  state_0; // @[PRNG.scala 47:50]
  reg  state_1; // @[PRNG.scala 47:50]
  reg  state_2; // @[PRNG.scala 47:50]
  reg  state_3; // @[PRNG.scala 47:50]
  reg  state_4; // @[PRNG.scala 47:50]
  reg  state_5; // @[PRNG.scala 47:50]
  reg  state_6; // @[PRNG.scala 47:50]
  reg  state_7; // @[PRNG.scala 47:50]
  reg  state_8; // @[PRNG.scala 47:50]
  reg  state_9; // @[PRNG.scala 47:50]
  reg  state_10; // @[PRNG.scala 47:50]
  reg  state_11; // @[PRNG.scala 47:50]
  reg  state_12; // @[PRNG.scala 47:50]
  reg  state_13; // @[PRNG.scala 47:50]
  reg  state_14; // @[PRNG.scala 47:50]
  reg  state_15; // @[PRNG.scala 47:50]
  reg  state_16; // @[PRNG.scala 47:50]
  reg  state_17; // @[PRNG.scala 47:50]
  reg  state_18; // @[PRNG.scala 47:50]
  reg  state_19; // @[PRNG.scala 47:50]
  reg  state_20; // @[PRNG.scala 47:50]
  reg  state_21; // @[PRNG.scala 47:50]
  reg  state_22; // @[PRNG.scala 47:50]
  reg  state_23; // @[PRNG.scala 47:50]
  reg  state_24; // @[PRNG.scala 47:50]
  reg  state_25; // @[PRNG.scala 47:50]
  reg  state_26; // @[PRNG.scala 47:50]
  reg  state_27; // @[PRNG.scala 47:50]
  reg  state_28; // @[PRNG.scala 47:50]
  reg  state_29; // @[PRNG.scala 47:50]
  reg  state_30; // @[PRNG.scala 47:50]
  reg  state_31; // @[PRNG.scala 47:50]
  reg  state_32; // @[PRNG.scala 47:50]
  reg  state_33; // @[PRNG.scala 47:50]
  reg  state_34; // @[PRNG.scala 47:50]
  reg  state_35; // @[PRNG.scala 47:50]
  reg  state_36; // @[PRNG.scala 47:50]
  reg  state_37; // @[PRNG.scala 47:50]
  reg  state_38; // @[PRNG.scala 47:50]
  reg  state_39; // @[PRNG.scala 47:50]
  reg  state_40; // @[PRNG.scala 47:50]
  reg  state_41; // @[PRNG.scala 47:50]
  reg  state_42; // @[PRNG.scala 47:50]
  reg  state_43; // @[PRNG.scala 47:50]
  reg  state_44; // @[PRNG.scala 47:50]
  reg  state_45; // @[PRNG.scala 47:50]
  reg  state_46; // @[PRNG.scala 47:50]
  reg  state_47; // @[PRNG.scala 47:50]
  reg  state_48; // @[PRNG.scala 47:50]
  reg  state_49; // @[PRNG.scala 47:50]
  reg  state_50; // @[PRNG.scala 47:50]
  reg  state_51; // @[PRNG.scala 47:50]
  reg  state_52; // @[PRNG.scala 47:50]
  reg  state_53; // @[PRNG.scala 47:50]
  reg  state_54; // @[PRNG.scala 47:50]
  reg  state_55; // @[PRNG.scala 47:50]
  reg  state_56; // @[PRNG.scala 47:50]
  reg  state_57; // @[PRNG.scala 47:50]
  reg  state_58; // @[PRNG.scala 47:50]
  reg  state_59; // @[PRNG.scala 47:50]
  reg  state_60; // @[PRNG.scala 47:50]
  reg  state_61; // @[PRNG.scala 47:50]
  reg  state_62; // @[PRNG.scala 47:50]
  reg  state_63; // @[PRNG.scala 47:50]
  reg  state_64; // @[PRNG.scala 47:50]
  reg  state_65; // @[PRNG.scala 47:50]
  reg  state_66; // @[PRNG.scala 47:50]
  reg  state_67; // @[PRNG.scala 47:50]
  reg  state_68; // @[PRNG.scala 47:50]
  reg  state_69; // @[PRNG.scala 47:50]
  reg  state_70; // @[PRNG.scala 47:50]
  reg  state_71; // @[PRNG.scala 47:50]
  reg  state_72; // @[PRNG.scala 47:50]
  reg  state_73; // @[PRNG.scala 47:50]
  reg  state_74; // @[PRNG.scala 47:50]
  reg  state_75; // @[PRNG.scala 47:50]
  reg  state_76; // @[PRNG.scala 47:50]
  reg  state_77; // @[PRNG.scala 47:50]
  reg  state_78; // @[PRNG.scala 47:50]
  reg  state_79; // @[PRNG.scala 47:50]
  reg  state_80; // @[PRNG.scala 47:50]
  reg  state_81; // @[PRNG.scala 47:50]
  reg  state_82; // @[PRNG.scala 47:50]
  reg  state_83; // @[PRNG.scala 47:50]
  reg  state_84; // @[PRNG.scala 47:50]
  reg  state_85; // @[PRNG.scala 47:50]
  reg  state_86; // @[PRNG.scala 47:50]
  reg  state_87; // @[PRNG.scala 47:50]
  reg  state_88; // @[PRNG.scala 47:50]
  reg  state_89; // @[PRNG.scala 47:50]
  reg  state_90; // @[PRNG.scala 47:50]
  reg  state_91; // @[PRNG.scala 47:50]
  reg  state_92; // @[PRNG.scala 47:50]
  reg  state_93; // @[PRNG.scala 47:50]
  reg  state_94; // @[PRNG.scala 47:50]
  reg  state_95; // @[PRNG.scala 47:50]
  reg  state_96; // @[PRNG.scala 47:50]
  reg  state_97; // @[PRNG.scala 47:50]
  reg  state_98; // @[PRNG.scala 47:50]
  reg  state_99; // @[PRNG.scala 47:50]
  reg  state_100; // @[PRNG.scala 47:50]
  reg  state_101; // @[PRNG.scala 47:50]
  reg  state_102; // @[PRNG.scala 47:50]
  reg  state_103; // @[PRNG.scala 47:50]
  reg  state_104; // @[PRNG.scala 47:50]
  reg  state_105; // @[PRNG.scala 47:50]
  reg  state_106; // @[PRNG.scala 47:50]
  reg  state_107; // @[PRNG.scala 47:50]
  reg  state_108; // @[PRNG.scala 47:50]
  reg  state_109; // @[PRNG.scala 47:50]
  reg  state_110; // @[PRNG.scala 47:50]
  reg  state_111; // @[PRNG.scala 47:50]
  reg  state_112; // @[PRNG.scala 47:50]
  reg  state_113; // @[PRNG.scala 47:50]
  reg  state_114; // @[PRNG.scala 47:50]
  reg  state_115; // @[PRNG.scala 47:50]
  reg  state_116; // @[PRNG.scala 47:50]
  reg  state_117; // @[PRNG.scala 47:50]
  reg  state_118; // @[PRNG.scala 47:50]
  reg  state_119; // @[PRNG.scala 47:50]
  reg  state_120; // @[PRNG.scala 47:50]
  reg  state_121; // @[PRNG.scala 47:50]
  reg  state_122; // @[PRNG.scala 47:50]
  reg  state_123; // @[PRNG.scala 47:50]
  reg  state_124; // @[PRNG.scala 47:50]
  reg  state_125; // @[PRNG.scala 47:50]
  reg  state_126; // @[PRNG.scala 47:50]
  reg  state_127; // @[PRNG.scala 47:50]
  wire  _T_2 = state_127 ^ state_126 ^ state_125 ^ state_120; // @[LFSR.scala 15:41]
  assign io_out_0 = state_0; // @[PRNG.scala 69:10]
  assign io_out_1 = state_1; // @[PRNG.scala 69:10]
  assign io_out_2 = state_2; // @[PRNG.scala 69:10]
  assign io_out_3 = state_3; // @[PRNG.scala 69:10]
  assign io_out_4 = state_4; // @[PRNG.scala 69:10]
  assign io_out_5 = state_5; // @[PRNG.scala 69:10]
  assign io_out_6 = state_6; // @[PRNG.scala 69:10]
  assign io_out_7 = state_7; // @[PRNG.scala 69:10]
  assign io_out_8 = state_8; // @[PRNG.scala 69:10]
  assign io_out_9 = state_9; // @[PRNG.scala 69:10]
  assign io_out_10 = state_10; // @[PRNG.scala 69:10]
  assign io_out_11 = state_11; // @[PRNG.scala 69:10]
  assign io_out_12 = state_12; // @[PRNG.scala 69:10]
  assign io_out_13 = state_13; // @[PRNG.scala 69:10]
  assign io_out_14 = state_14; // @[PRNG.scala 69:10]
  assign io_out_15 = state_15; // @[PRNG.scala 69:10]
  assign io_out_16 = state_16; // @[PRNG.scala 69:10]
  assign io_out_17 = state_17; // @[PRNG.scala 69:10]
  assign io_out_18 = state_18; // @[PRNG.scala 69:10]
  assign io_out_19 = state_19; // @[PRNG.scala 69:10]
  assign io_out_20 = state_20; // @[PRNG.scala 69:10]
  assign io_out_21 = state_21; // @[PRNG.scala 69:10]
  assign io_out_22 = state_22; // @[PRNG.scala 69:10]
  assign io_out_23 = state_23; // @[PRNG.scala 69:10]
  assign io_out_24 = state_24; // @[PRNG.scala 69:10]
  assign io_out_25 = state_25; // @[PRNG.scala 69:10]
  assign io_out_26 = state_26; // @[PRNG.scala 69:10]
  assign io_out_27 = state_27; // @[PRNG.scala 69:10]
  assign io_out_28 = state_28; // @[PRNG.scala 69:10]
  assign io_out_29 = state_29; // @[PRNG.scala 69:10]
  assign io_out_30 = state_30; // @[PRNG.scala 69:10]
  assign io_out_31 = state_31; // @[PRNG.scala 69:10]
  assign io_out_32 = state_32; // @[PRNG.scala 69:10]
  assign io_out_33 = state_33; // @[PRNG.scala 69:10]
  assign io_out_34 = state_34; // @[PRNG.scala 69:10]
  assign io_out_35 = state_35; // @[PRNG.scala 69:10]
  assign io_out_36 = state_36; // @[PRNG.scala 69:10]
  assign io_out_37 = state_37; // @[PRNG.scala 69:10]
  assign io_out_38 = state_38; // @[PRNG.scala 69:10]
  assign io_out_39 = state_39; // @[PRNG.scala 69:10]
  assign io_out_40 = state_40; // @[PRNG.scala 69:10]
  assign io_out_41 = state_41; // @[PRNG.scala 69:10]
  assign io_out_42 = state_42; // @[PRNG.scala 69:10]
  assign io_out_43 = state_43; // @[PRNG.scala 69:10]
  assign io_out_44 = state_44; // @[PRNG.scala 69:10]
  assign io_out_45 = state_45; // @[PRNG.scala 69:10]
  assign io_out_46 = state_46; // @[PRNG.scala 69:10]
  assign io_out_47 = state_47; // @[PRNG.scala 69:10]
  assign io_out_48 = state_48; // @[PRNG.scala 69:10]
  assign io_out_49 = state_49; // @[PRNG.scala 69:10]
  assign io_out_50 = state_50; // @[PRNG.scala 69:10]
  assign io_out_51 = state_51; // @[PRNG.scala 69:10]
  assign io_out_52 = state_52; // @[PRNG.scala 69:10]
  assign io_out_53 = state_53; // @[PRNG.scala 69:10]
  assign io_out_54 = state_54; // @[PRNG.scala 69:10]
  assign io_out_55 = state_55; // @[PRNG.scala 69:10]
  assign io_out_56 = state_56; // @[PRNG.scala 69:10]
  assign io_out_57 = state_57; // @[PRNG.scala 69:10]
  assign io_out_58 = state_58; // @[PRNG.scala 69:10]
  assign io_out_59 = state_59; // @[PRNG.scala 69:10]
  assign io_out_60 = state_60; // @[PRNG.scala 69:10]
  assign io_out_61 = state_61; // @[PRNG.scala 69:10]
  assign io_out_62 = state_62; // @[PRNG.scala 69:10]
  assign io_out_63 = state_63; // @[PRNG.scala 69:10]
  assign io_out_64 = state_64; // @[PRNG.scala 69:10]
  assign io_out_65 = state_65; // @[PRNG.scala 69:10]
  assign io_out_66 = state_66; // @[PRNG.scala 69:10]
  assign io_out_67 = state_67; // @[PRNG.scala 69:10]
  assign io_out_68 = state_68; // @[PRNG.scala 69:10]
  assign io_out_69 = state_69; // @[PRNG.scala 69:10]
  assign io_out_70 = state_70; // @[PRNG.scala 69:10]
  assign io_out_71 = state_71; // @[PRNG.scala 69:10]
  assign io_out_72 = state_72; // @[PRNG.scala 69:10]
  assign io_out_73 = state_73; // @[PRNG.scala 69:10]
  assign io_out_74 = state_74; // @[PRNG.scala 69:10]
  assign io_out_75 = state_75; // @[PRNG.scala 69:10]
  assign io_out_76 = state_76; // @[PRNG.scala 69:10]
  assign io_out_77 = state_77; // @[PRNG.scala 69:10]
  assign io_out_78 = state_78; // @[PRNG.scala 69:10]
  assign io_out_79 = state_79; // @[PRNG.scala 69:10]
  assign io_out_80 = state_80; // @[PRNG.scala 69:10]
  assign io_out_81 = state_81; // @[PRNG.scala 69:10]
  assign io_out_82 = state_82; // @[PRNG.scala 69:10]
  assign io_out_83 = state_83; // @[PRNG.scala 69:10]
  assign io_out_84 = state_84; // @[PRNG.scala 69:10]
  assign io_out_85 = state_85; // @[PRNG.scala 69:10]
  assign io_out_86 = state_86; // @[PRNG.scala 69:10]
  assign io_out_87 = state_87; // @[PRNG.scala 69:10]
  assign io_out_88 = state_88; // @[PRNG.scala 69:10]
  assign io_out_89 = state_89; // @[PRNG.scala 69:10]
  assign io_out_90 = state_90; // @[PRNG.scala 69:10]
  assign io_out_91 = state_91; // @[PRNG.scala 69:10]
  assign io_out_92 = state_92; // @[PRNG.scala 69:10]
  assign io_out_93 = state_93; // @[PRNG.scala 69:10]
  assign io_out_94 = state_94; // @[PRNG.scala 69:10]
  assign io_out_95 = state_95; // @[PRNG.scala 69:10]
  assign io_out_96 = state_96; // @[PRNG.scala 69:10]
  assign io_out_97 = state_97; // @[PRNG.scala 69:10]
  assign io_out_98 = state_98; // @[PRNG.scala 69:10]
  assign io_out_99 = state_99; // @[PRNG.scala 69:10]
  assign io_out_100 = state_100; // @[PRNG.scala 69:10]
  assign io_out_101 = state_101; // @[PRNG.scala 69:10]
  assign io_out_102 = state_102; // @[PRNG.scala 69:10]
  assign io_out_103 = state_103; // @[PRNG.scala 69:10]
  assign io_out_104 = state_104; // @[PRNG.scala 69:10]
  assign io_out_105 = state_105; // @[PRNG.scala 69:10]
  assign io_out_106 = state_106; // @[PRNG.scala 69:10]
  assign io_out_107 = state_107; // @[PRNG.scala 69:10]
  assign io_out_108 = state_108; // @[PRNG.scala 69:10]
  assign io_out_109 = state_109; // @[PRNG.scala 69:10]
  assign io_out_110 = state_110; // @[PRNG.scala 69:10]
  assign io_out_111 = state_111; // @[PRNG.scala 69:10]
  assign io_out_112 = state_112; // @[PRNG.scala 69:10]
  assign io_out_113 = state_113; // @[PRNG.scala 69:10]
  assign io_out_114 = state_114; // @[PRNG.scala 69:10]
  assign io_out_115 = state_115; // @[PRNG.scala 69:10]
  assign io_out_116 = state_116; // @[PRNG.scala 69:10]
  assign io_out_117 = state_117; // @[PRNG.scala 69:10]
  assign io_out_118 = state_118; // @[PRNG.scala 69:10]
  assign io_out_119 = state_119; // @[PRNG.scala 69:10]
  assign io_out_120 = state_120; // @[PRNG.scala 69:10]
  assign io_out_121 = state_121; // @[PRNG.scala 69:10]
  assign io_out_122 = state_122; // @[PRNG.scala 69:10]
  assign io_out_123 = state_123; // @[PRNG.scala 69:10]
  assign io_out_124 = state_124; // @[PRNG.scala 69:10]
  assign io_out_125 = state_125; // @[PRNG.scala 69:10]
  assign io_out_126 = state_126; // @[PRNG.scala 69:10]
  assign io_out_127 = state_127; // @[PRNG.scala 69:10]
  always @(posedge clock) begin
    state_0 <= reset | _T_2; // @[PRNG.scala 47:50 PRNG.scala 47:50]
    state_1 <= reset | state_0; // @[PRNG.scala 47:50 PRNG.scala 47:50]
    if (reset) begin // @[PRNG.scala 47:50]
      state_2 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_2 <= state_1;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_3 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_3 <= state_2;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_4 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_4 <= state_3;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_5 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_5 <= state_4;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_6 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_6 <= state_5;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_7 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_7 <= state_6;
    end
    state_8 <= reset | state_7; // @[PRNG.scala 47:50 PRNG.scala 47:50]
    state_9 <= reset | state_8; // @[PRNG.scala 47:50 PRNG.scala 47:50]
    state_10 <= reset | state_9; // @[PRNG.scala 47:50 PRNG.scala 47:50]
    if (reset) begin // @[PRNG.scala 47:50]
      state_11 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_11 <= state_10;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_12 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_12 <= state_11;
    end
    state_13 <= reset | state_12; // @[PRNG.scala 47:50 PRNG.scala 47:50]
    if (reset) begin // @[PRNG.scala 47:50]
      state_14 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_14 <= state_13;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_15 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_15 <= state_14;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_16 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_16 <= state_15;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_17 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_17 <= state_16;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_18 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_18 <= state_17;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_19 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_19 <= state_18;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_20 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_20 <= state_19;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_21 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_21 <= state_20;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_22 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_22 <= state_21;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_23 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_23 <= state_22;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_24 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_24 <= state_23;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_25 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_25 <= state_24;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_26 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_26 <= state_25;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_27 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_27 <= state_26;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_28 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_28 <= state_27;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_29 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_29 <= state_28;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_30 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_30 <= state_29;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_31 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_31 <= state_30;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_32 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_32 <= state_31;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_33 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_33 <= state_32;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_34 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_34 <= state_33;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_35 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_35 <= state_34;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_36 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_36 <= state_35;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_37 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_37 <= state_36;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_38 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_38 <= state_37;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_39 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_39 <= state_38;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_40 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_40 <= state_39;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_41 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_41 <= state_40;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_42 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_42 <= state_41;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_43 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_43 <= state_42;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_44 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_44 <= state_43;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_45 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_45 <= state_44;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_46 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_46 <= state_45;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_47 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_47 <= state_46;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_48 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_48 <= state_47;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_49 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_49 <= state_48;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_50 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_50 <= state_49;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_51 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_51 <= state_50;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_52 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_52 <= state_51;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_53 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_53 <= state_52;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_54 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_54 <= state_53;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_55 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_55 <= state_54;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_56 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_56 <= state_55;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_57 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_57 <= state_56;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_58 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_58 <= state_57;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_59 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_59 <= state_58;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_60 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_60 <= state_59;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_61 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_61 <= state_60;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_62 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_62 <= state_61;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_63 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_63 <= state_62;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_64 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_64 <= state_63;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_65 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_65 <= state_64;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_66 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_66 <= state_65;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_67 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_67 <= state_66;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_68 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_68 <= state_67;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_69 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_69 <= state_68;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_70 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_70 <= state_69;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_71 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_71 <= state_70;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_72 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_72 <= state_71;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_73 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_73 <= state_72;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_74 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_74 <= state_73;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_75 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_75 <= state_74;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_76 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_76 <= state_75;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_77 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_77 <= state_76;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_78 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_78 <= state_77;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_79 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_79 <= state_78;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_80 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_80 <= state_79;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_81 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_81 <= state_80;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_82 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_82 <= state_81;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_83 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_83 <= state_82;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_84 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_84 <= state_83;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_85 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_85 <= state_84;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_86 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_86 <= state_85;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_87 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_87 <= state_86;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_88 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_88 <= state_87;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_89 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_89 <= state_88;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_90 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_90 <= state_89;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_91 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_91 <= state_90;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_92 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_92 <= state_91;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_93 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_93 <= state_92;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_94 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_94 <= state_93;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_95 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_95 <= state_94;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_96 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_96 <= state_95;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_97 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_97 <= state_96;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_98 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_98 <= state_97;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_99 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_99 <= state_98;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_100 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_100 <= state_99;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_101 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_101 <= state_100;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_102 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_102 <= state_101;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_103 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_103 <= state_102;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_104 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_104 <= state_103;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_105 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_105 <= state_104;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_106 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_106 <= state_105;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_107 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_107 <= state_106;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_108 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_108 <= state_107;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_109 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_109 <= state_108;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_110 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_110 <= state_109;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_111 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_111 <= state_110;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_112 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_112 <= state_111;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_113 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_113 <= state_112;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_114 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_114 <= state_113;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_115 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_115 <= state_114;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_116 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_116 <= state_115;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_117 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_117 <= state_116;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_118 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_118 <= state_117;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_119 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_119 <= state_118;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_120 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_120 <= state_119;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_121 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_121 <= state_120;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_122 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_122 <= state_121;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_123 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_123 <= state_122;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_124 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_124 <= state_123;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_125 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_125 <= state_124;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_126 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_126 <= state_125;
    end
    if (reset) begin // @[PRNG.scala 47:50]
      state_127 <= 1'h0; // @[PRNG.scala 47:50]
    end else begin
      state_127 <= state_126;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  state_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  state_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  state_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  state_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  state_5 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  state_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  state_7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  state_8 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  state_9 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  state_10 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  state_11 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  state_12 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  state_13 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  state_14 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  state_15 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  state_16 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  state_17 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  state_18 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  state_19 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  state_20 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  state_21 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  state_22 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  state_23 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  state_24 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  state_25 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  state_26 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  state_27 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  state_28 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  state_29 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  state_30 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  state_31 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  state_32 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  state_33 = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  state_34 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  state_35 = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  state_36 = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  state_37 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  state_38 = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  state_39 = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  state_40 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  state_41 = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  state_42 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  state_43 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  state_44 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  state_45 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  state_46 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  state_47 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  state_48 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  state_49 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  state_50 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  state_51 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  state_52 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  state_53 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  state_54 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  state_55 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  state_56 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  state_57 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  state_58 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  state_59 = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  state_60 = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  state_61 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  state_62 = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  state_63 = _RAND_63[0:0];
  _RAND_64 = {1{`RANDOM}};
  state_64 = _RAND_64[0:0];
  _RAND_65 = {1{`RANDOM}};
  state_65 = _RAND_65[0:0];
  _RAND_66 = {1{`RANDOM}};
  state_66 = _RAND_66[0:0];
  _RAND_67 = {1{`RANDOM}};
  state_67 = _RAND_67[0:0];
  _RAND_68 = {1{`RANDOM}};
  state_68 = _RAND_68[0:0];
  _RAND_69 = {1{`RANDOM}};
  state_69 = _RAND_69[0:0];
  _RAND_70 = {1{`RANDOM}};
  state_70 = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  state_71 = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  state_72 = _RAND_72[0:0];
  _RAND_73 = {1{`RANDOM}};
  state_73 = _RAND_73[0:0];
  _RAND_74 = {1{`RANDOM}};
  state_74 = _RAND_74[0:0];
  _RAND_75 = {1{`RANDOM}};
  state_75 = _RAND_75[0:0];
  _RAND_76 = {1{`RANDOM}};
  state_76 = _RAND_76[0:0];
  _RAND_77 = {1{`RANDOM}};
  state_77 = _RAND_77[0:0];
  _RAND_78 = {1{`RANDOM}};
  state_78 = _RAND_78[0:0];
  _RAND_79 = {1{`RANDOM}};
  state_79 = _RAND_79[0:0];
  _RAND_80 = {1{`RANDOM}};
  state_80 = _RAND_80[0:0];
  _RAND_81 = {1{`RANDOM}};
  state_81 = _RAND_81[0:0];
  _RAND_82 = {1{`RANDOM}};
  state_82 = _RAND_82[0:0];
  _RAND_83 = {1{`RANDOM}};
  state_83 = _RAND_83[0:0];
  _RAND_84 = {1{`RANDOM}};
  state_84 = _RAND_84[0:0];
  _RAND_85 = {1{`RANDOM}};
  state_85 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  state_86 = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  state_87 = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  state_88 = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  state_89 = _RAND_89[0:0];
  _RAND_90 = {1{`RANDOM}};
  state_90 = _RAND_90[0:0];
  _RAND_91 = {1{`RANDOM}};
  state_91 = _RAND_91[0:0];
  _RAND_92 = {1{`RANDOM}};
  state_92 = _RAND_92[0:0];
  _RAND_93 = {1{`RANDOM}};
  state_93 = _RAND_93[0:0];
  _RAND_94 = {1{`RANDOM}};
  state_94 = _RAND_94[0:0];
  _RAND_95 = {1{`RANDOM}};
  state_95 = _RAND_95[0:0];
  _RAND_96 = {1{`RANDOM}};
  state_96 = _RAND_96[0:0];
  _RAND_97 = {1{`RANDOM}};
  state_97 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  state_98 = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  state_99 = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  state_100 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  state_101 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  state_102 = _RAND_102[0:0];
  _RAND_103 = {1{`RANDOM}};
  state_103 = _RAND_103[0:0];
  _RAND_104 = {1{`RANDOM}};
  state_104 = _RAND_104[0:0];
  _RAND_105 = {1{`RANDOM}};
  state_105 = _RAND_105[0:0];
  _RAND_106 = {1{`RANDOM}};
  state_106 = _RAND_106[0:0];
  _RAND_107 = {1{`RANDOM}};
  state_107 = _RAND_107[0:0];
  _RAND_108 = {1{`RANDOM}};
  state_108 = _RAND_108[0:0];
  _RAND_109 = {1{`RANDOM}};
  state_109 = _RAND_109[0:0];
  _RAND_110 = {1{`RANDOM}};
  state_110 = _RAND_110[0:0];
  _RAND_111 = {1{`RANDOM}};
  state_111 = _RAND_111[0:0];
  _RAND_112 = {1{`RANDOM}};
  state_112 = _RAND_112[0:0];
  _RAND_113 = {1{`RANDOM}};
  state_113 = _RAND_113[0:0];
  _RAND_114 = {1{`RANDOM}};
  state_114 = _RAND_114[0:0];
  _RAND_115 = {1{`RANDOM}};
  state_115 = _RAND_115[0:0];
  _RAND_116 = {1{`RANDOM}};
  state_116 = _RAND_116[0:0];
  _RAND_117 = {1{`RANDOM}};
  state_117 = _RAND_117[0:0];
  _RAND_118 = {1{`RANDOM}};
  state_118 = _RAND_118[0:0];
  _RAND_119 = {1{`RANDOM}};
  state_119 = _RAND_119[0:0];
  _RAND_120 = {1{`RANDOM}};
  state_120 = _RAND_120[0:0];
  _RAND_121 = {1{`RANDOM}};
  state_121 = _RAND_121[0:0];
  _RAND_122 = {1{`RANDOM}};
  state_122 = _RAND_122[0:0];
  _RAND_123 = {1{`RANDOM}};
  state_123 = _RAND_123[0:0];
  _RAND_124 = {1{`RANDOM}};
  state_124 = _RAND_124[0:0];
  _RAND_125 = {1{`RANDOM}};
  state_125 = _RAND_125[0:0];
  _RAND_126 = {1{`RANDOM}};
  state_126 = _RAND_126[0:0];
  _RAND_127 = {1{`RANDOM}};
  state_127 = _RAND_127[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_210013_Cache(
  input         clock,
  input         reset,
  output        io_cpu_req_ready,
  input         io_cpu_req_valid,
  input  [63:0] io_cpu_req_bits_addr,
  input  [63:0] io_cpu_req_bits_data,
  input  [7:0]  io_cpu_req_bits_mask,
  input         io_cpu_req_bits_op,
  output        io_cpu_resp_valid,
  output [63:0] io_cpu_resp_bits_data,
  output [3:0]  io_cpu_resp_bits_cmd,
  input         io_mem_req_ready,
  output        io_mem_req_valid,
  output [63:0] io_mem_req_bits_addr,
  output [63:0] io_mem_req_bits_data,
  output [3:0]  io_mem_req_bits_cmd,
  output [1:0]  io_mem_req_bits_len,
  output [7:0]  io_mem_req_bits_mask,
  output        io_mem_resp_ready,
  input         io_mem_resp_valid,
  input  [63:0] io_mem_resp_bits_data,
  input  [3:0]  io_mem_resp_bits_cmd,
  input         io_fence_i
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [127:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [63:0] _RAND_21;
  reg [63:0] _RAND_22;
  reg [127:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
`endif // RANDOMIZE_REG_INIT
  wire  ways_0_clock; // @[Cache.scala 210:40]
  wire  ways_0_reset; // @[Cache.scala 210:40]
  wire  ways_0_io_out_valid; // @[Cache.scala 210:40]
  wire [53:0] ways_0_io_out_bits_tag; // @[Cache.scala 210:40]
  wire  ways_0_io_out_bits_v; // @[Cache.scala 210:40]
  wire  ways_0_io_out_bits_d; // @[Cache.scala 210:40]
  wire [127:0] ways_0_io_out_bits_datas; // @[Cache.scala 210:40]
  wire  ways_0_io_in_w_valid; // @[Cache.scala 210:40]
  wire [53:0] ways_0_io_in_w_bits_tag; // @[Cache.scala 210:40]
  wire [5:0] ways_0_io_in_w_bits_index; // @[Cache.scala 210:40]
  wire [3:0] ways_0_io_in_w_bits_offset; // @[Cache.scala 210:40]
  wire  ways_0_io_in_w_bits_v; // @[Cache.scala 210:40]
  wire  ways_0_io_in_w_bits_d; // @[Cache.scala 210:40]
  wire [7:0] ways_0_io_in_w_bits_mask; // @[Cache.scala 210:40]
  wire [63:0] ways_0_io_in_w_bits_data; // @[Cache.scala 210:40]
  wire  ways_0_io_in_w_bits_op; // @[Cache.scala 210:40]
  wire  ways_0_io_in_r_valid; // @[Cache.scala 210:40]
  wire [5:0] ways_0_io_in_r_bits_index; // @[Cache.scala 210:40]
  wire  ways_0_io_fence_invalid; // @[Cache.scala 210:40]
  wire  ways_1_clock; // @[Cache.scala 210:40]
  wire  ways_1_reset; // @[Cache.scala 210:40]
  wire  ways_1_io_out_valid; // @[Cache.scala 210:40]
  wire [53:0] ways_1_io_out_bits_tag; // @[Cache.scala 210:40]
  wire  ways_1_io_out_bits_v; // @[Cache.scala 210:40]
  wire  ways_1_io_out_bits_d; // @[Cache.scala 210:40]
  wire [127:0] ways_1_io_out_bits_datas; // @[Cache.scala 210:40]
  wire  ways_1_io_in_w_valid; // @[Cache.scala 210:40]
  wire [53:0] ways_1_io_in_w_bits_tag; // @[Cache.scala 210:40]
  wire [5:0] ways_1_io_in_w_bits_index; // @[Cache.scala 210:40]
  wire [3:0] ways_1_io_in_w_bits_offset; // @[Cache.scala 210:40]
  wire  ways_1_io_in_w_bits_v; // @[Cache.scala 210:40]
  wire  ways_1_io_in_w_bits_d; // @[Cache.scala 210:40]
  wire [7:0] ways_1_io_in_w_bits_mask; // @[Cache.scala 210:40]
  wire [63:0] ways_1_io_in_w_bits_data; // @[Cache.scala 210:40]
  wire  ways_1_io_in_w_bits_op; // @[Cache.scala 210:40]
  wire  ways_1_io_in_r_valid; // @[Cache.scala 210:40]
  wire [5:0] ways_1_io_in_r_bits_index; // @[Cache.scala 210:40]
  wire  ways_1_io_fence_invalid; // @[Cache.scala 210:40]
  wire  ways_2_clock; // @[Cache.scala 210:40]
  wire  ways_2_reset; // @[Cache.scala 210:40]
  wire  ways_2_io_out_valid; // @[Cache.scala 210:40]
  wire [53:0] ways_2_io_out_bits_tag; // @[Cache.scala 210:40]
  wire  ways_2_io_out_bits_v; // @[Cache.scala 210:40]
  wire  ways_2_io_out_bits_d; // @[Cache.scala 210:40]
  wire [127:0] ways_2_io_out_bits_datas; // @[Cache.scala 210:40]
  wire  ways_2_io_in_w_valid; // @[Cache.scala 210:40]
  wire [53:0] ways_2_io_in_w_bits_tag; // @[Cache.scala 210:40]
  wire [5:0] ways_2_io_in_w_bits_index; // @[Cache.scala 210:40]
  wire [3:0] ways_2_io_in_w_bits_offset; // @[Cache.scala 210:40]
  wire  ways_2_io_in_w_bits_v; // @[Cache.scala 210:40]
  wire  ways_2_io_in_w_bits_d; // @[Cache.scala 210:40]
  wire [7:0] ways_2_io_in_w_bits_mask; // @[Cache.scala 210:40]
  wire [63:0] ways_2_io_in_w_bits_data; // @[Cache.scala 210:40]
  wire  ways_2_io_in_w_bits_op; // @[Cache.scala 210:40]
  wire  ways_2_io_in_r_valid; // @[Cache.scala 210:40]
  wire [5:0] ways_2_io_in_r_bits_index; // @[Cache.scala 210:40]
  wire  ways_2_io_fence_invalid; // @[Cache.scala 210:40]
  wire  ways_3_clock; // @[Cache.scala 210:40]
  wire  ways_3_reset; // @[Cache.scala 210:40]
  wire  ways_3_io_out_valid; // @[Cache.scala 210:40]
  wire [53:0] ways_3_io_out_bits_tag; // @[Cache.scala 210:40]
  wire  ways_3_io_out_bits_v; // @[Cache.scala 210:40]
  wire  ways_3_io_out_bits_d; // @[Cache.scala 210:40]
  wire [127:0] ways_3_io_out_bits_datas; // @[Cache.scala 210:40]
  wire  ways_3_io_in_w_valid; // @[Cache.scala 210:40]
  wire [53:0] ways_3_io_in_w_bits_tag; // @[Cache.scala 210:40]
  wire [5:0] ways_3_io_in_w_bits_index; // @[Cache.scala 210:40]
  wire [3:0] ways_3_io_in_w_bits_offset; // @[Cache.scala 210:40]
  wire  ways_3_io_in_w_bits_v; // @[Cache.scala 210:40]
  wire  ways_3_io_in_w_bits_d; // @[Cache.scala 210:40]
  wire [7:0] ways_3_io_in_w_bits_mask; // @[Cache.scala 210:40]
  wire [63:0] ways_3_io_in_w_bits_data; // @[Cache.scala 210:40]
  wire  ways_3_io_in_w_bits_op; // @[Cache.scala 210:40]
  wire  ways_3_io_in_r_valid; // @[Cache.scala 210:40]
  wire [5:0] ways_3_io_in_r_bits_index; // @[Cache.scala 210:40]
  wire  ways_3_io_fence_invalid; // @[Cache.scala 210:40]
  wire  rand_num_prng_clock; // @[PRNG.scala 82:22]
  wire  rand_num_prng_reset; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_0; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_1; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_2; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_3; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_4; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_5; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_6; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_7; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_8; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_9; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_10; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_11; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_12; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_13; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_14; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_15; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_16; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_17; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_18; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_19; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_20; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_21; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_22; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_23; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_24; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_25; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_26; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_27; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_28; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_29; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_30; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_31; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_32; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_33; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_34; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_35; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_36; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_37; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_38; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_39; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_40; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_41; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_42; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_43; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_44; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_45; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_46; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_47; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_48; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_49; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_50; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_51; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_52; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_53; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_54; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_55; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_56; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_57; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_58; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_59; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_60; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_61; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_62; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_63; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_64; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_65; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_66; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_67; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_68; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_69; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_70; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_71; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_72; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_73; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_74; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_75; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_76; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_77; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_78; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_79; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_80; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_81; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_82; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_83; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_84; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_85; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_86; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_87; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_88; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_89; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_90; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_91; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_92; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_93; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_94; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_95; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_96; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_97; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_98; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_99; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_100; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_101; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_102; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_103; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_104; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_105; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_106; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_107; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_108; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_109; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_110; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_111; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_112; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_113; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_114; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_115; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_116; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_117; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_118; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_119; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_120; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_121; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_122; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_123; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_124; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_125; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_126; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_127; // @[PRNG.scala 82:22]
  reg [2:0] state; // @[Cache.scala 214:22]
  reg [7:0] value; // @[Counter.scala 60:40]
  reg  value_1; // @[Counter.scala 60:40]
  reg [53:0] fence_rdata_tag; // @[Cache.scala 220:28]
  reg  fence_rdata_v; // @[Cache.scala 220:28]
  reg  fence_rdata_d; // @[Cache.scala 220:28]
  reg [127:0] fence_rdata_datas; // @[Cache.scala 220:28]
  reg [63:0] req_reg_addr; // @[Cache.scala 226:24]
  reg [63:0] req_reg_data; // @[Cache.scala 226:24]
  reg [7:0] req_reg_mask; // @[Cache.scala 226:24]
  reg  req_reg_op; // @[Cache.scala 226:24]
  reg  req_isCached; // @[Cache.scala 227:29]
  wire [3:0] req_reg_info_offset = req_reg_addr[3:0]; // @[Cache.scala 229:43]
  wire [5:0] req_reg_info_index = req_reg_addr[9:4]; // @[Cache.scala 229:43]
  wire [53:0] req_reg_info_tag = req_reg_addr[63:10]; // @[Cache.scala 229:43]
  reg  write_buffer_valid; // @[Cache.scala 233:29]
  reg [53:0] write_buffer_bits_tag; // @[Cache.scala 233:29]
  reg [5:0] write_buffer_bits_index; // @[Cache.scala 233:29]
  reg [3:0] write_buffer_bits_offset; // @[Cache.scala 233:29]
  reg  write_buffer_bits_v; // @[Cache.scala 233:29]
  reg  write_buffer_bits_d; // @[Cache.scala 233:29]
  reg [63:0] write_buffer_bits_data; // @[Cache.scala 233:29]
  reg [3:0] write_buffer_bits_replace_way; // @[Cache.scala 233:29]
  reg [7:0] write_buffer_bits_wmask; // @[Cache.scala 233:29]
  wire  _conflict_hit_write_T_2 = state == 3'h1; // @[Cache.scala 255:16]
  wire  _conflict_hit_write_T_13 = io_cpu_req_bits_addr[9:4] == req_reg_info_index; // @[Cache.scala 258:55]
  wire  _conflict_hit_write_T_14 = state == 3'h1 & req_reg_op & ~io_cpu_req_bits_op & _conflict_hit_write_T_13; // @[Cache.scala 255:84]
  wire  conflict_hit_write = write_buffer_valid | _conflict_hit_write_T_14; // @[Cache.scala 253:9]
  wire  _ways_0_io_in_r_valid_T = ~conflict_hit_write; // @[Cache.scala 279:50]
  wire  _ways_0_io_in_r_valid_T_2 = state == 3'h5; // @[Cache.scala 285:63]
  wire  _ways_0_io_in_r_valid_T_3 = write_buffer_valid ? 1'h0 : state == 3'h5; // @[Cache.scala 285:31]
  wire [7:0] _GEN_0 = state != 3'h5 & state != 3'h6 ? {{2'd0}, io_cpu_req_bits_addr[9:4]} : value; // @[Cache.scala 274:53 Cache.scala 276:30 Cache.scala 283:30]
  wire [1:0] fence_which_way = value[7:6]; // @[Cache.scala 289:40]
  wire [5:0] fence_which_index = value[5:0]; // @[Cache.scala 290:42]
  wire [127:0] ways_ret_datas_0_datas = ways_0_io_out_bits_datas; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire [127:0] ways_ret_datas_1_datas = ways_1_io_out_bits_datas; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire [127:0] _GEN_10 = 2'h1 == fence_which_way ? ways_ret_datas_1_datas : ways_ret_datas_0_datas; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire [127:0] ways_ret_datas_2_datas = ways_2_io_out_bits_datas; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire [127:0] ways_ret_datas_3_datas = ways_3_io_out_bits_datas; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  ways_ret_datas_0_d = ways_0_io_out_bits_d; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  ways_ret_datas_1_d = ways_1_io_out_bits_d; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  _GEN_14 = 2'h1 == fence_which_way ? ways_ret_datas_1_d : ways_ret_datas_0_d; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire  ways_ret_datas_2_d = ways_2_io_out_bits_d; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  _GEN_15 = 2'h2 == fence_which_way ? ways_ret_datas_2_d : _GEN_14; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire  ways_ret_datas_3_d = ways_3_io_out_bits_d; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  _GEN_16 = 2'h3 == fence_which_way ? ways_ret_datas_3_d : _GEN_15; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire  ways_ret_datas_0_v = ways_0_io_out_bits_v; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  ways_ret_datas_1_v = ways_1_io_out_bits_v; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  _GEN_18 = 2'h1 == fence_which_way ? ways_ret_datas_1_v : ways_ret_datas_0_v; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire  ways_ret_datas_2_v = ways_2_io_out_bits_v; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  _GEN_19 = 2'h2 == fence_which_way ? ways_ret_datas_2_v : _GEN_18; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire  ways_ret_datas_3_v = ways_3_io_out_bits_v; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  _GEN_20 = 2'h3 == fence_which_way ? ways_ret_datas_3_v : _GEN_19; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire [53:0] ways_ret_datas_0_tag = ways_0_io_out_bits_tag; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire [53:0] ways_ret_datas_1_tag = ways_1_io_out_bits_tag; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire [53:0] _GEN_22 = 2'h1 == fence_which_way ? ways_ret_datas_1_tag : ways_ret_datas_0_tag; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire [53:0] ways_ret_datas_2_tag = ways_2_io_out_bits_tag; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire [53:0] _GEN_23 = 2'h2 == fence_which_way ? ways_ret_datas_2_tag : _GEN_22; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire [53:0] ways_ret_datas_3_tag = ways_3_io_out_bits_tag; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire [53:0] tmp_addr_tag = 2'h3 == fence_which_way ? ways_ret_datas_3_tag : _GEN_23; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire  ways_compare_res_hi_hi = ways_0_io_out_bits_tag == req_reg_info_tag & ways_ret_datas_0_v; // @[Cache.scala 300:50]
  wire  ways_compare_res_hi_lo = ways_1_io_out_bits_tag == req_reg_info_tag & ways_ret_datas_1_v; // @[Cache.scala 300:50]
  wire  ways_compare_res_lo_hi = ways_2_io_out_bits_tag == req_reg_info_tag & ways_ret_datas_2_v; // @[Cache.scala 300:50]
  wire  ways_compare_res_lo_lo = ways_3_io_out_bits_tag == req_reg_info_tag & ways_ret_datas_3_v; // @[Cache.scala 300:50]
  wire [3:0] ways_compare_res = {ways_compare_res_hi_hi,ways_compare_res_hi_lo,ways_compare_res_lo_hi,
    ways_compare_res_lo_lo}; // @[Cat.scala 30:58]
  wire  _is_miss_T_3 = ~req_isCached; // @[Cache.scala 304:70]
  wire  is_miss = ~(|ways_compare_res) & req_isCached | ~req_isCached; // @[Cache.scala 304:67]
  wire [127:0] _select_data_T_4 = ways_compare_res[3] ? ways_ret_datas_0_datas : 128'h0; // @[Mux.scala 27:72]
  wire [127:0] _select_data_T_5 = ways_compare_res[2] ? ways_ret_datas_1_datas : 128'h0; // @[Mux.scala 27:72]
  wire [127:0] _select_data_T_6 = ways_compare_res[1] ? ways_ret_datas_2_datas : 128'h0; // @[Mux.scala 27:72]
  wire [127:0] _select_data_T_7 = ways_compare_res[0] ? ways_ret_datas_3_datas : 128'h0; // @[Mux.scala 27:72]
  wire [127:0] _select_data_T_8 = _select_data_T_4 | _select_data_T_5; // @[Mux.scala 27:72]
  wire [127:0] _select_data_T_9 = _select_data_T_8 | _select_data_T_6; // @[Mux.scala 27:72]
  wire [7:0] rand_num_lo_lo_lo_lo = {rand_num_prng_io_out_7,rand_num_prng_io_out_6,rand_num_prng_io_out_5,
    rand_num_prng_io_out_4,rand_num_prng_io_out_3,rand_num_prng_io_out_2,rand_num_prng_io_out_1,rand_num_prng_io_out_0}; // @[PRNG.scala 86:17]
  wire [15:0] rand_num_lo_lo_lo = {rand_num_prng_io_out_15,rand_num_prng_io_out_14,rand_num_prng_io_out_13,
    rand_num_prng_io_out_12,rand_num_prng_io_out_11,rand_num_prng_io_out_10,rand_num_prng_io_out_9,
    rand_num_prng_io_out_8,rand_num_lo_lo_lo_lo}; // @[PRNG.scala 86:17]
  wire [7:0] rand_num_lo_lo_hi_lo = {rand_num_prng_io_out_23,rand_num_prng_io_out_22,rand_num_prng_io_out_21,
    rand_num_prng_io_out_20,rand_num_prng_io_out_19,rand_num_prng_io_out_18,rand_num_prng_io_out_17,
    rand_num_prng_io_out_16}; // @[PRNG.scala 86:17]
  wire [31:0] rand_num_lo_lo = {rand_num_prng_io_out_31,rand_num_prng_io_out_30,rand_num_prng_io_out_29,
    rand_num_prng_io_out_28,rand_num_prng_io_out_27,rand_num_prng_io_out_26,rand_num_prng_io_out_25,
    rand_num_prng_io_out_24,rand_num_lo_lo_hi_lo,rand_num_lo_lo_lo}; // @[PRNG.scala 86:17]
  wire [7:0] rand_num_lo_hi_lo_lo = {rand_num_prng_io_out_39,rand_num_prng_io_out_38,rand_num_prng_io_out_37,
    rand_num_prng_io_out_36,rand_num_prng_io_out_35,rand_num_prng_io_out_34,rand_num_prng_io_out_33,
    rand_num_prng_io_out_32}; // @[PRNG.scala 86:17]
  wire [15:0] rand_num_lo_hi_lo = {rand_num_prng_io_out_47,rand_num_prng_io_out_46,rand_num_prng_io_out_45,
    rand_num_prng_io_out_44,rand_num_prng_io_out_43,rand_num_prng_io_out_42,rand_num_prng_io_out_41,
    rand_num_prng_io_out_40,rand_num_lo_hi_lo_lo}; // @[PRNG.scala 86:17]
  wire [7:0] rand_num_lo_hi_hi_lo = {rand_num_prng_io_out_55,rand_num_prng_io_out_54,rand_num_prng_io_out_53,
    rand_num_prng_io_out_52,rand_num_prng_io_out_51,rand_num_prng_io_out_50,rand_num_prng_io_out_49,
    rand_num_prng_io_out_48}; // @[PRNG.scala 86:17]
  wire [31:0] rand_num_lo_hi = {rand_num_prng_io_out_63,rand_num_prng_io_out_62,rand_num_prng_io_out_61,
    rand_num_prng_io_out_60,rand_num_prng_io_out_59,rand_num_prng_io_out_58,rand_num_prng_io_out_57,
    rand_num_prng_io_out_56,rand_num_lo_hi_hi_lo,rand_num_lo_hi_lo}; // @[PRNG.scala 86:17]
  wire [7:0] rand_num_hi_lo_lo_lo = {rand_num_prng_io_out_71,rand_num_prng_io_out_70,rand_num_prng_io_out_69,
    rand_num_prng_io_out_68,rand_num_prng_io_out_67,rand_num_prng_io_out_66,rand_num_prng_io_out_65,
    rand_num_prng_io_out_64}; // @[PRNG.scala 86:17]
  wire [15:0] rand_num_hi_lo_lo = {rand_num_prng_io_out_79,rand_num_prng_io_out_78,rand_num_prng_io_out_77,
    rand_num_prng_io_out_76,rand_num_prng_io_out_75,rand_num_prng_io_out_74,rand_num_prng_io_out_73,
    rand_num_prng_io_out_72,rand_num_hi_lo_lo_lo}; // @[PRNG.scala 86:17]
  wire [7:0] rand_num_hi_lo_hi_lo = {rand_num_prng_io_out_87,rand_num_prng_io_out_86,rand_num_prng_io_out_85,
    rand_num_prng_io_out_84,rand_num_prng_io_out_83,rand_num_prng_io_out_82,rand_num_prng_io_out_81,
    rand_num_prng_io_out_80}; // @[PRNG.scala 86:17]
  wire [31:0] rand_num_hi_lo = {rand_num_prng_io_out_95,rand_num_prng_io_out_94,rand_num_prng_io_out_93,
    rand_num_prng_io_out_92,rand_num_prng_io_out_91,rand_num_prng_io_out_90,rand_num_prng_io_out_89,
    rand_num_prng_io_out_88,rand_num_hi_lo_hi_lo,rand_num_hi_lo_lo}; // @[PRNG.scala 86:17]
  wire [7:0] rand_num_hi_hi_lo_lo = {rand_num_prng_io_out_103,rand_num_prng_io_out_102,rand_num_prng_io_out_101,
    rand_num_prng_io_out_100,rand_num_prng_io_out_99,rand_num_prng_io_out_98,rand_num_prng_io_out_97,
    rand_num_prng_io_out_96}; // @[PRNG.scala 86:17]
  wire [15:0] rand_num_hi_hi_lo = {rand_num_prng_io_out_111,rand_num_prng_io_out_110,rand_num_prng_io_out_109,
    rand_num_prng_io_out_108,rand_num_prng_io_out_107,rand_num_prng_io_out_106,rand_num_prng_io_out_105,
    rand_num_prng_io_out_104,rand_num_hi_hi_lo_lo}; // @[PRNG.scala 86:17]
  wire [7:0] rand_num_hi_hi_hi_lo = {rand_num_prng_io_out_119,rand_num_prng_io_out_118,rand_num_prng_io_out_117,
    rand_num_prng_io_out_116,rand_num_prng_io_out_115,rand_num_prng_io_out_114,rand_num_prng_io_out_113,
    rand_num_prng_io_out_112}; // @[PRNG.scala 86:17]
  wire [31:0] rand_num_hi_hi = {rand_num_prng_io_out_127,rand_num_prng_io_out_126,rand_num_prng_io_out_125,
    rand_num_prng_io_out_124,rand_num_prng_io_out_123,rand_num_prng_io_out_122,rand_num_prng_io_out_121,
    rand_num_prng_io_out_120,rand_num_hi_hi_hi_lo,rand_num_hi_hi_lo}; // @[PRNG.scala 86:17]
  wire [127:0] _rand_num_T = {rand_num_hi_hi,rand_num_hi_lo,rand_num_lo_hi,rand_num_lo_lo}; // @[PRNG.scala 86:17]
  wire [1:0] rand_num = _rand_num_T[1:0]; // @[Cache.scala 320:46]
  wire [1:0] write_buffer_conflict_with_replace_hi = write_buffer_bits_replace_way[3:2]; // @[OneHot.scala 30:18]
  wire [1:0] write_buffer_conflict_with_replace_lo = write_buffer_bits_replace_way[1:0]; // @[OneHot.scala 31:18]
  wire  write_buffer_conflict_with_replace_hi_1 = |write_buffer_conflict_with_replace_hi; // @[OneHot.scala 32:14]
  wire [1:0] _write_buffer_conflict_with_replace_T = write_buffer_conflict_with_replace_hi |
    write_buffer_conflict_with_replace_lo; // @[OneHot.scala 32:28]
  wire  write_buffer_conflict_with_replace_lo_1 = _write_buffer_conflict_with_replace_T[1]; // @[CircuitMath.scala 30:8]
  wire [1:0] _write_buffer_conflict_with_replace_T_1 = {write_buffer_conflict_with_replace_hi_1,
    write_buffer_conflict_with_replace_lo_1}; // @[Cat.scala 30:58]
  wire  write_buffer_conflict_with_replace = write_buffer_valid & rand_num == _write_buffer_conflict_with_replace_T_1; // @[Cache.scala 321:63]
  wire [1:0] _rand_way_T_1 = rand_num + 2'h1; // @[Cache.scala 322:77]
  wire [1:0] _rand_way_T_3 = write_buffer_conflict_with_replace ? _rand_way_T_1 : rand_num; // @[Cache.scala 322:30]
  wire [3:0] rand_way = 4'h1 << _rand_way_T_3; // @[OneHot.scala 58:35]
  wire [127:0] _rand_way_data_T_4 = rand_way[0] ? ways_ret_datas_0_datas : 128'h0; // @[Mux.scala 27:72]
  wire [127:0] _rand_way_data_T_5 = rand_way[1] ? ways_ret_datas_1_datas : 128'h0; // @[Mux.scala 27:72]
  wire [127:0] _rand_way_data_T_6 = rand_way[2] ? ways_ret_datas_2_datas : 128'h0; // @[Mux.scala 27:72]
  wire [127:0] _rand_way_data_T_7 = rand_way[3] ? ways_ret_datas_3_datas : 128'h0; // @[Mux.scala 27:72]
  wire [127:0] _rand_way_data_T_8 = _rand_way_data_T_4 | _rand_way_data_T_5; // @[Mux.scala 27:72]
  wire [127:0] _rand_way_data_T_9 = _rand_way_data_T_8 | _rand_way_data_T_6; // @[Mux.scala 27:72]
  wire [127:0] rand_way_data_datas = _rand_way_data_T_9 | _rand_way_data_T_7; // @[Mux.scala 27:72]
  wire  rand_way_data_d = rand_way[0] & ways_ret_datas_0_d | rand_way[1] & ways_ret_datas_1_d | rand_way[2] &
    ways_ret_datas_2_d | rand_way[3] & ways_ret_datas_3_d; // @[Mux.scala 27:72]
  wire  rand_way_data_v = rand_way[0] & ways_ret_datas_0_v | rand_way[1] & ways_ret_datas_1_v | rand_way[2] &
    ways_ret_datas_2_v | rand_way[3] & ways_ret_datas_3_v; // @[Mux.scala 27:72]
  wire [53:0] _rand_way_data_T_25 = rand_way[0] ? ways_ret_datas_0_tag : 54'h0; // @[Mux.scala 27:72]
  wire [53:0] _rand_way_data_T_26 = rand_way[1] ? ways_ret_datas_1_tag : 54'h0; // @[Mux.scala 27:72]
  wire [53:0] _rand_way_data_T_27 = rand_way[2] ? ways_ret_datas_2_tag : 54'h0; // @[Mux.scala 27:72]
  wire [53:0] _rand_way_data_T_28 = rand_way[3] ? ways_ret_datas_3_tag : 54'h0; // @[Mux.scala 27:72]
  wire [53:0] _rand_way_data_T_29 = _rand_way_data_T_25 | _rand_way_data_T_26; // @[Mux.scala 27:72]
  wire [53:0] _rand_way_data_T_30 = _rand_way_data_T_29 | _rand_way_data_T_27; // @[Mux.scala 27:72]
  wire [53:0] rand_way_data_tag = _rand_way_data_T_30 | _rand_way_data_T_28; // @[Mux.scala 27:72]
  reg [63:0] miss_info_addr; // @[Cache.scala 328:26]
  reg [63:0] replace_buffer_addr; // @[Cache.scala 334:31]
  reg [127:0] replace_buffer_data; // @[Cache.scala 334:31]
  reg [3:0] replace_buffer_way_num; // @[Cache.scala 334:31]
  reg  replace_buffer_v; // @[Cache.scala 334:31]
  reg  replace_buffer_d; // @[Cache.scala 334:31]
  wire [3:0] _ways_0_io_in_w_valid_T = {write_buffer_valid,write_buffer_valid,write_buffer_valid,write_buffer_valid}; // @[Cat.scala 30:58]
  wire [3:0] _GEN_149 = {{3'd0}, write_buffer_bits_replace_way[0]}; // @[Cache.scala 378:35]
  wire [3:0] _ways_0_io_in_w_valid_T_1 = _GEN_149 & _ways_0_io_in_w_valid_T; // @[Cache.scala 378:35]
  wire [3:0] _GEN_150 = {{3'd0}, write_buffer_bits_replace_way[1]}; // @[Cache.scala 378:35]
  wire [3:0] _ways_1_io_in_w_valid_T_1 = _GEN_150 & _ways_0_io_in_w_valid_T; // @[Cache.scala 378:35]
  wire [3:0] _GEN_151 = {{3'd0}, write_buffer_bits_replace_way[2]}; // @[Cache.scala 378:35]
  wire [3:0] _ways_2_io_in_w_valid_T_1 = _GEN_151 & _ways_0_io_in_w_valid_T; // @[Cache.scala 378:35]
  wire [3:0] _GEN_152 = {{3'd0}, write_buffer_bits_replace_way[3]}; // @[Cache.scala 378:35]
  wire [3:0] _ways_3_io_in_w_valid_T_1 = _GEN_152 & _ways_0_io_in_w_valid_T; // @[Cache.scala 378:35]
  reg  value_2; // @[Counter.scala 60:40]
  reg [63:0] load_ret; // @[Cache.scala 391:25]
  wire  _T_22 = state == 3'h4; // @[Cache.scala 392:15]
  wire  _T_23 = ~req_reg_op; // @[Cache.scala 392:33]
  wire  _io_cpu_resp_valid_T = state == 3'h0; // @[Cache.scala 398:31]
  wire  _io_cpu_resp_valid_T_2 = ~is_miss; // @[Cache.scala 398:70]
  wire  _io_cpu_resp_valid_T_3 = _conflict_hit_write_T_2 & ~is_miss; // @[Cache.scala 398:67]
  wire  _io_cpu_resp_valid_T_4 = state == 3'h0 | _conflict_hit_write_T_2 & ~is_miss; // @[Cache.scala 398:43]
  wire  _io_cpu_resp_valid_T_15 = _T_22 & (req_reg_op & value_2 & io_mem_resp_valid); // @[Cache.scala 401:44]
  wire  _io_cpu_resp_valid_T_17 = req_isCached & (_T_22 & (_T_23 & value_2 & io_mem_resp_valid) |
    _io_cpu_resp_valid_T_15); // @[Cache.scala 400:19]
  wire  _io_cpu_resp_valid_T_18 = state == 3'h0 | _conflict_hit_write_T_2 & ~is_miss | _io_cpu_resp_valid_T_17; // @[Cache.scala 398:81]
  wire  _io_cpu_resp_valid_T_24 = _is_miss_T_3 & (_T_22 & (_T_23 & io_mem_resp_valid)); // @[Cache.scala 402:20]
  wire  io_cpu_resp_bits_data_isHigh = req_reg_addr[3]; // @[Cache.scala 409:32]
  wire [127:0] select_data = _select_data_T_9 | _select_data_T_7; // @[Mux.scala 27:72]
  wire [63:0] io_cpu_resp_bits_data_tmp_data = io_cpu_resp_bits_data_isHigh ? select_data[127:64] : select_data[63:0]; // @[Cache.scala 410:22]
  wire [7:0] io_cpu_resp_bits_data_lo_lo_lo = req_reg_mask[0] ? io_cpu_resp_bits_data_tmp_data[7:0] : 8'h0; // @[Cache.scala 411:17]
  wire [7:0] io_cpu_resp_bits_data_lo_lo_hi = req_reg_mask[1] ? io_cpu_resp_bits_data_tmp_data[15:8] : 8'h0; // @[Cache.scala 411:17]
  wire [7:0] io_cpu_resp_bits_data_lo_hi_lo = req_reg_mask[2] ? io_cpu_resp_bits_data_tmp_data[23:16] : 8'h0; // @[Cache.scala 411:17]
  wire [7:0] io_cpu_resp_bits_data_lo_hi_hi = req_reg_mask[3] ? io_cpu_resp_bits_data_tmp_data[31:24] : 8'h0; // @[Cache.scala 411:17]
  wire [7:0] io_cpu_resp_bits_data_hi_lo_lo = req_reg_mask[4] ? io_cpu_resp_bits_data_tmp_data[39:32] : 8'h0; // @[Cache.scala 411:17]
  wire [7:0] io_cpu_resp_bits_data_hi_lo_hi = req_reg_mask[5] ? io_cpu_resp_bits_data_tmp_data[47:40] : 8'h0; // @[Cache.scala 411:17]
  wire [7:0] io_cpu_resp_bits_data_hi_hi_lo = req_reg_mask[6] ? io_cpu_resp_bits_data_tmp_data[55:48] : 8'h0; // @[Cache.scala 411:17]
  wire [7:0] io_cpu_resp_bits_data_hi_hi_hi = req_reg_mask[7] ? io_cpu_resp_bits_data_tmp_data[63:56] : 8'h0; // @[Cache.scala 411:17]
  wire [63:0] _io_cpu_resp_bits_data_T_8 = {io_cpu_resp_bits_data_hi_hi_hi,io_cpu_resp_bits_data_hi_hi_lo,
    io_cpu_resp_bits_data_hi_lo_hi,io_cpu_resp_bits_data_hi_lo_lo,io_cpu_resp_bits_data_lo_hi_hi,
    io_cpu_resp_bits_data_lo_hi_lo,io_cpu_resp_bits_data_lo_lo_hi,io_cpu_resp_bits_data_lo_lo_lo}; // @[Cat.scala 30:58]
  wire [5:0] _io_cpu_resp_bits_data_T_10 = {req_reg_addr[2:0], 3'h0}; // @[Cache.scala 413:40]
  wire [63:0] _io_cpu_resp_bits_data_T_11 = _io_cpu_resp_bits_data_T_8 >> _io_cpu_resp_bits_data_T_10; // @[Cache.scala 413:17]
  wire [63:0] _ret_T_5 = req_reg_info_offset[3] ? io_mem_resp_bits_data : load_ret; // @[Cache.scala 416:36]
  wire [63:0] ret = req_isCached ? _ret_T_5 : io_mem_resp_bits_data; // @[Cache.scala 416:18]
  wire [7:0] io_cpu_resp_bits_data_lo_lo_lo_1 = req_reg_mask[0] ? ret[7:0] : 8'h0; // @[Cache.scala 420:17]
  wire [7:0] io_cpu_resp_bits_data_lo_lo_hi_1 = req_reg_mask[1] ? ret[15:8] : 8'h0; // @[Cache.scala 420:17]
  wire [7:0] io_cpu_resp_bits_data_lo_hi_lo_1 = req_reg_mask[2] ? ret[23:16] : 8'h0; // @[Cache.scala 420:17]
  wire [7:0] io_cpu_resp_bits_data_lo_hi_hi_1 = req_reg_mask[3] ? ret[31:24] : 8'h0; // @[Cache.scala 420:17]
  wire [7:0] io_cpu_resp_bits_data_hi_lo_lo_1 = req_reg_mask[4] ? ret[39:32] : 8'h0; // @[Cache.scala 420:17]
  wire [7:0] io_cpu_resp_bits_data_hi_lo_hi_1 = req_reg_mask[5] ? ret[47:40] : 8'h0; // @[Cache.scala 420:17]
  wire [7:0] io_cpu_resp_bits_data_hi_hi_lo_1 = req_reg_mask[6] ? ret[55:48] : 8'h0; // @[Cache.scala 420:17]
  wire [7:0] io_cpu_resp_bits_data_hi_hi_hi_1 = req_reg_mask[7] ? ret[63:56] : 8'h0; // @[Cache.scala 420:17]
  wire [63:0] _io_cpu_resp_bits_data_T_20 = {io_cpu_resp_bits_data_hi_hi_hi_1,io_cpu_resp_bits_data_hi_hi_lo_1,
    io_cpu_resp_bits_data_hi_lo_hi_1,io_cpu_resp_bits_data_hi_lo_lo_1,io_cpu_resp_bits_data_lo_hi_hi_1,
    io_cpu_resp_bits_data_lo_hi_lo_1,io_cpu_resp_bits_data_lo_lo_hi_1,io_cpu_resp_bits_data_lo_lo_lo_1}; // @[Cat.scala 30:58]
  wire [63:0] _io_cpu_resp_bits_data_T_23 = _io_cpu_resp_bits_data_T_20 >> _io_cpu_resp_bits_data_T_10; // @[Cache.scala 422:17]
  wire [1:0] _io_cpu_resp_bits_cmd_T_2 = req_reg_op ? 2'h1 : 2'h2; // @[Cache.scala 426:57]
  wire [1:0] _io_cpu_resp_bits_cmd_T_3 = _io_cpu_resp_valid_T ? 2'h0 : _io_cpu_resp_bits_cmd_T_2; // @[Cache.scala 426:30]
  wire  _T_34 = io_mem_resp_ready & io_mem_resp_valid; // @[Decoupled.scala 40:37]
  wire  _T_35 = _T_22 & _T_34; // @[Cache.scala 428:28]
  reg  value_3; // @[Counter.scala 60:40]
  reg  value_4; // @[Counter.scala 60:40]
  wire  _T_39 = _conflict_hit_write_T_2 & is_miss; // @[Cache.scala 442:29]
  wire  _T_46 = _is_miss_T_3 & req_reg_op; // @[Cache.scala 443:55]
  wire  _T_47 = req_isCached & (rand_way_data_v & rand_way_data_d) | _T_46; // @[Cache.scala 442:115]
  wire  _T_48 = _conflict_hit_write_T_2 & is_miss & (req_isCached & (rand_way_data_v & rand_way_data_d) | _T_46); // @[Cache.scala 442:39]
  wire [63:0] _io_mem_req_bits_addr_T_3 = {rand_way_data_tag,req_reg_info_index,4'h0}; // @[Cat.scala 30:58]
  wire [63:0] _io_mem_req_bits_addr_T_4 = req_isCached ? _io_mem_req_bits_addr_T_3 : req_reg_addr; // @[Cache.scala 447:32]
  wire [3:0] _io_mem_req_bits_cmd_T = req_isCached ? 4'h9 : 4'h8; // @[Cache.scala 448:31]
  wire  _T_56 = state == 3'h2 & (req_isCached & replace_buffer_v & replace_buffer_d | _T_46); // @[Cache.scala 453:33]
  wire [63:0] _io_mem_req_bits_addr_T_5 = req_isCached ? replace_buffer_addr : req_reg_addr; // @[Cache.scala 458:32]
  wire [3:0] _io_mem_req_bits_cmd_T_2 = value_3 ? 4'ha : 4'hc; // @[Cache.scala 459:49]
  wire [3:0] _io_mem_req_bits_cmd_T_3 = req_isCached ? _io_mem_req_bits_cmd_T_2 : 4'ha; // @[Cache.scala 459:31]
  wire [63:0] wdata = value_3 ? replace_buffer_data[127:64] : replace_buffer_data[63:0]; // @[Cache.scala 462:17]
  wire [63:0] _io_mem_req_bits_data_T = req_isCached ? wdata : req_reg_data; // @[Cache.scala 463:32]
  wire  _T_57 = io_mem_req_ready & io_mem_req_valid; // @[Decoupled.scala 40:37]
  wire  _T_62 = _is_miss_T_3 & _T_23; // @[Cache.scala 469:50]
  wire  _T_64 = state == 3'h3 & (req_isCached | _T_62); // @[Cache.scala 468:34]
  wire [63:0] _io_mem_req_bits_addr_T_7 = miss_info_addr & 64'hfffffffffffffff0; // @[Cache.scala 473:62]
  wire [63:0] _io_mem_req_bits_addr_T_8 = req_isCached ? _io_mem_req_bits_addr_T_7 : req_reg_addr; // @[Cache.scala 473:32]
  wire [63:0] _io_mem_req_bits_addr_T_9 = {tmp_addr_tag,fence_which_index,4'h0}; // @[Cache.scala 486:44]
  wire  _T_66 = state == 3'h6; // @[Cache.scala 491:20]
  wire [63:0] _io_mem_req_bits_addr_T_10 = {fence_rdata_tag,fence_which_index,4'h0}; // @[Cache.scala 497:44]
  wire [3:0] _io_mem_req_bits_cmd_T_6 = value_1 ? 4'ha : 4'hc; // @[Cache.scala 498:31]
  wire [63:0] fence_rdata_cut = value_1 ? fence_rdata_datas[127:64] : fence_rdata_datas[63:0]; // @[Cache.scala 501:27]
  wire  _GEN_38 = _T_57 ? value_1 + 1'h1 : value_1; // @[Cache.scala 504:28 Counter.scala 76:15 Counter.scala 60:40]
  wire  _GEN_39 = state == 3'h6 & (fence_rdata_v & fence_rdata_d); // @[Cache.scala 491:35 Cache.scala 492:22 Cache.scala 508:22]
  wire [63:0] _GEN_40 = state == 3'h6 ? _io_mem_req_bits_addr_T_10 : 64'h0; // @[Cache.scala 491:35 Cache.scala 497:26 Cache.scala 509:26]
  wire [3:0] _GEN_41 = state == 3'h6 ? _io_mem_req_bits_cmd_T_6 : 4'h0; // @[Cache.scala 491:35 Cache.scala 498:25 Cache.scala 510:25]
  wire [63:0] _GEN_43 = state == 3'h6 ? fence_rdata_cut : 64'h0; // @[Cache.scala 491:35 Cache.scala 502:26 Cache.scala 512:26]
  wire  _GEN_45 = state == 3'h6 ? _GEN_38 : value_1; // @[Cache.scala 491:35 Counter.scala 60:40]
  wire  _GEN_46 = _ways_0_io_in_r_valid_T_2 ? ways_0_io_out_valid & _GEN_20 & _GEN_16 : _GEN_39; // @[Cache.scala 479:32 Cache.scala 481:22]
  wire [63:0] _GEN_47 = _ways_0_io_in_r_valid_T_2 ? _io_mem_req_bits_addr_T_9 : _GEN_40; // @[Cache.scala 479:32 Cache.scala 486:26]
  wire [3:0] _GEN_48 = _ways_0_io_in_r_valid_T_2 ? 4'h9 : _GEN_41; // @[Cache.scala 479:32 Cache.scala 487:25]
  wire  _GEN_49 = _ways_0_io_in_r_valid_T_2 | _T_66; // @[Cache.scala 479:32 Cache.scala 488:25]
  wire [63:0] _GEN_50 = _ways_0_io_in_r_valid_T_2 ? 64'h0 : _GEN_43; // @[Cache.scala 479:32 Cache.scala 489:26]
  wire  _GEN_52 = _ways_0_io_in_r_valid_T_2 ? value_1 : _GEN_45; // @[Cache.scala 479:32 Counter.scala 60:40]
  wire  _GEN_53 = _T_64 | _GEN_46; // @[Cache.scala 470:4 Cache.scala 472:22]
  wire [63:0] _GEN_54 = _T_64 ? _io_mem_req_bits_addr_T_8 : _GEN_47; // @[Cache.scala 470:4 Cache.scala 473:26]
  wire [3:0] _GEN_55 = _T_64 ? {{3'd0}, req_isCached} : _GEN_48; // @[Cache.scala 470:4 Cache.scala 474:25]
  wire  _GEN_56 = _T_64 ? req_isCached : _GEN_49; // @[Cache.scala 470:4 Cache.scala 475:25]
  wire [63:0] _GEN_57 = _T_64 ? 64'h0 : _GEN_50; // @[Cache.scala 470:4 Cache.scala 476:26]
  wire [7:0] _GEN_59 = _T_64 ? req_reg_mask : 8'h0; // @[Cache.scala 470:4 Cache.scala 478:26 Cache.scala 441:24]
  wire  _GEN_61 = _T_56 | _GEN_53; // @[Cache.scala 455:4 Cache.scala 457:22]
  wire [63:0] _GEN_62 = _T_56 ? _io_mem_req_bits_addr_T_5 : _GEN_54; // @[Cache.scala 455:4 Cache.scala 458:26]
  wire [3:0] _GEN_63 = _T_56 ? _io_mem_req_bits_cmd_T_3 : _GEN_55; // @[Cache.scala 455:4 Cache.scala 459:25]
  wire  _GEN_64 = _T_56 ? req_isCached : _GEN_56; // @[Cache.scala 455:4 Cache.scala 460:25]
  wire [63:0] _GEN_65 = _T_56 ? _io_mem_req_bits_data_T : _GEN_57; // @[Cache.scala 455:4 Cache.scala 463:26]
  wire [7:0] _GEN_68 = _T_56 ? 8'h0 : _GEN_59; // @[Cache.scala 455:4 Cache.scala 441:24]
  wire  _GEN_73 = _T_48 ? req_isCached : _GEN_64; // @[Cache.scala 444:4 Cache.scala 449:25]
  wire  _req_reg_T = io_cpu_req_ready & io_cpu_req_valid; // @[Decoupled.scala 40:37]
  wire  _req_isCached_T_5 = io_cpu_req_bits_addr >= 64'h80000000 & io_cpu_req_bits_addr < 64'hffffffff; // @[Cache.scala 524:45]
  wire  _write_buffer_valid_T_7 = _io_cpu_resp_valid_T_3 & req_reg_op; // @[Cache.scala 543:107]
  wire [3:0] _write_buffer_bits_replace_way_T = {ways_compare_res[0],ways_compare_res[1],ways_compare_res[2],
    ways_compare_res[3]}; // @[Cat.scala 30:58]
  wire [7:0] write_buffer_bits_data_hi_hi_hi = req_reg_mask[7] ? 8'hff : 8'h0; // @[Cache.scala 559:25]
  wire [7:0] write_buffer_bits_data_hi_hi_lo = req_reg_mask[6] ? 8'hff : 8'h0; // @[Cache.scala 559:25]
  wire [7:0] write_buffer_bits_data_hi_lo_hi = req_reg_mask[5] ? 8'hff : 8'h0; // @[Cache.scala 559:25]
  wire [7:0] write_buffer_bits_data_hi_lo_lo = req_reg_mask[4] ? 8'hff : 8'h0; // @[Cache.scala 559:25]
  wire [7:0] write_buffer_bits_data_lo_hi_hi = req_reg_mask[3] ? 8'hff : 8'h0; // @[Cache.scala 559:25]
  wire [7:0] write_buffer_bits_data_lo_hi_lo = req_reg_mask[2] ? 8'hff : 8'h0; // @[Cache.scala 559:25]
  wire [7:0] write_buffer_bits_data_lo_lo_hi = req_reg_mask[1] ? 8'hff : 8'h0; // @[Cache.scala 559:25]
  wire [7:0] write_buffer_bits_data_lo_lo_lo = req_reg_mask[0] ? 8'hff : 8'h0; // @[Cache.scala 559:25]
  wire [63:0] _write_buffer_bits_data_T_13 = {write_buffer_bits_data_hi_hi_hi,write_buffer_bits_data_hi_hi_lo,
    write_buffer_bits_data_hi_lo_hi,write_buffer_bits_data_hi_lo_lo,write_buffer_bits_data_lo_hi_hi,
    write_buffer_bits_data_lo_hi_lo,write_buffer_bits_data_lo_lo_hi,write_buffer_bits_data_lo_lo_lo}; // @[Cat.scala 30:58]
  wire [63:0] _write_buffer_bits_data_T_14 = ~_write_buffer_bits_data_T_13; // @[Cache.scala 557:39]
  wire [63:0] _write_buffer_bits_data_T_15 = io_mem_resp_bits_data & _write_buffer_bits_data_T_14; // @[Cache.scala 557:36]
  wire [63:0] _write_buffer_bits_data_T_25 = req_reg_data & _write_buffer_bits_data_T_13; // @[Cache.scala 561:44]
  wire [63:0] _write_buffer_bits_data_T_26 = _write_buffer_bits_data_T_15 | _write_buffer_bits_data_T_25; // @[Cache.scala 561:28]
  wire [63:0] _write_buffer_bits_data_T_27 = value_2 == miss_info_addr[3] ? _write_buffer_bits_data_T_26 :
    io_mem_resp_bits_data; // @[Cache.scala 556:40]
  wire [63:0] _GEN_87 = req_reg_op ? _write_buffer_bits_data_T_27 : io_mem_resp_bits_data; // @[Cache.scala 555:33 Cache.scala 556:34 Cache.scala 567:34]
  wire [3:0] _write_buffer_bits_offset_T_3 = {value_4, 3'h0}; // @[Cache.scala 573:51]
  wire  _GEN_92 = req_isCached | write_buffer_bits_v; // @[Cache.scala 554:33 Cache.scala 574:29 Cache.scala 233:29]
  wire  _GEN_93 = req_isCached ? req_reg_op : write_buffer_bits_d; // @[Cache.scala 554:33 Cache.scala 575:29 Cache.scala 233:29]
  wire  _GEN_101 = _T_35 ? _GEN_92 : write_buffer_bits_v; // @[Cache.scala 553:58 Cache.scala 233:29]
  wire  _GEN_102 = _T_35 ? _GEN_93 : write_buffer_bits_d; // @[Cache.scala 553:58 Cache.scala 233:29]
  wire  _GEN_109 = _write_buffer_valid_T_7 | _GEN_101; // @[Cache.scala 544:65 Cache.scala 548:27]
  wire  _GEN_110 = _write_buffer_valid_T_7 | _GEN_102; // @[Cache.scala 544:65 Cache.scala 549:27]
  wire  _T_80 = 3'h0 == state; // @[Conditional.scala 37:30]
  wire  _T_83 = _req_reg_T & _ways_0_io_in_r_valid_T; // @[Cache.scala 596:36]
  wire  _T_84 = 3'h1 == state; // @[Conditional.scala 37:30]
  wire  _T_112 = _T_57 & _T_47; // @[Cache.scala 621:30]
  wire  _T_113 = req_isCached & (~rand_way_data_v | ~rand_way_data_d) | _T_62 | _T_112; // @[Cache.scala 620:130]
  wire [2:0] _GEN_117 = _T_113 ? 3'h2 : state; // @[Cache.scala 622:10 Cache.scala 624:17 Cache.scala 214:22]
  wire [2:0] _GEN_118 = io_fence_i ? 3'h5 : _GEN_117; // @[Cache.scala 616:29 Cache.scala 617:15]
  wire [2:0] _GEN_119 = _io_cpu_resp_valid_T_2 & _T_83 ? 3'h1 : _GEN_118; // @[Cache.scala 613:75 Cache.scala 615:15]
  wire [2:0] _GEN_120 = _io_cpu_resp_valid_T_2 & (~_req_reg_T | conflict_hit_write) ? 3'h0 : _GEN_119; // @[Cache.scala 610:77 Cache.scala 612:15]
  wire  _T_114 = 3'h2 == state; // @[Conditional.scala 37:30]
  wire  _T_116 = io_mem_req_bits_cmd == 4'ha; // @[Cache.scala 631:67]
  wire  _T_117 = _T_57 & io_mem_req_bits_cmd == 4'ha; // @[Cache.scala 631:44]
  wire  _T_131 = _is_miss_T_3 & (req_reg_op & _T_117 | _T_23); // @[Cache.scala 632:26]
  wire  _T_132 = req_isCached & (_T_57 & io_mem_req_bits_cmd == 4'ha) | (~replace_buffer_v | ~replace_buffer_d) | _T_131
    ; // @[Cache.scala 631:156]
  wire [2:0] _GEN_122 = _T_132 ? 3'h3 : state; // @[Cache.scala 634:8 Cache.scala 636:15 Cache.scala 639:15]
  wire  _T_133 = 3'h3 == state; // @[Conditional.scala 37:30]
  wire  _T_144 = _T_23 & (_T_57 & io_mem_req_bits_cmd == 4'h0); // @[Cache.scala 646:52]
  wire  _T_146 = _is_miss_T_3 & (req_reg_op | _T_144); // @[Cache.scala 645:28]
  wire  _T_147 = req_isCached & (_T_57 & io_mem_req_bits_cmd == 4'h1) | _T_146; // @[Cache.scala 644:99]
  wire [2:0] _GEN_123 = _T_147 ? 3'h4 : state; // @[Cache.scala 647:8 Cache.scala 649:15 Cache.scala 651:15]
  wire  _T_148 = 3'h4 == state; // @[Conditional.scala 37:30]
  wire  _T_151 = _T_34 & io_mem_resp_bits_cmd == 4'h2; // @[Cache.scala 656:48]
  wire  _T_159 = _T_23 & _T_151; // @[Cache.scala 658:51]
  wire  _T_161 = _is_miss_T_3 & (req_reg_op | _T_159); // @[Cache.scala 657:27]
  wire  _T_162 = req_isCached & (_T_34 & io_mem_resp_bits_cmd == 4'h2) | _T_161; // @[Cache.scala 656:100]
  wire [2:0] _GEN_124 = _T_162 ? 3'h0 : state; // @[Cache.scala 660:8 Cache.scala 662:15 Cache.scala 664:15]
  wire  _T_163 = 3'h5 == state; // @[Conditional.scala 37:30]
  wire  _T_167 = ~io_mem_req_valid; // @[Cache.scala 669:82]
  wire [7:0] _value_T_9 = value + 8'h1; // @[Counter.scala 76:24]
  wire [2:0] _GEN_125 = ~write_buffer_valid & ways_0_io_out_valid & (_T_57 | ~io_mem_req_valid) ? 3'h6 : state; // @[Cache.scala 669:101 Cache.scala 671:15 Cache.scala 674:15]
  wire [7:0] _GEN_126 = ~write_buffer_valid & ways_0_io_out_valid & (_T_57 | ~io_mem_req_valid) ? _value_T_9 : value; // @[Cache.scala 669:101 Counter.scala 76:15 Counter.scala 60:40]
  wire  _T_170 = 3'h6 == state; // @[Conditional.scala 37:30]
  wire  _T_173 = _T_116 & _T_57; // @[Cache.scala 679:60]
  wire  _T_174 = value == 8'h0; // @[Cache.scala 679:99]
  wire [2:0] _GEN_127 = _T_167 ? 3'h5 : state; // @[Cache.scala 687:36 Cache.scala 688:15 Cache.scala 690:15]
  wire [2:0] _GEN_128 = _T_174 & _T_167 ? 3'h0 : _GEN_127; // @[Cache.scala 684:71 Cache.scala 685:15]
  wire [7:0] _GEN_129 = _T_174 & _T_167 ? 8'h0 : value; // @[Cache.scala 684:71 Cache.scala 686:25 Counter.scala 60:40]
  wire [2:0] _GEN_130 = _T_173 ? 3'h5 : _GEN_128; // @[Cache.scala 682:86 Cache.scala 683:15]
  wire [7:0] _GEN_131 = _T_173 ? value : _GEN_129; // @[Cache.scala 682:86 Counter.scala 60:40]
  wire [2:0] _GEN_132 = _T_116 & _T_57 & value == 8'h0 ? 3'h0 : _GEN_130; // @[Cache.scala 679:115 Cache.scala 680:15]
  wire [7:0] _GEN_133 = _T_116 & _T_57 & value == 8'h0 ? 8'h0 : _GEN_131; // @[Cache.scala 679:115 Cache.scala 681:25]
  wire  _T_183 = 3'h7 == state; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_134 = _T_183 ? 3'h0 : state; // @[Conditional.scala 39:67 Cache.scala 696:13 Cache.scala 214:22]
  wire [2:0] _GEN_135 = _T_170 ? _GEN_132 : _GEN_134; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_136 = _T_170 ? _GEN_133 : value; // @[Conditional.scala 39:67 Counter.scala 60:40]
  wire [2:0] _GEN_137 = _T_163 ? _GEN_125 : _GEN_135; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_138 = _T_163 ? _GEN_126 : _GEN_136; // @[Conditional.scala 39:67]
  wire [2:0] _GEN_139 = _T_148 ? _GEN_124 : _GEN_137; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_140 = _T_148 ? value : _GEN_138; // @[Conditional.scala 39:67 Counter.scala 60:40]
  wire [2:0] _GEN_141 = _T_133 ? _GEN_123 : _GEN_139; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_142 = _T_133 ? value : _GEN_140; // @[Conditional.scala 39:67 Counter.scala 60:40]
  ysyx_210013_Way ways_0 ( // @[Cache.scala 210:40]
    .clock(ways_0_clock),
    .reset(ways_0_reset),
    .io_out_valid(ways_0_io_out_valid),
    .io_out_bits_tag(ways_0_io_out_bits_tag),
    .io_out_bits_v(ways_0_io_out_bits_v),
    .io_out_bits_d(ways_0_io_out_bits_d),
    .io_out_bits_datas(ways_0_io_out_bits_datas),
    .io_in_w_valid(ways_0_io_in_w_valid),
    .io_in_w_bits_tag(ways_0_io_in_w_bits_tag),
    .io_in_w_bits_index(ways_0_io_in_w_bits_index),
    .io_in_w_bits_offset(ways_0_io_in_w_bits_offset),
    .io_in_w_bits_v(ways_0_io_in_w_bits_v),
    .io_in_w_bits_d(ways_0_io_in_w_bits_d),
    .io_in_w_bits_mask(ways_0_io_in_w_bits_mask),
    .io_in_w_bits_data(ways_0_io_in_w_bits_data),
    .io_in_w_bits_op(ways_0_io_in_w_bits_op),
    .io_in_r_valid(ways_0_io_in_r_valid),
    .io_in_r_bits_index(ways_0_io_in_r_bits_index),
    .io_fence_invalid(ways_0_io_fence_invalid)
  );
  ysyx_210013_Way ways_1 ( // @[Cache.scala 210:40]
    .clock(ways_1_clock),
    .reset(ways_1_reset),
    .io_out_valid(ways_1_io_out_valid),
    .io_out_bits_tag(ways_1_io_out_bits_tag),
    .io_out_bits_v(ways_1_io_out_bits_v),
    .io_out_bits_d(ways_1_io_out_bits_d),
    .io_out_bits_datas(ways_1_io_out_bits_datas),
    .io_in_w_valid(ways_1_io_in_w_valid),
    .io_in_w_bits_tag(ways_1_io_in_w_bits_tag),
    .io_in_w_bits_index(ways_1_io_in_w_bits_index),
    .io_in_w_bits_offset(ways_1_io_in_w_bits_offset),
    .io_in_w_bits_v(ways_1_io_in_w_bits_v),
    .io_in_w_bits_d(ways_1_io_in_w_bits_d),
    .io_in_w_bits_mask(ways_1_io_in_w_bits_mask),
    .io_in_w_bits_data(ways_1_io_in_w_bits_data),
    .io_in_w_bits_op(ways_1_io_in_w_bits_op),
    .io_in_r_valid(ways_1_io_in_r_valid),
    .io_in_r_bits_index(ways_1_io_in_r_bits_index),
    .io_fence_invalid(ways_1_io_fence_invalid)
  );
  ysyx_210013_Way ways_2 ( // @[Cache.scala 210:40]
    .clock(ways_2_clock),
    .reset(ways_2_reset),
    .io_out_valid(ways_2_io_out_valid),
    .io_out_bits_tag(ways_2_io_out_bits_tag),
    .io_out_bits_v(ways_2_io_out_bits_v),
    .io_out_bits_d(ways_2_io_out_bits_d),
    .io_out_bits_datas(ways_2_io_out_bits_datas),
    .io_in_w_valid(ways_2_io_in_w_valid),
    .io_in_w_bits_tag(ways_2_io_in_w_bits_tag),
    .io_in_w_bits_index(ways_2_io_in_w_bits_index),
    .io_in_w_bits_offset(ways_2_io_in_w_bits_offset),
    .io_in_w_bits_v(ways_2_io_in_w_bits_v),
    .io_in_w_bits_d(ways_2_io_in_w_bits_d),
    .io_in_w_bits_mask(ways_2_io_in_w_bits_mask),
    .io_in_w_bits_data(ways_2_io_in_w_bits_data),
    .io_in_w_bits_op(ways_2_io_in_w_bits_op),
    .io_in_r_valid(ways_2_io_in_r_valid),
    .io_in_r_bits_index(ways_2_io_in_r_bits_index),
    .io_fence_invalid(ways_2_io_fence_invalid)
  );
  ysyx_210013_Way ways_3 ( // @[Cache.scala 210:40]
    .clock(ways_3_clock),
    .reset(ways_3_reset),
    .io_out_valid(ways_3_io_out_valid),
    .io_out_bits_tag(ways_3_io_out_bits_tag),
    .io_out_bits_v(ways_3_io_out_bits_v),
    .io_out_bits_d(ways_3_io_out_bits_d),
    .io_out_bits_datas(ways_3_io_out_bits_datas),
    .io_in_w_valid(ways_3_io_in_w_valid),
    .io_in_w_bits_tag(ways_3_io_in_w_bits_tag),
    .io_in_w_bits_index(ways_3_io_in_w_bits_index),
    .io_in_w_bits_offset(ways_3_io_in_w_bits_offset),
    .io_in_w_bits_v(ways_3_io_in_w_bits_v),
    .io_in_w_bits_d(ways_3_io_in_w_bits_d),
    .io_in_w_bits_mask(ways_3_io_in_w_bits_mask),
    .io_in_w_bits_data(ways_3_io_in_w_bits_data),
    .io_in_w_bits_op(ways_3_io_in_w_bits_op),
    .io_in_r_valid(ways_3_io_in_r_valid),
    .io_in_r_bits_index(ways_3_io_in_r_bits_index),
    .io_fence_invalid(ways_3_io_fence_invalid)
  );
  ysyx_210013_MaxPeriodFibonacciLFSR rand_num_prng ( // @[PRNG.scala 82:22]
    .clock(rand_num_prng_clock),
    .reset(rand_num_prng_reset),
    .io_out_0(rand_num_prng_io_out_0),
    .io_out_1(rand_num_prng_io_out_1),
    .io_out_2(rand_num_prng_io_out_2),
    .io_out_3(rand_num_prng_io_out_3),
    .io_out_4(rand_num_prng_io_out_4),
    .io_out_5(rand_num_prng_io_out_5),
    .io_out_6(rand_num_prng_io_out_6),
    .io_out_7(rand_num_prng_io_out_7),
    .io_out_8(rand_num_prng_io_out_8),
    .io_out_9(rand_num_prng_io_out_9),
    .io_out_10(rand_num_prng_io_out_10),
    .io_out_11(rand_num_prng_io_out_11),
    .io_out_12(rand_num_prng_io_out_12),
    .io_out_13(rand_num_prng_io_out_13),
    .io_out_14(rand_num_prng_io_out_14),
    .io_out_15(rand_num_prng_io_out_15),
    .io_out_16(rand_num_prng_io_out_16),
    .io_out_17(rand_num_prng_io_out_17),
    .io_out_18(rand_num_prng_io_out_18),
    .io_out_19(rand_num_prng_io_out_19),
    .io_out_20(rand_num_prng_io_out_20),
    .io_out_21(rand_num_prng_io_out_21),
    .io_out_22(rand_num_prng_io_out_22),
    .io_out_23(rand_num_prng_io_out_23),
    .io_out_24(rand_num_prng_io_out_24),
    .io_out_25(rand_num_prng_io_out_25),
    .io_out_26(rand_num_prng_io_out_26),
    .io_out_27(rand_num_prng_io_out_27),
    .io_out_28(rand_num_prng_io_out_28),
    .io_out_29(rand_num_prng_io_out_29),
    .io_out_30(rand_num_prng_io_out_30),
    .io_out_31(rand_num_prng_io_out_31),
    .io_out_32(rand_num_prng_io_out_32),
    .io_out_33(rand_num_prng_io_out_33),
    .io_out_34(rand_num_prng_io_out_34),
    .io_out_35(rand_num_prng_io_out_35),
    .io_out_36(rand_num_prng_io_out_36),
    .io_out_37(rand_num_prng_io_out_37),
    .io_out_38(rand_num_prng_io_out_38),
    .io_out_39(rand_num_prng_io_out_39),
    .io_out_40(rand_num_prng_io_out_40),
    .io_out_41(rand_num_prng_io_out_41),
    .io_out_42(rand_num_prng_io_out_42),
    .io_out_43(rand_num_prng_io_out_43),
    .io_out_44(rand_num_prng_io_out_44),
    .io_out_45(rand_num_prng_io_out_45),
    .io_out_46(rand_num_prng_io_out_46),
    .io_out_47(rand_num_prng_io_out_47),
    .io_out_48(rand_num_prng_io_out_48),
    .io_out_49(rand_num_prng_io_out_49),
    .io_out_50(rand_num_prng_io_out_50),
    .io_out_51(rand_num_prng_io_out_51),
    .io_out_52(rand_num_prng_io_out_52),
    .io_out_53(rand_num_prng_io_out_53),
    .io_out_54(rand_num_prng_io_out_54),
    .io_out_55(rand_num_prng_io_out_55),
    .io_out_56(rand_num_prng_io_out_56),
    .io_out_57(rand_num_prng_io_out_57),
    .io_out_58(rand_num_prng_io_out_58),
    .io_out_59(rand_num_prng_io_out_59),
    .io_out_60(rand_num_prng_io_out_60),
    .io_out_61(rand_num_prng_io_out_61),
    .io_out_62(rand_num_prng_io_out_62),
    .io_out_63(rand_num_prng_io_out_63),
    .io_out_64(rand_num_prng_io_out_64),
    .io_out_65(rand_num_prng_io_out_65),
    .io_out_66(rand_num_prng_io_out_66),
    .io_out_67(rand_num_prng_io_out_67),
    .io_out_68(rand_num_prng_io_out_68),
    .io_out_69(rand_num_prng_io_out_69),
    .io_out_70(rand_num_prng_io_out_70),
    .io_out_71(rand_num_prng_io_out_71),
    .io_out_72(rand_num_prng_io_out_72),
    .io_out_73(rand_num_prng_io_out_73),
    .io_out_74(rand_num_prng_io_out_74),
    .io_out_75(rand_num_prng_io_out_75),
    .io_out_76(rand_num_prng_io_out_76),
    .io_out_77(rand_num_prng_io_out_77),
    .io_out_78(rand_num_prng_io_out_78),
    .io_out_79(rand_num_prng_io_out_79),
    .io_out_80(rand_num_prng_io_out_80),
    .io_out_81(rand_num_prng_io_out_81),
    .io_out_82(rand_num_prng_io_out_82),
    .io_out_83(rand_num_prng_io_out_83),
    .io_out_84(rand_num_prng_io_out_84),
    .io_out_85(rand_num_prng_io_out_85),
    .io_out_86(rand_num_prng_io_out_86),
    .io_out_87(rand_num_prng_io_out_87),
    .io_out_88(rand_num_prng_io_out_88),
    .io_out_89(rand_num_prng_io_out_89),
    .io_out_90(rand_num_prng_io_out_90),
    .io_out_91(rand_num_prng_io_out_91),
    .io_out_92(rand_num_prng_io_out_92),
    .io_out_93(rand_num_prng_io_out_93),
    .io_out_94(rand_num_prng_io_out_94),
    .io_out_95(rand_num_prng_io_out_95),
    .io_out_96(rand_num_prng_io_out_96),
    .io_out_97(rand_num_prng_io_out_97),
    .io_out_98(rand_num_prng_io_out_98),
    .io_out_99(rand_num_prng_io_out_99),
    .io_out_100(rand_num_prng_io_out_100),
    .io_out_101(rand_num_prng_io_out_101),
    .io_out_102(rand_num_prng_io_out_102),
    .io_out_103(rand_num_prng_io_out_103),
    .io_out_104(rand_num_prng_io_out_104),
    .io_out_105(rand_num_prng_io_out_105),
    .io_out_106(rand_num_prng_io_out_106),
    .io_out_107(rand_num_prng_io_out_107),
    .io_out_108(rand_num_prng_io_out_108),
    .io_out_109(rand_num_prng_io_out_109),
    .io_out_110(rand_num_prng_io_out_110),
    .io_out_111(rand_num_prng_io_out_111),
    .io_out_112(rand_num_prng_io_out_112),
    .io_out_113(rand_num_prng_io_out_113),
    .io_out_114(rand_num_prng_io_out_114),
    .io_out_115(rand_num_prng_io_out_115),
    .io_out_116(rand_num_prng_io_out_116),
    .io_out_117(rand_num_prng_io_out_117),
    .io_out_118(rand_num_prng_io_out_118),
    .io_out_119(rand_num_prng_io_out_119),
    .io_out_120(rand_num_prng_io_out_120),
    .io_out_121(rand_num_prng_io_out_121),
    .io_out_122(rand_num_prng_io_out_122),
    .io_out_123(rand_num_prng_io_out_123),
    .io_out_124(rand_num_prng_io_out_124),
    .io_out_125(rand_num_prng_io_out_125),
    .io_out_126(rand_num_prng_io_out_126),
    .io_out_127(rand_num_prng_io_out_127)
  );
  assign io_cpu_req_ready = _io_cpu_resp_valid_T_4 & _ways_0_io_in_r_valid_T; // @[Cache.scala 517:82]
  assign io_cpu_resp_valid = _io_cpu_resp_valid_T_18 | _io_cpu_resp_valid_T_24; // @[Cache.scala 401:113]
  assign io_cpu_resp_bits_data = _conflict_hit_write_T_2 ? _io_cpu_resp_bits_data_T_11 : _io_cpu_resp_bits_data_T_23; // @[Cache.scala 404:27 Cache.scala 405:27 Cache.scala 417:27]
  assign io_cpu_resp_bits_cmd = {{2'd0}, _io_cpu_resp_bits_cmd_T_3}; // @[Cache.scala 426:30]
  assign io_mem_req_valid = _T_48 | _GEN_61; // @[Cache.scala 444:4 Cache.scala 446:22]
  assign io_mem_req_bits_addr = _T_48 ? _io_mem_req_bits_addr_T_4 : _GEN_62; // @[Cache.scala 444:4 Cache.scala 447:26]
  assign io_mem_req_bits_data = _T_48 ? 64'h0 : _GEN_65; // @[Cache.scala 444:4 Cache.scala 450:26]
  assign io_mem_req_bits_cmd = _T_48 ? _io_mem_req_bits_cmd_T : _GEN_63; // @[Cache.scala 444:4 Cache.scala 448:25]
  assign io_mem_req_bits_len = {{1'd0}, _GEN_73}; // @[Cache.scala 444:4 Cache.scala 449:25]
  assign io_mem_req_bits_mask = _T_48 ? req_reg_mask : _GEN_68; // @[Cache.scala 444:4 Cache.scala 452:26]
  assign io_mem_resp_ready = state == 3'h4; // @[Cache.scala 542:31]
  assign ways_0_clock = clock;
  assign ways_0_reset = reset;
  assign ways_0_io_in_w_valid = _ways_0_io_in_w_valid_T_1[0]; // @[Cache.scala 378:23]
  assign ways_0_io_in_w_bits_tag = write_buffer_bits_tag; // @[Cache.scala 367:26]
  assign ways_0_io_in_w_bits_index = write_buffer_bits_index; // @[Cache.scala 368:28]
  assign ways_0_io_in_w_bits_offset = write_buffer_bits_offset; // @[Cache.scala 369:29]
  assign ways_0_io_in_w_bits_v = write_buffer_bits_v; // @[Cache.scala 370:24]
  assign ways_0_io_in_w_bits_d = write_buffer_bits_d; // @[Cache.scala 371:24]
  assign ways_0_io_in_w_bits_mask = write_buffer_bits_wmask; // @[Cache.scala 372:27]
  assign ways_0_io_in_w_bits_data = write_buffer_bits_data; // @[Cache.scala 373:27]
  assign ways_0_io_in_w_bits_op = 1'h1; // @[Cache.scala 374:25]
  assign ways_0_io_in_r_valid = state != 3'h5 & state != 3'h6 ? io_cpu_req_valid & ~conflict_hit_write :
    _ways_0_io_in_r_valid_T_3; // @[Cache.scala 274:53 Cache.scala 279:25 Cache.scala 285:25]
  assign ways_0_io_in_r_bits_index = _GEN_0[5:0];
  assign ways_0_io_fence_invalid = state == 3'h7; // @[Cache.scala 221:44]
  assign ways_1_clock = clock;
  assign ways_1_reset = reset;
  assign ways_1_io_in_w_valid = _ways_1_io_in_w_valid_T_1[0]; // @[Cache.scala 378:23]
  assign ways_1_io_in_w_bits_tag = write_buffer_bits_tag; // @[Cache.scala 367:26]
  assign ways_1_io_in_w_bits_index = write_buffer_bits_index; // @[Cache.scala 368:28]
  assign ways_1_io_in_w_bits_offset = write_buffer_bits_offset; // @[Cache.scala 369:29]
  assign ways_1_io_in_w_bits_v = write_buffer_bits_v; // @[Cache.scala 370:24]
  assign ways_1_io_in_w_bits_d = write_buffer_bits_d; // @[Cache.scala 371:24]
  assign ways_1_io_in_w_bits_mask = write_buffer_bits_wmask; // @[Cache.scala 372:27]
  assign ways_1_io_in_w_bits_data = write_buffer_bits_data; // @[Cache.scala 373:27]
  assign ways_1_io_in_w_bits_op = 1'h1; // @[Cache.scala 374:25]
  assign ways_1_io_in_r_valid = state != 3'h5 & state != 3'h6 ? io_cpu_req_valid & ~conflict_hit_write :
    _ways_0_io_in_r_valid_T_3; // @[Cache.scala 274:53 Cache.scala 279:25 Cache.scala 285:25]
  assign ways_1_io_in_r_bits_index = _GEN_0[5:0];
  assign ways_1_io_fence_invalid = state == 3'h7; // @[Cache.scala 221:44]
  assign ways_2_clock = clock;
  assign ways_2_reset = reset;
  assign ways_2_io_in_w_valid = _ways_2_io_in_w_valid_T_1[0]; // @[Cache.scala 378:23]
  assign ways_2_io_in_w_bits_tag = write_buffer_bits_tag; // @[Cache.scala 367:26]
  assign ways_2_io_in_w_bits_index = write_buffer_bits_index; // @[Cache.scala 368:28]
  assign ways_2_io_in_w_bits_offset = write_buffer_bits_offset; // @[Cache.scala 369:29]
  assign ways_2_io_in_w_bits_v = write_buffer_bits_v; // @[Cache.scala 370:24]
  assign ways_2_io_in_w_bits_d = write_buffer_bits_d; // @[Cache.scala 371:24]
  assign ways_2_io_in_w_bits_mask = write_buffer_bits_wmask; // @[Cache.scala 372:27]
  assign ways_2_io_in_w_bits_data = write_buffer_bits_data; // @[Cache.scala 373:27]
  assign ways_2_io_in_w_bits_op = 1'h1; // @[Cache.scala 374:25]
  assign ways_2_io_in_r_valid = state != 3'h5 & state != 3'h6 ? io_cpu_req_valid & ~conflict_hit_write :
    _ways_0_io_in_r_valid_T_3; // @[Cache.scala 274:53 Cache.scala 279:25 Cache.scala 285:25]
  assign ways_2_io_in_r_bits_index = _GEN_0[5:0];
  assign ways_2_io_fence_invalid = state == 3'h7; // @[Cache.scala 221:44]
  assign ways_3_clock = clock;
  assign ways_3_reset = reset;
  assign ways_3_io_in_w_valid = _ways_3_io_in_w_valid_T_1[0]; // @[Cache.scala 378:23]
  assign ways_3_io_in_w_bits_tag = write_buffer_bits_tag; // @[Cache.scala 367:26]
  assign ways_3_io_in_w_bits_index = write_buffer_bits_index; // @[Cache.scala 368:28]
  assign ways_3_io_in_w_bits_offset = write_buffer_bits_offset; // @[Cache.scala 369:29]
  assign ways_3_io_in_w_bits_v = write_buffer_bits_v; // @[Cache.scala 370:24]
  assign ways_3_io_in_w_bits_d = write_buffer_bits_d; // @[Cache.scala 371:24]
  assign ways_3_io_in_w_bits_mask = write_buffer_bits_wmask; // @[Cache.scala 372:27]
  assign ways_3_io_in_w_bits_data = write_buffer_bits_data; // @[Cache.scala 373:27]
  assign ways_3_io_in_w_bits_op = 1'h1; // @[Cache.scala 374:25]
  assign ways_3_io_in_r_valid = state != 3'h5 & state != 3'h6 ? io_cpu_req_valid & ~conflict_hit_write :
    _ways_0_io_in_r_valid_T_3; // @[Cache.scala 274:53 Cache.scala 279:25 Cache.scala 285:25]
  assign ways_3_io_in_r_bits_index = _GEN_0[5:0];
  assign ways_3_io_fence_invalid = state == 3'h7; // @[Cache.scala 221:44]
  assign rand_num_prng_clock = clock;
  assign rand_num_prng_reset = reset;
  always @(posedge clock) begin
    if (reset) begin // @[Cache.scala 214:22]
      state <= 3'h0; // @[Cache.scala 214:22]
    end else if (_T_80) begin // @[Conditional.scala 40:58]
      if (io_fence_i) begin // @[Cache.scala 590:23]
        state <= 3'h7; // @[Cache.scala 592:17]
      end else if (_req_reg_T & _ways_0_io_in_r_valid_T) begin // @[Cache.scala 596:58]
        state <= 3'h1; // @[Cache.scala 597:15]
      end
    end else if (_T_84) begin // @[Conditional.scala 39:67]
      if (io_fence_i) begin // @[Cache.scala 604:23]
        state <= 3'h7; // @[Cache.scala 606:17]
      end else begin
        state <= _GEN_120;
      end
    end else if (_T_114) begin // @[Conditional.scala 39:67]
      state <= _GEN_122;
    end else begin
      state <= _GEN_141;
    end
    if (reset) begin // @[Counter.scala 60:40]
      value <= 8'h0; // @[Counter.scala 60:40]
    end else if (!(_T_80)) begin // @[Conditional.scala 40:58]
      if (!(_T_84)) begin // @[Conditional.scala 39:67]
        if (!(_T_114)) begin // @[Conditional.scala 39:67]
          value <= _GEN_142;
        end
      end
    end
    if (reset) begin // @[Counter.scala 60:40]
      value_1 <= 1'h0; // @[Counter.scala 60:40]
    end else if (!(_T_48)) begin // @[Cache.scala 444:4]
      if (!(_T_56)) begin // @[Cache.scala 455:4]
        if (!(_T_64)) begin // @[Cache.scala 470:4]
          value_1 <= _GEN_52;
        end
      end
    end
    if (reset) begin // @[Cache.scala 220:28]
      fence_rdata_tag <= 54'h0; // @[Cache.scala 220:28]
    end else if (_ways_0_io_in_r_valid_T_2 & ways_0_io_out_valid) begin // @[Cache.scala 293:53]
      if (2'h3 == fence_which_way) begin // @[Cache.scala 294:17]
        fence_rdata_tag <= ways_ret_datas_3_tag; // @[Cache.scala 294:17]
      end else if (2'h2 == fence_which_way) begin // @[Cache.scala 294:17]
        fence_rdata_tag <= ways_ret_datas_2_tag; // @[Cache.scala 294:17]
      end else begin
        fence_rdata_tag <= _GEN_22;
      end
    end
    if (reset) begin // @[Cache.scala 220:28]
      fence_rdata_v <= 1'h0; // @[Cache.scala 220:28]
    end else if (_ways_0_io_in_r_valid_T_2 & ways_0_io_out_valid) begin // @[Cache.scala 293:53]
      if (2'h3 == fence_which_way) begin // @[Cache.scala 294:17]
        fence_rdata_v <= ways_ret_datas_3_v; // @[Cache.scala 294:17]
      end else if (2'h2 == fence_which_way) begin // @[Cache.scala 294:17]
        fence_rdata_v <= ways_ret_datas_2_v; // @[Cache.scala 294:17]
      end else begin
        fence_rdata_v <= _GEN_18;
      end
    end
    if (reset) begin // @[Cache.scala 220:28]
      fence_rdata_d <= 1'h0; // @[Cache.scala 220:28]
    end else if (_ways_0_io_in_r_valid_T_2 & ways_0_io_out_valid) begin // @[Cache.scala 293:53]
      if (2'h3 == fence_which_way) begin // @[Cache.scala 294:17]
        fence_rdata_d <= ways_ret_datas_3_d; // @[Cache.scala 294:17]
      end else if (2'h2 == fence_which_way) begin // @[Cache.scala 294:17]
        fence_rdata_d <= ways_ret_datas_2_d; // @[Cache.scala 294:17]
      end else begin
        fence_rdata_d <= _GEN_14;
      end
    end
    if (reset) begin // @[Cache.scala 220:28]
      fence_rdata_datas <= 128'h0; // @[Cache.scala 220:28]
    end else if (_ways_0_io_in_r_valid_T_2 & ways_0_io_out_valid) begin // @[Cache.scala 293:53]
      if (2'h3 == fence_which_way) begin // @[Cache.scala 294:17]
        fence_rdata_datas <= ways_ret_datas_3_datas; // @[Cache.scala 294:17]
      end else if (2'h2 == fence_which_way) begin // @[Cache.scala 294:17]
        fence_rdata_datas <= ways_ret_datas_2_datas; // @[Cache.scala 294:17]
      end else begin
        fence_rdata_datas <= _GEN_10;
      end
    end
    if (reset) begin // @[Cache.scala 226:24]
      req_reg_addr <= 64'h0; // @[Cache.scala 226:24]
    end else if (_req_reg_T) begin // @[Cache.scala 518:17]
      req_reg_addr <= io_cpu_req_bits_addr;
    end
    if (reset) begin // @[Cache.scala 226:24]
      req_reg_data <= 64'h0; // @[Cache.scala 226:24]
    end else if (_req_reg_T) begin // @[Cache.scala 518:17]
      req_reg_data <= io_cpu_req_bits_data;
    end
    if (reset) begin // @[Cache.scala 226:24]
      req_reg_mask <= 8'h0; // @[Cache.scala 226:24]
    end else if (_req_reg_T) begin // @[Cache.scala 518:17]
      req_reg_mask <= io_cpu_req_bits_mask;
    end
    if (reset) begin // @[Cache.scala 226:24]
      req_reg_op <= 1'h0; // @[Cache.scala 226:24]
    end else if (_req_reg_T) begin // @[Cache.scala 518:17]
      req_reg_op <= io_cpu_req_bits_op;
    end
    if (reset) begin // @[Cache.scala 227:29]
      req_isCached <= 1'h0; // @[Cache.scala 227:29]
    end else if (_req_reg_T) begin // @[Cache.scala 519:22]
      req_isCached <= _req_isCached_T_5;
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_valid <= 1'h0; // @[Cache.scala 233:29]
    end else begin
      write_buffer_valid <= _T_35 | _io_cpu_resp_valid_T_3 & req_reg_op; // @[Cache.scala 543:22]
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_bits_tag <= 54'h0; // @[Cache.scala 233:29]
    end else if (_write_buffer_valid_T_7) begin // @[Cache.scala 544:65]
      write_buffer_bits_tag <= req_reg_info_tag; // @[Cache.scala 545:29]
    end else if (_T_35) begin // @[Cache.scala 553:58]
      if (req_isCached) begin // @[Cache.scala 554:33]
        write_buffer_bits_tag <= miss_info_addr[63:10]; // @[Cache.scala 570:31]
      end
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_bits_index <= 6'h0; // @[Cache.scala 233:29]
    end else if (_write_buffer_valid_T_7) begin // @[Cache.scala 544:65]
      write_buffer_bits_index <= req_reg_info_index; // @[Cache.scala 546:31]
    end else if (_T_35) begin // @[Cache.scala 553:58]
      if (req_isCached) begin // @[Cache.scala 554:33]
        write_buffer_bits_index <= miss_info_addr[9:4]; // @[Cache.scala 571:33]
      end
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_bits_offset <= 4'h0; // @[Cache.scala 233:29]
    end else if (_write_buffer_valid_T_7) begin // @[Cache.scala 544:65]
      write_buffer_bits_offset <= req_reg_info_offset; // @[Cache.scala 547:32]
    end else if (_T_35) begin // @[Cache.scala 553:58]
      if (req_isCached) begin // @[Cache.scala 554:33]
        write_buffer_bits_offset <= _write_buffer_bits_offset_T_3; // @[Cache.scala 573:34]
      end
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_bits_v <= 1'h0; // @[Cache.scala 233:29]
    end else begin
      write_buffer_bits_v <= _GEN_109;
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_bits_d <= 1'h0; // @[Cache.scala 233:29]
    end else begin
      write_buffer_bits_d <= _GEN_110;
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_bits_data <= 64'h0; // @[Cache.scala 233:29]
    end else if (_write_buffer_valid_T_7) begin // @[Cache.scala 544:65]
      write_buffer_bits_data <= req_reg_data; // @[Cache.scala 550:30]
    end else if (_T_35) begin // @[Cache.scala 553:58]
      if (req_isCached) begin // @[Cache.scala 554:33]
        write_buffer_bits_data <= _GEN_87;
      end
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_bits_replace_way <= 4'h0; // @[Cache.scala 233:29]
    end else if (_write_buffer_valid_T_7) begin // @[Cache.scala 544:65]
      write_buffer_bits_replace_way <= _write_buffer_bits_replace_way_T; // @[Cache.scala 551:37]
    end else if (_T_35) begin // @[Cache.scala 553:58]
      if (req_isCached) begin // @[Cache.scala 554:33]
        write_buffer_bits_replace_way <= replace_buffer_way_num; // @[Cache.scala 576:39]
      end
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_bits_wmask <= 8'h0; // @[Cache.scala 233:29]
    end else if (_write_buffer_valid_T_7) begin // @[Cache.scala 544:65]
      write_buffer_bits_wmask <= req_reg_mask; // @[Cache.scala 552:31]
    end else if (_T_35) begin // @[Cache.scala 553:58]
      if (req_isCached) begin // @[Cache.scala 554:33]
        write_buffer_bits_wmask <= 8'hff; // @[Cache.scala 577:33]
      end
    end
    if (reset) begin // @[Cache.scala 328:26]
      miss_info_addr <= 64'h0; // @[Cache.scala 328:26]
    end else if (_T_39) begin // @[Cache.scala 527:39]
      miss_info_addr <= req_reg_addr; // @[Cache.scala 530:20]
    end
    if (reset) begin // @[Cache.scala 334:31]
      replace_buffer_addr <= 64'h0; // @[Cache.scala 334:31]
    end else if (_T_39) begin // @[Cache.scala 527:39]
      replace_buffer_addr <= _io_mem_req_bits_addr_T_3; // @[Cache.scala 535:25]
    end
    if (reset) begin // @[Cache.scala 334:31]
      replace_buffer_data <= 128'h0; // @[Cache.scala 334:31]
    end else if (_T_39) begin // @[Cache.scala 527:39]
      replace_buffer_data <= rand_way_data_datas; // @[Cache.scala 536:25]
    end
    if (reset) begin // @[Cache.scala 334:31]
      replace_buffer_way_num <= 4'h0; // @[Cache.scala 334:31]
    end else if (_T_39) begin // @[Cache.scala 527:39]
      replace_buffer_way_num <= rand_way; // @[Cache.scala 537:28]
    end
    if (reset) begin // @[Cache.scala 334:31]
      replace_buffer_v <= 1'h0; // @[Cache.scala 334:31]
    end else if (_T_39) begin // @[Cache.scala 527:39]
      replace_buffer_v <= rand_way_data_v; // @[Cache.scala 538:22]
    end
    if (reset) begin // @[Cache.scala 334:31]
      replace_buffer_d <= 1'h0; // @[Cache.scala 334:31]
    end else if (_T_39) begin // @[Cache.scala 527:39]
      replace_buffer_d <= rand_way_data_d; // @[Cache.scala 539:22]
    end
    if (reset) begin // @[Counter.scala 60:40]
      value_2 <= 1'h0; // @[Counter.scala 60:40]
    end else if (_T_22 & _T_34 & req_isCached) begin // @[Cache.scala 428:64]
      value_2 <= value_2 + 1'h1; // @[Counter.scala 76:15]
    end else if (_io_cpu_resp_valid_T) begin // @[Cache.scala 430:32]
      value_2 <= 1'h0; // @[Cache.scala 431:22]
    end
    if (reset) begin // @[Cache.scala 391:25]
      load_ret <= 64'h0; // @[Cache.scala 391:25]
    end else if (state == 3'h4 & (~req_reg_op & value_2 == req_reg_info_offset[3]) & io_mem_resp_valid) begin // @[Cache.scala 392:153]
      load_ret <= io_mem_resp_bits_data; // @[Cache.scala 393:14]
    end
    if (reset) begin // @[Counter.scala 60:40]
      value_3 <= 1'h0; // @[Counter.scala 60:40]
    end else if (!(_T_48)) begin // @[Cache.scala 444:4]
      if (_T_56) begin // @[Cache.scala 455:4]
        if (_T_57 & req_isCached) begin // @[Cache.scala 465:43]
          value_3 <= value_3 + 1'h1; // @[Counter.scala 76:15]
        end
      end
    end
    if (reset) begin // @[Counter.scala 60:40]
      value_4 <= 1'h0; // @[Counter.scala 60:40]
    end else if (!(_write_buffer_valid_T_7)) begin // @[Cache.scala 544:65]
      if (_T_35) begin // @[Cache.scala 553:58]
        if (req_isCached) begin // @[Cache.scala 554:33]
          value_4 <= value_4 + 1'h1; // @[Counter.scala 76:15]
        end
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~(|rand_way | reset)) begin
          $fwrite(32'h80000002,"Assertion failed\n    at Cache.scala:323 assert(rand_way.orR() === 1.U)\n"); // @[Cache.scala 323:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~(|rand_way | reset)) begin
          $fatal; // @[Cache.scala 323:9]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  value = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  value_1 = _RAND_2[0:0];
  _RAND_3 = {2{`RANDOM}};
  fence_rdata_tag = _RAND_3[53:0];
  _RAND_4 = {1{`RANDOM}};
  fence_rdata_v = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  fence_rdata_d = _RAND_5[0:0];
  _RAND_6 = {4{`RANDOM}};
  fence_rdata_datas = _RAND_6[127:0];
  _RAND_7 = {2{`RANDOM}};
  req_reg_addr = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  req_reg_data = _RAND_8[63:0];
  _RAND_9 = {1{`RANDOM}};
  req_reg_mask = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  req_reg_op = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  req_isCached = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  write_buffer_valid = _RAND_12[0:0];
  _RAND_13 = {2{`RANDOM}};
  write_buffer_bits_tag = _RAND_13[53:0];
  _RAND_14 = {1{`RANDOM}};
  write_buffer_bits_index = _RAND_14[5:0];
  _RAND_15 = {1{`RANDOM}};
  write_buffer_bits_offset = _RAND_15[3:0];
  _RAND_16 = {1{`RANDOM}};
  write_buffer_bits_v = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  write_buffer_bits_d = _RAND_17[0:0];
  _RAND_18 = {2{`RANDOM}};
  write_buffer_bits_data = _RAND_18[63:0];
  _RAND_19 = {1{`RANDOM}};
  write_buffer_bits_replace_way = _RAND_19[3:0];
  _RAND_20 = {1{`RANDOM}};
  write_buffer_bits_wmask = _RAND_20[7:0];
  _RAND_21 = {2{`RANDOM}};
  miss_info_addr = _RAND_21[63:0];
  _RAND_22 = {2{`RANDOM}};
  replace_buffer_addr = _RAND_22[63:0];
  _RAND_23 = {4{`RANDOM}};
  replace_buffer_data = _RAND_23[127:0];
  _RAND_24 = {1{`RANDOM}};
  replace_buffer_way_num = _RAND_24[3:0];
  _RAND_25 = {1{`RANDOM}};
  replace_buffer_v = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  replace_buffer_d = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  value_2 = _RAND_27[0:0];
  _RAND_28 = {2{`RANDOM}};
  load_ret = _RAND_28[63:0];
  _RAND_29 = {1{`RANDOM}};
  value_3 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  value_4 = _RAND_30[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_210013_Cache_1(
  input         clock,
  input         reset,
  output        io_cpu_req_ready,
  input         io_cpu_req_valid,
  input  [63:0] io_cpu_req_bits_addr,
  input  [63:0] io_cpu_req_bits_data,
  input  [7:0]  io_cpu_req_bits_mask,
  input         io_cpu_req_bits_op,
  output        io_cpu_resp_valid,
  output [63:0] io_cpu_resp_bits_data,
  output [3:0]  io_cpu_resp_bits_cmd,
  input         io_mem_req_ready,
  output        io_mem_req_valid,
  output [63:0] io_mem_req_bits_addr,
  output [63:0] io_mem_req_bits_data,
  output [3:0]  io_mem_req_bits_cmd,
  output [1:0]  io_mem_req_bits_len,
  output [7:0]  io_mem_req_bits_mask,
  output        io_mem_resp_ready,
  input         io_mem_resp_valid,
  input  [63:0] io_mem_resp_bits_data,
  input  [3:0]  io_mem_resp_bits_cmd,
  input         io_fence_i,
  output        io_fence_i_done
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [127:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [63:0] _RAND_21;
  reg [63:0] _RAND_22;
  reg [127:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  wire  ways_0_clock; // @[Cache.scala 210:40]
  wire  ways_0_reset; // @[Cache.scala 210:40]
  wire  ways_0_io_out_valid; // @[Cache.scala 210:40]
  wire [53:0] ways_0_io_out_bits_tag; // @[Cache.scala 210:40]
  wire  ways_0_io_out_bits_v; // @[Cache.scala 210:40]
  wire  ways_0_io_out_bits_d; // @[Cache.scala 210:40]
  wire [127:0] ways_0_io_out_bits_datas; // @[Cache.scala 210:40]
  wire  ways_0_io_in_w_valid; // @[Cache.scala 210:40]
  wire [53:0] ways_0_io_in_w_bits_tag; // @[Cache.scala 210:40]
  wire [5:0] ways_0_io_in_w_bits_index; // @[Cache.scala 210:40]
  wire [3:0] ways_0_io_in_w_bits_offset; // @[Cache.scala 210:40]
  wire  ways_0_io_in_w_bits_v; // @[Cache.scala 210:40]
  wire  ways_0_io_in_w_bits_d; // @[Cache.scala 210:40]
  wire [7:0] ways_0_io_in_w_bits_mask; // @[Cache.scala 210:40]
  wire [63:0] ways_0_io_in_w_bits_data; // @[Cache.scala 210:40]
  wire  ways_0_io_in_w_bits_op; // @[Cache.scala 210:40]
  wire  ways_0_io_in_r_valid; // @[Cache.scala 210:40]
  wire [5:0] ways_0_io_in_r_bits_index; // @[Cache.scala 210:40]
  wire  ways_0_io_fence_invalid; // @[Cache.scala 210:40]
  wire  ways_1_clock; // @[Cache.scala 210:40]
  wire  ways_1_reset; // @[Cache.scala 210:40]
  wire  ways_1_io_out_valid; // @[Cache.scala 210:40]
  wire [53:0] ways_1_io_out_bits_tag; // @[Cache.scala 210:40]
  wire  ways_1_io_out_bits_v; // @[Cache.scala 210:40]
  wire  ways_1_io_out_bits_d; // @[Cache.scala 210:40]
  wire [127:0] ways_1_io_out_bits_datas; // @[Cache.scala 210:40]
  wire  ways_1_io_in_w_valid; // @[Cache.scala 210:40]
  wire [53:0] ways_1_io_in_w_bits_tag; // @[Cache.scala 210:40]
  wire [5:0] ways_1_io_in_w_bits_index; // @[Cache.scala 210:40]
  wire [3:0] ways_1_io_in_w_bits_offset; // @[Cache.scala 210:40]
  wire  ways_1_io_in_w_bits_v; // @[Cache.scala 210:40]
  wire  ways_1_io_in_w_bits_d; // @[Cache.scala 210:40]
  wire [7:0] ways_1_io_in_w_bits_mask; // @[Cache.scala 210:40]
  wire [63:0] ways_1_io_in_w_bits_data; // @[Cache.scala 210:40]
  wire  ways_1_io_in_w_bits_op; // @[Cache.scala 210:40]
  wire  ways_1_io_in_r_valid; // @[Cache.scala 210:40]
  wire [5:0] ways_1_io_in_r_bits_index; // @[Cache.scala 210:40]
  wire  ways_1_io_fence_invalid; // @[Cache.scala 210:40]
  wire  ways_2_clock; // @[Cache.scala 210:40]
  wire  ways_2_reset; // @[Cache.scala 210:40]
  wire  ways_2_io_out_valid; // @[Cache.scala 210:40]
  wire [53:0] ways_2_io_out_bits_tag; // @[Cache.scala 210:40]
  wire  ways_2_io_out_bits_v; // @[Cache.scala 210:40]
  wire  ways_2_io_out_bits_d; // @[Cache.scala 210:40]
  wire [127:0] ways_2_io_out_bits_datas; // @[Cache.scala 210:40]
  wire  ways_2_io_in_w_valid; // @[Cache.scala 210:40]
  wire [53:0] ways_2_io_in_w_bits_tag; // @[Cache.scala 210:40]
  wire [5:0] ways_2_io_in_w_bits_index; // @[Cache.scala 210:40]
  wire [3:0] ways_2_io_in_w_bits_offset; // @[Cache.scala 210:40]
  wire  ways_2_io_in_w_bits_v; // @[Cache.scala 210:40]
  wire  ways_2_io_in_w_bits_d; // @[Cache.scala 210:40]
  wire [7:0] ways_2_io_in_w_bits_mask; // @[Cache.scala 210:40]
  wire [63:0] ways_2_io_in_w_bits_data; // @[Cache.scala 210:40]
  wire  ways_2_io_in_w_bits_op; // @[Cache.scala 210:40]
  wire  ways_2_io_in_r_valid; // @[Cache.scala 210:40]
  wire [5:0] ways_2_io_in_r_bits_index; // @[Cache.scala 210:40]
  wire  ways_2_io_fence_invalid; // @[Cache.scala 210:40]
  wire  ways_3_clock; // @[Cache.scala 210:40]
  wire  ways_3_reset; // @[Cache.scala 210:40]
  wire  ways_3_io_out_valid; // @[Cache.scala 210:40]
  wire [53:0] ways_3_io_out_bits_tag; // @[Cache.scala 210:40]
  wire  ways_3_io_out_bits_v; // @[Cache.scala 210:40]
  wire  ways_3_io_out_bits_d; // @[Cache.scala 210:40]
  wire [127:0] ways_3_io_out_bits_datas; // @[Cache.scala 210:40]
  wire  ways_3_io_in_w_valid; // @[Cache.scala 210:40]
  wire [53:0] ways_3_io_in_w_bits_tag; // @[Cache.scala 210:40]
  wire [5:0] ways_3_io_in_w_bits_index; // @[Cache.scala 210:40]
  wire [3:0] ways_3_io_in_w_bits_offset; // @[Cache.scala 210:40]
  wire  ways_3_io_in_w_bits_v; // @[Cache.scala 210:40]
  wire  ways_3_io_in_w_bits_d; // @[Cache.scala 210:40]
  wire [7:0] ways_3_io_in_w_bits_mask; // @[Cache.scala 210:40]
  wire [63:0] ways_3_io_in_w_bits_data; // @[Cache.scala 210:40]
  wire  ways_3_io_in_w_bits_op; // @[Cache.scala 210:40]
  wire  ways_3_io_in_r_valid; // @[Cache.scala 210:40]
  wire [5:0] ways_3_io_in_r_bits_index; // @[Cache.scala 210:40]
  wire  ways_3_io_fence_invalid; // @[Cache.scala 210:40]
  wire  rand_num_prng_clock; // @[PRNG.scala 82:22]
  wire  rand_num_prng_reset; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_0; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_1; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_2; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_3; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_4; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_5; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_6; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_7; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_8; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_9; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_10; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_11; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_12; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_13; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_14; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_15; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_16; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_17; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_18; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_19; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_20; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_21; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_22; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_23; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_24; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_25; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_26; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_27; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_28; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_29; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_30; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_31; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_32; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_33; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_34; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_35; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_36; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_37; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_38; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_39; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_40; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_41; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_42; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_43; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_44; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_45; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_46; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_47; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_48; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_49; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_50; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_51; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_52; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_53; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_54; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_55; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_56; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_57; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_58; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_59; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_60; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_61; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_62; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_63; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_64; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_65; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_66; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_67; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_68; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_69; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_70; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_71; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_72; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_73; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_74; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_75; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_76; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_77; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_78; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_79; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_80; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_81; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_82; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_83; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_84; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_85; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_86; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_87; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_88; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_89; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_90; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_91; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_92; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_93; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_94; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_95; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_96; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_97; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_98; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_99; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_100; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_101; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_102; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_103; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_104; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_105; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_106; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_107; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_108; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_109; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_110; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_111; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_112; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_113; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_114; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_115; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_116; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_117; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_118; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_119; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_120; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_121; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_122; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_123; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_124; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_125; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_126; // @[PRNG.scala 82:22]
  wire  rand_num_prng_io_out_127; // @[PRNG.scala 82:22]
  reg [2:0] state; // @[Cache.scala 214:22]
  reg [7:0] value; // @[Counter.scala 60:40]
  reg  value_1; // @[Counter.scala 60:40]
  reg [53:0] fence_rdata_tag; // @[Cache.scala 220:28]
  reg  fence_rdata_v; // @[Cache.scala 220:28]
  reg  fence_rdata_d; // @[Cache.scala 220:28]
  reg [127:0] fence_rdata_datas; // @[Cache.scala 220:28]
  reg [63:0] req_reg_addr; // @[Cache.scala 226:24]
  reg [63:0] req_reg_data; // @[Cache.scala 226:24]
  reg [7:0] req_reg_mask; // @[Cache.scala 226:24]
  reg  req_reg_op; // @[Cache.scala 226:24]
  reg  req_isCached; // @[Cache.scala 227:29]
  wire [3:0] req_reg_info_offset = req_reg_addr[3:0]; // @[Cache.scala 229:43]
  wire [5:0] req_reg_info_index = req_reg_addr[9:4]; // @[Cache.scala 229:43]
  wire [53:0] req_reg_info_tag = req_reg_addr[63:10]; // @[Cache.scala 229:43]
  reg  write_buffer_valid; // @[Cache.scala 233:29]
  reg [53:0] write_buffer_bits_tag; // @[Cache.scala 233:29]
  reg [5:0] write_buffer_bits_index; // @[Cache.scala 233:29]
  reg [3:0] write_buffer_bits_offset; // @[Cache.scala 233:29]
  reg  write_buffer_bits_v; // @[Cache.scala 233:29]
  reg  write_buffer_bits_d; // @[Cache.scala 233:29]
  reg [63:0] write_buffer_bits_data; // @[Cache.scala 233:29]
  reg [3:0] write_buffer_bits_replace_way; // @[Cache.scala 233:29]
  reg [7:0] write_buffer_bits_wmask; // @[Cache.scala 233:29]
  wire  _conflict_hit_write_T_2 = state == 3'h1; // @[Cache.scala 255:16]
  wire  _conflict_hit_write_T_13 = io_cpu_req_bits_addr[9:4] == req_reg_info_index; // @[Cache.scala 258:55]
  wire  _conflict_hit_write_T_14 = state == 3'h1 & req_reg_op & ~io_cpu_req_bits_op & _conflict_hit_write_T_13; // @[Cache.scala 255:84]
  wire  conflict_hit_write = write_buffer_valid | _conflict_hit_write_T_14; // @[Cache.scala 253:9]
  wire  _ways_0_io_in_r_valid_T = ~conflict_hit_write; // @[Cache.scala 279:50]
  wire  _ways_0_io_in_r_valid_T_2 = state == 3'h5; // @[Cache.scala 285:63]
  wire  _ways_0_io_in_r_valid_T_3 = write_buffer_valid ? 1'h0 : state == 3'h5; // @[Cache.scala 285:31]
  wire [7:0] _GEN_0 = state != 3'h5 & state != 3'h6 ? {{2'd0}, io_cpu_req_bits_addr[9:4]} : value; // @[Cache.scala 274:53 Cache.scala 276:30 Cache.scala 283:30]
  wire [1:0] fence_which_way = value[7:6]; // @[Cache.scala 289:40]
  wire [5:0] fence_which_index = value[5:0]; // @[Cache.scala 290:42]
  wire [127:0] ways_ret_datas_0_datas = ways_0_io_out_bits_datas; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire [127:0] ways_ret_datas_1_datas = ways_1_io_out_bits_datas; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire [127:0] _GEN_10 = 2'h1 == fence_which_way ? ways_ret_datas_1_datas : ways_ret_datas_0_datas; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire [127:0] ways_ret_datas_2_datas = ways_2_io_out_bits_datas; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire [127:0] ways_ret_datas_3_datas = ways_3_io_out_bits_datas; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  ways_ret_datas_0_d = ways_0_io_out_bits_d; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  ways_ret_datas_1_d = ways_1_io_out_bits_d; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  _GEN_14 = 2'h1 == fence_which_way ? ways_ret_datas_1_d : ways_ret_datas_0_d; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire  ways_ret_datas_2_d = ways_2_io_out_bits_d; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  _GEN_15 = 2'h2 == fence_which_way ? ways_ret_datas_2_d : _GEN_14; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire  ways_ret_datas_3_d = ways_3_io_out_bits_d; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  _GEN_16 = 2'h3 == fence_which_way ? ways_ret_datas_3_d : _GEN_15; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire  ways_ret_datas_0_v = ways_0_io_out_bits_v; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  ways_ret_datas_1_v = ways_1_io_out_bits_v; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  _GEN_18 = 2'h1 == fence_which_way ? ways_ret_datas_1_v : ways_ret_datas_0_v; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire  ways_ret_datas_2_v = ways_2_io_out_bits_v; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  _GEN_19 = 2'h2 == fence_which_way ? ways_ret_datas_2_v : _GEN_18; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire  ways_ret_datas_3_v = ways_3_io_out_bits_v; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire  _GEN_20 = 2'h3 == fence_which_way ? ways_ret_datas_3_v : _GEN_19; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire [53:0] ways_ret_datas_0_tag = ways_0_io_out_bits_tag; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire [53:0] ways_ret_datas_1_tag = ways_1_io_out_bits_tag; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire [53:0] _GEN_22 = 2'h1 == fence_which_way ? ways_ret_datas_1_tag : ways_ret_datas_0_tag; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire [53:0] ways_ret_datas_2_tag = ways_2_io_out_bits_tag; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire [53:0] _GEN_23 = 2'h2 == fence_which_way ? ways_ret_datas_2_tag : _GEN_22; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire [53:0] ways_ret_datas_3_tag = ways_3_io_out_bits_tag; // @[Cache.scala 266:28 Cache.scala 270:11]
  wire [53:0] tmp_addr_tag = 2'h3 == fence_which_way ? ways_ret_datas_3_tag : _GEN_23; // @[Cache.scala 294:17 Cache.scala 294:17]
  wire  ways_compare_res_hi_hi = ways_0_io_out_bits_tag == req_reg_info_tag & ways_ret_datas_0_v; // @[Cache.scala 300:50]
  wire  ways_compare_res_hi_lo = ways_1_io_out_bits_tag == req_reg_info_tag & ways_ret_datas_1_v; // @[Cache.scala 300:50]
  wire  ways_compare_res_lo_hi = ways_2_io_out_bits_tag == req_reg_info_tag & ways_ret_datas_2_v; // @[Cache.scala 300:50]
  wire  ways_compare_res_lo_lo = ways_3_io_out_bits_tag == req_reg_info_tag & ways_ret_datas_3_v; // @[Cache.scala 300:50]
  wire [3:0] ways_compare_res = {ways_compare_res_hi_hi,ways_compare_res_hi_lo,ways_compare_res_lo_hi,
    ways_compare_res_lo_lo}; // @[Cat.scala 30:58]
  wire  _is_miss_T_3 = ~req_isCached; // @[Cache.scala 304:70]
  wire  is_miss = ~(|ways_compare_res) & req_isCached | ~req_isCached; // @[Cache.scala 304:67]
  wire [127:0] _select_data_T_4 = ways_compare_res[3] ? ways_ret_datas_0_datas : 128'h0; // @[Mux.scala 27:72]
  wire [127:0] _select_data_T_5 = ways_compare_res[2] ? ways_ret_datas_1_datas : 128'h0; // @[Mux.scala 27:72]
  wire [127:0] _select_data_T_6 = ways_compare_res[1] ? ways_ret_datas_2_datas : 128'h0; // @[Mux.scala 27:72]
  wire [127:0] _select_data_T_7 = ways_compare_res[0] ? ways_ret_datas_3_datas : 128'h0; // @[Mux.scala 27:72]
  wire [127:0] _select_data_T_8 = _select_data_T_4 | _select_data_T_5; // @[Mux.scala 27:72]
  wire [127:0] _select_data_T_9 = _select_data_T_8 | _select_data_T_6; // @[Mux.scala 27:72]
  wire [7:0] rand_num_lo_lo_lo_lo = {rand_num_prng_io_out_7,rand_num_prng_io_out_6,rand_num_prng_io_out_5,
    rand_num_prng_io_out_4,rand_num_prng_io_out_3,rand_num_prng_io_out_2,rand_num_prng_io_out_1,rand_num_prng_io_out_0}; // @[PRNG.scala 86:17]
  wire [15:0] rand_num_lo_lo_lo = {rand_num_prng_io_out_15,rand_num_prng_io_out_14,rand_num_prng_io_out_13,
    rand_num_prng_io_out_12,rand_num_prng_io_out_11,rand_num_prng_io_out_10,rand_num_prng_io_out_9,
    rand_num_prng_io_out_8,rand_num_lo_lo_lo_lo}; // @[PRNG.scala 86:17]
  wire [7:0] rand_num_lo_lo_hi_lo = {rand_num_prng_io_out_23,rand_num_prng_io_out_22,rand_num_prng_io_out_21,
    rand_num_prng_io_out_20,rand_num_prng_io_out_19,rand_num_prng_io_out_18,rand_num_prng_io_out_17,
    rand_num_prng_io_out_16}; // @[PRNG.scala 86:17]
  wire [31:0] rand_num_lo_lo = {rand_num_prng_io_out_31,rand_num_prng_io_out_30,rand_num_prng_io_out_29,
    rand_num_prng_io_out_28,rand_num_prng_io_out_27,rand_num_prng_io_out_26,rand_num_prng_io_out_25,
    rand_num_prng_io_out_24,rand_num_lo_lo_hi_lo,rand_num_lo_lo_lo}; // @[PRNG.scala 86:17]
  wire [7:0] rand_num_lo_hi_lo_lo = {rand_num_prng_io_out_39,rand_num_prng_io_out_38,rand_num_prng_io_out_37,
    rand_num_prng_io_out_36,rand_num_prng_io_out_35,rand_num_prng_io_out_34,rand_num_prng_io_out_33,
    rand_num_prng_io_out_32}; // @[PRNG.scala 86:17]
  wire [15:0] rand_num_lo_hi_lo = {rand_num_prng_io_out_47,rand_num_prng_io_out_46,rand_num_prng_io_out_45,
    rand_num_prng_io_out_44,rand_num_prng_io_out_43,rand_num_prng_io_out_42,rand_num_prng_io_out_41,
    rand_num_prng_io_out_40,rand_num_lo_hi_lo_lo}; // @[PRNG.scala 86:17]
  wire [7:0] rand_num_lo_hi_hi_lo = {rand_num_prng_io_out_55,rand_num_prng_io_out_54,rand_num_prng_io_out_53,
    rand_num_prng_io_out_52,rand_num_prng_io_out_51,rand_num_prng_io_out_50,rand_num_prng_io_out_49,
    rand_num_prng_io_out_48}; // @[PRNG.scala 86:17]
  wire [31:0] rand_num_lo_hi = {rand_num_prng_io_out_63,rand_num_prng_io_out_62,rand_num_prng_io_out_61,
    rand_num_prng_io_out_60,rand_num_prng_io_out_59,rand_num_prng_io_out_58,rand_num_prng_io_out_57,
    rand_num_prng_io_out_56,rand_num_lo_hi_hi_lo,rand_num_lo_hi_lo}; // @[PRNG.scala 86:17]
  wire [7:0] rand_num_hi_lo_lo_lo = {rand_num_prng_io_out_71,rand_num_prng_io_out_70,rand_num_prng_io_out_69,
    rand_num_prng_io_out_68,rand_num_prng_io_out_67,rand_num_prng_io_out_66,rand_num_prng_io_out_65,
    rand_num_prng_io_out_64}; // @[PRNG.scala 86:17]
  wire [15:0] rand_num_hi_lo_lo = {rand_num_prng_io_out_79,rand_num_prng_io_out_78,rand_num_prng_io_out_77,
    rand_num_prng_io_out_76,rand_num_prng_io_out_75,rand_num_prng_io_out_74,rand_num_prng_io_out_73,
    rand_num_prng_io_out_72,rand_num_hi_lo_lo_lo}; // @[PRNG.scala 86:17]
  wire [7:0] rand_num_hi_lo_hi_lo = {rand_num_prng_io_out_87,rand_num_prng_io_out_86,rand_num_prng_io_out_85,
    rand_num_prng_io_out_84,rand_num_prng_io_out_83,rand_num_prng_io_out_82,rand_num_prng_io_out_81,
    rand_num_prng_io_out_80}; // @[PRNG.scala 86:17]
  wire [31:0] rand_num_hi_lo = {rand_num_prng_io_out_95,rand_num_prng_io_out_94,rand_num_prng_io_out_93,
    rand_num_prng_io_out_92,rand_num_prng_io_out_91,rand_num_prng_io_out_90,rand_num_prng_io_out_89,
    rand_num_prng_io_out_88,rand_num_hi_lo_hi_lo,rand_num_hi_lo_lo}; // @[PRNG.scala 86:17]
  wire [7:0] rand_num_hi_hi_lo_lo = {rand_num_prng_io_out_103,rand_num_prng_io_out_102,rand_num_prng_io_out_101,
    rand_num_prng_io_out_100,rand_num_prng_io_out_99,rand_num_prng_io_out_98,rand_num_prng_io_out_97,
    rand_num_prng_io_out_96}; // @[PRNG.scala 86:17]
  wire [15:0] rand_num_hi_hi_lo = {rand_num_prng_io_out_111,rand_num_prng_io_out_110,rand_num_prng_io_out_109,
    rand_num_prng_io_out_108,rand_num_prng_io_out_107,rand_num_prng_io_out_106,rand_num_prng_io_out_105,
    rand_num_prng_io_out_104,rand_num_hi_hi_lo_lo}; // @[PRNG.scala 86:17]
  wire [7:0] rand_num_hi_hi_hi_lo = {rand_num_prng_io_out_119,rand_num_prng_io_out_118,rand_num_prng_io_out_117,
    rand_num_prng_io_out_116,rand_num_prng_io_out_115,rand_num_prng_io_out_114,rand_num_prng_io_out_113,
    rand_num_prng_io_out_112}; // @[PRNG.scala 86:17]
  wire [31:0] rand_num_hi_hi = {rand_num_prng_io_out_127,rand_num_prng_io_out_126,rand_num_prng_io_out_125,
    rand_num_prng_io_out_124,rand_num_prng_io_out_123,rand_num_prng_io_out_122,rand_num_prng_io_out_121,
    rand_num_prng_io_out_120,rand_num_hi_hi_hi_lo,rand_num_hi_hi_lo}; // @[PRNG.scala 86:17]
  wire [127:0] _rand_num_T = {rand_num_hi_hi,rand_num_hi_lo,rand_num_lo_hi,rand_num_lo_lo}; // @[PRNG.scala 86:17]
  wire [1:0] rand_num = _rand_num_T[1:0]; // @[Cache.scala 320:46]
  wire [1:0] write_buffer_conflict_with_replace_hi = write_buffer_bits_replace_way[3:2]; // @[OneHot.scala 30:18]
  wire [1:0] write_buffer_conflict_with_replace_lo = write_buffer_bits_replace_way[1:0]; // @[OneHot.scala 31:18]
  wire  write_buffer_conflict_with_replace_hi_1 = |write_buffer_conflict_with_replace_hi; // @[OneHot.scala 32:14]
  wire [1:0] _write_buffer_conflict_with_replace_T = write_buffer_conflict_with_replace_hi |
    write_buffer_conflict_with_replace_lo; // @[OneHot.scala 32:28]
  wire  write_buffer_conflict_with_replace_lo_1 = _write_buffer_conflict_with_replace_T[1]; // @[CircuitMath.scala 30:8]
  wire [1:0] _write_buffer_conflict_with_replace_T_1 = {write_buffer_conflict_with_replace_hi_1,
    write_buffer_conflict_with_replace_lo_1}; // @[Cat.scala 30:58]
  wire  write_buffer_conflict_with_replace = write_buffer_valid & rand_num == _write_buffer_conflict_with_replace_T_1; // @[Cache.scala 321:63]
  wire [1:0] _rand_way_T_1 = rand_num + 2'h1; // @[Cache.scala 322:77]
  wire [1:0] _rand_way_T_3 = write_buffer_conflict_with_replace ? _rand_way_T_1 : rand_num; // @[Cache.scala 322:30]
  wire [3:0] rand_way = 4'h1 << _rand_way_T_3; // @[OneHot.scala 58:35]
  wire [127:0] _rand_way_data_T_4 = rand_way[0] ? ways_ret_datas_0_datas : 128'h0; // @[Mux.scala 27:72]
  wire [127:0] _rand_way_data_T_5 = rand_way[1] ? ways_ret_datas_1_datas : 128'h0; // @[Mux.scala 27:72]
  wire [127:0] _rand_way_data_T_6 = rand_way[2] ? ways_ret_datas_2_datas : 128'h0; // @[Mux.scala 27:72]
  wire [127:0] _rand_way_data_T_7 = rand_way[3] ? ways_ret_datas_3_datas : 128'h0; // @[Mux.scala 27:72]
  wire [127:0] _rand_way_data_T_8 = _rand_way_data_T_4 | _rand_way_data_T_5; // @[Mux.scala 27:72]
  wire [127:0] _rand_way_data_T_9 = _rand_way_data_T_8 | _rand_way_data_T_6; // @[Mux.scala 27:72]
  wire [127:0] rand_way_data_datas = _rand_way_data_T_9 | _rand_way_data_T_7; // @[Mux.scala 27:72]
  wire  rand_way_data_d = rand_way[0] & ways_ret_datas_0_d | rand_way[1] & ways_ret_datas_1_d | rand_way[2] &
    ways_ret_datas_2_d | rand_way[3] & ways_ret_datas_3_d; // @[Mux.scala 27:72]
  wire  rand_way_data_v = rand_way[0] & ways_ret_datas_0_v | rand_way[1] & ways_ret_datas_1_v | rand_way[2] &
    ways_ret_datas_2_v | rand_way[3] & ways_ret_datas_3_v; // @[Mux.scala 27:72]
  wire [53:0] _rand_way_data_T_25 = rand_way[0] ? ways_ret_datas_0_tag : 54'h0; // @[Mux.scala 27:72]
  wire [53:0] _rand_way_data_T_26 = rand_way[1] ? ways_ret_datas_1_tag : 54'h0; // @[Mux.scala 27:72]
  wire [53:0] _rand_way_data_T_27 = rand_way[2] ? ways_ret_datas_2_tag : 54'h0; // @[Mux.scala 27:72]
  wire [53:0] _rand_way_data_T_28 = rand_way[3] ? ways_ret_datas_3_tag : 54'h0; // @[Mux.scala 27:72]
  wire [53:0] _rand_way_data_T_29 = _rand_way_data_T_25 | _rand_way_data_T_26; // @[Mux.scala 27:72]
  wire [53:0] _rand_way_data_T_30 = _rand_way_data_T_29 | _rand_way_data_T_27; // @[Mux.scala 27:72]
  wire [53:0] rand_way_data_tag = _rand_way_data_T_30 | _rand_way_data_T_28; // @[Mux.scala 27:72]
  reg [63:0] miss_info_addr; // @[Cache.scala 328:26]
  reg [63:0] replace_buffer_addr; // @[Cache.scala 334:31]
  reg [127:0] replace_buffer_data; // @[Cache.scala 334:31]
  reg [3:0] replace_buffer_way_num; // @[Cache.scala 334:31]
  reg  replace_buffer_v; // @[Cache.scala 334:31]
  reg  replace_buffer_d; // @[Cache.scala 334:31]
  wire [3:0] _ways_0_io_in_w_valid_T = {write_buffer_valid,write_buffer_valid,write_buffer_valid,write_buffer_valid}; // @[Cat.scala 30:58]
  wire [3:0] _GEN_149 = {{3'd0}, write_buffer_bits_replace_way[0]}; // @[Cache.scala 378:35]
  wire [3:0] _ways_0_io_in_w_valid_T_1 = _GEN_149 & _ways_0_io_in_w_valid_T; // @[Cache.scala 378:35]
  wire [3:0] _GEN_150 = {{3'd0}, write_buffer_bits_replace_way[1]}; // @[Cache.scala 378:35]
  wire [3:0] _ways_1_io_in_w_valid_T_1 = _GEN_150 & _ways_0_io_in_w_valid_T; // @[Cache.scala 378:35]
  wire [3:0] _GEN_151 = {{3'd0}, write_buffer_bits_replace_way[2]}; // @[Cache.scala 378:35]
  wire [3:0] _ways_2_io_in_w_valid_T_1 = _GEN_151 & _ways_0_io_in_w_valid_T; // @[Cache.scala 378:35]
  wire [3:0] _GEN_152 = {{3'd0}, write_buffer_bits_replace_way[3]}; // @[Cache.scala 378:35]
  wire [3:0] _ways_3_io_in_w_valid_T_1 = _GEN_152 & _ways_0_io_in_w_valid_T; // @[Cache.scala 378:35]
  reg  value_2; // @[Counter.scala 60:40]
  reg [63:0] load_ret; // @[Cache.scala 391:25]
  wire  _T_22 = state == 3'h4; // @[Cache.scala 392:15]
  wire  _T_23 = ~req_reg_op; // @[Cache.scala 392:33]
  wire  _io_cpu_resp_valid_T = state == 3'h0; // @[Cache.scala 398:31]
  wire  _io_cpu_resp_valid_T_2 = ~is_miss; // @[Cache.scala 398:70]
  wire  _io_cpu_resp_valid_T_3 = _conflict_hit_write_T_2 & ~is_miss; // @[Cache.scala 398:67]
  wire  _io_cpu_resp_valid_T_4 = state == 3'h0 | _conflict_hit_write_T_2 & ~is_miss; // @[Cache.scala 398:43]
  wire  _io_cpu_resp_valid_T_15 = _T_22 & (req_reg_op & value_2 & io_mem_resp_valid); // @[Cache.scala 401:44]
  wire  _io_cpu_resp_valid_T_17 = req_isCached & (_T_22 & (_T_23 & value_2 & io_mem_resp_valid) |
    _io_cpu_resp_valid_T_15); // @[Cache.scala 400:19]
  wire  _io_cpu_resp_valid_T_18 = state == 3'h0 | _conflict_hit_write_T_2 & ~is_miss | _io_cpu_resp_valid_T_17; // @[Cache.scala 398:81]
  wire  _io_cpu_resp_valid_T_24 = _is_miss_T_3 & (_T_22 & (_T_23 & io_mem_resp_valid)); // @[Cache.scala 402:20]
  wire  io_cpu_resp_bits_data_isHigh = req_reg_addr[3]; // @[Cache.scala 409:32]
  wire [127:0] select_data = _select_data_T_9 | _select_data_T_7; // @[Mux.scala 27:72]
  wire [63:0] io_cpu_resp_bits_data_tmp_data = io_cpu_resp_bits_data_isHigh ? select_data[127:64] : select_data[63:0]; // @[Cache.scala 410:22]
  wire [7:0] io_cpu_resp_bits_data_lo_lo_lo = req_reg_mask[0] ? io_cpu_resp_bits_data_tmp_data[7:0] : 8'h0; // @[Cache.scala 411:17]
  wire [7:0] io_cpu_resp_bits_data_lo_lo_hi = req_reg_mask[1] ? io_cpu_resp_bits_data_tmp_data[15:8] : 8'h0; // @[Cache.scala 411:17]
  wire [7:0] io_cpu_resp_bits_data_lo_hi_lo = req_reg_mask[2] ? io_cpu_resp_bits_data_tmp_data[23:16] : 8'h0; // @[Cache.scala 411:17]
  wire [7:0] io_cpu_resp_bits_data_lo_hi_hi = req_reg_mask[3] ? io_cpu_resp_bits_data_tmp_data[31:24] : 8'h0; // @[Cache.scala 411:17]
  wire [7:0] io_cpu_resp_bits_data_hi_lo_lo = req_reg_mask[4] ? io_cpu_resp_bits_data_tmp_data[39:32] : 8'h0; // @[Cache.scala 411:17]
  wire [7:0] io_cpu_resp_bits_data_hi_lo_hi = req_reg_mask[5] ? io_cpu_resp_bits_data_tmp_data[47:40] : 8'h0; // @[Cache.scala 411:17]
  wire [7:0] io_cpu_resp_bits_data_hi_hi_lo = req_reg_mask[6] ? io_cpu_resp_bits_data_tmp_data[55:48] : 8'h0; // @[Cache.scala 411:17]
  wire [7:0] io_cpu_resp_bits_data_hi_hi_hi = req_reg_mask[7] ? io_cpu_resp_bits_data_tmp_data[63:56] : 8'h0; // @[Cache.scala 411:17]
  wire [63:0] _io_cpu_resp_bits_data_T_8 = {io_cpu_resp_bits_data_hi_hi_hi,io_cpu_resp_bits_data_hi_hi_lo,
    io_cpu_resp_bits_data_hi_lo_hi,io_cpu_resp_bits_data_hi_lo_lo,io_cpu_resp_bits_data_lo_hi_hi,
    io_cpu_resp_bits_data_lo_hi_lo,io_cpu_resp_bits_data_lo_lo_hi,io_cpu_resp_bits_data_lo_lo_lo}; // @[Cat.scala 30:58]
  wire [5:0] _io_cpu_resp_bits_data_T_10 = {req_reg_addr[2:0], 3'h0}; // @[Cache.scala 413:40]
  wire [63:0] _io_cpu_resp_bits_data_T_11 = _io_cpu_resp_bits_data_T_8 >> _io_cpu_resp_bits_data_T_10; // @[Cache.scala 413:17]
  wire [63:0] _ret_T_5 = req_reg_info_offset[3] ? io_mem_resp_bits_data : load_ret; // @[Cache.scala 416:36]
  wire [63:0] ret = req_isCached ? _ret_T_5 : io_mem_resp_bits_data; // @[Cache.scala 416:18]
  wire [7:0] io_cpu_resp_bits_data_lo_lo_lo_1 = req_reg_mask[0] ? ret[7:0] : 8'h0; // @[Cache.scala 420:17]
  wire [7:0] io_cpu_resp_bits_data_lo_lo_hi_1 = req_reg_mask[1] ? ret[15:8] : 8'h0; // @[Cache.scala 420:17]
  wire [7:0] io_cpu_resp_bits_data_lo_hi_lo_1 = req_reg_mask[2] ? ret[23:16] : 8'h0; // @[Cache.scala 420:17]
  wire [7:0] io_cpu_resp_bits_data_lo_hi_hi_1 = req_reg_mask[3] ? ret[31:24] : 8'h0; // @[Cache.scala 420:17]
  wire [7:0] io_cpu_resp_bits_data_hi_lo_lo_1 = req_reg_mask[4] ? ret[39:32] : 8'h0; // @[Cache.scala 420:17]
  wire [7:0] io_cpu_resp_bits_data_hi_lo_hi_1 = req_reg_mask[5] ? ret[47:40] : 8'h0; // @[Cache.scala 420:17]
  wire [7:0] io_cpu_resp_bits_data_hi_hi_lo_1 = req_reg_mask[6] ? ret[55:48] : 8'h0; // @[Cache.scala 420:17]
  wire [7:0] io_cpu_resp_bits_data_hi_hi_hi_1 = req_reg_mask[7] ? ret[63:56] : 8'h0; // @[Cache.scala 420:17]
  wire [63:0] _io_cpu_resp_bits_data_T_20 = {io_cpu_resp_bits_data_hi_hi_hi_1,io_cpu_resp_bits_data_hi_hi_lo_1,
    io_cpu_resp_bits_data_hi_lo_hi_1,io_cpu_resp_bits_data_hi_lo_lo_1,io_cpu_resp_bits_data_lo_hi_hi_1,
    io_cpu_resp_bits_data_lo_hi_lo_1,io_cpu_resp_bits_data_lo_lo_hi_1,io_cpu_resp_bits_data_lo_lo_lo_1}; // @[Cat.scala 30:58]
  wire [63:0] _io_cpu_resp_bits_data_T_23 = _io_cpu_resp_bits_data_T_20 >> _io_cpu_resp_bits_data_T_10; // @[Cache.scala 422:17]
  wire [1:0] _io_cpu_resp_bits_cmd_T_2 = req_reg_op ? 2'h1 : 2'h2; // @[Cache.scala 426:57]
  wire [1:0] _io_cpu_resp_bits_cmd_T_3 = _io_cpu_resp_valid_T ? 2'h0 : _io_cpu_resp_bits_cmd_T_2; // @[Cache.scala 426:30]
  wire  _T_34 = io_mem_resp_ready & io_mem_resp_valid; // @[Decoupled.scala 40:37]
  wire  _T_35 = _T_22 & _T_34; // @[Cache.scala 428:28]
  reg  value_3; // @[Counter.scala 60:40]
  reg  value_4; // @[Counter.scala 60:40]
  wire  _T_39 = _conflict_hit_write_T_2 & is_miss; // @[Cache.scala 442:29]
  wire  _T_46 = _is_miss_T_3 & req_reg_op; // @[Cache.scala 443:55]
  wire  _T_47 = req_isCached & (rand_way_data_v & rand_way_data_d) | _T_46; // @[Cache.scala 442:115]
  wire  _T_48 = _conflict_hit_write_T_2 & is_miss & (req_isCached & (rand_way_data_v & rand_way_data_d) | _T_46); // @[Cache.scala 442:39]
  wire [63:0] _io_mem_req_bits_addr_T_3 = {rand_way_data_tag,req_reg_info_index,4'h0}; // @[Cat.scala 30:58]
  wire [63:0] _io_mem_req_bits_addr_T_4 = req_isCached ? _io_mem_req_bits_addr_T_3 : req_reg_addr; // @[Cache.scala 447:32]
  wire [3:0] _io_mem_req_bits_cmd_T = req_isCached ? 4'h9 : 4'h8; // @[Cache.scala 448:31]
  wire  _T_56 = state == 3'h2 & (req_isCached & replace_buffer_v & replace_buffer_d | _T_46); // @[Cache.scala 453:33]
  wire [63:0] _io_mem_req_bits_addr_T_5 = req_isCached ? replace_buffer_addr : req_reg_addr; // @[Cache.scala 458:32]
  wire [3:0] _io_mem_req_bits_cmd_T_2 = value_3 ? 4'ha : 4'hc; // @[Cache.scala 459:49]
  wire [3:0] _io_mem_req_bits_cmd_T_3 = req_isCached ? _io_mem_req_bits_cmd_T_2 : 4'ha; // @[Cache.scala 459:31]
  wire [63:0] wdata = value_3 ? replace_buffer_data[127:64] : replace_buffer_data[63:0]; // @[Cache.scala 462:17]
  wire [63:0] _io_mem_req_bits_data_T = req_isCached ? wdata : req_reg_data; // @[Cache.scala 463:32]
  wire  _T_57 = io_mem_req_ready & io_mem_req_valid; // @[Decoupled.scala 40:37]
  wire  _T_62 = _is_miss_T_3 & _T_23; // @[Cache.scala 469:50]
  wire  _T_64 = state == 3'h3 & (req_isCached | _T_62); // @[Cache.scala 468:34]
  wire [63:0] _io_mem_req_bits_addr_T_7 = miss_info_addr & 64'hfffffffffffffff0; // @[Cache.scala 473:62]
  wire [63:0] _io_mem_req_bits_addr_T_8 = req_isCached ? _io_mem_req_bits_addr_T_7 : req_reg_addr; // @[Cache.scala 473:32]
  wire [63:0] _io_mem_req_bits_addr_T_9 = {tmp_addr_tag,fence_which_index,4'h0}; // @[Cache.scala 486:44]
  wire  _T_66 = state == 3'h6; // @[Cache.scala 491:20]
  wire [63:0] _io_mem_req_bits_addr_T_10 = {fence_rdata_tag,fence_which_index,4'h0}; // @[Cache.scala 497:44]
  wire [3:0] _io_mem_req_bits_cmd_T_6 = value_1 ? 4'ha : 4'hc; // @[Cache.scala 498:31]
  wire [63:0] fence_rdata_cut = value_1 ? fence_rdata_datas[127:64] : fence_rdata_datas[63:0]; // @[Cache.scala 501:27]
  wire  _GEN_38 = _T_57 ? value_1 + 1'h1 : value_1; // @[Cache.scala 504:28 Counter.scala 76:15 Counter.scala 60:40]
  wire  _GEN_39 = state == 3'h6 & (fence_rdata_v & fence_rdata_d); // @[Cache.scala 491:35 Cache.scala 492:22 Cache.scala 508:22]
  wire [63:0] _GEN_40 = state == 3'h6 ? _io_mem_req_bits_addr_T_10 : 64'h0; // @[Cache.scala 491:35 Cache.scala 497:26 Cache.scala 509:26]
  wire [3:0] _GEN_41 = state == 3'h6 ? _io_mem_req_bits_cmd_T_6 : 4'h0; // @[Cache.scala 491:35 Cache.scala 498:25 Cache.scala 510:25]
  wire [63:0] _GEN_43 = state == 3'h6 ? fence_rdata_cut : 64'h0; // @[Cache.scala 491:35 Cache.scala 502:26 Cache.scala 512:26]
  wire  _GEN_45 = state == 3'h6 ? _GEN_38 : value_1; // @[Cache.scala 491:35 Counter.scala 60:40]
  wire  _GEN_46 = _ways_0_io_in_r_valid_T_2 ? ways_0_io_out_valid & _GEN_20 & _GEN_16 : _GEN_39; // @[Cache.scala 479:32 Cache.scala 481:22]
  wire [63:0] _GEN_47 = _ways_0_io_in_r_valid_T_2 ? _io_mem_req_bits_addr_T_9 : _GEN_40; // @[Cache.scala 479:32 Cache.scala 486:26]
  wire [3:0] _GEN_48 = _ways_0_io_in_r_valid_T_2 ? 4'h9 : _GEN_41; // @[Cache.scala 479:32 Cache.scala 487:25]
  wire  _GEN_49 = _ways_0_io_in_r_valid_T_2 | _T_66; // @[Cache.scala 479:32 Cache.scala 488:25]
  wire [63:0] _GEN_50 = _ways_0_io_in_r_valid_T_2 ? 64'h0 : _GEN_43; // @[Cache.scala 479:32 Cache.scala 489:26]
  wire  _GEN_52 = _ways_0_io_in_r_valid_T_2 ? value_1 : _GEN_45; // @[Cache.scala 479:32 Counter.scala 60:40]
  wire  _GEN_53 = _T_64 | _GEN_46; // @[Cache.scala 470:4 Cache.scala 472:22]
  wire [63:0] _GEN_54 = _T_64 ? _io_mem_req_bits_addr_T_8 : _GEN_47; // @[Cache.scala 470:4 Cache.scala 473:26]
  wire [3:0] _GEN_55 = _T_64 ? {{3'd0}, req_isCached} : _GEN_48; // @[Cache.scala 470:4 Cache.scala 474:25]
  wire  _GEN_56 = _T_64 ? req_isCached : _GEN_49; // @[Cache.scala 470:4 Cache.scala 475:25]
  wire [63:0] _GEN_57 = _T_64 ? 64'h0 : _GEN_50; // @[Cache.scala 470:4 Cache.scala 476:26]
  wire [7:0] _GEN_59 = _T_64 ? req_reg_mask : 8'h0; // @[Cache.scala 470:4 Cache.scala 478:26 Cache.scala 441:24]
  wire  _GEN_61 = _T_56 | _GEN_53; // @[Cache.scala 455:4 Cache.scala 457:22]
  wire [63:0] _GEN_62 = _T_56 ? _io_mem_req_bits_addr_T_5 : _GEN_54; // @[Cache.scala 455:4 Cache.scala 458:26]
  wire [3:0] _GEN_63 = _T_56 ? _io_mem_req_bits_cmd_T_3 : _GEN_55; // @[Cache.scala 455:4 Cache.scala 459:25]
  wire  _GEN_64 = _T_56 ? req_isCached : _GEN_56; // @[Cache.scala 455:4 Cache.scala 460:25]
  wire [63:0] _GEN_65 = _T_56 ? _io_mem_req_bits_data_T : _GEN_57; // @[Cache.scala 455:4 Cache.scala 463:26]
  wire [7:0] _GEN_68 = _T_56 ? 8'h0 : _GEN_59; // @[Cache.scala 455:4 Cache.scala 441:24]
  wire  _GEN_73 = _T_48 ? req_isCached : _GEN_64; // @[Cache.scala 444:4 Cache.scala 449:25]
  wire  _req_reg_T = io_cpu_req_ready & io_cpu_req_valid; // @[Decoupled.scala 40:37]
  wire  _req_isCached_T_5 = io_cpu_req_bits_addr >= 64'h80000000 & io_cpu_req_bits_addr < 64'hffffffff; // @[Cache.scala 524:45]
  wire  _write_buffer_valid_T_7 = _io_cpu_resp_valid_T_3 & req_reg_op; // @[Cache.scala 543:107]
  wire [3:0] _write_buffer_bits_replace_way_T = {ways_compare_res[0],ways_compare_res[1],ways_compare_res[2],
    ways_compare_res[3]}; // @[Cat.scala 30:58]
  wire [7:0] write_buffer_bits_data_hi_hi_hi = req_reg_mask[7] ? 8'hff : 8'h0; // @[Cache.scala 559:25]
  wire [7:0] write_buffer_bits_data_hi_hi_lo = req_reg_mask[6] ? 8'hff : 8'h0; // @[Cache.scala 559:25]
  wire [7:0] write_buffer_bits_data_hi_lo_hi = req_reg_mask[5] ? 8'hff : 8'h0; // @[Cache.scala 559:25]
  wire [7:0] write_buffer_bits_data_hi_lo_lo = req_reg_mask[4] ? 8'hff : 8'h0; // @[Cache.scala 559:25]
  wire [7:0] write_buffer_bits_data_lo_hi_hi = req_reg_mask[3] ? 8'hff : 8'h0; // @[Cache.scala 559:25]
  wire [7:0] write_buffer_bits_data_lo_hi_lo = req_reg_mask[2] ? 8'hff : 8'h0; // @[Cache.scala 559:25]
  wire [7:0] write_buffer_bits_data_lo_lo_hi = req_reg_mask[1] ? 8'hff : 8'h0; // @[Cache.scala 559:25]
  wire [7:0] write_buffer_bits_data_lo_lo_lo = req_reg_mask[0] ? 8'hff : 8'h0; // @[Cache.scala 559:25]
  wire [63:0] _write_buffer_bits_data_T_13 = {write_buffer_bits_data_hi_hi_hi,write_buffer_bits_data_hi_hi_lo,
    write_buffer_bits_data_hi_lo_hi,write_buffer_bits_data_hi_lo_lo,write_buffer_bits_data_lo_hi_hi,
    write_buffer_bits_data_lo_hi_lo,write_buffer_bits_data_lo_lo_hi,write_buffer_bits_data_lo_lo_lo}; // @[Cat.scala 30:58]
  wire [63:0] _write_buffer_bits_data_T_14 = ~_write_buffer_bits_data_T_13; // @[Cache.scala 557:39]
  wire [63:0] _write_buffer_bits_data_T_15 = io_mem_resp_bits_data & _write_buffer_bits_data_T_14; // @[Cache.scala 557:36]
  wire [63:0] _write_buffer_bits_data_T_25 = req_reg_data & _write_buffer_bits_data_T_13; // @[Cache.scala 561:44]
  wire [63:0] _write_buffer_bits_data_T_26 = _write_buffer_bits_data_T_15 | _write_buffer_bits_data_T_25; // @[Cache.scala 561:28]
  wire [63:0] _write_buffer_bits_data_T_27 = value_2 == miss_info_addr[3] ? _write_buffer_bits_data_T_26 :
    io_mem_resp_bits_data; // @[Cache.scala 556:40]
  wire [63:0] _GEN_87 = req_reg_op ? _write_buffer_bits_data_T_27 : io_mem_resp_bits_data; // @[Cache.scala 555:33 Cache.scala 556:34 Cache.scala 567:34]
  wire [3:0] _write_buffer_bits_offset_T_3 = {value_4, 3'h0}; // @[Cache.scala 573:51]
  wire  _GEN_92 = req_isCached | write_buffer_bits_v; // @[Cache.scala 554:33 Cache.scala 574:29 Cache.scala 233:29]
  wire  _GEN_93 = req_isCached ? req_reg_op : write_buffer_bits_d; // @[Cache.scala 554:33 Cache.scala 575:29 Cache.scala 233:29]
  wire  _GEN_101 = _T_35 ? _GEN_92 : write_buffer_bits_v; // @[Cache.scala 553:58 Cache.scala 233:29]
  wire  _GEN_102 = _T_35 ? _GEN_93 : write_buffer_bits_d; // @[Cache.scala 553:58 Cache.scala 233:29]
  wire  _GEN_109 = _write_buffer_valid_T_7 | _GEN_101; // @[Cache.scala 544:65 Cache.scala 548:27]
  wire  _GEN_110 = _write_buffer_valid_T_7 | _GEN_102; // @[Cache.scala 544:65 Cache.scala 549:27]
  wire  _T_80 = 3'h0 == state; // @[Conditional.scala 37:30]
  wire  _T_83 = _req_reg_T & _ways_0_io_in_r_valid_T; // @[Cache.scala 596:36]
  wire  _T_84 = 3'h1 == state; // @[Conditional.scala 37:30]
  wire  _T_112 = _T_57 & _T_47; // @[Cache.scala 621:30]
  wire  _T_113 = req_isCached & (~rand_way_data_v | ~rand_way_data_d) | _T_62 | _T_112; // @[Cache.scala 620:130]
  wire [2:0] _GEN_117 = _T_113 ? 3'h2 : state; // @[Cache.scala 622:10 Cache.scala 624:17 Cache.scala 214:22]
  wire [2:0] _GEN_118 = io_fence_i ? 3'h5 : _GEN_117; // @[Cache.scala 616:29 Cache.scala 617:15]
  wire [2:0] _GEN_119 = _io_cpu_resp_valid_T_2 & _T_83 ? 3'h1 : _GEN_118; // @[Cache.scala 613:75 Cache.scala 615:15]
  wire [2:0] _GEN_120 = _io_cpu_resp_valid_T_2 & (~_req_reg_T | conflict_hit_write) ? 3'h0 : _GEN_119; // @[Cache.scala 610:77 Cache.scala 612:15]
  wire  _T_114 = 3'h2 == state; // @[Conditional.scala 37:30]
  wire  _T_116 = io_mem_req_bits_cmd == 4'ha; // @[Cache.scala 631:67]
  wire  _T_117 = _T_57 & io_mem_req_bits_cmd == 4'ha; // @[Cache.scala 631:44]
  wire  _T_131 = _is_miss_T_3 & (req_reg_op & _T_117 | _T_23); // @[Cache.scala 632:26]
  wire  _T_132 = req_isCached & (_T_57 & io_mem_req_bits_cmd == 4'ha) | (~replace_buffer_v | ~replace_buffer_d) | _T_131
    ; // @[Cache.scala 631:156]
  wire [2:0] _GEN_122 = _T_132 ? 3'h3 : state; // @[Cache.scala 634:8 Cache.scala 636:15 Cache.scala 639:15]
  wire  _T_133 = 3'h3 == state; // @[Conditional.scala 37:30]
  wire  _T_144 = _T_23 & (_T_57 & io_mem_req_bits_cmd == 4'h0); // @[Cache.scala 646:52]
  wire  _T_146 = _is_miss_T_3 & (req_reg_op | _T_144); // @[Cache.scala 645:28]
  wire  _T_147 = req_isCached & (_T_57 & io_mem_req_bits_cmd == 4'h1) | _T_146; // @[Cache.scala 644:99]
  wire [2:0] _GEN_123 = _T_147 ? 3'h4 : state; // @[Cache.scala 647:8 Cache.scala 649:15 Cache.scala 651:15]
  wire  _T_148 = 3'h4 == state; // @[Conditional.scala 37:30]
  wire  _T_151 = _T_34 & io_mem_resp_bits_cmd == 4'h2; // @[Cache.scala 656:48]
  wire  _T_159 = _T_23 & _T_151; // @[Cache.scala 658:51]
  wire  _T_161 = _is_miss_T_3 & (req_reg_op | _T_159); // @[Cache.scala 657:27]
  wire  _T_162 = req_isCached & (_T_34 & io_mem_resp_bits_cmd == 4'h2) | _T_161; // @[Cache.scala 656:100]
  wire [2:0] _GEN_124 = _T_162 ? 3'h0 : state; // @[Cache.scala 660:8 Cache.scala 662:15 Cache.scala 664:15]
  wire  _T_163 = 3'h5 == state; // @[Conditional.scala 37:30]
  wire  _T_167 = ~io_mem_req_valid; // @[Cache.scala 669:82]
  wire [7:0] _value_T_9 = value + 8'h1; // @[Counter.scala 76:24]
  wire [2:0] _GEN_125 = ~write_buffer_valid & ways_0_io_out_valid & (_T_57 | ~io_mem_req_valid) ? 3'h6 : state; // @[Cache.scala 669:101 Cache.scala 671:15 Cache.scala 674:15]
  wire [7:0] _GEN_126 = ~write_buffer_valid & ways_0_io_out_valid & (_T_57 | ~io_mem_req_valid) ? _value_T_9 : value; // @[Cache.scala 669:101 Counter.scala 76:15 Counter.scala 60:40]
  wire  _T_170 = 3'h6 == state; // @[Conditional.scala 37:30]
  wire  _T_173 = _T_116 & _T_57; // @[Cache.scala 679:60]
  wire  _T_174 = value == 8'h0; // @[Cache.scala 679:99]
  wire [2:0] _GEN_127 = _T_167 ? 3'h5 : state; // @[Cache.scala 687:36 Cache.scala 688:15 Cache.scala 690:15]
  wire [2:0] _GEN_128 = _T_174 & _T_167 ? 3'h0 : _GEN_127; // @[Cache.scala 684:71 Cache.scala 685:15]
  wire [7:0] _GEN_129 = _T_174 & _T_167 ? 8'h0 : value; // @[Cache.scala 684:71 Cache.scala 686:25 Counter.scala 60:40]
  wire [2:0] _GEN_130 = _T_173 ? 3'h5 : _GEN_128; // @[Cache.scala 682:86 Cache.scala 683:15]
  wire [7:0] _GEN_131 = _T_173 ? value : _GEN_129; // @[Cache.scala 682:86 Counter.scala 60:40]
  wire [2:0] _GEN_132 = _T_116 & _T_57 & value == 8'h0 ? 3'h0 : _GEN_130; // @[Cache.scala 679:115 Cache.scala 680:15]
  wire [7:0] _GEN_133 = _T_116 & _T_57 & value == 8'h0 ? 8'h0 : _GEN_131; // @[Cache.scala 679:115 Cache.scala 681:25]
  wire  _T_183 = 3'h7 == state; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_134 = _T_183 ? 3'h0 : state; // @[Conditional.scala 39:67 Cache.scala 696:13 Cache.scala 214:22]
  wire [2:0] _GEN_135 = _T_170 ? _GEN_132 : _GEN_134; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_136 = _T_170 ? _GEN_133 : value; // @[Conditional.scala 39:67 Counter.scala 60:40]
  wire [2:0] _GEN_137 = _T_163 ? _GEN_125 : _GEN_135; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_138 = _T_163 ? _GEN_126 : _GEN_136; // @[Conditional.scala 39:67]
  wire [2:0] _GEN_139 = _T_148 ? _GEN_124 : _GEN_137; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_140 = _T_148 ? value : _GEN_138; // @[Conditional.scala 39:67 Counter.scala 60:40]
  wire [2:0] _GEN_141 = _T_133 ? _GEN_123 : _GEN_139; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_142 = _T_133 ? value : _GEN_140; // @[Conditional.scala 39:67 Counter.scala 60:40]
  reg [2:0] io_fence_i_done_REG; // @[Cache.scala 701:51]
  ysyx_210013_Way ways_0 ( // @[Cache.scala 210:40]
    .clock(ways_0_clock),
    .reset(ways_0_reset),
    .io_out_valid(ways_0_io_out_valid),
    .io_out_bits_tag(ways_0_io_out_bits_tag),
    .io_out_bits_v(ways_0_io_out_bits_v),
    .io_out_bits_d(ways_0_io_out_bits_d),
    .io_out_bits_datas(ways_0_io_out_bits_datas),
    .io_in_w_valid(ways_0_io_in_w_valid),
    .io_in_w_bits_tag(ways_0_io_in_w_bits_tag),
    .io_in_w_bits_index(ways_0_io_in_w_bits_index),
    .io_in_w_bits_offset(ways_0_io_in_w_bits_offset),
    .io_in_w_bits_v(ways_0_io_in_w_bits_v),
    .io_in_w_bits_d(ways_0_io_in_w_bits_d),
    .io_in_w_bits_mask(ways_0_io_in_w_bits_mask),
    .io_in_w_bits_data(ways_0_io_in_w_bits_data),
    .io_in_w_bits_op(ways_0_io_in_w_bits_op),
    .io_in_r_valid(ways_0_io_in_r_valid),
    .io_in_r_bits_index(ways_0_io_in_r_bits_index),
    .io_fence_invalid(ways_0_io_fence_invalid)
  );
  ysyx_210013_Way ways_1 ( // @[Cache.scala 210:40]
    .clock(ways_1_clock),
    .reset(ways_1_reset),
    .io_out_valid(ways_1_io_out_valid),
    .io_out_bits_tag(ways_1_io_out_bits_tag),
    .io_out_bits_v(ways_1_io_out_bits_v),
    .io_out_bits_d(ways_1_io_out_bits_d),
    .io_out_bits_datas(ways_1_io_out_bits_datas),
    .io_in_w_valid(ways_1_io_in_w_valid),
    .io_in_w_bits_tag(ways_1_io_in_w_bits_tag),
    .io_in_w_bits_index(ways_1_io_in_w_bits_index),
    .io_in_w_bits_offset(ways_1_io_in_w_bits_offset),
    .io_in_w_bits_v(ways_1_io_in_w_bits_v),
    .io_in_w_bits_d(ways_1_io_in_w_bits_d),
    .io_in_w_bits_mask(ways_1_io_in_w_bits_mask),
    .io_in_w_bits_data(ways_1_io_in_w_bits_data),
    .io_in_w_bits_op(ways_1_io_in_w_bits_op),
    .io_in_r_valid(ways_1_io_in_r_valid),
    .io_in_r_bits_index(ways_1_io_in_r_bits_index),
    .io_fence_invalid(ways_1_io_fence_invalid)
  );
  ysyx_210013_Way ways_2 ( // @[Cache.scala 210:40]
    .clock(ways_2_clock),
    .reset(ways_2_reset),
    .io_out_valid(ways_2_io_out_valid),
    .io_out_bits_tag(ways_2_io_out_bits_tag),
    .io_out_bits_v(ways_2_io_out_bits_v),
    .io_out_bits_d(ways_2_io_out_bits_d),
    .io_out_bits_datas(ways_2_io_out_bits_datas),
    .io_in_w_valid(ways_2_io_in_w_valid),
    .io_in_w_bits_tag(ways_2_io_in_w_bits_tag),
    .io_in_w_bits_index(ways_2_io_in_w_bits_index),
    .io_in_w_bits_offset(ways_2_io_in_w_bits_offset),
    .io_in_w_bits_v(ways_2_io_in_w_bits_v),
    .io_in_w_bits_d(ways_2_io_in_w_bits_d),
    .io_in_w_bits_mask(ways_2_io_in_w_bits_mask),
    .io_in_w_bits_data(ways_2_io_in_w_bits_data),
    .io_in_w_bits_op(ways_2_io_in_w_bits_op),
    .io_in_r_valid(ways_2_io_in_r_valid),
    .io_in_r_bits_index(ways_2_io_in_r_bits_index),
    .io_fence_invalid(ways_2_io_fence_invalid)
  );
  ysyx_210013_Way ways_3 ( // @[Cache.scala 210:40]
    .clock(ways_3_clock),
    .reset(ways_3_reset),
    .io_out_valid(ways_3_io_out_valid),
    .io_out_bits_tag(ways_3_io_out_bits_tag),
    .io_out_bits_v(ways_3_io_out_bits_v),
    .io_out_bits_d(ways_3_io_out_bits_d),
    .io_out_bits_datas(ways_3_io_out_bits_datas),
    .io_in_w_valid(ways_3_io_in_w_valid),
    .io_in_w_bits_tag(ways_3_io_in_w_bits_tag),
    .io_in_w_bits_index(ways_3_io_in_w_bits_index),
    .io_in_w_bits_offset(ways_3_io_in_w_bits_offset),
    .io_in_w_bits_v(ways_3_io_in_w_bits_v),
    .io_in_w_bits_d(ways_3_io_in_w_bits_d),
    .io_in_w_bits_mask(ways_3_io_in_w_bits_mask),
    .io_in_w_bits_data(ways_3_io_in_w_bits_data),
    .io_in_w_bits_op(ways_3_io_in_w_bits_op),
    .io_in_r_valid(ways_3_io_in_r_valid),
    .io_in_r_bits_index(ways_3_io_in_r_bits_index),
    .io_fence_invalid(ways_3_io_fence_invalid)
  );
  ysyx_210013_MaxPeriodFibonacciLFSR rand_num_prng ( // @[PRNG.scala 82:22]
    .clock(rand_num_prng_clock),
    .reset(rand_num_prng_reset),
    .io_out_0(rand_num_prng_io_out_0),
    .io_out_1(rand_num_prng_io_out_1),
    .io_out_2(rand_num_prng_io_out_2),
    .io_out_3(rand_num_prng_io_out_3),
    .io_out_4(rand_num_prng_io_out_4),
    .io_out_5(rand_num_prng_io_out_5),
    .io_out_6(rand_num_prng_io_out_6),
    .io_out_7(rand_num_prng_io_out_7),
    .io_out_8(rand_num_prng_io_out_8),
    .io_out_9(rand_num_prng_io_out_9),
    .io_out_10(rand_num_prng_io_out_10),
    .io_out_11(rand_num_prng_io_out_11),
    .io_out_12(rand_num_prng_io_out_12),
    .io_out_13(rand_num_prng_io_out_13),
    .io_out_14(rand_num_prng_io_out_14),
    .io_out_15(rand_num_prng_io_out_15),
    .io_out_16(rand_num_prng_io_out_16),
    .io_out_17(rand_num_prng_io_out_17),
    .io_out_18(rand_num_prng_io_out_18),
    .io_out_19(rand_num_prng_io_out_19),
    .io_out_20(rand_num_prng_io_out_20),
    .io_out_21(rand_num_prng_io_out_21),
    .io_out_22(rand_num_prng_io_out_22),
    .io_out_23(rand_num_prng_io_out_23),
    .io_out_24(rand_num_prng_io_out_24),
    .io_out_25(rand_num_prng_io_out_25),
    .io_out_26(rand_num_prng_io_out_26),
    .io_out_27(rand_num_prng_io_out_27),
    .io_out_28(rand_num_prng_io_out_28),
    .io_out_29(rand_num_prng_io_out_29),
    .io_out_30(rand_num_prng_io_out_30),
    .io_out_31(rand_num_prng_io_out_31),
    .io_out_32(rand_num_prng_io_out_32),
    .io_out_33(rand_num_prng_io_out_33),
    .io_out_34(rand_num_prng_io_out_34),
    .io_out_35(rand_num_prng_io_out_35),
    .io_out_36(rand_num_prng_io_out_36),
    .io_out_37(rand_num_prng_io_out_37),
    .io_out_38(rand_num_prng_io_out_38),
    .io_out_39(rand_num_prng_io_out_39),
    .io_out_40(rand_num_prng_io_out_40),
    .io_out_41(rand_num_prng_io_out_41),
    .io_out_42(rand_num_prng_io_out_42),
    .io_out_43(rand_num_prng_io_out_43),
    .io_out_44(rand_num_prng_io_out_44),
    .io_out_45(rand_num_prng_io_out_45),
    .io_out_46(rand_num_prng_io_out_46),
    .io_out_47(rand_num_prng_io_out_47),
    .io_out_48(rand_num_prng_io_out_48),
    .io_out_49(rand_num_prng_io_out_49),
    .io_out_50(rand_num_prng_io_out_50),
    .io_out_51(rand_num_prng_io_out_51),
    .io_out_52(rand_num_prng_io_out_52),
    .io_out_53(rand_num_prng_io_out_53),
    .io_out_54(rand_num_prng_io_out_54),
    .io_out_55(rand_num_prng_io_out_55),
    .io_out_56(rand_num_prng_io_out_56),
    .io_out_57(rand_num_prng_io_out_57),
    .io_out_58(rand_num_prng_io_out_58),
    .io_out_59(rand_num_prng_io_out_59),
    .io_out_60(rand_num_prng_io_out_60),
    .io_out_61(rand_num_prng_io_out_61),
    .io_out_62(rand_num_prng_io_out_62),
    .io_out_63(rand_num_prng_io_out_63),
    .io_out_64(rand_num_prng_io_out_64),
    .io_out_65(rand_num_prng_io_out_65),
    .io_out_66(rand_num_prng_io_out_66),
    .io_out_67(rand_num_prng_io_out_67),
    .io_out_68(rand_num_prng_io_out_68),
    .io_out_69(rand_num_prng_io_out_69),
    .io_out_70(rand_num_prng_io_out_70),
    .io_out_71(rand_num_prng_io_out_71),
    .io_out_72(rand_num_prng_io_out_72),
    .io_out_73(rand_num_prng_io_out_73),
    .io_out_74(rand_num_prng_io_out_74),
    .io_out_75(rand_num_prng_io_out_75),
    .io_out_76(rand_num_prng_io_out_76),
    .io_out_77(rand_num_prng_io_out_77),
    .io_out_78(rand_num_prng_io_out_78),
    .io_out_79(rand_num_prng_io_out_79),
    .io_out_80(rand_num_prng_io_out_80),
    .io_out_81(rand_num_prng_io_out_81),
    .io_out_82(rand_num_prng_io_out_82),
    .io_out_83(rand_num_prng_io_out_83),
    .io_out_84(rand_num_prng_io_out_84),
    .io_out_85(rand_num_prng_io_out_85),
    .io_out_86(rand_num_prng_io_out_86),
    .io_out_87(rand_num_prng_io_out_87),
    .io_out_88(rand_num_prng_io_out_88),
    .io_out_89(rand_num_prng_io_out_89),
    .io_out_90(rand_num_prng_io_out_90),
    .io_out_91(rand_num_prng_io_out_91),
    .io_out_92(rand_num_prng_io_out_92),
    .io_out_93(rand_num_prng_io_out_93),
    .io_out_94(rand_num_prng_io_out_94),
    .io_out_95(rand_num_prng_io_out_95),
    .io_out_96(rand_num_prng_io_out_96),
    .io_out_97(rand_num_prng_io_out_97),
    .io_out_98(rand_num_prng_io_out_98),
    .io_out_99(rand_num_prng_io_out_99),
    .io_out_100(rand_num_prng_io_out_100),
    .io_out_101(rand_num_prng_io_out_101),
    .io_out_102(rand_num_prng_io_out_102),
    .io_out_103(rand_num_prng_io_out_103),
    .io_out_104(rand_num_prng_io_out_104),
    .io_out_105(rand_num_prng_io_out_105),
    .io_out_106(rand_num_prng_io_out_106),
    .io_out_107(rand_num_prng_io_out_107),
    .io_out_108(rand_num_prng_io_out_108),
    .io_out_109(rand_num_prng_io_out_109),
    .io_out_110(rand_num_prng_io_out_110),
    .io_out_111(rand_num_prng_io_out_111),
    .io_out_112(rand_num_prng_io_out_112),
    .io_out_113(rand_num_prng_io_out_113),
    .io_out_114(rand_num_prng_io_out_114),
    .io_out_115(rand_num_prng_io_out_115),
    .io_out_116(rand_num_prng_io_out_116),
    .io_out_117(rand_num_prng_io_out_117),
    .io_out_118(rand_num_prng_io_out_118),
    .io_out_119(rand_num_prng_io_out_119),
    .io_out_120(rand_num_prng_io_out_120),
    .io_out_121(rand_num_prng_io_out_121),
    .io_out_122(rand_num_prng_io_out_122),
    .io_out_123(rand_num_prng_io_out_123),
    .io_out_124(rand_num_prng_io_out_124),
    .io_out_125(rand_num_prng_io_out_125),
    .io_out_126(rand_num_prng_io_out_126),
    .io_out_127(rand_num_prng_io_out_127)
  );
  assign io_cpu_req_ready = _io_cpu_resp_valid_T_4 & _ways_0_io_in_r_valid_T; // @[Cache.scala 517:82]
  assign io_cpu_resp_valid = _io_cpu_resp_valid_T_18 | _io_cpu_resp_valid_T_24; // @[Cache.scala 401:113]
  assign io_cpu_resp_bits_data = _conflict_hit_write_T_2 ? _io_cpu_resp_bits_data_T_11 : _io_cpu_resp_bits_data_T_23; // @[Cache.scala 404:27 Cache.scala 405:27 Cache.scala 417:27]
  assign io_cpu_resp_bits_cmd = {{2'd0}, _io_cpu_resp_bits_cmd_T_3}; // @[Cache.scala 426:30]
  assign io_mem_req_valid = _T_48 | _GEN_61; // @[Cache.scala 444:4 Cache.scala 446:22]
  assign io_mem_req_bits_addr = _T_48 ? _io_mem_req_bits_addr_T_4 : _GEN_62; // @[Cache.scala 444:4 Cache.scala 447:26]
  assign io_mem_req_bits_data = _T_48 ? 64'h0 : _GEN_65; // @[Cache.scala 444:4 Cache.scala 450:26]
  assign io_mem_req_bits_cmd = _T_48 ? _io_mem_req_bits_cmd_T : _GEN_63; // @[Cache.scala 444:4 Cache.scala 448:25]
  assign io_mem_req_bits_len = {{1'd0}, _GEN_73}; // @[Cache.scala 444:4 Cache.scala 449:25]
  assign io_mem_req_bits_mask = _T_48 ? req_reg_mask : _GEN_68; // @[Cache.scala 444:4 Cache.scala 452:26]
  assign io_mem_resp_ready = state == 3'h4; // @[Cache.scala 542:31]
  assign io_fence_i_done = _io_cpu_resp_valid_T & io_fence_i_done_REG == 3'h6; // @[Cache.scala 701:41]
  assign ways_0_clock = clock;
  assign ways_0_reset = reset;
  assign ways_0_io_in_w_valid = _ways_0_io_in_w_valid_T_1[0]; // @[Cache.scala 378:23]
  assign ways_0_io_in_w_bits_tag = write_buffer_bits_tag; // @[Cache.scala 367:26]
  assign ways_0_io_in_w_bits_index = write_buffer_bits_index; // @[Cache.scala 368:28]
  assign ways_0_io_in_w_bits_offset = write_buffer_bits_offset; // @[Cache.scala 369:29]
  assign ways_0_io_in_w_bits_v = write_buffer_bits_v; // @[Cache.scala 370:24]
  assign ways_0_io_in_w_bits_d = write_buffer_bits_d; // @[Cache.scala 371:24]
  assign ways_0_io_in_w_bits_mask = write_buffer_bits_wmask; // @[Cache.scala 372:27]
  assign ways_0_io_in_w_bits_data = write_buffer_bits_data; // @[Cache.scala 373:27]
  assign ways_0_io_in_w_bits_op = 1'h1; // @[Cache.scala 374:25]
  assign ways_0_io_in_r_valid = state != 3'h5 & state != 3'h6 ? io_cpu_req_valid & ~conflict_hit_write :
    _ways_0_io_in_r_valid_T_3; // @[Cache.scala 274:53 Cache.scala 279:25 Cache.scala 285:25]
  assign ways_0_io_in_r_bits_index = _GEN_0[5:0];
  assign ways_0_io_fence_invalid = state == 3'h7; // @[Cache.scala 221:44]
  assign ways_1_clock = clock;
  assign ways_1_reset = reset;
  assign ways_1_io_in_w_valid = _ways_1_io_in_w_valid_T_1[0]; // @[Cache.scala 378:23]
  assign ways_1_io_in_w_bits_tag = write_buffer_bits_tag; // @[Cache.scala 367:26]
  assign ways_1_io_in_w_bits_index = write_buffer_bits_index; // @[Cache.scala 368:28]
  assign ways_1_io_in_w_bits_offset = write_buffer_bits_offset; // @[Cache.scala 369:29]
  assign ways_1_io_in_w_bits_v = write_buffer_bits_v; // @[Cache.scala 370:24]
  assign ways_1_io_in_w_bits_d = write_buffer_bits_d; // @[Cache.scala 371:24]
  assign ways_1_io_in_w_bits_mask = write_buffer_bits_wmask; // @[Cache.scala 372:27]
  assign ways_1_io_in_w_bits_data = write_buffer_bits_data; // @[Cache.scala 373:27]
  assign ways_1_io_in_w_bits_op = 1'h1; // @[Cache.scala 374:25]
  assign ways_1_io_in_r_valid = state != 3'h5 & state != 3'h6 ? io_cpu_req_valid & ~conflict_hit_write :
    _ways_0_io_in_r_valid_T_3; // @[Cache.scala 274:53 Cache.scala 279:25 Cache.scala 285:25]
  assign ways_1_io_in_r_bits_index = _GEN_0[5:0];
  assign ways_1_io_fence_invalid = state == 3'h7; // @[Cache.scala 221:44]
  assign ways_2_clock = clock;
  assign ways_2_reset = reset;
  assign ways_2_io_in_w_valid = _ways_2_io_in_w_valid_T_1[0]; // @[Cache.scala 378:23]
  assign ways_2_io_in_w_bits_tag = write_buffer_bits_tag; // @[Cache.scala 367:26]
  assign ways_2_io_in_w_bits_index = write_buffer_bits_index; // @[Cache.scala 368:28]
  assign ways_2_io_in_w_bits_offset = write_buffer_bits_offset; // @[Cache.scala 369:29]
  assign ways_2_io_in_w_bits_v = write_buffer_bits_v; // @[Cache.scala 370:24]
  assign ways_2_io_in_w_bits_d = write_buffer_bits_d; // @[Cache.scala 371:24]
  assign ways_2_io_in_w_bits_mask = write_buffer_bits_wmask; // @[Cache.scala 372:27]
  assign ways_2_io_in_w_bits_data = write_buffer_bits_data; // @[Cache.scala 373:27]
  assign ways_2_io_in_w_bits_op = 1'h1; // @[Cache.scala 374:25]
  assign ways_2_io_in_r_valid = state != 3'h5 & state != 3'h6 ? io_cpu_req_valid & ~conflict_hit_write :
    _ways_0_io_in_r_valid_T_3; // @[Cache.scala 274:53 Cache.scala 279:25 Cache.scala 285:25]
  assign ways_2_io_in_r_bits_index = _GEN_0[5:0];
  assign ways_2_io_fence_invalid = state == 3'h7; // @[Cache.scala 221:44]
  assign ways_3_clock = clock;
  assign ways_3_reset = reset;
  assign ways_3_io_in_w_valid = _ways_3_io_in_w_valid_T_1[0]; // @[Cache.scala 378:23]
  assign ways_3_io_in_w_bits_tag = write_buffer_bits_tag; // @[Cache.scala 367:26]
  assign ways_3_io_in_w_bits_index = write_buffer_bits_index; // @[Cache.scala 368:28]
  assign ways_3_io_in_w_bits_offset = write_buffer_bits_offset; // @[Cache.scala 369:29]
  assign ways_3_io_in_w_bits_v = write_buffer_bits_v; // @[Cache.scala 370:24]
  assign ways_3_io_in_w_bits_d = write_buffer_bits_d; // @[Cache.scala 371:24]
  assign ways_3_io_in_w_bits_mask = write_buffer_bits_wmask; // @[Cache.scala 372:27]
  assign ways_3_io_in_w_bits_data = write_buffer_bits_data; // @[Cache.scala 373:27]
  assign ways_3_io_in_w_bits_op = 1'h1; // @[Cache.scala 374:25]
  assign ways_3_io_in_r_valid = state != 3'h5 & state != 3'h6 ? io_cpu_req_valid & ~conflict_hit_write :
    _ways_0_io_in_r_valid_T_3; // @[Cache.scala 274:53 Cache.scala 279:25 Cache.scala 285:25]
  assign ways_3_io_in_r_bits_index = _GEN_0[5:0];
  assign ways_3_io_fence_invalid = state == 3'h7; // @[Cache.scala 221:44]
  assign rand_num_prng_clock = clock;
  assign rand_num_prng_reset = reset;
  always @(posedge clock) begin
    if (reset) begin // @[Cache.scala 214:22]
      state <= 3'h0; // @[Cache.scala 214:22]
    end else if (_T_80) begin // @[Conditional.scala 40:58]
      if (io_fence_i) begin // @[Cache.scala 590:23]
        state <= 3'h5; // @[Cache.scala 594:17]
      end else if (_req_reg_T & _ways_0_io_in_r_valid_T) begin // @[Cache.scala 596:58]
        state <= 3'h1; // @[Cache.scala 597:15]
      end
    end else if (_T_84) begin // @[Conditional.scala 39:67]
      if (io_fence_i) begin // @[Cache.scala 604:23]
        state <= 3'h5; // @[Cache.scala 608:17]
      end else begin
        state <= _GEN_120;
      end
    end else if (_T_114) begin // @[Conditional.scala 39:67]
      state <= _GEN_122;
    end else begin
      state <= _GEN_141;
    end
    if (reset) begin // @[Counter.scala 60:40]
      value <= 8'h0; // @[Counter.scala 60:40]
    end else if (!(_T_80)) begin // @[Conditional.scala 40:58]
      if (!(_T_84)) begin // @[Conditional.scala 39:67]
        if (!(_T_114)) begin // @[Conditional.scala 39:67]
          value <= _GEN_142;
        end
      end
    end
    if (reset) begin // @[Counter.scala 60:40]
      value_1 <= 1'h0; // @[Counter.scala 60:40]
    end else if (!(_T_48)) begin // @[Cache.scala 444:4]
      if (!(_T_56)) begin // @[Cache.scala 455:4]
        if (!(_T_64)) begin // @[Cache.scala 470:4]
          value_1 <= _GEN_52;
        end
      end
    end
    if (reset) begin // @[Cache.scala 220:28]
      fence_rdata_tag <= 54'h0; // @[Cache.scala 220:28]
    end else if (_ways_0_io_in_r_valid_T_2 & ways_0_io_out_valid) begin // @[Cache.scala 293:53]
      if (2'h3 == fence_which_way) begin // @[Cache.scala 294:17]
        fence_rdata_tag <= ways_ret_datas_3_tag; // @[Cache.scala 294:17]
      end else if (2'h2 == fence_which_way) begin // @[Cache.scala 294:17]
        fence_rdata_tag <= ways_ret_datas_2_tag; // @[Cache.scala 294:17]
      end else begin
        fence_rdata_tag <= _GEN_22;
      end
    end
    if (reset) begin // @[Cache.scala 220:28]
      fence_rdata_v <= 1'h0; // @[Cache.scala 220:28]
    end else if (_ways_0_io_in_r_valid_T_2 & ways_0_io_out_valid) begin // @[Cache.scala 293:53]
      if (2'h3 == fence_which_way) begin // @[Cache.scala 294:17]
        fence_rdata_v <= ways_ret_datas_3_v; // @[Cache.scala 294:17]
      end else if (2'h2 == fence_which_way) begin // @[Cache.scala 294:17]
        fence_rdata_v <= ways_ret_datas_2_v; // @[Cache.scala 294:17]
      end else begin
        fence_rdata_v <= _GEN_18;
      end
    end
    if (reset) begin // @[Cache.scala 220:28]
      fence_rdata_d <= 1'h0; // @[Cache.scala 220:28]
    end else if (_ways_0_io_in_r_valid_T_2 & ways_0_io_out_valid) begin // @[Cache.scala 293:53]
      if (2'h3 == fence_which_way) begin // @[Cache.scala 294:17]
        fence_rdata_d <= ways_ret_datas_3_d; // @[Cache.scala 294:17]
      end else if (2'h2 == fence_which_way) begin // @[Cache.scala 294:17]
        fence_rdata_d <= ways_ret_datas_2_d; // @[Cache.scala 294:17]
      end else begin
        fence_rdata_d <= _GEN_14;
      end
    end
    if (reset) begin // @[Cache.scala 220:28]
      fence_rdata_datas <= 128'h0; // @[Cache.scala 220:28]
    end else if (_ways_0_io_in_r_valid_T_2 & ways_0_io_out_valid) begin // @[Cache.scala 293:53]
      if (2'h3 == fence_which_way) begin // @[Cache.scala 294:17]
        fence_rdata_datas <= ways_ret_datas_3_datas; // @[Cache.scala 294:17]
      end else if (2'h2 == fence_which_way) begin // @[Cache.scala 294:17]
        fence_rdata_datas <= ways_ret_datas_2_datas; // @[Cache.scala 294:17]
      end else begin
        fence_rdata_datas <= _GEN_10;
      end
    end
    if (reset) begin // @[Cache.scala 226:24]
      req_reg_addr <= 64'h0; // @[Cache.scala 226:24]
    end else if (_req_reg_T) begin // @[Cache.scala 518:17]
      req_reg_addr <= io_cpu_req_bits_addr;
    end
    if (reset) begin // @[Cache.scala 226:24]
      req_reg_data <= 64'h0; // @[Cache.scala 226:24]
    end else if (_req_reg_T) begin // @[Cache.scala 518:17]
      req_reg_data <= io_cpu_req_bits_data;
    end
    if (reset) begin // @[Cache.scala 226:24]
      req_reg_mask <= 8'h0; // @[Cache.scala 226:24]
    end else if (_req_reg_T) begin // @[Cache.scala 518:17]
      req_reg_mask <= io_cpu_req_bits_mask;
    end
    if (reset) begin // @[Cache.scala 226:24]
      req_reg_op <= 1'h0; // @[Cache.scala 226:24]
    end else if (_req_reg_T) begin // @[Cache.scala 518:17]
      req_reg_op <= io_cpu_req_bits_op;
    end
    if (reset) begin // @[Cache.scala 227:29]
      req_isCached <= 1'h0; // @[Cache.scala 227:29]
    end else if (_req_reg_T) begin // @[Cache.scala 519:22]
      req_isCached <= _req_isCached_T_5;
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_valid <= 1'h0; // @[Cache.scala 233:29]
    end else begin
      write_buffer_valid <= _T_35 | _io_cpu_resp_valid_T_3 & req_reg_op; // @[Cache.scala 543:22]
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_bits_tag <= 54'h0; // @[Cache.scala 233:29]
    end else if (_write_buffer_valid_T_7) begin // @[Cache.scala 544:65]
      write_buffer_bits_tag <= req_reg_info_tag; // @[Cache.scala 545:29]
    end else if (_T_35) begin // @[Cache.scala 553:58]
      if (req_isCached) begin // @[Cache.scala 554:33]
        write_buffer_bits_tag <= miss_info_addr[63:10]; // @[Cache.scala 570:31]
      end
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_bits_index <= 6'h0; // @[Cache.scala 233:29]
    end else if (_write_buffer_valid_T_7) begin // @[Cache.scala 544:65]
      write_buffer_bits_index <= req_reg_info_index; // @[Cache.scala 546:31]
    end else if (_T_35) begin // @[Cache.scala 553:58]
      if (req_isCached) begin // @[Cache.scala 554:33]
        write_buffer_bits_index <= miss_info_addr[9:4]; // @[Cache.scala 571:33]
      end
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_bits_offset <= 4'h0; // @[Cache.scala 233:29]
    end else if (_write_buffer_valid_T_7) begin // @[Cache.scala 544:65]
      write_buffer_bits_offset <= req_reg_info_offset; // @[Cache.scala 547:32]
    end else if (_T_35) begin // @[Cache.scala 553:58]
      if (req_isCached) begin // @[Cache.scala 554:33]
        write_buffer_bits_offset <= _write_buffer_bits_offset_T_3; // @[Cache.scala 573:34]
      end
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_bits_v <= 1'h0; // @[Cache.scala 233:29]
    end else begin
      write_buffer_bits_v <= _GEN_109;
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_bits_d <= 1'h0; // @[Cache.scala 233:29]
    end else begin
      write_buffer_bits_d <= _GEN_110;
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_bits_data <= 64'h0; // @[Cache.scala 233:29]
    end else if (_write_buffer_valid_T_7) begin // @[Cache.scala 544:65]
      write_buffer_bits_data <= req_reg_data; // @[Cache.scala 550:30]
    end else if (_T_35) begin // @[Cache.scala 553:58]
      if (req_isCached) begin // @[Cache.scala 554:33]
        write_buffer_bits_data <= _GEN_87;
      end
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_bits_replace_way <= 4'h0; // @[Cache.scala 233:29]
    end else if (_write_buffer_valid_T_7) begin // @[Cache.scala 544:65]
      write_buffer_bits_replace_way <= _write_buffer_bits_replace_way_T; // @[Cache.scala 551:37]
    end else if (_T_35) begin // @[Cache.scala 553:58]
      if (req_isCached) begin // @[Cache.scala 554:33]
        write_buffer_bits_replace_way <= replace_buffer_way_num; // @[Cache.scala 576:39]
      end
    end
    if (reset) begin // @[Cache.scala 233:29]
      write_buffer_bits_wmask <= 8'h0; // @[Cache.scala 233:29]
    end else if (_write_buffer_valid_T_7) begin // @[Cache.scala 544:65]
      write_buffer_bits_wmask <= req_reg_mask; // @[Cache.scala 552:31]
    end else if (_T_35) begin // @[Cache.scala 553:58]
      if (req_isCached) begin // @[Cache.scala 554:33]
        write_buffer_bits_wmask <= 8'hff; // @[Cache.scala 577:33]
      end
    end
    if (reset) begin // @[Cache.scala 328:26]
      miss_info_addr <= 64'h0; // @[Cache.scala 328:26]
    end else if (_T_39) begin // @[Cache.scala 527:39]
      miss_info_addr <= req_reg_addr; // @[Cache.scala 530:20]
    end
    if (reset) begin // @[Cache.scala 334:31]
      replace_buffer_addr <= 64'h0; // @[Cache.scala 334:31]
    end else if (_T_39) begin // @[Cache.scala 527:39]
      replace_buffer_addr <= _io_mem_req_bits_addr_T_3; // @[Cache.scala 535:25]
    end
    if (reset) begin // @[Cache.scala 334:31]
      replace_buffer_data <= 128'h0; // @[Cache.scala 334:31]
    end else if (_T_39) begin // @[Cache.scala 527:39]
      replace_buffer_data <= rand_way_data_datas; // @[Cache.scala 536:25]
    end
    if (reset) begin // @[Cache.scala 334:31]
      replace_buffer_way_num <= 4'h0; // @[Cache.scala 334:31]
    end else if (_T_39) begin // @[Cache.scala 527:39]
      replace_buffer_way_num <= rand_way; // @[Cache.scala 537:28]
    end
    if (reset) begin // @[Cache.scala 334:31]
      replace_buffer_v <= 1'h0; // @[Cache.scala 334:31]
    end else if (_T_39) begin // @[Cache.scala 527:39]
      replace_buffer_v <= rand_way_data_v; // @[Cache.scala 538:22]
    end
    if (reset) begin // @[Cache.scala 334:31]
      replace_buffer_d <= 1'h0; // @[Cache.scala 334:31]
    end else if (_T_39) begin // @[Cache.scala 527:39]
      replace_buffer_d <= rand_way_data_d; // @[Cache.scala 539:22]
    end
    if (reset) begin // @[Counter.scala 60:40]
      value_2 <= 1'h0; // @[Counter.scala 60:40]
    end else if (_T_22 & _T_34 & req_isCached) begin // @[Cache.scala 428:64]
      value_2 <= value_2 + 1'h1; // @[Counter.scala 76:15]
    end else if (_io_cpu_resp_valid_T) begin // @[Cache.scala 430:32]
      value_2 <= 1'h0; // @[Cache.scala 431:22]
    end
    if (reset) begin // @[Cache.scala 391:25]
      load_ret <= 64'h0; // @[Cache.scala 391:25]
    end else if (state == 3'h4 & (~req_reg_op & value_2 == req_reg_info_offset[3]) & io_mem_resp_valid) begin // @[Cache.scala 392:153]
      load_ret <= io_mem_resp_bits_data; // @[Cache.scala 393:14]
    end
    if (reset) begin // @[Counter.scala 60:40]
      value_3 <= 1'h0; // @[Counter.scala 60:40]
    end else if (!(_T_48)) begin // @[Cache.scala 444:4]
      if (_T_56) begin // @[Cache.scala 455:4]
        if (_T_57 & req_isCached) begin // @[Cache.scala 465:43]
          value_3 <= value_3 + 1'h1; // @[Counter.scala 76:15]
        end
      end
    end
    if (reset) begin // @[Counter.scala 60:40]
      value_4 <= 1'h0; // @[Counter.scala 60:40]
    end else if (!(_write_buffer_valid_T_7)) begin // @[Cache.scala 544:65]
      if (_T_35) begin // @[Cache.scala 553:58]
        if (req_isCached) begin // @[Cache.scala 554:33]
          value_4 <= value_4 + 1'h1; // @[Counter.scala 76:15]
        end
      end
    end
    io_fence_i_done_REG <= state; // @[Cache.scala 701:51]
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~(|rand_way | reset)) begin
          $fwrite(32'h80000002,"Assertion failed\n    at Cache.scala:323 assert(rand_way.orR() === 1.U)\n"); // @[Cache.scala 323:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~(|rand_way | reset)) begin
          $fatal; // @[Cache.scala 323:9]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  value = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  value_1 = _RAND_2[0:0];
  _RAND_3 = {2{`RANDOM}};
  fence_rdata_tag = _RAND_3[53:0];
  _RAND_4 = {1{`RANDOM}};
  fence_rdata_v = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  fence_rdata_d = _RAND_5[0:0];
  _RAND_6 = {4{`RANDOM}};
  fence_rdata_datas = _RAND_6[127:0];
  _RAND_7 = {2{`RANDOM}};
  req_reg_addr = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  req_reg_data = _RAND_8[63:0];
  _RAND_9 = {1{`RANDOM}};
  req_reg_mask = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  req_reg_op = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  req_isCached = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  write_buffer_valid = _RAND_12[0:0];
  _RAND_13 = {2{`RANDOM}};
  write_buffer_bits_tag = _RAND_13[53:0];
  _RAND_14 = {1{`RANDOM}};
  write_buffer_bits_index = _RAND_14[5:0];
  _RAND_15 = {1{`RANDOM}};
  write_buffer_bits_offset = _RAND_15[3:0];
  _RAND_16 = {1{`RANDOM}};
  write_buffer_bits_v = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  write_buffer_bits_d = _RAND_17[0:0];
  _RAND_18 = {2{`RANDOM}};
  write_buffer_bits_data = _RAND_18[63:0];
  _RAND_19 = {1{`RANDOM}};
  write_buffer_bits_replace_way = _RAND_19[3:0];
  _RAND_20 = {1{`RANDOM}};
  write_buffer_bits_wmask = _RAND_20[7:0];
  _RAND_21 = {2{`RANDOM}};
  miss_info_addr = _RAND_21[63:0];
  _RAND_22 = {2{`RANDOM}};
  replace_buffer_addr = _RAND_22[63:0];
  _RAND_23 = {4{`RANDOM}};
  replace_buffer_data = _RAND_23[127:0];
  _RAND_24 = {1{`RANDOM}};
  replace_buffer_way_num = _RAND_24[3:0];
  _RAND_25 = {1{`RANDOM}};
  replace_buffer_v = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  replace_buffer_d = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  value_2 = _RAND_27[0:0];
  _RAND_28 = {2{`RANDOM}};
  load_ret = _RAND_28[63:0];
  _RAND_29 = {1{`RANDOM}};
  value_3 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  value_4 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  io_fence_i_done_REG = _RAND_31[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_210013_Control(
  input  [31:0] io_inst,
  output [1:0]  io_signal_pc_sel,
  output        io_signal_a_sel,
  output        io_signal_b_sel,
  output [2:0]  io_signal_imm_sel,
  output [4:0]  io_signal_alu_op,
  output [2:0]  io_signal_br_type,
  output        io_signal_kill,
  output [2:0]  io_signal_st_type,
  output [2:0]  io_signal_ld_type,
  output [1:0]  io_signal_wb_type,
  output        io_signal_wen,
  output [2:0]  io_signal_csr_cmd,
  output        io_signal_illegal
);
  wire [31:0] _ctrl_signal_T = io_inst & 32'hfe00707f; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_1 = 32'h33 == _ctrl_signal_T; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_3 = 32'h40000033 == _ctrl_signal_T; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_5 = 32'h1033 == _ctrl_signal_T; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_7 = 32'h2033 == _ctrl_signal_T; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_9 = 32'h3033 == _ctrl_signal_T; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_11 = 32'h4033 == _ctrl_signal_T; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_13 = 32'h5033 == _ctrl_signal_T; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_15 = 32'h40005033 == _ctrl_signal_T; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_17 = 32'h6033 == _ctrl_signal_T; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_19 = 32'h7033 == _ctrl_signal_T; // @[Lookup.scala 31:38]
  wire [31:0] _ctrl_signal_T_20 = io_inst & 32'h707f; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_21 = 32'h67 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_23 = 32'h13 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_25 = 32'h2013 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_27 = 32'h3013 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_29 = 32'h4013 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_31 = 32'h6013 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_33 = 32'h7013 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_35 = 32'h3 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_37 = 32'h1003 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_39 = 32'h2003 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_41 = 32'h4003 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_43 = 32'h5003 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire [31:0] _ctrl_signal_T_44 = io_inst & 32'hfc00707f; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_45 = 32'h1013 == _ctrl_signal_T_44; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_47 = 32'h5013 == _ctrl_signal_T_44; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_49 = 32'h40005013 == _ctrl_signal_T; // @[Lookup.scala 31:38]
  wire [31:0] _ctrl_signal_T_50 = io_inst & 32'hf00fffff; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_51 = 32'hf == _ctrl_signal_T_50; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_53 = 32'h100f == io_inst; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_55 = 32'h73 == io_inst; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_57 = 32'h100073 == io_inst; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_59 = 32'h30200073 == io_inst; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_61 = 32'h10200073 == io_inst; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_63 = 32'h10500073 == io_inst; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_65 = 32'h1073 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_67 = 32'h2073 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_69 = 32'h3073 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_71 = 32'h5073 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_73 = 32'h6073 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_75 = 32'h7073 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire [31:0] _ctrl_signal_T_76 = io_inst & 32'h7f; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_77 = 32'h37 == _ctrl_signal_T_76; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_79 = 32'h17 == _ctrl_signal_T_76; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_81 = 32'h23 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_83 = 32'h1023 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_85 = 32'h2023 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_87 = 32'h63 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_89 = 32'h1063 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_91 = 32'h4063 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_93 = 32'h5063 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_95 = 32'h6063 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_97 = 32'h7063 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_99 = 32'h6f == _ctrl_signal_T_76; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_101 = 32'h103b == _ctrl_signal_T; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_103 = 32'h503b == _ctrl_signal_T; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_105 = 32'h4000503b == _ctrl_signal_T; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_107 = 32'h3b == _ctrl_signal_T; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_109 = 32'h4000003b == _ctrl_signal_T; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_111 = 32'h101b == _ctrl_signal_T_44; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_113 = 32'h501b == _ctrl_signal_T_44; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_115 = 32'h4000501b == _ctrl_signal_T_44; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_117 = 32'h1b == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_119 = 32'h6003 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_121 = 32'h3003 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire  _ctrl_signal_T_123 = 32'h3023 == _ctrl_signal_T_20; // @[Lookup.scala 31:38]
  wire [1:0] _ctrl_signal_T_136 = _ctrl_signal_T_99 ? 2'h1 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_137 = _ctrl_signal_T_97 ? 2'h0 : _ctrl_signal_T_136; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_138 = _ctrl_signal_T_95 ? 2'h0 : _ctrl_signal_T_137; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_139 = _ctrl_signal_T_93 ? 2'h0 : _ctrl_signal_T_138; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_140 = _ctrl_signal_T_91 ? 2'h0 : _ctrl_signal_T_139; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_141 = _ctrl_signal_T_89 ? 2'h0 : _ctrl_signal_T_140; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_142 = _ctrl_signal_T_87 ? 2'h0 : _ctrl_signal_T_141; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_143 = _ctrl_signal_T_85 ? 2'h0 : _ctrl_signal_T_142; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_144 = _ctrl_signal_T_83 ? 2'h0 : _ctrl_signal_T_143; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_145 = _ctrl_signal_T_81 ? 2'h0 : _ctrl_signal_T_144; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_146 = _ctrl_signal_T_79 ? 2'h0 : _ctrl_signal_T_145; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_147 = _ctrl_signal_T_77 ? 2'h0 : _ctrl_signal_T_146; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_148 = _ctrl_signal_T_75 ? 2'h0 : _ctrl_signal_T_147; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_149 = _ctrl_signal_T_73 ? 2'h0 : _ctrl_signal_T_148; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_150 = _ctrl_signal_T_71 ? 2'h0 : _ctrl_signal_T_149; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_151 = _ctrl_signal_T_69 ? 2'h0 : _ctrl_signal_T_150; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_152 = _ctrl_signal_T_67 ? 2'h0 : _ctrl_signal_T_151; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_153 = _ctrl_signal_T_65 ? 2'h0 : _ctrl_signal_T_152; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_154 = _ctrl_signal_T_63 ? 2'h0 : _ctrl_signal_T_153; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_155 = _ctrl_signal_T_61 ? 2'h3 : _ctrl_signal_T_154; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_156 = _ctrl_signal_T_59 ? 2'h3 : _ctrl_signal_T_155; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_157 = _ctrl_signal_T_57 ? 2'h0 : _ctrl_signal_T_156; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_158 = _ctrl_signal_T_55 ? 2'h0 : _ctrl_signal_T_157; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_159 = _ctrl_signal_T_53 ? 2'h2 : _ctrl_signal_T_158; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_160 = _ctrl_signal_T_51 ? 2'h0 : _ctrl_signal_T_159; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_161 = _ctrl_signal_T_49 ? 2'h0 : _ctrl_signal_T_160; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_162 = _ctrl_signal_T_47 ? 2'h0 : _ctrl_signal_T_161; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_163 = _ctrl_signal_T_45 ? 2'h0 : _ctrl_signal_T_162; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_164 = _ctrl_signal_T_43 ? 2'h0 : _ctrl_signal_T_163; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_165 = _ctrl_signal_T_41 ? 2'h0 : _ctrl_signal_T_164; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_166 = _ctrl_signal_T_39 ? 2'h0 : _ctrl_signal_T_165; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_167 = _ctrl_signal_T_37 ? 2'h0 : _ctrl_signal_T_166; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_168 = _ctrl_signal_T_35 ? 2'h0 : _ctrl_signal_T_167; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_169 = _ctrl_signal_T_33 ? 2'h0 : _ctrl_signal_T_168; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_170 = _ctrl_signal_T_31 ? 2'h0 : _ctrl_signal_T_169; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_171 = _ctrl_signal_T_29 ? 2'h0 : _ctrl_signal_T_170; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_172 = _ctrl_signal_T_27 ? 2'h0 : _ctrl_signal_T_171; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_173 = _ctrl_signal_T_25 ? 2'h0 : _ctrl_signal_T_172; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_174 = _ctrl_signal_T_23 ? 2'h0 : _ctrl_signal_T_173; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_175 = _ctrl_signal_T_21 ? 2'h1 : _ctrl_signal_T_174; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_176 = _ctrl_signal_T_19 ? 2'h0 : _ctrl_signal_T_175; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_177 = _ctrl_signal_T_17 ? 2'h0 : _ctrl_signal_T_176; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_178 = _ctrl_signal_T_15 ? 2'h0 : _ctrl_signal_T_177; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_179 = _ctrl_signal_T_13 ? 2'h0 : _ctrl_signal_T_178; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_180 = _ctrl_signal_T_11 ? 2'h0 : _ctrl_signal_T_179; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_181 = _ctrl_signal_T_9 ? 2'h0 : _ctrl_signal_T_180; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_182 = _ctrl_signal_T_7 ? 2'h0 : _ctrl_signal_T_181; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_183 = _ctrl_signal_T_5 ? 2'h0 : _ctrl_signal_T_182; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_184 = _ctrl_signal_T_3 ? 2'h0 : _ctrl_signal_T_183; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_197 = _ctrl_signal_T_99 ? 1'h0 : _ctrl_signal_T_101 | (_ctrl_signal_T_103 | (_ctrl_signal_T_105
     | (_ctrl_signal_T_107 | (_ctrl_signal_T_109 | (_ctrl_signal_T_111 | (_ctrl_signal_T_113 | (_ctrl_signal_T_115 | (
    _ctrl_signal_T_117 | (_ctrl_signal_T_119 | (_ctrl_signal_T_121 | _ctrl_signal_T_123)))))))))); // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_198 = _ctrl_signal_T_97 ? 1'h0 : _ctrl_signal_T_197; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_199 = _ctrl_signal_T_95 ? 1'h0 : _ctrl_signal_T_198; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_200 = _ctrl_signal_T_93 ? 1'h0 : _ctrl_signal_T_199; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_201 = _ctrl_signal_T_91 ? 1'h0 : _ctrl_signal_T_200; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_202 = _ctrl_signal_T_89 ? 1'h0 : _ctrl_signal_T_201; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_203 = _ctrl_signal_T_87 ? 1'h0 : _ctrl_signal_T_202; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_207 = _ctrl_signal_T_79 ? 1'h0 : _ctrl_signal_T_81 | (_ctrl_signal_T_83 | (_ctrl_signal_T_85 |
    _ctrl_signal_T_203)); // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_209 = _ctrl_signal_T_75 ? 1'h0 : _ctrl_signal_T_77 | _ctrl_signal_T_207; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_210 = _ctrl_signal_T_73 ? 1'h0 : _ctrl_signal_T_209; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_211 = _ctrl_signal_T_71 ? 1'h0 : _ctrl_signal_T_210; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_215 = _ctrl_signal_T_63 ? 1'h0 : _ctrl_signal_T_65 | (_ctrl_signal_T_67 | (_ctrl_signal_T_69 |
    _ctrl_signal_T_211)); // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_216 = _ctrl_signal_T_61 ? 1'h0 : _ctrl_signal_T_215; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_217 = _ctrl_signal_T_59 ? 1'h0 : _ctrl_signal_T_216; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_218 = _ctrl_signal_T_57 ? 1'h0 : _ctrl_signal_T_217; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_219 = _ctrl_signal_T_55 ? 1'h0 : _ctrl_signal_T_218; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_220 = _ctrl_signal_T_53 ? 1'h0 : _ctrl_signal_T_219; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_221 = _ctrl_signal_T_51 ? 1'h0 : _ctrl_signal_T_220; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_258 = _ctrl_signal_T_99 ? 1'h0 : _ctrl_signal_T_101 | (_ctrl_signal_T_103 | (_ctrl_signal_T_105
     | (_ctrl_signal_T_107 | _ctrl_signal_T_109))); // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_259 = _ctrl_signal_T_97 ? 1'h0 : _ctrl_signal_T_258; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_260 = _ctrl_signal_T_95 ? 1'h0 : _ctrl_signal_T_259; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_261 = _ctrl_signal_T_93 ? 1'h0 : _ctrl_signal_T_260; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_262 = _ctrl_signal_T_91 ? 1'h0 : _ctrl_signal_T_261; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_263 = _ctrl_signal_T_89 ? 1'h0 : _ctrl_signal_T_262; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_264 = _ctrl_signal_T_87 ? 1'h0 : _ctrl_signal_T_263; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_265 = _ctrl_signal_T_85 ? 1'h0 : _ctrl_signal_T_264; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_266 = _ctrl_signal_T_83 ? 1'h0 : _ctrl_signal_T_265; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_267 = _ctrl_signal_T_81 ? 1'h0 : _ctrl_signal_T_266; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_268 = _ctrl_signal_T_79 ? 1'h0 : _ctrl_signal_T_267; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_269 = _ctrl_signal_T_77 ? 1'h0 : _ctrl_signal_T_268; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_270 = _ctrl_signal_T_75 ? 1'h0 : _ctrl_signal_T_269; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_271 = _ctrl_signal_T_73 ? 1'h0 : _ctrl_signal_T_270; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_272 = _ctrl_signal_T_71 ? 1'h0 : _ctrl_signal_T_271; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_273 = _ctrl_signal_T_69 ? 1'h0 : _ctrl_signal_T_272; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_274 = _ctrl_signal_T_67 ? 1'h0 : _ctrl_signal_T_273; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_275 = _ctrl_signal_T_65 ? 1'h0 : _ctrl_signal_T_274; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_276 = _ctrl_signal_T_63 ? 1'h0 : _ctrl_signal_T_275; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_277 = _ctrl_signal_T_61 ? 1'h0 : _ctrl_signal_T_276; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_278 = _ctrl_signal_T_59 ? 1'h0 : _ctrl_signal_T_277; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_279 = _ctrl_signal_T_57 ? 1'h0 : _ctrl_signal_T_278; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_280 = _ctrl_signal_T_55 ? 1'h0 : _ctrl_signal_T_279; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_281 = _ctrl_signal_T_53 ? 1'h0 : _ctrl_signal_T_280; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_282 = _ctrl_signal_T_51 ? 1'h0 : _ctrl_signal_T_281; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_283 = _ctrl_signal_T_49 ? 1'h0 : _ctrl_signal_T_282; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_284 = _ctrl_signal_T_47 ? 1'h0 : _ctrl_signal_T_283; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_285 = _ctrl_signal_T_45 ? 1'h0 : _ctrl_signal_T_284; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_286 = _ctrl_signal_T_43 ? 1'h0 : _ctrl_signal_T_285; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_287 = _ctrl_signal_T_41 ? 1'h0 : _ctrl_signal_T_286; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_288 = _ctrl_signal_T_39 ? 1'h0 : _ctrl_signal_T_287; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_289 = _ctrl_signal_T_37 ? 1'h0 : _ctrl_signal_T_288; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_290 = _ctrl_signal_T_35 ? 1'h0 : _ctrl_signal_T_289; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_291 = _ctrl_signal_T_33 ? 1'h0 : _ctrl_signal_T_290; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_292 = _ctrl_signal_T_31 ? 1'h0 : _ctrl_signal_T_291; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_293 = _ctrl_signal_T_29 ? 1'h0 : _ctrl_signal_T_292; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_294 = _ctrl_signal_T_27 ? 1'h0 : _ctrl_signal_T_293; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_295 = _ctrl_signal_T_25 ? 1'h0 : _ctrl_signal_T_294; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_296 = _ctrl_signal_T_23 ? 1'h0 : _ctrl_signal_T_295; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_297 = _ctrl_signal_T_21 ? 1'h0 : _ctrl_signal_T_296; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_307 = _ctrl_signal_T_123 ? 3'h2 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_308 = _ctrl_signal_T_121 ? 3'h1 : _ctrl_signal_T_307; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_309 = _ctrl_signal_T_119 ? 3'h1 : _ctrl_signal_T_308; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_310 = _ctrl_signal_T_117 ? 3'h1 : _ctrl_signal_T_309; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_311 = _ctrl_signal_T_115 ? 3'h1 : _ctrl_signal_T_310; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_312 = _ctrl_signal_T_113 ? 3'h1 : _ctrl_signal_T_311; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_313 = _ctrl_signal_T_111 ? 3'h1 : _ctrl_signal_T_312; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_314 = _ctrl_signal_T_109 ? 3'h0 : _ctrl_signal_T_313; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_315 = _ctrl_signal_T_107 ? 3'h0 : _ctrl_signal_T_314; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_316 = _ctrl_signal_T_105 ? 3'h0 : _ctrl_signal_T_315; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_317 = _ctrl_signal_T_103 ? 3'h0 : _ctrl_signal_T_316; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_318 = _ctrl_signal_T_101 ? 3'h0 : _ctrl_signal_T_317; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_319 = _ctrl_signal_T_99 ? 3'h4 : _ctrl_signal_T_318; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_320 = _ctrl_signal_T_97 ? 3'h5 : _ctrl_signal_T_319; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_321 = _ctrl_signal_T_95 ? 3'h5 : _ctrl_signal_T_320; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_322 = _ctrl_signal_T_93 ? 3'h5 : _ctrl_signal_T_321; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_323 = _ctrl_signal_T_91 ? 3'h5 : _ctrl_signal_T_322; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_324 = _ctrl_signal_T_89 ? 3'h5 : _ctrl_signal_T_323; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_325 = _ctrl_signal_T_87 ? 3'h5 : _ctrl_signal_T_324; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_326 = _ctrl_signal_T_85 ? 3'h2 : _ctrl_signal_T_325; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_327 = _ctrl_signal_T_83 ? 3'h2 : _ctrl_signal_T_326; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_328 = _ctrl_signal_T_81 ? 3'h2 : _ctrl_signal_T_327; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_329 = _ctrl_signal_T_79 ? 3'h3 : _ctrl_signal_T_328; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_330 = _ctrl_signal_T_77 ? 3'h3 : _ctrl_signal_T_329; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_331 = _ctrl_signal_T_75 ? 3'h6 : _ctrl_signal_T_330; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_332 = _ctrl_signal_T_73 ? 3'h6 : _ctrl_signal_T_331; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_333 = _ctrl_signal_T_71 ? 3'h6 : _ctrl_signal_T_332; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_334 = _ctrl_signal_T_69 ? 3'h0 : _ctrl_signal_T_333; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_335 = _ctrl_signal_T_67 ? 3'h0 : _ctrl_signal_T_334; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_336 = _ctrl_signal_T_65 ? 3'h0 : _ctrl_signal_T_335; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_337 = _ctrl_signal_T_63 ? 3'h0 : _ctrl_signal_T_336; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_338 = _ctrl_signal_T_61 ? 3'h0 : _ctrl_signal_T_337; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_339 = _ctrl_signal_T_59 ? 3'h0 : _ctrl_signal_T_338; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_340 = _ctrl_signal_T_57 ? 3'h0 : _ctrl_signal_T_339; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_341 = _ctrl_signal_T_55 ? 3'h0 : _ctrl_signal_T_340; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_342 = _ctrl_signal_T_53 ? 3'h0 : _ctrl_signal_T_341; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_343 = _ctrl_signal_T_51 ? 3'h0 : _ctrl_signal_T_342; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_344 = _ctrl_signal_T_49 ? 3'h1 : _ctrl_signal_T_343; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_345 = _ctrl_signal_T_47 ? 3'h1 : _ctrl_signal_T_344; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_346 = _ctrl_signal_T_45 ? 3'h1 : _ctrl_signal_T_345; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_347 = _ctrl_signal_T_43 ? 3'h1 : _ctrl_signal_T_346; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_348 = _ctrl_signal_T_41 ? 3'h1 : _ctrl_signal_T_347; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_349 = _ctrl_signal_T_39 ? 3'h1 : _ctrl_signal_T_348; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_350 = _ctrl_signal_T_37 ? 3'h1 : _ctrl_signal_T_349; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_351 = _ctrl_signal_T_35 ? 3'h1 : _ctrl_signal_T_350; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_352 = _ctrl_signal_T_33 ? 3'h1 : _ctrl_signal_T_351; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_353 = _ctrl_signal_T_31 ? 3'h1 : _ctrl_signal_T_352; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_354 = _ctrl_signal_T_29 ? 3'h1 : _ctrl_signal_T_353; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_355 = _ctrl_signal_T_27 ? 3'h1 : _ctrl_signal_T_354; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_356 = _ctrl_signal_T_25 ? 3'h1 : _ctrl_signal_T_355; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_357 = _ctrl_signal_T_23 ? 3'h1 : _ctrl_signal_T_356; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_358 = _ctrl_signal_T_21 ? 3'h1 : _ctrl_signal_T_357; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_359 = _ctrl_signal_T_19 ? 3'h0 : _ctrl_signal_T_358; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_360 = _ctrl_signal_T_17 ? 3'h0 : _ctrl_signal_T_359; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_361 = _ctrl_signal_T_15 ? 3'h0 : _ctrl_signal_T_360; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_362 = _ctrl_signal_T_13 ? 3'h0 : _ctrl_signal_T_361; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_363 = _ctrl_signal_T_11 ? 3'h0 : _ctrl_signal_T_362; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_364 = _ctrl_signal_T_9 ? 3'h0 : _ctrl_signal_T_363; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_365 = _ctrl_signal_T_7 ? 3'h0 : _ctrl_signal_T_364; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_366 = _ctrl_signal_T_5 ? 3'h0 : _ctrl_signal_T_365; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_367 = _ctrl_signal_T_3 ? 3'h0 : _ctrl_signal_T_366; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_368 = _ctrl_signal_T_123 ? 5'h0 : 5'h15; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_369 = _ctrl_signal_T_121 ? 5'h0 : _ctrl_signal_T_368; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_370 = _ctrl_signal_T_119 ? 5'h0 : _ctrl_signal_T_369; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_371 = _ctrl_signal_T_117 ? 5'h14 : _ctrl_signal_T_370; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_372 = _ctrl_signal_T_115 ? 5'h13 : _ctrl_signal_T_371; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_373 = _ctrl_signal_T_113 ? 5'h12 : _ctrl_signal_T_372; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_374 = _ctrl_signal_T_111 ? 5'h11 : _ctrl_signal_T_373; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_375 = _ctrl_signal_T_109 ? 5'h10 : _ctrl_signal_T_374; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_376 = _ctrl_signal_T_107 ? 5'hf : _ctrl_signal_T_375; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_377 = _ctrl_signal_T_105 ? 5'he : _ctrl_signal_T_376; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_378 = _ctrl_signal_T_103 ? 5'hd : _ctrl_signal_T_377; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_379 = _ctrl_signal_T_101 ? 5'hc : _ctrl_signal_T_378; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_380 = _ctrl_signal_T_99 ? 5'h0 : _ctrl_signal_T_379; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_381 = _ctrl_signal_T_97 ? 5'h0 : _ctrl_signal_T_380; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_382 = _ctrl_signal_T_95 ? 5'h0 : _ctrl_signal_T_381; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_383 = _ctrl_signal_T_93 ? 5'h0 : _ctrl_signal_T_382; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_384 = _ctrl_signal_T_91 ? 5'h0 : _ctrl_signal_T_383; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_385 = _ctrl_signal_T_89 ? 5'h0 : _ctrl_signal_T_384; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_386 = _ctrl_signal_T_87 ? 5'h0 : _ctrl_signal_T_385; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_387 = _ctrl_signal_T_85 ? 5'h0 : _ctrl_signal_T_386; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_388 = _ctrl_signal_T_83 ? 5'h0 : _ctrl_signal_T_387; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_389 = _ctrl_signal_T_81 ? 5'h0 : _ctrl_signal_T_388; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_390 = _ctrl_signal_T_79 ? 5'h0 : _ctrl_signal_T_389; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_391 = _ctrl_signal_T_77 ? 5'hb : _ctrl_signal_T_390; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_392 = _ctrl_signal_T_75 ? 5'hb : _ctrl_signal_T_391; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_393 = _ctrl_signal_T_73 ? 5'hb : _ctrl_signal_T_392; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_394 = _ctrl_signal_T_71 ? 5'hb : _ctrl_signal_T_393; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_395 = _ctrl_signal_T_69 ? 5'ha : _ctrl_signal_T_394; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_396 = _ctrl_signal_T_67 ? 5'ha : _ctrl_signal_T_395; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_397 = _ctrl_signal_T_65 ? 5'ha : _ctrl_signal_T_396; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_398 = _ctrl_signal_T_63 ? 5'h15 : _ctrl_signal_T_397; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_399 = _ctrl_signal_T_61 ? 5'h15 : _ctrl_signal_T_398; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_400 = _ctrl_signal_T_59 ? 5'h15 : _ctrl_signal_T_399; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_401 = _ctrl_signal_T_57 ? 5'h15 : _ctrl_signal_T_400; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_402 = _ctrl_signal_T_55 ? 5'h15 : _ctrl_signal_T_401; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_403 = _ctrl_signal_T_53 ? 5'h15 : _ctrl_signal_T_402; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_404 = _ctrl_signal_T_51 ? 5'h15 : _ctrl_signal_T_403; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_405 = _ctrl_signal_T_49 ? 5'h9 : _ctrl_signal_T_404; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_406 = _ctrl_signal_T_47 ? 5'h8 : _ctrl_signal_T_405; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_407 = _ctrl_signal_T_45 ? 5'h6 : _ctrl_signal_T_406; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_408 = _ctrl_signal_T_43 ? 5'h0 : _ctrl_signal_T_407; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_409 = _ctrl_signal_T_41 ? 5'h0 : _ctrl_signal_T_408; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_410 = _ctrl_signal_T_39 ? 5'h0 : _ctrl_signal_T_409; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_411 = _ctrl_signal_T_37 ? 5'h0 : _ctrl_signal_T_410; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_412 = _ctrl_signal_T_35 ? 5'h0 : _ctrl_signal_T_411; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_413 = _ctrl_signal_T_33 ? 5'h2 : _ctrl_signal_T_412; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_414 = _ctrl_signal_T_31 ? 5'h3 : _ctrl_signal_T_413; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_415 = _ctrl_signal_T_29 ? 5'h4 : _ctrl_signal_T_414; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_416 = _ctrl_signal_T_27 ? 5'h7 : _ctrl_signal_T_415; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_417 = _ctrl_signal_T_25 ? 5'h5 : _ctrl_signal_T_416; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_418 = _ctrl_signal_T_23 ? 5'h0 : _ctrl_signal_T_417; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_419 = _ctrl_signal_T_21 ? 5'h0 : _ctrl_signal_T_418; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_420 = _ctrl_signal_T_19 ? 5'h2 : _ctrl_signal_T_419; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_421 = _ctrl_signal_T_17 ? 5'h3 : _ctrl_signal_T_420; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_422 = _ctrl_signal_T_15 ? 5'h9 : _ctrl_signal_T_421; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_423 = _ctrl_signal_T_13 ? 5'h8 : _ctrl_signal_T_422; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_424 = _ctrl_signal_T_11 ? 5'h4 : _ctrl_signal_T_423; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_425 = _ctrl_signal_T_9 ? 5'h7 : _ctrl_signal_T_424; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_426 = _ctrl_signal_T_7 ? 5'h5 : _ctrl_signal_T_425; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_427 = _ctrl_signal_T_5 ? 5'h6 : _ctrl_signal_T_426; // @[Lookup.scala 33:37]
  wire [4:0] _ctrl_signal_T_428 = _ctrl_signal_T_3 ? 5'h1 : _ctrl_signal_T_427; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_441 = _ctrl_signal_T_99 ? 3'h7 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_442 = _ctrl_signal_T_97 ? 3'h4 : _ctrl_signal_T_441; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_443 = _ctrl_signal_T_95 ? 3'h1 : _ctrl_signal_T_442; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_444 = _ctrl_signal_T_93 ? 3'h5 : _ctrl_signal_T_443; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_445 = _ctrl_signal_T_91 ? 3'h2 : _ctrl_signal_T_444; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_446 = _ctrl_signal_T_89 ? 3'h6 : _ctrl_signal_T_445; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_447 = _ctrl_signal_T_87 ? 3'h3 : _ctrl_signal_T_446; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_448 = _ctrl_signal_T_85 ? 3'h0 : _ctrl_signal_T_447; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_449 = _ctrl_signal_T_83 ? 3'h0 : _ctrl_signal_T_448; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_450 = _ctrl_signal_T_81 ? 3'h0 : _ctrl_signal_T_449; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_451 = _ctrl_signal_T_79 ? 3'h0 : _ctrl_signal_T_450; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_452 = _ctrl_signal_T_77 ? 3'h0 : _ctrl_signal_T_451; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_453 = _ctrl_signal_T_75 ? 3'h0 : _ctrl_signal_T_452; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_454 = _ctrl_signal_T_73 ? 3'h0 : _ctrl_signal_T_453; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_455 = _ctrl_signal_T_71 ? 3'h0 : _ctrl_signal_T_454; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_456 = _ctrl_signal_T_69 ? 3'h0 : _ctrl_signal_T_455; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_457 = _ctrl_signal_T_67 ? 3'h0 : _ctrl_signal_T_456; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_458 = _ctrl_signal_T_65 ? 3'h0 : _ctrl_signal_T_457; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_459 = _ctrl_signal_T_63 ? 3'h0 : _ctrl_signal_T_458; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_460 = _ctrl_signal_T_61 ? 3'h0 : _ctrl_signal_T_459; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_461 = _ctrl_signal_T_59 ? 3'h0 : _ctrl_signal_T_460; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_462 = _ctrl_signal_T_57 ? 3'h0 : _ctrl_signal_T_461; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_463 = _ctrl_signal_T_55 ? 3'h0 : _ctrl_signal_T_462; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_464 = _ctrl_signal_T_53 ? 3'h0 : _ctrl_signal_T_463; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_465 = _ctrl_signal_T_51 ? 3'h0 : _ctrl_signal_T_464; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_466 = _ctrl_signal_T_49 ? 3'h0 : _ctrl_signal_T_465; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_467 = _ctrl_signal_T_47 ? 3'h0 : _ctrl_signal_T_466; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_468 = _ctrl_signal_T_45 ? 3'h0 : _ctrl_signal_T_467; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_469 = _ctrl_signal_T_43 ? 3'h0 : _ctrl_signal_T_468; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_470 = _ctrl_signal_T_41 ? 3'h0 : _ctrl_signal_T_469; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_471 = _ctrl_signal_T_39 ? 3'h0 : _ctrl_signal_T_470; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_472 = _ctrl_signal_T_37 ? 3'h0 : _ctrl_signal_T_471; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_473 = _ctrl_signal_T_35 ? 3'h0 : _ctrl_signal_T_472; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_474 = _ctrl_signal_T_33 ? 3'h0 : _ctrl_signal_T_473; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_475 = _ctrl_signal_T_31 ? 3'h0 : _ctrl_signal_T_474; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_476 = _ctrl_signal_T_29 ? 3'h0 : _ctrl_signal_T_475; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_477 = _ctrl_signal_T_27 ? 3'h0 : _ctrl_signal_T_476; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_478 = _ctrl_signal_T_25 ? 3'h0 : _ctrl_signal_T_477; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_479 = _ctrl_signal_T_23 ? 3'h0 : _ctrl_signal_T_478; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_480 = _ctrl_signal_T_21 ? 3'h7 : _ctrl_signal_T_479; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_481 = _ctrl_signal_T_19 ? 3'h0 : _ctrl_signal_T_480; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_482 = _ctrl_signal_T_17 ? 3'h0 : _ctrl_signal_T_481; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_483 = _ctrl_signal_T_15 ? 3'h0 : _ctrl_signal_T_482; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_484 = _ctrl_signal_T_13 ? 3'h0 : _ctrl_signal_T_483; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_485 = _ctrl_signal_T_11 ? 3'h0 : _ctrl_signal_T_484; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_486 = _ctrl_signal_T_9 ? 3'h0 : _ctrl_signal_T_485; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_487 = _ctrl_signal_T_7 ? 3'h0 : _ctrl_signal_T_486; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_488 = _ctrl_signal_T_5 ? 3'h0 : _ctrl_signal_T_487; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_489 = _ctrl_signal_T_3 ? 3'h0 : _ctrl_signal_T_488; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_523 = _ctrl_signal_T_57 ? 1'h0 : _ctrl_signal_T_59 | _ctrl_signal_T_61; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_524 = _ctrl_signal_T_55 ? 1'h0 : _ctrl_signal_T_523; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_526 = _ctrl_signal_T_51 ? 1'h0 : _ctrl_signal_T_53 | _ctrl_signal_T_524; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_527 = _ctrl_signal_T_49 ? 1'h0 : _ctrl_signal_T_526; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_528 = _ctrl_signal_T_47 ? 1'h0 : _ctrl_signal_T_527; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_529 = _ctrl_signal_T_45 ? 1'h0 : _ctrl_signal_T_528; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_530 = _ctrl_signal_T_43 ? 1'h0 : _ctrl_signal_T_529; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_531 = _ctrl_signal_T_41 ? 1'h0 : _ctrl_signal_T_530; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_532 = _ctrl_signal_T_39 ? 1'h0 : _ctrl_signal_T_531; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_533 = _ctrl_signal_T_37 ? 1'h0 : _ctrl_signal_T_532; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_534 = _ctrl_signal_T_35 ? 1'h0 : _ctrl_signal_T_533; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_535 = _ctrl_signal_T_33 ? 1'h0 : _ctrl_signal_T_534; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_536 = _ctrl_signal_T_31 ? 1'h0 : _ctrl_signal_T_535; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_537 = _ctrl_signal_T_29 ? 1'h0 : _ctrl_signal_T_536; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_538 = _ctrl_signal_T_27 ? 1'h0 : _ctrl_signal_T_537; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_539 = _ctrl_signal_T_25 ? 1'h0 : _ctrl_signal_T_538; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_540 = _ctrl_signal_T_23 ? 1'h0 : _ctrl_signal_T_539; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_541 = _ctrl_signal_T_21 ? 1'h0 : _ctrl_signal_T_540; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_542 = _ctrl_signal_T_19 ? 1'h0 : _ctrl_signal_T_541; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_543 = _ctrl_signal_T_17 ? 1'h0 : _ctrl_signal_T_542; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_544 = _ctrl_signal_T_15 ? 1'h0 : _ctrl_signal_T_543; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_545 = _ctrl_signal_T_13 ? 1'h0 : _ctrl_signal_T_544; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_546 = _ctrl_signal_T_11 ? 1'h0 : _ctrl_signal_T_545; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_547 = _ctrl_signal_T_9 ? 1'h0 : _ctrl_signal_T_546; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_548 = _ctrl_signal_T_7 ? 1'h0 : _ctrl_signal_T_547; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_549 = _ctrl_signal_T_5 ? 1'h0 : _ctrl_signal_T_548; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_550 = _ctrl_signal_T_3 ? 1'h0 : _ctrl_signal_T_549; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_551 = _ctrl_signal_T_123 ? 3'h1 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_552 = _ctrl_signal_T_121 ? 3'h0 : _ctrl_signal_T_551; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_553 = _ctrl_signal_T_119 ? 3'h0 : _ctrl_signal_T_552; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_554 = _ctrl_signal_T_117 ? 3'h0 : _ctrl_signal_T_553; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_555 = _ctrl_signal_T_115 ? 3'h0 : _ctrl_signal_T_554; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_556 = _ctrl_signal_T_113 ? 3'h0 : _ctrl_signal_T_555; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_557 = _ctrl_signal_T_111 ? 3'h0 : _ctrl_signal_T_556; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_558 = _ctrl_signal_T_109 ? 3'h0 : _ctrl_signal_T_557; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_559 = _ctrl_signal_T_107 ? 3'h0 : _ctrl_signal_T_558; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_560 = _ctrl_signal_T_105 ? 3'h0 : _ctrl_signal_T_559; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_561 = _ctrl_signal_T_103 ? 3'h0 : _ctrl_signal_T_560; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_562 = _ctrl_signal_T_101 ? 3'h0 : _ctrl_signal_T_561; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_563 = _ctrl_signal_T_99 ? 3'h0 : _ctrl_signal_T_562; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_564 = _ctrl_signal_T_97 ? 3'h0 : _ctrl_signal_T_563; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_565 = _ctrl_signal_T_95 ? 3'h0 : _ctrl_signal_T_564; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_566 = _ctrl_signal_T_93 ? 3'h0 : _ctrl_signal_T_565; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_567 = _ctrl_signal_T_91 ? 3'h0 : _ctrl_signal_T_566; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_568 = _ctrl_signal_T_89 ? 3'h0 : _ctrl_signal_T_567; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_569 = _ctrl_signal_T_87 ? 3'h0 : _ctrl_signal_T_568; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_570 = _ctrl_signal_T_85 ? 3'h2 : _ctrl_signal_T_569; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_571 = _ctrl_signal_T_83 ? 3'h3 : _ctrl_signal_T_570; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_572 = _ctrl_signal_T_81 ? 3'h4 : _ctrl_signal_T_571; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_573 = _ctrl_signal_T_79 ? 3'h0 : _ctrl_signal_T_572; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_574 = _ctrl_signal_T_77 ? 3'h0 : _ctrl_signal_T_573; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_575 = _ctrl_signal_T_75 ? 3'h0 : _ctrl_signal_T_574; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_576 = _ctrl_signal_T_73 ? 3'h0 : _ctrl_signal_T_575; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_577 = _ctrl_signal_T_71 ? 3'h0 : _ctrl_signal_T_576; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_578 = _ctrl_signal_T_69 ? 3'h0 : _ctrl_signal_T_577; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_579 = _ctrl_signal_T_67 ? 3'h0 : _ctrl_signal_T_578; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_580 = _ctrl_signal_T_65 ? 3'h0 : _ctrl_signal_T_579; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_581 = _ctrl_signal_T_63 ? 3'h0 : _ctrl_signal_T_580; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_582 = _ctrl_signal_T_61 ? 3'h0 : _ctrl_signal_T_581; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_583 = _ctrl_signal_T_59 ? 3'h0 : _ctrl_signal_T_582; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_584 = _ctrl_signal_T_57 ? 3'h0 : _ctrl_signal_T_583; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_585 = _ctrl_signal_T_55 ? 3'h0 : _ctrl_signal_T_584; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_586 = _ctrl_signal_T_53 ? 3'h0 : _ctrl_signal_T_585; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_587 = _ctrl_signal_T_51 ? 3'h0 : _ctrl_signal_T_586; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_588 = _ctrl_signal_T_49 ? 3'h0 : _ctrl_signal_T_587; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_589 = _ctrl_signal_T_47 ? 3'h0 : _ctrl_signal_T_588; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_590 = _ctrl_signal_T_45 ? 3'h0 : _ctrl_signal_T_589; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_591 = _ctrl_signal_T_43 ? 3'h0 : _ctrl_signal_T_590; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_592 = _ctrl_signal_T_41 ? 3'h0 : _ctrl_signal_T_591; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_593 = _ctrl_signal_T_39 ? 3'h0 : _ctrl_signal_T_592; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_594 = _ctrl_signal_T_37 ? 3'h0 : _ctrl_signal_T_593; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_595 = _ctrl_signal_T_35 ? 3'h0 : _ctrl_signal_T_594; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_596 = _ctrl_signal_T_33 ? 3'h0 : _ctrl_signal_T_595; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_597 = _ctrl_signal_T_31 ? 3'h0 : _ctrl_signal_T_596; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_598 = _ctrl_signal_T_29 ? 3'h0 : _ctrl_signal_T_597; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_599 = _ctrl_signal_T_27 ? 3'h0 : _ctrl_signal_T_598; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_600 = _ctrl_signal_T_25 ? 3'h0 : _ctrl_signal_T_599; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_601 = _ctrl_signal_T_23 ? 3'h0 : _ctrl_signal_T_600; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_602 = _ctrl_signal_T_21 ? 3'h0 : _ctrl_signal_T_601; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_603 = _ctrl_signal_T_19 ? 3'h0 : _ctrl_signal_T_602; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_604 = _ctrl_signal_T_17 ? 3'h0 : _ctrl_signal_T_603; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_605 = _ctrl_signal_T_15 ? 3'h0 : _ctrl_signal_T_604; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_606 = _ctrl_signal_T_13 ? 3'h0 : _ctrl_signal_T_605; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_607 = _ctrl_signal_T_11 ? 3'h0 : _ctrl_signal_T_606; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_608 = _ctrl_signal_T_9 ? 3'h0 : _ctrl_signal_T_607; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_609 = _ctrl_signal_T_7 ? 3'h0 : _ctrl_signal_T_608; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_610 = _ctrl_signal_T_5 ? 3'h0 : _ctrl_signal_T_609; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_611 = _ctrl_signal_T_3 ? 3'h0 : _ctrl_signal_T_610; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_613 = _ctrl_signal_T_121 ? 3'h1 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_614 = _ctrl_signal_T_119 ? 3'h5 : _ctrl_signal_T_613; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_615 = _ctrl_signal_T_117 ? 3'h0 : _ctrl_signal_T_614; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_616 = _ctrl_signal_T_115 ? 3'h0 : _ctrl_signal_T_615; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_617 = _ctrl_signal_T_113 ? 3'h0 : _ctrl_signal_T_616; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_618 = _ctrl_signal_T_111 ? 3'h0 : _ctrl_signal_T_617; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_619 = _ctrl_signal_T_109 ? 3'h0 : _ctrl_signal_T_618; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_620 = _ctrl_signal_T_107 ? 3'h0 : _ctrl_signal_T_619; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_621 = _ctrl_signal_T_105 ? 3'h0 : _ctrl_signal_T_620; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_622 = _ctrl_signal_T_103 ? 3'h0 : _ctrl_signal_T_621; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_623 = _ctrl_signal_T_101 ? 3'h0 : _ctrl_signal_T_622; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_624 = _ctrl_signal_T_99 ? 3'h0 : _ctrl_signal_T_623; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_625 = _ctrl_signal_T_97 ? 3'h0 : _ctrl_signal_T_624; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_626 = _ctrl_signal_T_95 ? 3'h0 : _ctrl_signal_T_625; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_627 = _ctrl_signal_T_93 ? 3'h0 : _ctrl_signal_T_626; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_628 = _ctrl_signal_T_91 ? 3'h0 : _ctrl_signal_T_627; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_629 = _ctrl_signal_T_89 ? 3'h0 : _ctrl_signal_T_628; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_630 = _ctrl_signal_T_87 ? 3'h0 : _ctrl_signal_T_629; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_631 = _ctrl_signal_T_85 ? 3'h0 : _ctrl_signal_T_630; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_632 = _ctrl_signal_T_83 ? 3'h0 : _ctrl_signal_T_631; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_633 = _ctrl_signal_T_81 ? 3'h0 : _ctrl_signal_T_632; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_634 = _ctrl_signal_T_79 ? 3'h0 : _ctrl_signal_T_633; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_635 = _ctrl_signal_T_77 ? 3'h0 : _ctrl_signal_T_634; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_636 = _ctrl_signal_T_75 ? 3'h0 : _ctrl_signal_T_635; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_637 = _ctrl_signal_T_73 ? 3'h0 : _ctrl_signal_T_636; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_638 = _ctrl_signal_T_71 ? 3'h0 : _ctrl_signal_T_637; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_639 = _ctrl_signal_T_69 ? 3'h0 : _ctrl_signal_T_638; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_640 = _ctrl_signal_T_67 ? 3'h0 : _ctrl_signal_T_639; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_641 = _ctrl_signal_T_65 ? 3'h0 : _ctrl_signal_T_640; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_642 = _ctrl_signal_T_63 ? 3'h0 : _ctrl_signal_T_641; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_643 = _ctrl_signal_T_61 ? 3'h0 : _ctrl_signal_T_642; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_644 = _ctrl_signal_T_59 ? 3'h0 : _ctrl_signal_T_643; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_645 = _ctrl_signal_T_57 ? 3'h0 : _ctrl_signal_T_644; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_646 = _ctrl_signal_T_55 ? 3'h0 : _ctrl_signal_T_645; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_647 = _ctrl_signal_T_53 ? 3'h0 : _ctrl_signal_T_646; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_648 = _ctrl_signal_T_51 ? 3'h0 : _ctrl_signal_T_647; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_649 = _ctrl_signal_T_49 ? 3'h0 : _ctrl_signal_T_648; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_650 = _ctrl_signal_T_47 ? 3'h0 : _ctrl_signal_T_649; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_651 = _ctrl_signal_T_45 ? 3'h0 : _ctrl_signal_T_650; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_652 = _ctrl_signal_T_43 ? 3'h6 : _ctrl_signal_T_651; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_653 = _ctrl_signal_T_41 ? 3'h7 : _ctrl_signal_T_652; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_654 = _ctrl_signal_T_39 ? 3'h2 : _ctrl_signal_T_653; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_655 = _ctrl_signal_T_37 ? 3'h3 : _ctrl_signal_T_654; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_656 = _ctrl_signal_T_35 ? 3'h4 : _ctrl_signal_T_655; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_657 = _ctrl_signal_T_33 ? 3'h0 : _ctrl_signal_T_656; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_658 = _ctrl_signal_T_31 ? 3'h0 : _ctrl_signal_T_657; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_659 = _ctrl_signal_T_29 ? 3'h0 : _ctrl_signal_T_658; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_660 = _ctrl_signal_T_27 ? 3'h0 : _ctrl_signal_T_659; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_661 = _ctrl_signal_T_25 ? 3'h0 : _ctrl_signal_T_660; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_662 = _ctrl_signal_T_23 ? 3'h0 : _ctrl_signal_T_661; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_663 = _ctrl_signal_T_21 ? 3'h0 : _ctrl_signal_T_662; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_664 = _ctrl_signal_T_19 ? 3'h0 : _ctrl_signal_T_663; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_665 = _ctrl_signal_T_17 ? 3'h0 : _ctrl_signal_T_664; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_666 = _ctrl_signal_T_15 ? 3'h0 : _ctrl_signal_T_665; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_667 = _ctrl_signal_T_13 ? 3'h0 : _ctrl_signal_T_666; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_668 = _ctrl_signal_T_11 ? 3'h0 : _ctrl_signal_T_667; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_669 = _ctrl_signal_T_9 ? 3'h0 : _ctrl_signal_T_668; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_670 = _ctrl_signal_T_7 ? 3'h0 : _ctrl_signal_T_669; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_671 = _ctrl_signal_T_5 ? 3'h0 : _ctrl_signal_T_670; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_672 = _ctrl_signal_T_3 ? 3'h0 : _ctrl_signal_T_671; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_674 = _ctrl_signal_T_121 ? 2'h1 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_675 = _ctrl_signal_T_119 ? 2'h1 : _ctrl_signal_T_674; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_676 = _ctrl_signal_T_117 ? 2'h0 : _ctrl_signal_T_675; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_677 = _ctrl_signal_T_115 ? 2'h0 : _ctrl_signal_T_676; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_678 = _ctrl_signal_T_113 ? 2'h0 : _ctrl_signal_T_677; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_679 = _ctrl_signal_T_111 ? 2'h0 : _ctrl_signal_T_678; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_680 = _ctrl_signal_T_109 ? 2'h0 : _ctrl_signal_T_679; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_681 = _ctrl_signal_T_107 ? 2'h0 : _ctrl_signal_T_680; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_682 = _ctrl_signal_T_105 ? 2'h0 : _ctrl_signal_T_681; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_683 = _ctrl_signal_T_103 ? 2'h0 : _ctrl_signal_T_682; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_684 = _ctrl_signal_T_101 ? 2'h0 : _ctrl_signal_T_683; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_685 = _ctrl_signal_T_99 ? 2'h2 : _ctrl_signal_T_684; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_686 = _ctrl_signal_T_97 ? 2'h0 : _ctrl_signal_T_685; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_687 = _ctrl_signal_T_95 ? 2'h0 : _ctrl_signal_T_686; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_688 = _ctrl_signal_T_93 ? 2'h0 : _ctrl_signal_T_687; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_689 = _ctrl_signal_T_91 ? 2'h0 : _ctrl_signal_T_688; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_690 = _ctrl_signal_T_89 ? 2'h0 : _ctrl_signal_T_689; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_691 = _ctrl_signal_T_87 ? 2'h0 : _ctrl_signal_T_690; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_692 = _ctrl_signal_T_85 ? 2'h1 : _ctrl_signal_T_691; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_693 = _ctrl_signal_T_83 ? 2'h1 : _ctrl_signal_T_692; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_694 = _ctrl_signal_T_81 ? 2'h1 : _ctrl_signal_T_693; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_695 = _ctrl_signal_T_79 ? 2'h0 : _ctrl_signal_T_694; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_696 = _ctrl_signal_T_77 ? 2'h0 : _ctrl_signal_T_695; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_697 = _ctrl_signal_T_75 ? 2'h3 : _ctrl_signal_T_696; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_698 = _ctrl_signal_T_73 ? 2'h3 : _ctrl_signal_T_697; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_699 = _ctrl_signal_T_71 ? 2'h3 : _ctrl_signal_T_698; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_700 = _ctrl_signal_T_69 ? 2'h3 : _ctrl_signal_T_699; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_701 = _ctrl_signal_T_67 ? 2'h3 : _ctrl_signal_T_700; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_702 = _ctrl_signal_T_65 ? 2'h3 : _ctrl_signal_T_701; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_703 = _ctrl_signal_T_63 ? 2'h0 : _ctrl_signal_T_702; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_704 = _ctrl_signal_T_61 ? 2'h0 : _ctrl_signal_T_703; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_705 = _ctrl_signal_T_59 ? 2'h0 : _ctrl_signal_T_704; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_706 = _ctrl_signal_T_57 ? 2'h0 : _ctrl_signal_T_705; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_707 = _ctrl_signal_T_55 ? 2'h0 : _ctrl_signal_T_706; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_708 = _ctrl_signal_T_53 ? 2'h0 : _ctrl_signal_T_707; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_709 = _ctrl_signal_T_51 ? 2'h0 : _ctrl_signal_T_708; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_710 = _ctrl_signal_T_49 ? 2'h0 : _ctrl_signal_T_709; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_711 = _ctrl_signal_T_47 ? 2'h0 : _ctrl_signal_T_710; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_712 = _ctrl_signal_T_45 ? 2'h0 : _ctrl_signal_T_711; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_713 = _ctrl_signal_T_43 ? 2'h1 : _ctrl_signal_T_712; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_714 = _ctrl_signal_T_41 ? 2'h1 : _ctrl_signal_T_713; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_715 = _ctrl_signal_T_39 ? 2'h1 : _ctrl_signal_T_714; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_716 = _ctrl_signal_T_37 ? 2'h1 : _ctrl_signal_T_715; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_717 = _ctrl_signal_T_35 ? 2'h1 : _ctrl_signal_T_716; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_718 = _ctrl_signal_T_33 ? 2'h0 : _ctrl_signal_T_717; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_719 = _ctrl_signal_T_31 ? 2'h0 : _ctrl_signal_T_718; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_720 = _ctrl_signal_T_29 ? 2'h0 : _ctrl_signal_T_719; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_721 = _ctrl_signal_T_27 ? 2'h0 : _ctrl_signal_T_720; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_722 = _ctrl_signal_T_25 ? 2'h0 : _ctrl_signal_T_721; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_723 = _ctrl_signal_T_23 ? 2'h0 : _ctrl_signal_T_722; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_724 = _ctrl_signal_T_21 ? 2'h2 : _ctrl_signal_T_723; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_725 = _ctrl_signal_T_19 ? 2'h0 : _ctrl_signal_T_724; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_726 = _ctrl_signal_T_17 ? 2'h0 : _ctrl_signal_T_725; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_727 = _ctrl_signal_T_15 ? 2'h0 : _ctrl_signal_T_726; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_728 = _ctrl_signal_T_13 ? 2'h0 : _ctrl_signal_T_727; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_729 = _ctrl_signal_T_11 ? 2'h0 : _ctrl_signal_T_728; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_730 = _ctrl_signal_T_9 ? 2'h0 : _ctrl_signal_T_729; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_731 = _ctrl_signal_T_7 ? 2'h0 : _ctrl_signal_T_730; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_732 = _ctrl_signal_T_5 ? 2'h0 : _ctrl_signal_T_731; // @[Lookup.scala 33:37]
  wire [1:0] _ctrl_signal_T_733 = _ctrl_signal_T_3 ? 2'h0 : _ctrl_signal_T_732; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_747 = _ctrl_signal_T_97 ? 1'h0 : _ctrl_signal_T_99 | (_ctrl_signal_T_101 | (_ctrl_signal_T_103 |
    (_ctrl_signal_T_105 | (_ctrl_signal_T_107 | (_ctrl_signal_T_109 | (_ctrl_signal_T_111 | (_ctrl_signal_T_113 | (
    _ctrl_signal_T_115 | (_ctrl_signal_T_117 | (_ctrl_signal_T_119 | _ctrl_signal_T_121)))))))))); // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_748 = _ctrl_signal_T_95 ? 1'h0 : _ctrl_signal_T_747; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_749 = _ctrl_signal_T_93 ? 1'h0 : _ctrl_signal_T_748; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_750 = _ctrl_signal_T_91 ? 1'h0 : _ctrl_signal_T_749; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_751 = _ctrl_signal_T_89 ? 1'h0 : _ctrl_signal_T_750; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_752 = _ctrl_signal_T_87 ? 1'h0 : _ctrl_signal_T_751; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_753 = _ctrl_signal_T_85 ? 1'h0 : _ctrl_signal_T_752; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_754 = _ctrl_signal_T_83 ? 1'h0 : _ctrl_signal_T_753; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_755 = _ctrl_signal_T_81 ? 1'h0 : _ctrl_signal_T_754; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_764 = _ctrl_signal_T_63 ? 1'h0 : _ctrl_signal_T_65 | (_ctrl_signal_T_67 | (_ctrl_signal_T_69 | (
    _ctrl_signal_T_71 | (_ctrl_signal_T_73 | (_ctrl_signal_T_75 | (_ctrl_signal_T_77 | (_ctrl_signal_T_79 |
    _ctrl_signal_T_755))))))); // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_765 = _ctrl_signal_T_61 ? 1'h0 : _ctrl_signal_T_764; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_766 = _ctrl_signal_T_59 ? 1'h0 : _ctrl_signal_T_765; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_767 = _ctrl_signal_T_57 ? 1'h0 : _ctrl_signal_T_766; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_768 = _ctrl_signal_T_55 ? 1'h0 : _ctrl_signal_T_767; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_769 = _ctrl_signal_T_53 ? 1'h0 : _ctrl_signal_T_768; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_770 = _ctrl_signal_T_51 ? 1'h0 : _ctrl_signal_T_769; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_819 = _ctrl_signal_T_75 ? 3'h3 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_820 = _ctrl_signal_T_73 ? 3'h2 : _ctrl_signal_T_819; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_821 = _ctrl_signal_T_71 ? 3'h1 : _ctrl_signal_T_820; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_822 = _ctrl_signal_T_69 ? 3'h3 : _ctrl_signal_T_821; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_823 = _ctrl_signal_T_67 ? 3'h2 : _ctrl_signal_T_822; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_824 = _ctrl_signal_T_65 ? 3'h1 : _ctrl_signal_T_823; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_825 = _ctrl_signal_T_63 ? 3'h0 : _ctrl_signal_T_824; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_826 = _ctrl_signal_T_61 ? 3'h4 : _ctrl_signal_T_825; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_827 = _ctrl_signal_T_59 ? 3'h4 : _ctrl_signal_T_826; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_828 = _ctrl_signal_T_57 ? 3'h4 : _ctrl_signal_T_827; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_829 = _ctrl_signal_T_55 ? 3'h4 : _ctrl_signal_T_828; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_830 = _ctrl_signal_T_53 ? 3'h0 : _ctrl_signal_T_829; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_831 = _ctrl_signal_T_51 ? 3'h0 : _ctrl_signal_T_830; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_832 = _ctrl_signal_T_49 ? 3'h0 : _ctrl_signal_T_831; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_833 = _ctrl_signal_T_47 ? 3'h0 : _ctrl_signal_T_832; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_834 = _ctrl_signal_T_45 ? 3'h0 : _ctrl_signal_T_833; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_835 = _ctrl_signal_T_43 ? 3'h0 : _ctrl_signal_T_834; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_836 = _ctrl_signal_T_41 ? 3'h0 : _ctrl_signal_T_835; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_837 = _ctrl_signal_T_39 ? 3'h0 : _ctrl_signal_T_836; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_838 = _ctrl_signal_T_37 ? 3'h0 : _ctrl_signal_T_837; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_839 = _ctrl_signal_T_35 ? 3'h0 : _ctrl_signal_T_838; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_840 = _ctrl_signal_T_33 ? 3'h0 : _ctrl_signal_T_839; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_841 = _ctrl_signal_T_31 ? 3'h0 : _ctrl_signal_T_840; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_842 = _ctrl_signal_T_29 ? 3'h0 : _ctrl_signal_T_841; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_843 = _ctrl_signal_T_27 ? 3'h0 : _ctrl_signal_T_842; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_844 = _ctrl_signal_T_25 ? 3'h0 : _ctrl_signal_T_843; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_845 = _ctrl_signal_T_23 ? 3'h0 : _ctrl_signal_T_844; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_846 = _ctrl_signal_T_21 ? 3'h0 : _ctrl_signal_T_845; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_847 = _ctrl_signal_T_19 ? 3'h0 : _ctrl_signal_T_846; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_848 = _ctrl_signal_T_17 ? 3'h0 : _ctrl_signal_T_847; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_849 = _ctrl_signal_T_15 ? 3'h0 : _ctrl_signal_T_848; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_850 = _ctrl_signal_T_13 ? 3'h0 : _ctrl_signal_T_849; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_851 = _ctrl_signal_T_11 ? 3'h0 : _ctrl_signal_T_850; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_852 = _ctrl_signal_T_9 ? 3'h0 : _ctrl_signal_T_851; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_853 = _ctrl_signal_T_7 ? 3'h0 : _ctrl_signal_T_852; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_854 = _ctrl_signal_T_5 ? 3'h0 : _ctrl_signal_T_853; // @[Lookup.scala 33:37]
  wire [2:0] _ctrl_signal_T_855 = _ctrl_signal_T_3 ? 3'h0 : _ctrl_signal_T_854; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_856 = _ctrl_signal_T_123 ? 1'h0 : 1'h1; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_857 = _ctrl_signal_T_121 ? 1'h0 : _ctrl_signal_T_856; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_858 = _ctrl_signal_T_119 ? 1'h0 : _ctrl_signal_T_857; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_859 = _ctrl_signal_T_117 ? 1'h0 : _ctrl_signal_T_858; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_860 = _ctrl_signal_T_115 ? 1'h0 : _ctrl_signal_T_859; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_861 = _ctrl_signal_T_113 ? 1'h0 : _ctrl_signal_T_860; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_862 = _ctrl_signal_T_111 ? 1'h0 : _ctrl_signal_T_861; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_863 = _ctrl_signal_T_109 ? 1'h0 : _ctrl_signal_T_862; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_864 = _ctrl_signal_T_107 ? 1'h0 : _ctrl_signal_T_863; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_865 = _ctrl_signal_T_105 ? 1'h0 : _ctrl_signal_T_864; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_866 = _ctrl_signal_T_103 ? 1'h0 : _ctrl_signal_T_865; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_867 = _ctrl_signal_T_101 ? 1'h0 : _ctrl_signal_T_866; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_868 = _ctrl_signal_T_99 ? 1'h0 : _ctrl_signal_T_867; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_869 = _ctrl_signal_T_97 ? 1'h0 : _ctrl_signal_T_868; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_870 = _ctrl_signal_T_95 ? 1'h0 : _ctrl_signal_T_869; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_871 = _ctrl_signal_T_93 ? 1'h0 : _ctrl_signal_T_870; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_872 = _ctrl_signal_T_91 ? 1'h0 : _ctrl_signal_T_871; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_873 = _ctrl_signal_T_89 ? 1'h0 : _ctrl_signal_T_872; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_874 = _ctrl_signal_T_87 ? 1'h0 : _ctrl_signal_T_873; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_875 = _ctrl_signal_T_85 ? 1'h0 : _ctrl_signal_T_874; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_876 = _ctrl_signal_T_83 ? 1'h0 : _ctrl_signal_T_875; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_877 = _ctrl_signal_T_81 ? 1'h0 : _ctrl_signal_T_876; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_878 = _ctrl_signal_T_79 ? 1'h0 : _ctrl_signal_T_877; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_879 = _ctrl_signal_T_77 ? 1'h0 : _ctrl_signal_T_878; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_880 = _ctrl_signal_T_75 ? 1'h0 : _ctrl_signal_T_879; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_881 = _ctrl_signal_T_73 ? 1'h0 : _ctrl_signal_T_880; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_882 = _ctrl_signal_T_71 ? 1'h0 : _ctrl_signal_T_881; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_883 = _ctrl_signal_T_69 ? 1'h0 : _ctrl_signal_T_882; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_884 = _ctrl_signal_T_67 ? 1'h0 : _ctrl_signal_T_883; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_885 = _ctrl_signal_T_65 ? 1'h0 : _ctrl_signal_T_884; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_886 = _ctrl_signal_T_63 ? 1'h0 : _ctrl_signal_T_885; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_887 = _ctrl_signal_T_61 ? 1'h0 : _ctrl_signal_T_886; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_888 = _ctrl_signal_T_59 ? 1'h0 : _ctrl_signal_T_887; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_889 = _ctrl_signal_T_57 ? 1'h0 : _ctrl_signal_T_888; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_890 = _ctrl_signal_T_55 ? 1'h0 : _ctrl_signal_T_889; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_891 = _ctrl_signal_T_53 ? 1'h0 : _ctrl_signal_T_890; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_892 = _ctrl_signal_T_51 ? 1'h0 : _ctrl_signal_T_891; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_893 = _ctrl_signal_T_49 ? 1'h0 : _ctrl_signal_T_892; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_894 = _ctrl_signal_T_47 ? 1'h0 : _ctrl_signal_T_893; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_895 = _ctrl_signal_T_45 ? 1'h0 : _ctrl_signal_T_894; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_896 = _ctrl_signal_T_43 ? 1'h0 : _ctrl_signal_T_895; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_897 = _ctrl_signal_T_41 ? 1'h0 : _ctrl_signal_T_896; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_898 = _ctrl_signal_T_39 ? 1'h0 : _ctrl_signal_T_897; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_899 = _ctrl_signal_T_37 ? 1'h0 : _ctrl_signal_T_898; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_900 = _ctrl_signal_T_35 ? 1'h0 : _ctrl_signal_T_899; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_901 = _ctrl_signal_T_33 ? 1'h0 : _ctrl_signal_T_900; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_902 = _ctrl_signal_T_31 ? 1'h0 : _ctrl_signal_T_901; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_903 = _ctrl_signal_T_29 ? 1'h0 : _ctrl_signal_T_902; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_904 = _ctrl_signal_T_27 ? 1'h0 : _ctrl_signal_T_903; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_905 = _ctrl_signal_T_25 ? 1'h0 : _ctrl_signal_T_904; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_906 = _ctrl_signal_T_23 ? 1'h0 : _ctrl_signal_T_905; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_907 = _ctrl_signal_T_21 ? 1'h0 : _ctrl_signal_T_906; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_908 = _ctrl_signal_T_19 ? 1'h0 : _ctrl_signal_T_907; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_909 = _ctrl_signal_T_17 ? 1'h0 : _ctrl_signal_T_908; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_910 = _ctrl_signal_T_15 ? 1'h0 : _ctrl_signal_T_909; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_911 = _ctrl_signal_T_13 ? 1'h0 : _ctrl_signal_T_910; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_912 = _ctrl_signal_T_11 ? 1'h0 : _ctrl_signal_T_911; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_913 = _ctrl_signal_T_9 ? 1'h0 : _ctrl_signal_T_912; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_914 = _ctrl_signal_T_7 ? 1'h0 : _ctrl_signal_T_913; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_915 = _ctrl_signal_T_5 ? 1'h0 : _ctrl_signal_T_914; // @[Lookup.scala 33:37]
  wire  _ctrl_signal_T_916 = _ctrl_signal_T_3 ? 1'h0 : _ctrl_signal_T_915; // @[Lookup.scala 33:37]
  assign io_signal_pc_sel = _ctrl_signal_T_1 ? 2'h0 : _ctrl_signal_T_184; // @[Lookup.scala 33:37]
  assign io_signal_a_sel = _ctrl_signal_T_1 | (_ctrl_signal_T_3 | (_ctrl_signal_T_5 | (_ctrl_signal_T_7 | (
    _ctrl_signal_T_9 | (_ctrl_signal_T_11 | (_ctrl_signal_T_13 | (_ctrl_signal_T_15 | (_ctrl_signal_T_17 | (
    _ctrl_signal_T_19 | (_ctrl_signal_T_21 | (_ctrl_signal_T_23 | (_ctrl_signal_T_25 | (_ctrl_signal_T_27 | (
    _ctrl_signal_T_29 | (_ctrl_signal_T_31 | (_ctrl_signal_T_33 | (_ctrl_signal_T_35 | (_ctrl_signal_T_37 | (
    _ctrl_signal_T_39 | (_ctrl_signal_T_41 | (_ctrl_signal_T_43 | (_ctrl_signal_T_45 | (_ctrl_signal_T_47 | (
    _ctrl_signal_T_49 | _ctrl_signal_T_221)))))))))))))))))))))))); // @[Lookup.scala 33:37]
  assign io_signal_b_sel = _ctrl_signal_T_1 | (_ctrl_signal_T_3 | (_ctrl_signal_T_5 | (_ctrl_signal_T_7 | (
    _ctrl_signal_T_9 | (_ctrl_signal_T_11 | (_ctrl_signal_T_13 | (_ctrl_signal_T_15 | (_ctrl_signal_T_17 | (
    _ctrl_signal_T_19 | _ctrl_signal_T_297))))))))); // @[Lookup.scala 33:37]
  assign io_signal_imm_sel = _ctrl_signal_T_1 ? 3'h0 : _ctrl_signal_T_367; // @[Lookup.scala 33:37]
  assign io_signal_alu_op = _ctrl_signal_T_1 ? 5'h0 : _ctrl_signal_T_428; // @[Lookup.scala 33:37]
  assign io_signal_br_type = _ctrl_signal_T_1 ? 3'h0 : _ctrl_signal_T_489; // @[Lookup.scala 33:37]
  assign io_signal_kill = _ctrl_signal_T_1 ? 1'h0 : _ctrl_signal_T_550; // @[Lookup.scala 33:37]
  assign io_signal_st_type = _ctrl_signal_T_1 ? 3'h0 : _ctrl_signal_T_611; // @[Lookup.scala 33:37]
  assign io_signal_ld_type = _ctrl_signal_T_1 ? 3'h0 : _ctrl_signal_T_672; // @[Lookup.scala 33:37]
  assign io_signal_wb_type = _ctrl_signal_T_1 ? 2'h0 : _ctrl_signal_T_733; // @[Lookup.scala 33:37]
  assign io_signal_wen = _ctrl_signal_T_1 | (_ctrl_signal_T_3 | (_ctrl_signal_T_5 | (_ctrl_signal_T_7 | (
    _ctrl_signal_T_9 | (_ctrl_signal_T_11 | (_ctrl_signal_T_13 | (_ctrl_signal_T_15 | (_ctrl_signal_T_17 | (
    _ctrl_signal_T_19 | (_ctrl_signal_T_21 | (_ctrl_signal_T_23 | (_ctrl_signal_T_25 | (_ctrl_signal_T_27 | (
    _ctrl_signal_T_29 | (_ctrl_signal_T_31 | (_ctrl_signal_T_33 | (_ctrl_signal_T_35 | (_ctrl_signal_T_37 | (
    _ctrl_signal_T_39 | (_ctrl_signal_T_41 | (_ctrl_signal_T_43 | (_ctrl_signal_T_45 | (_ctrl_signal_T_47 | (
    _ctrl_signal_T_49 | _ctrl_signal_T_770)))))))))))))))))))))))); // @[Lookup.scala 33:37]
  assign io_signal_csr_cmd = _ctrl_signal_T_1 ? 3'h0 : _ctrl_signal_T_855; // @[Lookup.scala 33:37]
  assign io_signal_illegal = _ctrl_signal_T_1 ? 1'h0 : _ctrl_signal_T_916; // @[Lookup.scala 33:37]
endmodule
module ysyx_210013_LockingArbiter(
  input         clock,
  input         reset,
  output        io_in_0_ready,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits_addr,
  input  [63:0] io_in_0_bits_data,
  input  [3:0]  io_in_0_bits_cmd,
  input  [1:0]  io_in_0_bits_len,
  input  [7:0]  io_in_0_bits_mask,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits_addr,
  input  [63:0] io_in_1_bits_data,
  input  [3:0]  io_in_1_bits_cmd,
  input  [1:0]  io_in_1_bits_len,
  input  [7:0]  io_in_1_bits_mask,
  input         io_out_ready,
  output        io_out_valid,
  output [63:0] io_out_bits_addr,
  output [63:0] io_out_bits_data,
  output [3:0]  io_out_bits_cmd,
  output [1:0]  io_out_bits_len,
  output [3:0]  io_out_bits_id,
  output [7:0]  io_out_bits_mask,
  output        io_chosen
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] value; // @[Counter.scala 60:40]
  reg  lockIdx; // @[Arbiter.scala 46:22]
  wire  locked = value != 2'h0; // @[Arbiter.scala 47:34]
  wire  wantsLock = io_out_bits_cmd == 4'h9 | io_out_bits_cmd == 4'hc & io_out_bits_len != 2'h0 | io_out_bits_cmd == 4'ha
     & io_out_bits_len != 2'h0; // @[CrossBar.scala 17:124]
  wire  _T = io_out_ready & io_out_valid; // @[Decoupled.scala 40:37]
  wire  wrap = value == 2'h2; // @[Counter.scala 72:24]
  wire [1:0] _value_T_1 = value + 2'h1; // @[Counter.scala 76:24]
  wire  choice = io_in_0_valid ? 1'h0 : 1'h1; // @[Arbiter.scala 88:27 Arbiter.scala 88:36]
  wire  _T_2 = ~io_in_0_valid; // @[Arbiter.scala 31:78]
  wire  _io_in_0_ready_T_1 = locked ? ~lockIdx : 1'h1; // @[Arbiter.scala 57:22]
  wire  _io_in_1_ready_T_1 = locked ? lockIdx : _T_2; // @[Arbiter.scala 57:22]
  assign io_in_0_ready = _io_in_0_ready_T_1 & io_out_ready; // @[Arbiter.scala 57:56]
  assign io_in_1_ready = _io_in_1_ready_T_1 & io_out_ready; // @[Arbiter.scala 57:56]
  assign io_out_valid = io_chosen ? io_in_1_valid : io_in_0_valid; // @[Arbiter.scala 41:16 Arbiter.scala 41:16]
  assign io_out_bits_addr = io_chosen ? io_in_1_bits_addr : io_in_0_bits_addr; // @[Arbiter.scala 42:15 Arbiter.scala 42:15]
  assign io_out_bits_data = io_chosen ? io_in_1_bits_data : io_in_0_bits_data; // @[Arbiter.scala 42:15 Arbiter.scala 42:15]
  assign io_out_bits_cmd = io_chosen ? io_in_1_bits_cmd : io_in_0_bits_cmd; // @[Arbiter.scala 42:15 Arbiter.scala 42:15]
  assign io_out_bits_len = io_chosen ? io_in_1_bits_len : io_in_0_bits_len; // @[Arbiter.scala 42:15 Arbiter.scala 42:15]
  assign io_out_bits_id = io_chosen ? 4'h1 : 4'h0; // @[Arbiter.scala 42:15 Arbiter.scala 42:15]
  assign io_out_bits_mask = io_chosen ? io_in_1_bits_mask : io_in_0_bits_mask; // @[Arbiter.scala 42:15 Arbiter.scala 42:15]
  assign io_chosen = locked ? lockIdx : choice; // @[Arbiter.scala 55:19 Arbiter.scala 55:31 Arbiter.scala 40:13]
  always @(posedge clock) begin
    if (reset) begin // @[Counter.scala 60:40]
      value <= 2'h0; // @[Counter.scala 60:40]
    end else if (_T & wantsLock) begin // @[Arbiter.scala 50:39]
      if (wrap) begin // @[Counter.scala 86:20]
        value <= 2'h0; // @[Counter.scala 86:28]
      end else begin
        value <= _value_T_1; // @[Counter.scala 76:15]
      end
    end
    if (_T & wantsLock) begin // @[Arbiter.scala 50:39]
      lockIdx <= io_chosen; // @[Arbiter.scala 51:15]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  value = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  lockIdx = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_210013_InnerCrossBarN21(
  input         clock,
  input         reset,
  output        io_in_0_req_ready,
  input         io_in_0_req_valid,
  input  [63:0] io_in_0_req_bits_addr,
  input  [63:0] io_in_0_req_bits_data,
  input  [3:0]  io_in_0_req_bits_cmd,
  input  [1:0]  io_in_0_req_bits_len,
  input  [7:0]  io_in_0_req_bits_mask,
  input         io_in_0_resp_ready,
  output        io_in_0_resp_valid,
  output [63:0] io_in_0_resp_bits_data,
  output [3:0]  io_in_0_resp_bits_cmd,
  output        io_in_1_req_ready,
  input         io_in_1_req_valid,
  input  [63:0] io_in_1_req_bits_addr,
  input  [63:0] io_in_1_req_bits_data,
  input  [3:0]  io_in_1_req_bits_cmd,
  input  [1:0]  io_in_1_req_bits_len,
  input  [7:0]  io_in_1_req_bits_mask,
  input         io_in_1_resp_ready,
  output        io_in_1_resp_valid,
  output [63:0] io_in_1_resp_bits_data,
  output [3:0]  io_in_1_resp_bits_cmd,
  input         io_out_req_ready,
  output        io_out_req_valid,
  output [63:0] io_out_req_bits_addr,
  output [63:0] io_out_req_bits_data,
  output [3:0]  io_out_req_bits_cmd,
  output [1:0]  io_out_req_bits_len,
  output [3:0]  io_out_req_bits_id,
  output [7:0]  io_out_req_bits_mask,
  output        io_out_resp_ready,
  input         io_out_resp_valid,
  input  [63:0] io_out_resp_bits_data,
  input  [3:0]  io_out_resp_bits_cmd,
  input  [3:0]  io_out_resp_bits_id
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  arbiter_clock; // @[CrossBar.scala 18:23]
  wire  arbiter_reset; // @[CrossBar.scala 18:23]
  wire  arbiter_io_in_0_ready; // @[CrossBar.scala 18:23]
  wire  arbiter_io_in_0_valid; // @[CrossBar.scala 18:23]
  wire [63:0] arbiter_io_in_0_bits_addr; // @[CrossBar.scala 18:23]
  wire [63:0] arbiter_io_in_0_bits_data; // @[CrossBar.scala 18:23]
  wire [3:0] arbiter_io_in_0_bits_cmd; // @[CrossBar.scala 18:23]
  wire [1:0] arbiter_io_in_0_bits_len; // @[CrossBar.scala 18:23]
  wire [7:0] arbiter_io_in_0_bits_mask; // @[CrossBar.scala 18:23]
  wire  arbiter_io_in_1_ready; // @[CrossBar.scala 18:23]
  wire  arbiter_io_in_1_valid; // @[CrossBar.scala 18:23]
  wire [63:0] arbiter_io_in_1_bits_addr; // @[CrossBar.scala 18:23]
  wire [63:0] arbiter_io_in_1_bits_data; // @[CrossBar.scala 18:23]
  wire [3:0] arbiter_io_in_1_bits_cmd; // @[CrossBar.scala 18:23]
  wire [1:0] arbiter_io_in_1_bits_len; // @[CrossBar.scala 18:23]
  wire [7:0] arbiter_io_in_1_bits_mask; // @[CrossBar.scala 18:23]
  wire  arbiter_io_out_ready; // @[CrossBar.scala 18:23]
  wire  arbiter_io_out_valid; // @[CrossBar.scala 18:23]
  wire [63:0] arbiter_io_out_bits_addr; // @[CrossBar.scala 18:23]
  wire [63:0] arbiter_io_out_bits_data; // @[CrossBar.scala 18:23]
  wire [3:0] arbiter_io_out_bits_cmd; // @[CrossBar.scala 18:23]
  wire [1:0] arbiter_io_out_bits_len; // @[CrossBar.scala 18:23]
  wire [3:0] arbiter_io_out_bits_id; // @[CrossBar.scala 18:23]
  wire [7:0] arbiter_io_out_bits_mask; // @[CrossBar.scala 18:23]
  wire  arbiter_io_chosen; // @[CrossBar.scala 18:23]
  reg [1:0] state; // @[CrossBar.scala 21:22]
  reg  cur_idx; // @[CrossBar.scala 24:24]
  wire  _T = 2'h0 == state; // @[Conditional.scala 37:30]
  wire  _T_1 = arbiter_io_out_ready & arbiter_io_out_valid; // @[Decoupled.scala 40:37]
  wire [1:0] _GEN_0 = arbiter_io_out_bits_cmd == 4'h8 ? 2'h2 : state; // @[CrossBar.scala 36:64 CrossBar.scala 37:17 CrossBar.scala 21:22]
  wire [1:0] _GEN_1 = arbiter_io_out_bits_cmd == 4'h0 ? 2'h1 : _GEN_0; // @[CrossBar.scala 34:63 CrossBar.scala 35:17]
  wire [1:0] _GEN_2 = arbiter_io_out_bits_cmd == 4'h9 ? 2'h2 : _GEN_1; // @[CrossBar.scala 32:65 CrossBar.scala 33:17]
  wire  _T_6 = 2'h1 == state; // @[Conditional.scala 37:30]
  wire  _T_7 = io_out_resp_ready & io_out_resp_valid; // @[Decoupled.scala 40:37]
  wire  _T_10 = 2'h2 == state; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_7 = io_out_resp_valid ? 2'h0 : state; // @[CrossBar.scala 42:49 CrossBar.scala 42:57 CrossBar.scala 21:22]
  wire  _arbiter_io_in_0_valid_T_2 = ~cur_idx; // @[CrossBar.scala 49:43]
  wire  _arbiter_io_in_0_valid_T_9 = state == 2'h2 & ~cur_idx & (io_in_0_req_bits_cmd == 4'hc & io_in_0_req_bits_len != 2'h0
     | io_in_0_req_bits_cmd == 4'ha); // @[CrossBar.scala 49:69]
  wire  _arbiter_io_in_0_valid_T_10 = state == 2'h0 | _arbiter_io_in_0_valid_T_9; // @[CrossBar.scala 48:49]
  wire  _arbiter_io_in_0_valid_T_13 = state == 2'h1 & _arbiter_io_in_0_valid_T_2; // @[CrossBar.scala 50:31]
  wire  _arbiter_io_in_0_valid_T_14 = _arbiter_io_in_0_valid_T_10 | _arbiter_io_in_0_valid_T_13; // @[CrossBar.scala 49:182]
  wire  _arbiter_io_in_1_valid_T_9 = state == 2'h2 & cur_idx & (io_in_1_req_bits_cmd == 4'hc & io_in_1_req_bits_len != 2'h0
     | io_in_1_req_bits_cmd == 4'ha); // @[CrossBar.scala 49:69]
  wire  _arbiter_io_in_1_valid_T_10 = state == 2'h0 | _arbiter_io_in_1_valid_T_9; // @[CrossBar.scala 48:49]
  wire  _arbiter_io_in_1_valid_T_13 = state == 2'h1 & cur_idx; // @[CrossBar.scala 50:31]
  wire  _arbiter_io_in_1_valid_T_14 = _arbiter_io_in_1_valid_T_10 | _arbiter_io_in_1_valid_T_13; // @[CrossBar.scala 49:182]
  ysyx_210013_LockingArbiter arbiter ( // @[CrossBar.scala 18:23]
    .clock(arbiter_clock),
    .reset(arbiter_reset),
    .io_in_0_ready(arbiter_io_in_0_ready),
    .io_in_0_valid(arbiter_io_in_0_valid),
    .io_in_0_bits_addr(arbiter_io_in_0_bits_addr),
    .io_in_0_bits_data(arbiter_io_in_0_bits_data),
    .io_in_0_bits_cmd(arbiter_io_in_0_bits_cmd),
    .io_in_0_bits_len(arbiter_io_in_0_bits_len),
    .io_in_0_bits_mask(arbiter_io_in_0_bits_mask),
    .io_in_1_ready(arbiter_io_in_1_ready),
    .io_in_1_valid(arbiter_io_in_1_valid),
    .io_in_1_bits_addr(arbiter_io_in_1_bits_addr),
    .io_in_1_bits_data(arbiter_io_in_1_bits_data),
    .io_in_1_bits_cmd(arbiter_io_in_1_bits_cmd),
    .io_in_1_bits_len(arbiter_io_in_1_bits_len),
    .io_in_1_bits_mask(arbiter_io_in_1_bits_mask),
    .io_out_ready(arbiter_io_out_ready),
    .io_out_valid(arbiter_io_out_valid),
    .io_out_bits_addr(arbiter_io_out_bits_addr),
    .io_out_bits_data(arbiter_io_out_bits_data),
    .io_out_bits_cmd(arbiter_io_out_bits_cmd),
    .io_out_bits_len(arbiter_io_out_bits_len),
    .io_out_bits_id(arbiter_io_out_bits_id),
    .io_out_bits_mask(arbiter_io_out_bits_mask),
    .io_chosen(arbiter_io_chosen)
  );
  assign io_in_0_req_ready = arbiter_io_in_0_ready & _arbiter_io_in_0_valid_T_14; // @[CrossBar.scala 54:27]
  assign io_in_0_resp_valid = io_out_resp_valid & io_out_resp_bits_id == 4'h0; // @[CrossBar.scala 68:37]
  assign io_in_0_resp_bits_data = io_out_resp_bits_data; // @[CrossBar.scala 67:15]
  assign io_in_0_resp_bits_cmd = io_out_resp_bits_cmd; // @[CrossBar.scala 67:15]
  assign io_in_1_req_ready = arbiter_io_in_1_ready & _arbiter_io_in_1_valid_T_14; // @[CrossBar.scala 54:27]
  assign io_in_1_resp_valid = io_out_resp_valid & io_out_resp_bits_id == 4'h1; // @[CrossBar.scala 68:37]
  assign io_in_1_resp_bits_data = io_out_resp_bits_data; // @[CrossBar.scala 67:15]
  assign io_in_1_resp_bits_cmd = io_out_resp_bits_cmd; // @[CrossBar.scala 67:15]
  assign io_out_req_valid = arbiter_io_out_valid; // @[CrossBar.scala 61:14]
  assign io_out_req_bits_addr = arbiter_io_out_bits_addr; // @[CrossBar.scala 61:14]
  assign io_out_req_bits_data = arbiter_io_out_bits_data; // @[CrossBar.scala 61:14]
  assign io_out_req_bits_cmd = arbiter_io_out_bits_cmd; // @[CrossBar.scala 61:14]
  assign io_out_req_bits_len = arbiter_io_out_bits_len; // @[CrossBar.scala 61:14]
  assign io_out_req_bits_id = arbiter_io_out_bits_id; // @[CrossBar.scala 61:14]
  assign io_out_req_bits_mask = arbiter_io_out_bits_mask; // @[CrossBar.scala 61:14]
  assign io_out_resp_ready = cur_idx ? io_in_1_resp_ready : io_in_0_resp_ready; // @[CrossBar.scala 62:21 CrossBar.scala 62:21]
  assign arbiter_clock = clock;
  assign arbiter_reset = reset;
  assign arbiter_io_in_0_valid = io_in_0_req_valid & _arbiter_io_in_0_valid_T_14; // @[CrossBar.scala 48:27]
  assign arbiter_io_in_0_bits_addr = io_in_0_req_bits_addr; // @[CrossBar.scala 47:14]
  assign arbiter_io_in_0_bits_data = io_in_0_req_bits_data; // @[CrossBar.scala 47:14]
  assign arbiter_io_in_0_bits_cmd = io_in_0_req_bits_cmd; // @[CrossBar.scala 47:14]
  assign arbiter_io_in_0_bits_len = io_in_0_req_bits_len; // @[CrossBar.scala 47:14]
  assign arbiter_io_in_0_bits_mask = io_in_0_req_bits_mask; // @[CrossBar.scala 47:14]
  assign arbiter_io_in_1_valid = io_in_1_req_valid & _arbiter_io_in_1_valid_T_14; // @[CrossBar.scala 48:27]
  assign arbiter_io_in_1_bits_addr = io_in_1_req_bits_addr; // @[CrossBar.scala 47:14]
  assign arbiter_io_in_1_bits_data = io_in_1_req_bits_data; // @[CrossBar.scala 47:14]
  assign arbiter_io_in_1_bits_cmd = io_in_1_req_bits_cmd; // @[CrossBar.scala 47:14]
  assign arbiter_io_in_1_bits_len = io_in_1_req_bits_len; // @[CrossBar.scala 47:14]
  assign arbiter_io_in_1_bits_mask = io_in_1_req_bits_mask; // @[CrossBar.scala 47:14]
  assign arbiter_io_out_ready = io_out_req_ready; // @[CrossBar.scala 61:14]
  always @(posedge clock) begin
    if (reset) begin // @[CrossBar.scala 21:22]
      state <= 2'h0; // @[CrossBar.scala 21:22]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (_T_1) begin // @[CrossBar.scala 28:29]
        if (arbiter_io_out_bits_cmd == 4'h1) begin // @[CrossBar.scala 30:59]
          state <= 2'h1; // @[CrossBar.scala 31:17]
        end else begin
          state <= _GEN_2;
        end
      end
    end else if (_T_6) begin // @[Conditional.scala 39:67]
      if (_T_7 & io_out_resp_bits_cmd == 4'h2) begin // @[CrossBar.scala 41:98]
        state <= 2'h0; // @[CrossBar.scala 41:106]
      end
    end else if (_T_10) begin // @[Conditional.scala 39:67]
      state <= _GEN_7;
    end
    if (reset) begin // @[CrossBar.scala 24:24]
      cur_idx <= 1'h0; // @[CrossBar.scala 24:24]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (_T_1) begin // @[CrossBar.scala 28:29]
        cur_idx <= arbiter_io_chosen; // @[CrossBar.scala 29:17]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  cur_idx = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_210013_InnerCrossBar12N(
  input         clock,
  input         reset,
  output        io_in_req_ready,
  input         io_in_req_valid,
  input  [63:0] io_in_req_bits_addr,
  input  [63:0] io_in_req_bits_data,
  input  [3:0]  io_in_req_bits_cmd,
  input  [1:0]  io_in_req_bits_len,
  input  [3:0]  io_in_req_bits_id,
  input  [7:0]  io_in_req_bits_mask,
  input         io_in_resp_ready,
  output        io_in_resp_valid,
  output [63:0] io_in_resp_bits_data,
  output [3:0]  io_in_resp_bits_cmd,
  output [3:0]  io_in_resp_bits_id,
  input         io_out_0_req_ready,
  output        io_out_0_req_valid,
  output [63:0] io_out_0_req_bits_addr,
  output [63:0] io_out_0_req_bits_data,
  output [3:0]  io_out_0_req_bits_cmd,
  output [1:0]  io_out_0_req_bits_len,
  output [3:0]  io_out_0_req_bits_id,
  output [7:0]  io_out_0_req_bits_mask,
  output        io_out_0_resp_ready,
  input         io_out_0_resp_valid,
  input  [63:0] io_out_0_resp_bits_data,
  input  [3:0]  io_out_0_resp_bits_cmd,
  input  [3:0]  io_out_0_resp_bits_id,
  input         io_out_1_req_ready,
  output        io_out_1_req_valid,
  output [63:0] io_out_1_req_bits_addr,
  output [63:0] io_out_1_req_bits_data,
  output [3:0]  io_out_1_req_bits_cmd,
  output [1:0]  io_out_1_req_bits_len,
  output [3:0]  io_out_1_req_bits_id,
  output [7:0]  io_out_1_req_bits_mask,
  output        io_out_1_resp_ready,
  input         io_out_1_resp_valid,
  input  [63:0] io_out_1_resp_bits_data,
  input  [3:0]  io_out_1_resp_bits_cmd,
  input  [3:0]  io_out_1_resp_bits_id
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[CrossBar.scala 86:22]
  wire  outSelVec_0 = io_in_req_bits_addr >= 64'h2000000 & io_in_req_bits_addr < 64'h200ffff; // @[CrossBar.scala 97:37]
  wire  _outSelVec_1_T_4 = io_in_req_bits_addr >= 64'h10000000 & io_in_req_bits_addr < 64'h10000fff; // @[CrossBar.scala 97:37]
  wire  _outSelVec_1_T_9 = io_in_req_bits_addr >= 64'h10001000 & io_in_req_bits_addr < 64'h10001fff; // @[CrossBar.scala 97:37]
  wire  _outSelVec_1_T_14 = io_in_req_bits_addr >= 64'h30000000 & io_in_req_bits_addr < 64'h3fffffff; // @[CrossBar.scala 97:37]
  wire  _outSelVec_1_T_19 = io_in_req_bits_addr >= 64'h80000000 & io_in_req_bits_addr < 64'hffffffff; // @[CrossBar.scala 97:37]
  wire  outSelVec_1 = _outSelVec_1_T_4 | _outSelVec_1_T_9 | _outSelVec_1_T_14 | _outSelVec_1_T_19; // @[CrossBar.scala 98:17]
  wire [1:0] _reqInvalidAddr_T = {outSelVec_1,outSelVec_0}; // @[CrossBar.scala 101:59]
  wire  reqInvalidAddr = io_in_req_valid & ~(|_reqInvalidAddr_T); // @[CrossBar.scala 101:40]
  wire  outSelIdx = outSelVec_0 ? 1'h0 : 1'h1; // @[Mux.scala 47:69]
  wire  _cur_idx_T = io_in_req_ready & io_in_req_valid; // @[Decoupled.scala 40:37]
  wire  _cur_idx_T_1 = state == 2'h0; // @[CrossBar.scala 106:64]
  wire  _cur_idx_T_2 = _cur_idx_T & state == 2'h0; // @[CrossBar.scala 106:55]
  reg  cur_idx; // @[Reg.scala 15:16]
  wire  _io_out_0_req_valid_T_3 = _cur_idx_T_1 | state == 2'h2; // @[CrossBar.scala 111:66]
  wire  _GEN_2 = outSelIdx ? io_out_1_req_ready : io_out_0_req_ready; // @[CrossBar.scala 113:40 CrossBar.scala 113:40]
  wire  _io_in_req_ready_T_4 = state == 2'h3; // @[CrossBar.scala 113:116]
  wire  _GEN_4 = cur_idx ? io_out_1_resp_valid : io_out_0_resp_valid; // @[CrossBar.scala 116:50 CrossBar.scala 116:50]
  wire [3:0] _GEN_8 = cur_idx ? io_out_1_resp_bits_cmd : io_out_0_resp_bits_cmd; // @[CrossBar.scala 117:19 CrossBar.scala 117:19]
  wire  _GEN_33 = ~cur_idx; // @[CrossBar.scala 119:30 CrossBar.scala 119:30 CrossBar.scala 118:31]
  wire  _GEN_11 = ~cur_idx & io_in_resp_ready; // @[CrossBar.scala 119:30 CrossBar.scala 119:30 CrossBar.scala 118:31]
  wire  _GEN_12 = cur_idx & io_in_resp_ready; // @[CrossBar.scala 119:30 CrossBar.scala 119:30 CrossBar.scala 118:31]
  wire  _T = 2'h0 == state; // @[Conditional.scala 37:30]
  wire  _T_6 = ~reqInvalidAddr; // @[CrossBar.scala 123:132]
  wire [1:0] _GEN_13 = _cur_idx_T & reqInvalidAddr ? 2'h3 : state; // @[CrossBar.scala 127:52 CrossBar.scala 128:15 CrossBar.scala 86:22]
  wire  _T_17 = 2'h2 == state; // @[Conditional.scala 37:30]
  wire  _GEN_16 = _GEN_33 | _GEN_11; // @[CrossBar.scala 134:36 CrossBar.scala 134:36]
  wire  _GEN_17 = cur_idx | _GEN_12; // @[CrossBar.scala 134:36 CrossBar.scala 134:36]
  wire  _GEN_19 = _GEN_4 ? _GEN_16 : _GEN_11; // @[CrossBar.scala 132:40]
  wire  _GEN_20 = _GEN_4 ? _GEN_17 : _GEN_12; // @[CrossBar.scala 132:40]
  wire  _T_18 = 2'h1 == state; // @[Conditional.scala 37:30]
  wire  _GEN_22 = cur_idx ? io_out_1_resp_ready : io_out_0_resp_ready; // @[Decoupled.scala 40:37 Decoupled.scala 40:37]
  wire  _T_19 = _GEN_22 & _GEN_4; // @[Decoupled.scala 40:37]
  wire [1:0] _GEN_23 = _T_19 & _GEN_8 == 4'h2 ? 2'h0 : state; // @[CrossBar.scala 138:99 CrossBar.scala 139:15 CrossBar.scala 86:22]
  wire  _T_22 = 2'h3 == state; // @[Conditional.scala 37:30]
  wire  _T_23 = io_in_resp_ready & io_in_resp_valid; // @[Decoupled.scala 40:37]
  wire [1:0] _GEN_24 = _T_23 ? 2'h0 : state; // @[CrossBar.scala 143:30 CrossBar.scala 144:15 CrossBar.scala 86:22]
  wire [1:0] _GEN_25 = _T_22 ? _GEN_24 : state; // @[Conditional.scala 39:67 CrossBar.scala 86:22]
  wire  _GEN_28 = _T_17 ? _GEN_19 : _GEN_11; // @[Conditional.scala 39:67]
  wire  _GEN_29 = _T_17 ? _GEN_20 : _GEN_12; // @[Conditional.scala 39:67]
  assign io_in_req_ready = (_GEN_2 | reqInvalidAddr) & (_io_out_0_req_valid_T_3 | state == 2'h3); // @[CrossBar.scala 113:59]
  assign io_in_resp_valid = _GEN_4 | _io_in_req_ready_T_4; // @[CrossBar.scala 116:50]
  assign io_in_resp_bits_data = cur_idx ? io_out_1_resp_bits_data : io_out_0_resp_bits_data; // @[CrossBar.scala 117:19 CrossBar.scala 117:19]
  assign io_in_resp_bits_cmd = cur_idx ? io_out_1_resp_bits_cmd : io_out_0_resp_bits_cmd; // @[CrossBar.scala 117:19 CrossBar.scala 117:19]
  assign io_in_resp_bits_id = cur_idx ? io_out_1_resp_bits_id : io_out_0_resp_bits_id; // @[CrossBar.scala 117:19 CrossBar.scala 117:19]
  assign io_out_0_req_valid = io_in_req_valid & outSelVec_0 & (_cur_idx_T_1 | state == 2'h2); // @[CrossBar.scala 111:44]
  assign io_out_0_req_bits_addr = io_in_req_bits_addr; // @[CrossBar.scala 110:18]
  assign io_out_0_req_bits_data = io_in_req_bits_data; // @[CrossBar.scala 110:18]
  assign io_out_0_req_bits_cmd = io_in_req_bits_cmd; // @[CrossBar.scala 110:18]
  assign io_out_0_req_bits_len = io_in_req_bits_len; // @[CrossBar.scala 110:18]
  assign io_out_0_req_bits_id = io_in_req_bits_id; // @[CrossBar.scala 110:18]
  assign io_out_0_req_bits_mask = io_in_req_bits_mask; // @[CrossBar.scala 110:18]
  assign io_out_0_resp_ready = _T ? _GEN_11 : _GEN_28; // @[Conditional.scala 40:58]
  assign io_out_1_req_valid = io_in_req_valid & outSelVec_1 & (_cur_idx_T_1 | state == 2'h2); // @[CrossBar.scala 111:44]
  assign io_out_1_req_bits_addr = io_in_req_bits_addr; // @[CrossBar.scala 110:18]
  assign io_out_1_req_bits_data = io_in_req_bits_data; // @[CrossBar.scala 110:18]
  assign io_out_1_req_bits_cmd = io_in_req_bits_cmd; // @[CrossBar.scala 110:18]
  assign io_out_1_req_bits_len = io_in_req_bits_len; // @[CrossBar.scala 110:18]
  assign io_out_1_req_bits_id = io_in_req_bits_id; // @[CrossBar.scala 110:18]
  assign io_out_1_req_bits_mask = io_in_req_bits_mask; // @[CrossBar.scala 110:18]
  assign io_out_1_resp_ready = _T ? _GEN_12 : _GEN_29; // @[Conditional.scala 40:58]
  always @(posedge clock) begin
    if (reset) begin // @[CrossBar.scala 86:22]
      state <= 2'h0; // @[CrossBar.scala 86:22]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (_cur_idx_T & (io_in_req_bits_cmd == 4'h9 | io_in_req_bits_cmd == 4'h8) & ~reqInvalidAddr) begin // @[CrossBar.scala 123:148]
        state <= 2'h2; // @[CrossBar.scala 124:15]
      end else if (_cur_idx_T & (io_in_req_bits_cmd == 4'h1 | io_in_req_bits_cmd == 4'h0) & _T_6) begin // @[CrossBar.scala 125:152]
        state <= 2'h1; // @[CrossBar.scala 126:15]
      end else begin
        state <= _GEN_13;
      end
    end else if (_T_17) begin // @[Conditional.scala 39:67]
      if (_GEN_4) begin // @[CrossBar.scala 132:40]
        state <= 2'h0; // @[CrossBar.scala 133:15]
      end
    end else if (_T_18) begin // @[Conditional.scala 39:67]
      state <= _GEN_23;
    end else begin
      state <= _GEN_25;
    end
    if (_cur_idx_T_2) begin // @[Reg.scala 16:19]
      if (outSelVec_0) begin // @[Mux.scala 47:69]
        cur_idx <= 1'h0;
      end else begin
        cur_idx <= 1'h1;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  cur_idx = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_210013_InnerCrossBarNN(
  input         clock,
  input         reset,
  output        io_in_0_req_ready,
  input         io_in_0_req_valid,
  input  [63:0] io_in_0_req_bits_addr,
  input  [63:0] io_in_0_req_bits_data,
  input  [3:0]  io_in_0_req_bits_cmd,
  input  [1:0]  io_in_0_req_bits_len,
  input  [7:0]  io_in_0_req_bits_mask,
  input         io_in_0_resp_ready,
  output        io_in_0_resp_valid,
  output [63:0] io_in_0_resp_bits_data,
  output [3:0]  io_in_0_resp_bits_cmd,
  output        io_in_1_req_ready,
  input         io_in_1_req_valid,
  input  [63:0] io_in_1_req_bits_addr,
  input  [63:0] io_in_1_req_bits_data,
  input  [3:0]  io_in_1_req_bits_cmd,
  input  [1:0]  io_in_1_req_bits_len,
  input  [7:0]  io_in_1_req_bits_mask,
  input         io_in_1_resp_ready,
  output        io_in_1_resp_valid,
  output [63:0] io_in_1_resp_bits_data,
  output [3:0]  io_in_1_resp_bits_cmd,
  output        io_out_0_req_valid,
  output [63:0] io_out_0_req_bits_addr,
  output [63:0] io_out_0_req_bits_data,
  output [3:0]  io_out_0_req_bits_cmd,
  output [3:0]  io_out_0_req_bits_id,
  output        io_out_0_resp_ready,
  input         io_out_0_resp_valid,
  input  [63:0] io_out_0_resp_bits_data,
  input  [3:0]  io_out_0_resp_bits_cmd,
  input  [3:0]  io_out_0_resp_bits_id,
  input         io_out_1_req_ready,
  output        io_out_1_req_valid,
  output [63:0] io_out_1_req_bits_addr,
  output [63:0] io_out_1_req_bits_data,
  output [3:0]  io_out_1_req_bits_cmd,
  output [1:0]  io_out_1_req_bits_len,
  output [3:0]  io_out_1_req_bits_id,
  output [7:0]  io_out_1_req_bits_mask,
  output        io_out_1_resp_ready,
  input         io_out_1_resp_valid,
  input  [63:0] io_out_1_resp_bits_data,
  input  [3:0]  io_out_1_resp_bits_cmd,
  input  [3:0]  io_out_1_resp_bits_id
);
  wire  n2one_clock; // @[CrossBar.scala 156:21]
  wire  n2one_reset; // @[CrossBar.scala 156:21]
  wire  n2one_io_in_0_req_ready; // @[CrossBar.scala 156:21]
  wire  n2one_io_in_0_req_valid; // @[CrossBar.scala 156:21]
  wire [63:0] n2one_io_in_0_req_bits_addr; // @[CrossBar.scala 156:21]
  wire [63:0] n2one_io_in_0_req_bits_data; // @[CrossBar.scala 156:21]
  wire [3:0] n2one_io_in_0_req_bits_cmd; // @[CrossBar.scala 156:21]
  wire [1:0] n2one_io_in_0_req_bits_len; // @[CrossBar.scala 156:21]
  wire [7:0] n2one_io_in_0_req_bits_mask; // @[CrossBar.scala 156:21]
  wire  n2one_io_in_0_resp_ready; // @[CrossBar.scala 156:21]
  wire  n2one_io_in_0_resp_valid; // @[CrossBar.scala 156:21]
  wire [63:0] n2one_io_in_0_resp_bits_data; // @[CrossBar.scala 156:21]
  wire [3:0] n2one_io_in_0_resp_bits_cmd; // @[CrossBar.scala 156:21]
  wire  n2one_io_in_1_req_ready; // @[CrossBar.scala 156:21]
  wire  n2one_io_in_1_req_valid; // @[CrossBar.scala 156:21]
  wire [63:0] n2one_io_in_1_req_bits_addr; // @[CrossBar.scala 156:21]
  wire [63:0] n2one_io_in_1_req_bits_data; // @[CrossBar.scala 156:21]
  wire [3:0] n2one_io_in_1_req_bits_cmd; // @[CrossBar.scala 156:21]
  wire [1:0] n2one_io_in_1_req_bits_len; // @[CrossBar.scala 156:21]
  wire [7:0] n2one_io_in_1_req_bits_mask; // @[CrossBar.scala 156:21]
  wire  n2one_io_in_1_resp_ready; // @[CrossBar.scala 156:21]
  wire  n2one_io_in_1_resp_valid; // @[CrossBar.scala 156:21]
  wire [63:0] n2one_io_in_1_resp_bits_data; // @[CrossBar.scala 156:21]
  wire [3:0] n2one_io_in_1_resp_bits_cmd; // @[CrossBar.scala 156:21]
  wire  n2one_io_out_req_ready; // @[CrossBar.scala 156:21]
  wire  n2one_io_out_req_valid; // @[CrossBar.scala 156:21]
  wire [63:0] n2one_io_out_req_bits_addr; // @[CrossBar.scala 156:21]
  wire [63:0] n2one_io_out_req_bits_data; // @[CrossBar.scala 156:21]
  wire [3:0] n2one_io_out_req_bits_cmd; // @[CrossBar.scala 156:21]
  wire [1:0] n2one_io_out_req_bits_len; // @[CrossBar.scala 156:21]
  wire [3:0] n2one_io_out_req_bits_id; // @[CrossBar.scala 156:21]
  wire [7:0] n2one_io_out_req_bits_mask; // @[CrossBar.scala 156:21]
  wire  n2one_io_out_resp_ready; // @[CrossBar.scala 156:21]
  wire  n2one_io_out_resp_valid; // @[CrossBar.scala 156:21]
  wire [63:0] n2one_io_out_resp_bits_data; // @[CrossBar.scala 156:21]
  wire [3:0] n2one_io_out_resp_bits_cmd; // @[CrossBar.scala 156:21]
  wire [3:0] n2one_io_out_resp_bits_id; // @[CrossBar.scala 156:21]
  wire  one2n_clock; // @[CrossBar.scala 157:21]
  wire  one2n_reset; // @[CrossBar.scala 157:21]
  wire  one2n_io_in_req_ready; // @[CrossBar.scala 157:21]
  wire  one2n_io_in_req_valid; // @[CrossBar.scala 157:21]
  wire [63:0] one2n_io_in_req_bits_addr; // @[CrossBar.scala 157:21]
  wire [63:0] one2n_io_in_req_bits_data; // @[CrossBar.scala 157:21]
  wire [3:0] one2n_io_in_req_bits_cmd; // @[CrossBar.scala 157:21]
  wire [1:0] one2n_io_in_req_bits_len; // @[CrossBar.scala 157:21]
  wire [3:0] one2n_io_in_req_bits_id; // @[CrossBar.scala 157:21]
  wire [7:0] one2n_io_in_req_bits_mask; // @[CrossBar.scala 157:21]
  wire  one2n_io_in_resp_ready; // @[CrossBar.scala 157:21]
  wire  one2n_io_in_resp_valid; // @[CrossBar.scala 157:21]
  wire [63:0] one2n_io_in_resp_bits_data; // @[CrossBar.scala 157:21]
  wire [3:0] one2n_io_in_resp_bits_cmd; // @[CrossBar.scala 157:21]
  wire [3:0] one2n_io_in_resp_bits_id; // @[CrossBar.scala 157:21]
  wire  one2n_io_out_0_req_ready; // @[CrossBar.scala 157:21]
  wire  one2n_io_out_0_req_valid; // @[CrossBar.scala 157:21]
  wire [63:0] one2n_io_out_0_req_bits_addr; // @[CrossBar.scala 157:21]
  wire [63:0] one2n_io_out_0_req_bits_data; // @[CrossBar.scala 157:21]
  wire [3:0] one2n_io_out_0_req_bits_cmd; // @[CrossBar.scala 157:21]
  wire [1:0] one2n_io_out_0_req_bits_len; // @[CrossBar.scala 157:21]
  wire [3:0] one2n_io_out_0_req_bits_id; // @[CrossBar.scala 157:21]
  wire [7:0] one2n_io_out_0_req_bits_mask; // @[CrossBar.scala 157:21]
  wire  one2n_io_out_0_resp_ready; // @[CrossBar.scala 157:21]
  wire  one2n_io_out_0_resp_valid; // @[CrossBar.scala 157:21]
  wire [63:0] one2n_io_out_0_resp_bits_data; // @[CrossBar.scala 157:21]
  wire [3:0] one2n_io_out_0_resp_bits_cmd; // @[CrossBar.scala 157:21]
  wire [3:0] one2n_io_out_0_resp_bits_id; // @[CrossBar.scala 157:21]
  wire  one2n_io_out_1_req_ready; // @[CrossBar.scala 157:21]
  wire  one2n_io_out_1_req_valid; // @[CrossBar.scala 157:21]
  wire [63:0] one2n_io_out_1_req_bits_addr; // @[CrossBar.scala 157:21]
  wire [63:0] one2n_io_out_1_req_bits_data; // @[CrossBar.scala 157:21]
  wire [3:0] one2n_io_out_1_req_bits_cmd; // @[CrossBar.scala 157:21]
  wire [1:0] one2n_io_out_1_req_bits_len; // @[CrossBar.scala 157:21]
  wire [3:0] one2n_io_out_1_req_bits_id; // @[CrossBar.scala 157:21]
  wire [7:0] one2n_io_out_1_req_bits_mask; // @[CrossBar.scala 157:21]
  wire  one2n_io_out_1_resp_ready; // @[CrossBar.scala 157:21]
  wire  one2n_io_out_1_resp_valid; // @[CrossBar.scala 157:21]
  wire [63:0] one2n_io_out_1_resp_bits_data; // @[CrossBar.scala 157:21]
  wire [3:0] one2n_io_out_1_resp_bits_cmd; // @[CrossBar.scala 157:21]
  wire [3:0] one2n_io_out_1_resp_bits_id; // @[CrossBar.scala 157:21]
  ysyx_210013_InnerCrossBarN21 n2one ( // @[CrossBar.scala 156:21]
    .clock(n2one_clock),
    .reset(n2one_reset),
    .io_in_0_req_ready(n2one_io_in_0_req_ready),
    .io_in_0_req_valid(n2one_io_in_0_req_valid),
    .io_in_0_req_bits_addr(n2one_io_in_0_req_bits_addr),
    .io_in_0_req_bits_data(n2one_io_in_0_req_bits_data),
    .io_in_0_req_bits_cmd(n2one_io_in_0_req_bits_cmd),
    .io_in_0_req_bits_len(n2one_io_in_0_req_bits_len),
    .io_in_0_req_bits_mask(n2one_io_in_0_req_bits_mask),
    .io_in_0_resp_ready(n2one_io_in_0_resp_ready),
    .io_in_0_resp_valid(n2one_io_in_0_resp_valid),
    .io_in_0_resp_bits_data(n2one_io_in_0_resp_bits_data),
    .io_in_0_resp_bits_cmd(n2one_io_in_0_resp_bits_cmd),
    .io_in_1_req_ready(n2one_io_in_1_req_ready),
    .io_in_1_req_valid(n2one_io_in_1_req_valid),
    .io_in_1_req_bits_addr(n2one_io_in_1_req_bits_addr),
    .io_in_1_req_bits_data(n2one_io_in_1_req_bits_data),
    .io_in_1_req_bits_cmd(n2one_io_in_1_req_bits_cmd),
    .io_in_1_req_bits_len(n2one_io_in_1_req_bits_len),
    .io_in_1_req_bits_mask(n2one_io_in_1_req_bits_mask),
    .io_in_1_resp_ready(n2one_io_in_1_resp_ready),
    .io_in_1_resp_valid(n2one_io_in_1_resp_valid),
    .io_in_1_resp_bits_data(n2one_io_in_1_resp_bits_data),
    .io_in_1_resp_bits_cmd(n2one_io_in_1_resp_bits_cmd),
    .io_out_req_ready(n2one_io_out_req_ready),
    .io_out_req_valid(n2one_io_out_req_valid),
    .io_out_req_bits_addr(n2one_io_out_req_bits_addr),
    .io_out_req_bits_data(n2one_io_out_req_bits_data),
    .io_out_req_bits_cmd(n2one_io_out_req_bits_cmd),
    .io_out_req_bits_len(n2one_io_out_req_bits_len),
    .io_out_req_bits_id(n2one_io_out_req_bits_id),
    .io_out_req_bits_mask(n2one_io_out_req_bits_mask),
    .io_out_resp_ready(n2one_io_out_resp_ready),
    .io_out_resp_valid(n2one_io_out_resp_valid),
    .io_out_resp_bits_data(n2one_io_out_resp_bits_data),
    .io_out_resp_bits_cmd(n2one_io_out_resp_bits_cmd),
    .io_out_resp_bits_id(n2one_io_out_resp_bits_id)
  );
  ysyx_210013_InnerCrossBar12N one2n ( // @[CrossBar.scala 157:21]
    .clock(one2n_clock),
    .reset(one2n_reset),
    .io_in_req_ready(one2n_io_in_req_ready),
    .io_in_req_valid(one2n_io_in_req_valid),
    .io_in_req_bits_addr(one2n_io_in_req_bits_addr),
    .io_in_req_bits_data(one2n_io_in_req_bits_data),
    .io_in_req_bits_cmd(one2n_io_in_req_bits_cmd),
    .io_in_req_bits_len(one2n_io_in_req_bits_len),
    .io_in_req_bits_id(one2n_io_in_req_bits_id),
    .io_in_req_bits_mask(one2n_io_in_req_bits_mask),
    .io_in_resp_ready(one2n_io_in_resp_ready),
    .io_in_resp_valid(one2n_io_in_resp_valid),
    .io_in_resp_bits_data(one2n_io_in_resp_bits_data),
    .io_in_resp_bits_cmd(one2n_io_in_resp_bits_cmd),
    .io_in_resp_bits_id(one2n_io_in_resp_bits_id),
    .io_out_0_req_ready(one2n_io_out_0_req_ready),
    .io_out_0_req_valid(one2n_io_out_0_req_valid),
    .io_out_0_req_bits_addr(one2n_io_out_0_req_bits_addr),
    .io_out_0_req_bits_data(one2n_io_out_0_req_bits_data),
    .io_out_0_req_bits_cmd(one2n_io_out_0_req_bits_cmd),
    .io_out_0_req_bits_len(one2n_io_out_0_req_bits_len),
    .io_out_0_req_bits_id(one2n_io_out_0_req_bits_id),
    .io_out_0_req_bits_mask(one2n_io_out_0_req_bits_mask),
    .io_out_0_resp_ready(one2n_io_out_0_resp_ready),
    .io_out_0_resp_valid(one2n_io_out_0_resp_valid),
    .io_out_0_resp_bits_data(one2n_io_out_0_resp_bits_data),
    .io_out_0_resp_bits_cmd(one2n_io_out_0_resp_bits_cmd),
    .io_out_0_resp_bits_id(one2n_io_out_0_resp_bits_id),
    .io_out_1_req_ready(one2n_io_out_1_req_ready),
    .io_out_1_req_valid(one2n_io_out_1_req_valid),
    .io_out_1_req_bits_addr(one2n_io_out_1_req_bits_addr),
    .io_out_1_req_bits_data(one2n_io_out_1_req_bits_data),
    .io_out_1_req_bits_cmd(one2n_io_out_1_req_bits_cmd),
    .io_out_1_req_bits_len(one2n_io_out_1_req_bits_len),
    .io_out_1_req_bits_id(one2n_io_out_1_req_bits_id),
    .io_out_1_req_bits_mask(one2n_io_out_1_req_bits_mask),
    .io_out_1_resp_ready(one2n_io_out_1_resp_ready),
    .io_out_1_resp_valid(one2n_io_out_1_resp_valid),
    .io_out_1_resp_bits_data(one2n_io_out_1_resp_bits_data),
    .io_out_1_resp_bits_cmd(one2n_io_out_1_resp_bits_cmd),
    .io_out_1_resp_bits_id(one2n_io_out_1_resp_bits_id)
  );
  assign io_in_0_req_ready = n2one_io_in_0_req_ready; // @[CrossBar.scala 159:41]
  assign io_in_0_resp_valid = n2one_io_in_0_resp_valid; // @[CrossBar.scala 159:41]
  assign io_in_0_resp_bits_data = n2one_io_in_0_resp_bits_data; // @[CrossBar.scala 159:41]
  assign io_in_0_resp_bits_cmd = n2one_io_in_0_resp_bits_cmd; // @[CrossBar.scala 159:41]
  assign io_in_1_req_ready = n2one_io_in_1_req_ready; // @[CrossBar.scala 159:41]
  assign io_in_1_resp_valid = n2one_io_in_1_resp_valid; // @[CrossBar.scala 159:41]
  assign io_in_1_resp_bits_data = n2one_io_in_1_resp_bits_data; // @[CrossBar.scala 159:41]
  assign io_in_1_resp_bits_cmd = n2one_io_in_1_resp_bits_cmd; // @[CrossBar.scala 159:41]
  assign io_out_0_req_valid = one2n_io_out_0_req_valid; // @[CrossBar.scala 161:43]
  assign io_out_0_req_bits_addr = one2n_io_out_0_req_bits_addr; // @[CrossBar.scala 161:43]
  assign io_out_0_req_bits_data = one2n_io_out_0_req_bits_data; // @[CrossBar.scala 161:43]
  assign io_out_0_req_bits_cmd = one2n_io_out_0_req_bits_cmd; // @[CrossBar.scala 161:43]
  assign io_out_0_req_bits_id = one2n_io_out_0_req_bits_id; // @[CrossBar.scala 161:43]
  assign io_out_0_resp_ready = one2n_io_out_0_resp_ready; // @[CrossBar.scala 161:43]
  assign io_out_1_req_valid = one2n_io_out_1_req_valid; // @[CrossBar.scala 161:43]
  assign io_out_1_req_bits_addr = one2n_io_out_1_req_bits_addr; // @[CrossBar.scala 161:43]
  assign io_out_1_req_bits_data = one2n_io_out_1_req_bits_data; // @[CrossBar.scala 161:43]
  assign io_out_1_req_bits_cmd = one2n_io_out_1_req_bits_cmd; // @[CrossBar.scala 161:43]
  assign io_out_1_req_bits_len = one2n_io_out_1_req_bits_len; // @[CrossBar.scala 161:43]
  assign io_out_1_req_bits_id = one2n_io_out_1_req_bits_id; // @[CrossBar.scala 161:43]
  assign io_out_1_req_bits_mask = one2n_io_out_1_req_bits_mask; // @[CrossBar.scala 161:43]
  assign io_out_1_resp_ready = one2n_io_out_1_resp_ready; // @[CrossBar.scala 161:43]
  assign n2one_clock = clock;
  assign n2one_reset = reset;
  assign n2one_io_in_0_req_valid = io_in_0_req_valid; // @[CrossBar.scala 159:41]
  assign n2one_io_in_0_req_bits_addr = io_in_0_req_bits_addr; // @[CrossBar.scala 159:41]
  assign n2one_io_in_0_req_bits_data = io_in_0_req_bits_data; // @[CrossBar.scala 159:41]
  assign n2one_io_in_0_req_bits_cmd = io_in_0_req_bits_cmd; // @[CrossBar.scala 159:41]
  assign n2one_io_in_0_req_bits_len = io_in_0_req_bits_len; // @[CrossBar.scala 159:41]
  assign n2one_io_in_0_req_bits_mask = io_in_0_req_bits_mask; // @[CrossBar.scala 159:41]
  assign n2one_io_in_0_resp_ready = io_in_0_resp_ready; // @[CrossBar.scala 159:41]
  assign n2one_io_in_1_req_valid = io_in_1_req_valid; // @[CrossBar.scala 159:41]
  assign n2one_io_in_1_req_bits_addr = io_in_1_req_bits_addr; // @[CrossBar.scala 159:41]
  assign n2one_io_in_1_req_bits_data = io_in_1_req_bits_data; // @[CrossBar.scala 159:41]
  assign n2one_io_in_1_req_bits_cmd = io_in_1_req_bits_cmd; // @[CrossBar.scala 159:41]
  assign n2one_io_in_1_req_bits_len = io_in_1_req_bits_len; // @[CrossBar.scala 159:41]
  assign n2one_io_in_1_req_bits_mask = io_in_1_req_bits_mask; // @[CrossBar.scala 159:41]
  assign n2one_io_in_1_resp_ready = io_in_1_resp_ready; // @[CrossBar.scala 159:41]
  assign n2one_io_out_req_ready = one2n_io_in_req_ready; // @[CrossBar.scala 160:16]
  assign n2one_io_out_resp_valid = one2n_io_in_resp_valid; // @[CrossBar.scala 160:16]
  assign n2one_io_out_resp_bits_data = one2n_io_in_resp_bits_data; // @[CrossBar.scala 160:16]
  assign n2one_io_out_resp_bits_cmd = one2n_io_in_resp_bits_cmd; // @[CrossBar.scala 160:16]
  assign n2one_io_out_resp_bits_id = one2n_io_in_resp_bits_id; // @[CrossBar.scala 160:16]
  assign one2n_clock = clock;
  assign one2n_reset = reset;
  assign one2n_io_in_req_valid = n2one_io_out_req_valid; // @[CrossBar.scala 160:16]
  assign one2n_io_in_req_bits_addr = n2one_io_out_req_bits_addr; // @[CrossBar.scala 160:16]
  assign one2n_io_in_req_bits_data = n2one_io_out_req_bits_data; // @[CrossBar.scala 160:16]
  assign one2n_io_in_req_bits_cmd = n2one_io_out_req_bits_cmd; // @[CrossBar.scala 160:16]
  assign one2n_io_in_req_bits_len = n2one_io_out_req_bits_len; // @[CrossBar.scala 160:16]
  assign one2n_io_in_req_bits_id = n2one_io_out_req_bits_id; // @[CrossBar.scala 160:16]
  assign one2n_io_in_req_bits_mask = n2one_io_out_req_bits_mask; // @[CrossBar.scala 160:16]
  assign one2n_io_in_resp_ready = n2one_io_out_resp_ready; // @[CrossBar.scala 160:16]
  assign one2n_io_out_0_req_ready = 1'h1; // @[CrossBar.scala 161:43]
  assign one2n_io_out_0_resp_valid = io_out_0_resp_valid; // @[CrossBar.scala 161:43]
  assign one2n_io_out_0_resp_bits_data = io_out_0_resp_bits_data; // @[CrossBar.scala 161:43]
  assign one2n_io_out_0_resp_bits_cmd = io_out_0_resp_bits_cmd; // @[CrossBar.scala 161:43]
  assign one2n_io_out_0_resp_bits_id = io_out_0_resp_bits_id; // @[CrossBar.scala 161:43]
  assign one2n_io_out_1_req_ready = io_out_1_req_ready; // @[CrossBar.scala 161:43]
  assign one2n_io_out_1_resp_valid = io_out_1_resp_valid; // @[CrossBar.scala 161:43]
  assign one2n_io_out_1_resp_bits_data = io_out_1_resp_bits_data; // @[CrossBar.scala 161:43]
  assign one2n_io_out_1_resp_bits_cmd = io_out_1_resp_bits_cmd; // @[CrossBar.scala 161:43]
  assign one2n_io_out_1_resp_bits_id = io_out_1_resp_bits_id; // @[CrossBar.scala 161:43]
endmodule
module ysyx_210013_MemBus2AXI(
  input         clock,
  input         reset,
  output        io_in_req_ready,
  input         io_in_req_valid,
  input  [63:0] io_in_req_bits_addr,
  input  [63:0] io_in_req_bits_data,
  input  [3:0]  io_in_req_bits_cmd,
  input  [1:0]  io_in_req_bits_len,
  input  [3:0]  io_in_req_bits_id,
  input  [7:0]  io_in_req_bits_mask,
  input         io_in_resp_ready,
  output        io_in_resp_valid,
  output [63:0] io_in_resp_bits_data,
  output [3:0]  io_in_resp_bits_cmd,
  output [3:0]  io_in_resp_bits_id,
  input         io_axi4_aw_ready,
  output        io_axi4_aw_valid,
  output [63:0] io_axi4_aw_bits_addr,
  output [3:0]  io_axi4_aw_bits_id,
  output [7:0]  io_axi4_aw_bits_len,
  output [2:0]  io_axi4_aw_bits_size,
  input         io_axi4_w_ready,
  output        io_axi4_w_valid,
  output [63:0] io_axi4_w_bits_data,
  output        io_axi4_w_bits_last,
  output        io_axi4_b_ready,
  input         io_axi4_b_valid,
  input  [3:0]  io_axi4_b_bits_id,
  input         io_axi4_ar_ready,
  output        io_axi4_ar_valid,
  output [63:0] io_axi4_ar_bits_addr,
  output [3:0]  io_axi4_ar_bits_id,
  output [7:0]  io_axi4_ar_bits_len,
  output [2:0]  io_axi4_ar_bits_size,
  output        io_axi4_r_ready,
  input         io_axi4_r_valid,
  input  [63:0] io_axi4_r_bits_data,
  input         io_axi4_r_bits_last,
  input  [3:0]  io_axi4_r_bits_id
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  _is32req_T_4 = io_in_req_bits_addr >= 64'h10000000 & io_in_req_bits_addr < 64'h10000fff; // @[MemBus2AXI.scala 19:35]
  wire  _is32req_T_9 = io_in_req_bits_addr >= 64'h10001000 & io_in_req_bits_addr < 64'h10001fff; // @[MemBus2AXI.scala 19:35]
  wire  _is32req_T_14 = io_in_req_bits_addr >= 64'h30000000 & io_in_req_bits_addr < 64'h3fffffff; // @[MemBus2AXI.scala 19:35]
  wire  is32req = _is32req_T_4 | _is32req_T_9 | _is32req_T_14; // @[MemBus2AXI.scala 20:15]
  wire  is32high = io_in_req_bits_mask[3:0] == 4'h0; // @[MemBus2AXI.scala 21:48]
  reg [1:0] state; // @[MemBus2AXI.scala 24:22]
  reg  isBurst; // @[MemBus2AXI.scala 25:24]
  wire  _T = 2'h0 == state; // @[Conditional.scala 37:30]
  wire  _T_1 = io_in_req_ready & io_in_req_valid; // @[Decoupled.scala 40:37]
  wire  _T_4 = io_in_req_bits_cmd == 4'h9 | io_in_req_bits_cmd == 4'h8; // @[MemBus2AXI.scala 33:80]
  wire  _T_9 = io_in_req_bits_cmd == 4'h1 | io_in_req_bits_cmd == 4'h0; // @[MemBus2AXI.scala 36:85]
  wire  _T_11 = 2'h2 == state; // @[Conditional.scala 37:30]
  wire  _T_13 = io_in_req_bits_cmd == 4'ha; // @[MemBus2AXI.scala 45:51]
  wire  _T_15 = 2'h1 == state; // @[Conditional.scala 37:30]
  wire  _T_16 = io_in_resp_ready & io_in_resp_valid; // @[Decoupled.scala 40:37]
  wire [1:0] _GEN_11 = _T_16 & io_in_resp_bits_cmd == 4'h2 ? 2'h0 : state; // @[MemBus2AXI.scala 50:79 MemBus2AXI.scala 51:15 MemBus2AXI.scala 24:22]
  wire  _T_19 = 2'h3 == state; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_12 = io_in_resp_valid ? 2'h0 : state; // @[MemBus2AXI.scala 55:29 MemBus2AXI.scala 56:15 MemBus2AXI.scala 24:22]
  wire [1:0] _GEN_13 = _T_19 ? _GEN_12 : state; // @[Conditional.scala 39:67 MemBus2AXI.scala 24:22]
  wire [126:0] _io_in_resp_bits_data_T_2 = {{63'd0}, io_axi4_r_bits_data}; // @[MemBus2AXI.scala 65:32]
  wire [1:0] _io_in_resp_bits_cmd_T = io_axi4_r_bits_last ? 2'h2 : 2'h0; // @[MemBus2AXI.scala 67:44]
  wire [1:0] _io_in_resp_bits_cmd_T_1 = isBurst ? _io_in_resp_bits_cmd_T : 2'h2; // @[MemBus2AXI.scala 67:31]
  wire  _T_21 = state == 2'h3; // @[MemBus2AXI.scala 68:20]
  wire [3:0] _GEN_21 = state == 2'h3 ? io_axi4_b_bits_id : 4'h0; // @[MemBus2AXI.scala 68:31 MemBus2AXI.scala 69:24 MemBus2AXI.scala 74:24]
  wire  _GEN_23 = state == 2'h3 & io_axi4_b_valid; // @[MemBus2AXI.scala 68:31 MemBus2AXI.scala 71:22 MemBus2AXI.scala 76:22]
  wire [126:0] _GEN_26 = state == 2'h1 ? _io_in_resp_bits_data_T_2 : 127'h0; // @[MemBus2AXI.scala 63:25 MemBus2AXI.scala 65:26]
  wire [1:0] _GEN_28 = state == 2'h1 ? _io_in_resp_bits_cmd_T_1 : {{1'd0}, _T_21}; // @[MemBus2AXI.scala 63:25 MemBus2AXI.scala 67:25]
  wire  _io_axi4_ar_bits_addr_T = is32req & is32high; // @[MemBus2AXI.scala 89:31]
  wire [63:0] _io_axi4_ar_bits_addr_T_1 = io_in_req_bits_addr | 64'h4; // @[MemBus2AXI.scala 89:63]
  wire [3:0] _io_axi4_ar_bits_len_T = 4'h1 << io_in_req_bits_len; // @[MemBus2AXI.scala 90:23]
  wire [3:0] _io_axi4_ar_bits_len_T_2 = _io_axi4_ar_bits_len_T - 4'h1; // @[MemBus2AXI.scala 90:55]
  wire [1:0] _io_axi4_ar_bits_size_T = is32req ? 2'h2 : 2'h3; // @[MemBus2AXI.scala 91:22]
  assign io_in_req_ready = io_axi4_ar_ready | io_axi4_aw_ready | io_axi4_w_ready; // @[MemBus2AXI.scala 81:42]
  assign io_in_resp_valid = state == 2'h1 ? io_axi4_r_valid : _GEN_23; // @[MemBus2AXI.scala 63:25 MemBus2AXI.scala 66:22]
  assign io_in_resp_bits_data = _GEN_26[63:0];
  assign io_in_resp_bits_cmd = {{2'd0}, _GEN_28}; // @[MemBus2AXI.scala 63:25 MemBus2AXI.scala 67:25]
  assign io_in_resp_bits_id = state == 2'h1 ? io_axi4_r_bits_id : _GEN_21; // @[MemBus2AXI.scala 63:25 MemBus2AXI.scala 64:24]
  assign io_axi4_aw_valid = _T_4 & io_in_req_valid; // @[MemBus2AXI.scala 105:114]
  assign io_axi4_aw_bits_addr = _io_axi4_ar_bits_addr_T ? _io_axi4_ar_bits_addr_T_1 : io_in_req_bits_addr; // @[MemBus2AXI.scala 101:22]
  assign io_axi4_aw_bits_id = io_in_req_bits_id; // @[MemBus2AXI.scala 100:14]
  assign io_axi4_aw_bits_len = {{4'd0}, _io_axi4_ar_bits_len_T_2}; // @[MemBus2AXI.scala 102:55]
  assign io_axi4_aw_bits_size = {{1'd0}, _io_axi4_ar_bits_size_T}; // @[MemBus2AXI.scala 103:22]
  assign io_axi4_w_valid = (io_in_req_bits_cmd == 4'hc | _T_13) & io_in_req_valid; // @[MemBus2AXI.scala 110:112]
  assign io_axi4_w_bits_data = io_in_req_bits_data; // @[MemBus2AXI.scala 107:21]
  assign io_axi4_w_bits_last = io_in_req_bits_cmd == 4'ha; // @[MemBus2AXI.scala 109:37]
  assign io_axi4_b_ready = io_in_resp_ready; // @[MemBus2AXI.scala 114:11]
  assign io_axi4_ar_valid = _T_9 & io_in_req_valid; // @[MemBus2AXI.scala 93:112]
  assign io_axi4_ar_bits_addr = is32req & is32high ? _io_axi4_ar_bits_addr_T_1 : io_in_req_bits_addr; // @[MemBus2AXI.scala 89:22]
  assign io_axi4_ar_bits_id = io_in_req_bits_id; // @[MemBus2AXI.scala 88:14]
  assign io_axi4_ar_bits_len = {{4'd0}, _io_axi4_ar_bits_len_T_2}; // @[MemBus2AXI.scala 90:55]
  assign io_axi4_ar_bits_size = {{1'd0}, _io_axi4_ar_bits_size_T}; // @[MemBus2AXI.scala 91:22]
  assign io_axi4_r_ready = io_in_resp_ready; // @[MemBus2AXI.scala 112:11]
  always @(posedge clock) begin
    if (reset) begin // @[MemBus2AXI.scala 24:22]
      state <= 2'h0; // @[MemBus2AXI.scala 24:22]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (_T_1 & (io_in_req_bits_cmd == 4'h9 | io_in_req_bits_cmd == 4'h8)) begin // @[MemBus2AXI.scala 33:130]
        state <= 2'h2; // @[MemBus2AXI.scala 34:15]
      end else if (_T_1 & (io_in_req_bits_cmd == 4'h1 | io_in_req_bits_cmd == 4'h0)) begin // @[MemBus2AXI.scala 36:134]
        state <= 2'h1; // @[MemBus2AXI.scala 37:15]
      end
    end else if (_T_11) begin // @[Conditional.scala 39:67]
      if (_T_1 & io_in_req_bits_cmd == 4'ha) begin // @[MemBus2AXI.scala 45:78]
        state <= 2'h3; // @[MemBus2AXI.scala 46:15]
      end
    end else if (_T_15) begin // @[Conditional.scala 39:67]
      state <= _GEN_11;
    end else begin
      state <= _GEN_13;
    end
    if (reset) begin // @[MemBus2AXI.scala 25:24]
      isBurst <= 1'h0; // @[MemBus2AXI.scala 25:24]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (_T_1 & (io_in_req_bits_cmd == 4'h9 | io_in_req_bits_cmd == 4'h8)) begin // @[MemBus2AXI.scala 33:130]
        isBurst <= io_in_req_bits_cmd == 4'h9; // @[MemBus2AXI.scala 35:17]
      end else if (_T_1 & (io_in_req_bits_cmd == 4'h1 | io_in_req_bits_cmd == 4'h0)) begin // @[MemBus2AXI.scala 36:134]
        isBurst <= io_in_req_bits_cmd == 4'h1; // @[MemBus2AXI.scala 38:17]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  isBurst = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_210013_CLINT(
  input         clock,
  input         reset,
  output        io_cpu_req_ready,
  input         io_cpu_req_valid,
  input  [63:0] io_cpu_req_bits_addr,
  input  [63:0] io_cpu_req_bits_data,
  input  [3:0]  io_cpu_req_bits_cmd,
  input  [3:0]  io_cpu_req_bits_id,
  input         io_cpu_resp_ready,
  output        io_cpu_resp_valid,
  output [63:0] io_cpu_resp_bits_data,
  output [3:0]  io_cpu_resp_bits_cmd,
  output [3:0]  io_cpu_resp_bits_id,
  output        io_interrupt
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] mtime; // @[CLINT.scala 20:22]
  reg [63:0] mtimecmp; // @[CLINT.scala 21:25]
  reg [1:0] state; // @[CLINT.scala 24:22]
  reg  op; // @[CLINT.scala 26:19]
  reg [3:0] id; // @[CLINT.scala 27:19]
  reg [63:0] addr; // @[CLINT.scala 28:21]
  wire [63:0] _sel_data_T_1 = 64'h200bff8 == addr ? mtime : 64'h7fffffff; // @[Mux.scala 80:57]
  wire [63:0] sel_data = 64'h2004000 == addr ? mtimecmp : _sel_data_T_1; // @[Mux.scala 80:57]
  wire  _io_cpu_resp_valid_T = state == 2'h2; // @[CLINT.scala 38:30]
  wire [1:0] _io_cpu_resp_bits_cmd_T_1 = op ? 2'h1 : 2'h2; // @[CLINT.scala 41:31]
  reg  io_interrupt_REG; // @[CLINT.scala 43:26]
  wire [63:0] _mtime_T_1 = mtime + 64'h1; // @[CLINT.scala 45:18]
  wire  _T_1 = io_cpu_req_ready & io_cpu_req_valid; // @[Decoupled.scala 40:37]
  wire  _op_T = io_cpu_req_bits_cmd == 4'h8; // @[CLINT.scala 48:33]
  wire [63:0] _GEN_0 = io_cpu_req_bits_addr == 64'h2004000 ? io_cpu_req_bits_data : mtimecmp; // @[CLINT.scala 54:55 CLINT.scala 55:16 CLINT.scala 21:25]
  wire [63:0] _GEN_3 = op ? 64'h0 : sel_data; // @[CLINT.scala 58:21 CLINT.scala 59:29 CLINT.scala 61:29]
  wire [63:0] _GEN_4 = _io_cpu_resp_valid_T ? _GEN_3 : 64'h0; // @[CLINT.scala 57:33 CLINT.scala 40:25]
  wire [63:0] _GEN_7 = state == 2'h1 & _T_1 ? 64'h0 : _GEN_4; // @[CLINT.scala 51:50 CLINT.scala 40:25]
  wire  _T_10 = 2'h0 == state; // @[Conditional.scala 37:30]
  wire  _T_17 = 2'h1 == state; // @[Conditional.scala 37:30]
  wire  _T_19 = 2'h2 == state; // @[Conditional.scala 37:30]
  wire  _T_20 = io_cpu_resp_ready & io_cpu_resp_valid; // @[Decoupled.scala 40:37]
  wire [1:0] _GEN_17 = _T_20 ? 2'h0 : state; // @[CLINT.scala 79:31 CLINT.scala 80:15 CLINT.scala 24:22]
  assign io_cpu_req_ready = 1'h1; // @[CLINT.scala 36:20]
  assign io_cpu_resp_valid = state == 2'h2; // @[CLINT.scala 38:30]
  assign io_cpu_resp_bits_data = state == 2'h0 & _T_1 ? 64'h0 : _GEN_7; // @[CLINT.scala 47:48 CLINT.scala 40:25]
  assign io_cpu_resp_bits_cmd = {{2'd0}, _io_cpu_resp_bits_cmd_T_1}; // @[CLINT.scala 41:31]
  assign io_cpu_resp_bits_id = id; // @[CLINT.scala 39:23]
  assign io_interrupt = io_interrupt_REG; // @[CLINT.scala 43:16]
  always @(posedge clock) begin
    if (reset) begin // @[CLINT.scala 20:22]
      mtime <= 64'h1; // @[CLINT.scala 20:22]
    end else if (state == 2'h0 & _T_1) begin // @[CLINT.scala 47:48]
      mtime <= _mtime_T_1; // @[CLINT.scala 45:9]
    end else if (state == 2'h1 & _T_1) begin // @[CLINT.scala 51:50]
      if (io_cpu_req_bits_addr == 64'h200bff8) begin // @[CLINT.scala 52:46]
        mtime <= io_cpu_req_bits_data; // @[CLINT.scala 53:13]
      end else begin
        mtime <= _mtime_T_1; // @[CLINT.scala 45:9]
      end
    end else begin
      mtime <= _mtime_T_1; // @[CLINT.scala 45:9]
    end
    if (reset) begin // @[CLINT.scala 21:25]
      mtimecmp <= 64'h2; // @[CLINT.scala 21:25]
    end else if (!(state == 2'h0 & _T_1)) begin // @[CLINT.scala 47:48]
      if (state == 2'h1 & _T_1) begin // @[CLINT.scala 51:50]
        if (!(io_cpu_req_bits_addr == 64'h200bff8)) begin // @[CLINT.scala 52:46]
          mtimecmp <= _GEN_0;
        end
      end
    end
    if (reset) begin // @[CLINT.scala 24:22]
      state <= 2'h0; // @[CLINT.scala 24:22]
    end else if (_T_10) begin // @[Conditional.scala 40:58]
      if (_T_1 & _op_T) begin // @[CLINT.scala 67:80]
        state <= 2'h1; // @[CLINT.scala 68:15]
      end else if (_T_1 & io_cpu_req_bits_cmd == 4'h0) begin // @[CLINT.scala 69:85]
        state <= 2'h2; // @[CLINT.scala 70:15]
      end
    end else if (_T_17) begin // @[Conditional.scala 39:67]
      if (_T_1) begin // @[CLINT.scala 74:30]
        state <= 2'h2; // @[CLINT.scala 75:15]
      end
    end else if (_T_19) begin // @[Conditional.scala 39:67]
      state <= _GEN_17;
    end
    if (reset) begin // @[CLINT.scala 26:19]
      op <= 1'h0; // @[CLINT.scala 26:19]
    end else if (state == 2'h0 & _T_1) begin // @[CLINT.scala 47:48]
      op <= io_cpu_req_bits_cmd == 4'h8; // @[CLINT.scala 48:8]
    end
    if (reset) begin // @[CLINT.scala 27:19]
      id <= 4'h0; // @[CLINT.scala 27:19]
    end else if (state == 2'h0 & _T_1) begin // @[CLINT.scala 47:48]
      id <= io_cpu_req_bits_id; // @[CLINT.scala 49:8]
    end
    if (reset) begin // @[CLINT.scala 28:21]
      addr <= 64'h0; // @[CLINT.scala 28:21]
    end else if (state == 2'h0 & _T_1) begin // @[CLINT.scala 47:48]
      addr <= io_cpu_req_bits_addr; // @[CLINT.scala 50:10]
    end
    io_interrupt_REG <= mtime >= mtimecmp; // @[CLINT.scala 43:33]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  mtime = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  mtimecmp = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  state = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  op = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  id = _RAND_4[3:0];
  _RAND_5 = {2{`RANDOM}};
  addr = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  io_interrupt_REG = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ysyx_210013_Core(
  input         clock,
  input         reset,
  input         io_memAXI_0_aw_ready,
  output        io_memAXI_0_aw_valid,
  output [63:0] io_memAXI_0_aw_bits_addr,
  output [2:0]  io_memAXI_0_aw_bits_prot,
  output [3:0]  io_memAXI_0_aw_bits_id,
  output        io_memAXI_0_aw_bits_user,
  output [7:0]  io_memAXI_0_aw_bits_len,
  output [2:0]  io_memAXI_0_aw_bits_size,
  output [1:0]  io_memAXI_0_aw_bits_burst,
  output        io_memAXI_0_aw_bits_lock,
  output [3:0]  io_memAXI_0_aw_bits_cache,
  output [3:0]  io_memAXI_0_aw_bits_qos,
  input         io_memAXI_0_w_ready,
  output        io_memAXI_0_w_valid,
  output [63:0] io_memAXI_0_w_bits_data,
  output [7:0]  io_memAXI_0_w_bits_strb,
  output        io_memAXI_0_w_bits_last,
  output        io_memAXI_0_b_ready,
  input         io_memAXI_0_b_valid,
  input  [1:0]  io_memAXI_0_b_bits_resp,
  input  [3:0]  io_memAXI_0_b_bits_id,
  input         io_memAXI_0_b_bits_user,
  input         io_memAXI_0_ar_ready,
  output        io_memAXI_0_ar_valid,
  output [63:0] io_memAXI_0_ar_bits_addr,
  output [2:0]  io_memAXI_0_ar_bits_prot,
  output [3:0]  io_memAXI_0_ar_bits_id,
  output        io_memAXI_0_ar_bits_user,
  output [7:0]  io_memAXI_0_ar_bits_len,
  output [2:0]  io_memAXI_0_ar_bits_size,
  output [1:0]  io_memAXI_0_ar_bits_burst,
  output        io_memAXI_0_ar_bits_lock,
  output [3:0]  io_memAXI_0_ar_bits_cache,
  output [3:0]  io_memAXI_0_ar_bits_qos,
  output        io_memAXI_0_r_ready,
  input         io_memAXI_0_r_valid,
  input  [1:0]  io_memAXI_0_r_bits_resp,
  input  [63:0] io_memAXI_0_r_bits_data,
  input         io_memAXI_0_r_bits_last,
  input  [3:0]  io_memAXI_0_r_bits_id,
  input         io_memAXI_0_r_bits_user
);
  wire  datapath_clock; // @[Core.scala 12:24]
  wire  datapath_reset; // @[Core.scala 12:24]
  wire  datapath_io_icacahe_req_ready; // @[Core.scala 12:24]
  wire  datapath_io_icacahe_req_valid; // @[Core.scala 12:24]
  wire [63:0] datapath_io_icacahe_req_bits_addr; // @[Core.scala 12:24]
  wire [63:0] datapath_io_icacahe_req_bits_data; // @[Core.scala 12:24]
  wire [7:0] datapath_io_icacahe_req_bits_mask; // @[Core.scala 12:24]
  wire  datapath_io_icacahe_req_bits_op; // @[Core.scala 12:24]
  wire  datapath_io_icacahe_resp_valid; // @[Core.scala 12:24]
  wire [63:0] datapath_io_icacahe_resp_bits_data; // @[Core.scala 12:24]
  wire [3:0] datapath_io_icacahe_resp_bits_cmd; // @[Core.scala 12:24]
  wire  datapath_io_dcache_req_ready; // @[Core.scala 12:24]
  wire  datapath_io_dcache_req_valid; // @[Core.scala 12:24]
  wire [63:0] datapath_io_dcache_req_bits_addr; // @[Core.scala 12:24]
  wire [63:0] datapath_io_dcache_req_bits_data; // @[Core.scala 12:24]
  wire [7:0] datapath_io_dcache_req_bits_mask; // @[Core.scala 12:24]
  wire  datapath_io_dcache_req_bits_op; // @[Core.scala 12:24]
  wire  datapath_io_dcache_resp_valid; // @[Core.scala 12:24]
  wire [63:0] datapath_io_dcache_resp_bits_data; // @[Core.scala 12:24]
  wire [3:0] datapath_io_dcache_resp_bits_cmd; // @[Core.scala 12:24]
  wire [31:0] datapath_io_control_inst; // @[Core.scala 12:24]
  wire [1:0] datapath_io_control_signal_pc_sel; // @[Core.scala 12:24]
  wire  datapath_io_control_signal_a_sel; // @[Core.scala 12:24]
  wire  datapath_io_control_signal_b_sel; // @[Core.scala 12:24]
  wire [2:0] datapath_io_control_signal_imm_sel; // @[Core.scala 12:24]
  wire [4:0] datapath_io_control_signal_alu_op; // @[Core.scala 12:24]
  wire [2:0] datapath_io_control_signal_br_type; // @[Core.scala 12:24]
  wire  datapath_io_control_signal_kill; // @[Core.scala 12:24]
  wire [2:0] datapath_io_control_signal_st_type; // @[Core.scala 12:24]
  wire [2:0] datapath_io_control_signal_ld_type; // @[Core.scala 12:24]
  wire [1:0] datapath_io_control_signal_wb_type; // @[Core.scala 12:24]
  wire  datapath_io_control_signal_wen; // @[Core.scala 12:24]
  wire [2:0] datapath_io_control_signal_csr_cmd; // @[Core.scala 12:24]
  wire  datapath_io_control_signal_illegal; // @[Core.scala 12:24]
  wire  datapath_io_time_interrupt; // @[Core.scala 12:24]
  wire  datapath_io_fence_i_do; // @[Core.scala 12:24]
  wire  datapath_io_fence_i_done; // @[Core.scala 12:24]
  wire  icache_clock; // @[Core.scala 13:22]
  wire  icache_reset; // @[Core.scala 13:22]
  wire  icache_io_cpu_req_ready; // @[Core.scala 13:22]
  wire  icache_io_cpu_req_valid; // @[Core.scala 13:22]
  wire [63:0] icache_io_cpu_req_bits_addr; // @[Core.scala 13:22]
  wire [63:0] icache_io_cpu_req_bits_data; // @[Core.scala 13:22]
  wire [7:0] icache_io_cpu_req_bits_mask; // @[Core.scala 13:22]
  wire  icache_io_cpu_req_bits_op; // @[Core.scala 13:22]
  wire  icache_io_cpu_resp_valid; // @[Core.scala 13:22]
  wire [63:0] icache_io_cpu_resp_bits_data; // @[Core.scala 13:22]
  wire [3:0] icache_io_cpu_resp_bits_cmd; // @[Core.scala 13:22]
  wire  icache_io_mem_req_ready; // @[Core.scala 13:22]
  wire  icache_io_mem_req_valid; // @[Core.scala 13:22]
  wire [63:0] icache_io_mem_req_bits_addr; // @[Core.scala 13:22]
  wire [63:0] icache_io_mem_req_bits_data; // @[Core.scala 13:22]
  wire [3:0] icache_io_mem_req_bits_cmd; // @[Core.scala 13:22]
  wire [1:0] icache_io_mem_req_bits_len; // @[Core.scala 13:22]
  wire [7:0] icache_io_mem_req_bits_mask; // @[Core.scala 13:22]
  wire  icache_io_mem_resp_ready; // @[Core.scala 13:22]
  wire  icache_io_mem_resp_valid; // @[Core.scala 13:22]
  wire [63:0] icache_io_mem_resp_bits_data; // @[Core.scala 13:22]
  wire [3:0] icache_io_mem_resp_bits_cmd; // @[Core.scala 13:22]
  wire  icache_io_fence_i; // @[Core.scala 13:22]
  wire  dcache_clock; // @[Core.scala 14:22]
  wire  dcache_reset; // @[Core.scala 14:22]
  wire  dcache_io_cpu_req_ready; // @[Core.scala 14:22]
  wire  dcache_io_cpu_req_valid; // @[Core.scala 14:22]
  wire [63:0] dcache_io_cpu_req_bits_addr; // @[Core.scala 14:22]
  wire [63:0] dcache_io_cpu_req_bits_data; // @[Core.scala 14:22]
  wire [7:0] dcache_io_cpu_req_bits_mask; // @[Core.scala 14:22]
  wire  dcache_io_cpu_req_bits_op; // @[Core.scala 14:22]
  wire  dcache_io_cpu_resp_valid; // @[Core.scala 14:22]
  wire [63:0] dcache_io_cpu_resp_bits_data; // @[Core.scala 14:22]
  wire [3:0] dcache_io_cpu_resp_bits_cmd; // @[Core.scala 14:22]
  wire  dcache_io_mem_req_ready; // @[Core.scala 14:22]
  wire  dcache_io_mem_req_valid; // @[Core.scala 14:22]
  wire [63:0] dcache_io_mem_req_bits_addr; // @[Core.scala 14:22]
  wire [63:0] dcache_io_mem_req_bits_data; // @[Core.scala 14:22]
  wire [3:0] dcache_io_mem_req_bits_cmd; // @[Core.scala 14:22]
  wire [1:0] dcache_io_mem_req_bits_len; // @[Core.scala 14:22]
  wire [7:0] dcache_io_mem_req_bits_mask; // @[Core.scala 14:22]
  wire  dcache_io_mem_resp_ready; // @[Core.scala 14:22]
  wire  dcache_io_mem_resp_valid; // @[Core.scala 14:22]
  wire [63:0] dcache_io_mem_resp_bits_data; // @[Core.scala 14:22]
  wire [3:0] dcache_io_mem_resp_bits_cmd; // @[Core.scala 14:22]
  wire  dcache_io_fence_i; // @[Core.scala 14:22]
  wire  dcache_io_fence_i_done; // @[Core.scala 14:22]
  wire [31:0] control_io_inst; // @[Core.scala 15:23]
  wire [1:0] control_io_signal_pc_sel; // @[Core.scala 15:23]
  wire  control_io_signal_a_sel; // @[Core.scala 15:23]
  wire  control_io_signal_b_sel; // @[Core.scala 15:23]
  wire [2:0] control_io_signal_imm_sel; // @[Core.scala 15:23]
  wire [4:0] control_io_signal_alu_op; // @[Core.scala 15:23]
  wire [2:0] control_io_signal_br_type; // @[Core.scala 15:23]
  wire  control_io_signal_kill; // @[Core.scala 15:23]
  wire [2:0] control_io_signal_st_type; // @[Core.scala 15:23]
  wire [2:0] control_io_signal_ld_type; // @[Core.scala 15:23]
  wire [1:0] control_io_signal_wb_type; // @[Core.scala 15:23]
  wire  control_io_signal_wen; // @[Core.scala 15:23]
  wire [2:0] control_io_signal_csr_cmd; // @[Core.scala 15:23]
  wire  control_io_signal_illegal; // @[Core.scala 15:23]
  wire  crossbar_clock; // @[Core.scala 16:24]
  wire  crossbar_reset; // @[Core.scala 16:24]
  wire  crossbar_io_in_0_req_ready; // @[Core.scala 16:24]
  wire  crossbar_io_in_0_req_valid; // @[Core.scala 16:24]
  wire [63:0] crossbar_io_in_0_req_bits_addr; // @[Core.scala 16:24]
  wire [63:0] crossbar_io_in_0_req_bits_data; // @[Core.scala 16:24]
  wire [3:0] crossbar_io_in_0_req_bits_cmd; // @[Core.scala 16:24]
  wire [1:0] crossbar_io_in_0_req_bits_len; // @[Core.scala 16:24]
  wire [7:0] crossbar_io_in_0_req_bits_mask; // @[Core.scala 16:24]
  wire  crossbar_io_in_0_resp_ready; // @[Core.scala 16:24]
  wire  crossbar_io_in_0_resp_valid; // @[Core.scala 16:24]
  wire [63:0] crossbar_io_in_0_resp_bits_data; // @[Core.scala 16:24]
  wire [3:0] crossbar_io_in_0_resp_bits_cmd; // @[Core.scala 16:24]
  wire  crossbar_io_in_1_req_ready; // @[Core.scala 16:24]
  wire  crossbar_io_in_1_req_valid; // @[Core.scala 16:24]
  wire [63:0] crossbar_io_in_1_req_bits_addr; // @[Core.scala 16:24]
  wire [63:0] crossbar_io_in_1_req_bits_data; // @[Core.scala 16:24]
  wire [3:0] crossbar_io_in_1_req_bits_cmd; // @[Core.scala 16:24]
  wire [1:0] crossbar_io_in_1_req_bits_len; // @[Core.scala 16:24]
  wire [7:0] crossbar_io_in_1_req_bits_mask; // @[Core.scala 16:24]
  wire  crossbar_io_in_1_resp_ready; // @[Core.scala 16:24]
  wire  crossbar_io_in_1_resp_valid; // @[Core.scala 16:24]
  wire [63:0] crossbar_io_in_1_resp_bits_data; // @[Core.scala 16:24]
  wire [3:0] crossbar_io_in_1_resp_bits_cmd; // @[Core.scala 16:24]
  wire  crossbar_io_out_0_req_valid; // @[Core.scala 16:24]
  wire [63:0] crossbar_io_out_0_req_bits_addr; // @[Core.scala 16:24]
  wire [63:0] crossbar_io_out_0_req_bits_data; // @[Core.scala 16:24]
  wire [3:0] crossbar_io_out_0_req_bits_cmd; // @[Core.scala 16:24]
  wire [3:0] crossbar_io_out_0_req_bits_id; // @[Core.scala 16:24]
  wire  crossbar_io_out_0_resp_ready; // @[Core.scala 16:24]
  wire  crossbar_io_out_0_resp_valid; // @[Core.scala 16:24]
  wire [63:0] crossbar_io_out_0_resp_bits_data; // @[Core.scala 16:24]
  wire [3:0] crossbar_io_out_0_resp_bits_cmd; // @[Core.scala 16:24]
  wire [3:0] crossbar_io_out_0_resp_bits_id; // @[Core.scala 16:24]
  wire  crossbar_io_out_1_req_ready; // @[Core.scala 16:24]
  wire  crossbar_io_out_1_req_valid; // @[Core.scala 16:24]
  wire [63:0] crossbar_io_out_1_req_bits_addr; // @[Core.scala 16:24]
  wire [63:0] crossbar_io_out_1_req_bits_data; // @[Core.scala 16:24]
  wire [3:0] crossbar_io_out_1_req_bits_cmd; // @[Core.scala 16:24]
  wire [1:0] crossbar_io_out_1_req_bits_len; // @[Core.scala 16:24]
  wire [3:0] crossbar_io_out_1_req_bits_id; // @[Core.scala 16:24]
  wire [7:0] crossbar_io_out_1_req_bits_mask; // @[Core.scala 16:24]
  wire  crossbar_io_out_1_resp_ready; // @[Core.scala 16:24]
  wire  crossbar_io_out_1_resp_valid; // @[Core.scala 16:24]
  wire [63:0] crossbar_io_out_1_resp_bits_data; // @[Core.scala 16:24]
  wire [3:0] crossbar_io_out_1_resp_bits_cmd; // @[Core.scala 16:24]
  wire [3:0] crossbar_io_out_1_resp_bits_id; // @[Core.scala 16:24]
  wire  mem2axi_clock; // @[Core.scala 17:23]
  wire  mem2axi_reset; // @[Core.scala 17:23]
  wire  mem2axi_io_in_req_ready; // @[Core.scala 17:23]
  wire  mem2axi_io_in_req_valid; // @[Core.scala 17:23]
  wire [63:0] mem2axi_io_in_req_bits_addr; // @[Core.scala 17:23]
  wire [63:0] mem2axi_io_in_req_bits_data; // @[Core.scala 17:23]
  wire [3:0] mem2axi_io_in_req_bits_cmd; // @[Core.scala 17:23]
  wire [1:0] mem2axi_io_in_req_bits_len; // @[Core.scala 17:23]
  wire [3:0] mem2axi_io_in_req_bits_id; // @[Core.scala 17:23]
  wire [7:0] mem2axi_io_in_req_bits_mask; // @[Core.scala 17:23]
  wire  mem2axi_io_in_resp_ready; // @[Core.scala 17:23]
  wire  mem2axi_io_in_resp_valid; // @[Core.scala 17:23]
  wire [63:0] mem2axi_io_in_resp_bits_data; // @[Core.scala 17:23]
  wire [3:0] mem2axi_io_in_resp_bits_cmd; // @[Core.scala 17:23]
  wire [3:0] mem2axi_io_in_resp_bits_id; // @[Core.scala 17:23]
  wire  mem2axi_io_axi4_aw_ready; // @[Core.scala 17:23]
  wire  mem2axi_io_axi4_aw_valid; // @[Core.scala 17:23]
  wire [63:0] mem2axi_io_axi4_aw_bits_addr; // @[Core.scala 17:23]
  wire [3:0] mem2axi_io_axi4_aw_bits_id; // @[Core.scala 17:23]
  wire [7:0] mem2axi_io_axi4_aw_bits_len; // @[Core.scala 17:23]
  wire [2:0] mem2axi_io_axi4_aw_bits_size; // @[Core.scala 17:23]
  wire  mem2axi_io_axi4_w_ready; // @[Core.scala 17:23]
  wire  mem2axi_io_axi4_w_valid; // @[Core.scala 17:23]
  wire [63:0] mem2axi_io_axi4_w_bits_data; // @[Core.scala 17:23]
  wire  mem2axi_io_axi4_w_bits_last; // @[Core.scala 17:23]
  wire  mem2axi_io_axi4_b_ready; // @[Core.scala 17:23]
  wire  mem2axi_io_axi4_b_valid; // @[Core.scala 17:23]
  wire [3:0] mem2axi_io_axi4_b_bits_id; // @[Core.scala 17:23]
  wire  mem2axi_io_axi4_ar_ready; // @[Core.scala 17:23]
  wire  mem2axi_io_axi4_ar_valid; // @[Core.scala 17:23]
  wire [63:0] mem2axi_io_axi4_ar_bits_addr; // @[Core.scala 17:23]
  wire [3:0] mem2axi_io_axi4_ar_bits_id; // @[Core.scala 17:23]
  wire [7:0] mem2axi_io_axi4_ar_bits_len; // @[Core.scala 17:23]
  wire [2:0] mem2axi_io_axi4_ar_bits_size; // @[Core.scala 17:23]
  wire  mem2axi_io_axi4_r_ready; // @[Core.scala 17:23]
  wire  mem2axi_io_axi4_r_valid; // @[Core.scala 17:23]
  wire [63:0] mem2axi_io_axi4_r_bits_data; // @[Core.scala 17:23]
  wire  mem2axi_io_axi4_r_bits_last; // @[Core.scala 17:23]
  wire [3:0] mem2axi_io_axi4_r_bits_id; // @[Core.scala 17:23]
  wire  clint_clock; // @[Core.scala 18:21]
  wire  clint_reset; // @[Core.scala 18:21]
  wire  clint_io_cpu_req_ready; // @[Core.scala 18:21]
  wire  clint_io_cpu_req_valid; // @[Core.scala 18:21]
  wire [63:0] clint_io_cpu_req_bits_addr; // @[Core.scala 18:21]
  wire [63:0] clint_io_cpu_req_bits_data; // @[Core.scala 18:21]
  wire [3:0] clint_io_cpu_req_bits_cmd; // @[Core.scala 18:21]
  wire [3:0] clint_io_cpu_req_bits_id; // @[Core.scala 18:21]
  wire  clint_io_cpu_resp_ready; // @[Core.scala 18:21]
  wire  clint_io_cpu_resp_valid; // @[Core.scala 18:21]
  wire [63:0] clint_io_cpu_resp_bits_data; // @[Core.scala 18:21]
  wire [3:0] clint_io_cpu_resp_bits_cmd; // @[Core.scala 18:21]
  wire [3:0] clint_io_cpu_resp_bits_id; // @[Core.scala 18:21]
  wire  clint_io_interrupt; // @[Core.scala 18:21]
  ysyx_210013_DataPath datapath ( // @[Core.scala 12:24]
    .clock(datapath_clock),
    .reset(datapath_reset),
    .io_icacahe_req_ready(datapath_io_icacahe_req_ready),
    .io_icacahe_req_valid(datapath_io_icacahe_req_valid),
    .io_icacahe_req_bits_addr(datapath_io_icacahe_req_bits_addr),
    .io_icacahe_req_bits_data(datapath_io_icacahe_req_bits_data),
    .io_icacahe_req_bits_mask(datapath_io_icacahe_req_bits_mask),
    .io_icacahe_req_bits_op(datapath_io_icacahe_req_bits_op),
    .io_icacahe_resp_valid(datapath_io_icacahe_resp_valid),
    .io_icacahe_resp_bits_data(datapath_io_icacahe_resp_bits_data),
    .io_icacahe_resp_bits_cmd(datapath_io_icacahe_resp_bits_cmd),
    .io_dcache_req_ready(datapath_io_dcache_req_ready),
    .io_dcache_req_valid(datapath_io_dcache_req_valid),
    .io_dcache_req_bits_addr(datapath_io_dcache_req_bits_addr),
    .io_dcache_req_bits_data(datapath_io_dcache_req_bits_data),
    .io_dcache_req_bits_mask(datapath_io_dcache_req_bits_mask),
    .io_dcache_req_bits_op(datapath_io_dcache_req_bits_op),
    .io_dcache_resp_valid(datapath_io_dcache_resp_valid),
    .io_dcache_resp_bits_data(datapath_io_dcache_resp_bits_data),
    .io_dcache_resp_bits_cmd(datapath_io_dcache_resp_bits_cmd),
    .io_control_inst(datapath_io_control_inst),
    .io_control_signal_pc_sel(datapath_io_control_signal_pc_sel),
    .io_control_signal_a_sel(datapath_io_control_signal_a_sel),
    .io_control_signal_b_sel(datapath_io_control_signal_b_sel),
    .io_control_signal_imm_sel(datapath_io_control_signal_imm_sel),
    .io_control_signal_alu_op(datapath_io_control_signal_alu_op),
    .io_control_signal_br_type(datapath_io_control_signal_br_type),
    .io_control_signal_kill(datapath_io_control_signal_kill),
    .io_control_signal_st_type(datapath_io_control_signal_st_type),
    .io_control_signal_ld_type(datapath_io_control_signal_ld_type),
    .io_control_signal_wb_type(datapath_io_control_signal_wb_type),
    .io_control_signal_wen(datapath_io_control_signal_wen),
    .io_control_signal_csr_cmd(datapath_io_control_signal_csr_cmd),
    .io_control_signal_illegal(datapath_io_control_signal_illegal),
    .io_time_interrupt(datapath_io_time_interrupt),
    .io_fence_i_do(datapath_io_fence_i_do),
    .io_fence_i_done(datapath_io_fence_i_done)
  );
  ysyx_210013_Cache icache ( // @[Core.scala 13:22]
    .clock(icache_clock),
    .reset(icache_reset),
    .io_cpu_req_ready(icache_io_cpu_req_ready),
    .io_cpu_req_valid(icache_io_cpu_req_valid),
    .io_cpu_req_bits_addr(icache_io_cpu_req_bits_addr),
    .io_cpu_req_bits_data(icache_io_cpu_req_bits_data),
    .io_cpu_req_bits_mask(icache_io_cpu_req_bits_mask),
    .io_cpu_req_bits_op(icache_io_cpu_req_bits_op),
    .io_cpu_resp_valid(icache_io_cpu_resp_valid),
    .io_cpu_resp_bits_data(icache_io_cpu_resp_bits_data),
    .io_cpu_resp_bits_cmd(icache_io_cpu_resp_bits_cmd),
    .io_mem_req_ready(icache_io_mem_req_ready),
    .io_mem_req_valid(icache_io_mem_req_valid),
    .io_mem_req_bits_addr(icache_io_mem_req_bits_addr),
    .io_mem_req_bits_data(icache_io_mem_req_bits_data),
    .io_mem_req_bits_cmd(icache_io_mem_req_bits_cmd),
    .io_mem_req_bits_len(icache_io_mem_req_bits_len),
    .io_mem_req_bits_mask(icache_io_mem_req_bits_mask),
    .io_mem_resp_ready(icache_io_mem_resp_ready),
    .io_mem_resp_valid(icache_io_mem_resp_valid),
    .io_mem_resp_bits_data(icache_io_mem_resp_bits_data),
    .io_mem_resp_bits_cmd(icache_io_mem_resp_bits_cmd),
    .io_fence_i(icache_io_fence_i)
  );
  ysyx_210013_Cache_1 dcache ( // @[Core.scala 14:22]
    .clock(dcache_clock),
    .reset(dcache_reset),
    .io_cpu_req_ready(dcache_io_cpu_req_ready),
    .io_cpu_req_valid(dcache_io_cpu_req_valid),
    .io_cpu_req_bits_addr(dcache_io_cpu_req_bits_addr),
    .io_cpu_req_bits_data(dcache_io_cpu_req_bits_data),
    .io_cpu_req_bits_mask(dcache_io_cpu_req_bits_mask),
    .io_cpu_req_bits_op(dcache_io_cpu_req_bits_op),
    .io_cpu_resp_valid(dcache_io_cpu_resp_valid),
    .io_cpu_resp_bits_data(dcache_io_cpu_resp_bits_data),
    .io_cpu_resp_bits_cmd(dcache_io_cpu_resp_bits_cmd),
    .io_mem_req_ready(dcache_io_mem_req_ready),
    .io_mem_req_valid(dcache_io_mem_req_valid),
    .io_mem_req_bits_addr(dcache_io_mem_req_bits_addr),
    .io_mem_req_bits_data(dcache_io_mem_req_bits_data),
    .io_mem_req_bits_cmd(dcache_io_mem_req_bits_cmd),
    .io_mem_req_bits_len(dcache_io_mem_req_bits_len),
    .io_mem_req_bits_mask(dcache_io_mem_req_bits_mask),
    .io_mem_resp_ready(dcache_io_mem_resp_ready),
    .io_mem_resp_valid(dcache_io_mem_resp_valid),
    .io_mem_resp_bits_data(dcache_io_mem_resp_bits_data),
    .io_mem_resp_bits_cmd(dcache_io_mem_resp_bits_cmd),
    .io_fence_i(dcache_io_fence_i),
    .io_fence_i_done(dcache_io_fence_i_done)
  );
  ysyx_210013_Control control ( // @[Core.scala 15:23]
    .io_inst(control_io_inst),
    .io_signal_pc_sel(control_io_signal_pc_sel),
    .io_signal_a_sel(control_io_signal_a_sel),
    .io_signal_b_sel(control_io_signal_b_sel),
    .io_signal_imm_sel(control_io_signal_imm_sel),
    .io_signal_alu_op(control_io_signal_alu_op),
    .io_signal_br_type(control_io_signal_br_type),
    .io_signal_kill(control_io_signal_kill),
    .io_signal_st_type(control_io_signal_st_type),
    .io_signal_ld_type(control_io_signal_ld_type),
    .io_signal_wb_type(control_io_signal_wb_type),
    .io_signal_wen(control_io_signal_wen),
    .io_signal_csr_cmd(control_io_signal_csr_cmd),
    .io_signal_illegal(control_io_signal_illegal)
  );
  ysyx_210013_InnerCrossBarNN crossbar ( // @[Core.scala 16:24]
    .clock(crossbar_clock),
    .reset(crossbar_reset),
    .io_in_0_req_ready(crossbar_io_in_0_req_ready),
    .io_in_0_req_valid(crossbar_io_in_0_req_valid),
    .io_in_0_req_bits_addr(crossbar_io_in_0_req_bits_addr),
    .io_in_0_req_bits_data(crossbar_io_in_0_req_bits_data),
    .io_in_0_req_bits_cmd(crossbar_io_in_0_req_bits_cmd),
    .io_in_0_req_bits_len(crossbar_io_in_0_req_bits_len),
    .io_in_0_req_bits_mask(crossbar_io_in_0_req_bits_mask),
    .io_in_0_resp_ready(crossbar_io_in_0_resp_ready),
    .io_in_0_resp_valid(crossbar_io_in_0_resp_valid),
    .io_in_0_resp_bits_data(crossbar_io_in_0_resp_bits_data),
    .io_in_0_resp_bits_cmd(crossbar_io_in_0_resp_bits_cmd),
    .io_in_1_req_ready(crossbar_io_in_1_req_ready),
    .io_in_1_req_valid(crossbar_io_in_1_req_valid),
    .io_in_1_req_bits_addr(crossbar_io_in_1_req_bits_addr),
    .io_in_1_req_bits_data(crossbar_io_in_1_req_bits_data),
    .io_in_1_req_bits_cmd(crossbar_io_in_1_req_bits_cmd),
    .io_in_1_req_bits_len(crossbar_io_in_1_req_bits_len),
    .io_in_1_req_bits_mask(crossbar_io_in_1_req_bits_mask),
    .io_in_1_resp_ready(crossbar_io_in_1_resp_ready),
    .io_in_1_resp_valid(crossbar_io_in_1_resp_valid),
    .io_in_1_resp_bits_data(crossbar_io_in_1_resp_bits_data),
    .io_in_1_resp_bits_cmd(crossbar_io_in_1_resp_bits_cmd),
    .io_out_0_req_valid(crossbar_io_out_0_req_valid),
    .io_out_0_req_bits_addr(crossbar_io_out_0_req_bits_addr),
    .io_out_0_req_bits_data(crossbar_io_out_0_req_bits_data),
    .io_out_0_req_bits_cmd(crossbar_io_out_0_req_bits_cmd),
    .io_out_0_req_bits_id(crossbar_io_out_0_req_bits_id),
    .io_out_0_resp_ready(crossbar_io_out_0_resp_ready),
    .io_out_0_resp_valid(crossbar_io_out_0_resp_valid),
    .io_out_0_resp_bits_data(crossbar_io_out_0_resp_bits_data),
    .io_out_0_resp_bits_cmd(crossbar_io_out_0_resp_bits_cmd),
    .io_out_0_resp_bits_id(crossbar_io_out_0_resp_bits_id),
    .io_out_1_req_ready(crossbar_io_out_1_req_ready),
    .io_out_1_req_valid(crossbar_io_out_1_req_valid),
    .io_out_1_req_bits_addr(crossbar_io_out_1_req_bits_addr),
    .io_out_1_req_bits_data(crossbar_io_out_1_req_bits_data),
    .io_out_1_req_bits_cmd(crossbar_io_out_1_req_bits_cmd),
    .io_out_1_req_bits_len(crossbar_io_out_1_req_bits_len),
    .io_out_1_req_bits_id(crossbar_io_out_1_req_bits_id),
    .io_out_1_req_bits_mask(crossbar_io_out_1_req_bits_mask),
    .io_out_1_resp_ready(crossbar_io_out_1_resp_ready),
    .io_out_1_resp_valid(crossbar_io_out_1_resp_valid),
    .io_out_1_resp_bits_data(crossbar_io_out_1_resp_bits_data),
    .io_out_1_resp_bits_cmd(crossbar_io_out_1_resp_bits_cmd),
    .io_out_1_resp_bits_id(crossbar_io_out_1_resp_bits_id)
  );
  ysyx_210013_MemBus2AXI mem2axi ( // @[Core.scala 17:23]
    .clock(mem2axi_clock),
    .reset(mem2axi_reset),
    .io_in_req_ready(mem2axi_io_in_req_ready),
    .io_in_req_valid(mem2axi_io_in_req_valid),
    .io_in_req_bits_addr(mem2axi_io_in_req_bits_addr),
    .io_in_req_bits_data(mem2axi_io_in_req_bits_data),
    .io_in_req_bits_cmd(mem2axi_io_in_req_bits_cmd),
    .io_in_req_bits_len(mem2axi_io_in_req_bits_len),
    .io_in_req_bits_id(mem2axi_io_in_req_bits_id),
    .io_in_req_bits_mask(mem2axi_io_in_req_bits_mask),
    .io_in_resp_ready(mem2axi_io_in_resp_ready),
    .io_in_resp_valid(mem2axi_io_in_resp_valid),
    .io_in_resp_bits_data(mem2axi_io_in_resp_bits_data),
    .io_in_resp_bits_cmd(mem2axi_io_in_resp_bits_cmd),
    .io_in_resp_bits_id(mem2axi_io_in_resp_bits_id),
    .io_axi4_aw_ready(mem2axi_io_axi4_aw_ready),
    .io_axi4_aw_valid(mem2axi_io_axi4_aw_valid),
    .io_axi4_aw_bits_addr(mem2axi_io_axi4_aw_bits_addr),
    .io_axi4_aw_bits_id(mem2axi_io_axi4_aw_bits_id),
    .io_axi4_aw_bits_len(mem2axi_io_axi4_aw_bits_len),
    .io_axi4_aw_bits_size(mem2axi_io_axi4_aw_bits_size),
    .io_axi4_w_ready(mem2axi_io_axi4_w_ready),
    .io_axi4_w_valid(mem2axi_io_axi4_w_valid),
    .io_axi4_w_bits_data(mem2axi_io_axi4_w_bits_data),
    .io_axi4_w_bits_last(mem2axi_io_axi4_w_bits_last),
    .io_axi4_b_ready(mem2axi_io_axi4_b_ready),
    .io_axi4_b_valid(mem2axi_io_axi4_b_valid),
    .io_axi4_b_bits_id(mem2axi_io_axi4_b_bits_id),
    .io_axi4_ar_ready(mem2axi_io_axi4_ar_ready),
    .io_axi4_ar_valid(mem2axi_io_axi4_ar_valid),
    .io_axi4_ar_bits_addr(mem2axi_io_axi4_ar_bits_addr),
    .io_axi4_ar_bits_id(mem2axi_io_axi4_ar_bits_id),
    .io_axi4_ar_bits_len(mem2axi_io_axi4_ar_bits_len),
    .io_axi4_ar_bits_size(mem2axi_io_axi4_ar_bits_size),
    .io_axi4_r_ready(mem2axi_io_axi4_r_ready),
    .io_axi4_r_valid(mem2axi_io_axi4_r_valid),
    .io_axi4_r_bits_data(mem2axi_io_axi4_r_bits_data),
    .io_axi4_r_bits_last(mem2axi_io_axi4_r_bits_last),
    .io_axi4_r_bits_id(mem2axi_io_axi4_r_bits_id)
  );
  ysyx_210013_CLINT clint ( // @[Core.scala 18:21]
    .clock(clint_clock),
    .reset(clint_reset),
    .io_cpu_req_ready(clint_io_cpu_req_ready),
    .io_cpu_req_valid(clint_io_cpu_req_valid),
    .io_cpu_req_bits_addr(clint_io_cpu_req_bits_addr),
    .io_cpu_req_bits_data(clint_io_cpu_req_bits_data),
    .io_cpu_req_bits_cmd(clint_io_cpu_req_bits_cmd),
    .io_cpu_req_bits_id(clint_io_cpu_req_bits_id),
    .io_cpu_resp_ready(clint_io_cpu_resp_ready),
    .io_cpu_resp_valid(clint_io_cpu_resp_valid),
    .io_cpu_resp_bits_data(clint_io_cpu_resp_bits_data),
    .io_cpu_resp_bits_cmd(clint_io_cpu_resp_bits_cmd),
    .io_cpu_resp_bits_id(clint_io_cpu_resp_bits_id),
    .io_interrupt(clint_io_interrupt)
  );
  assign io_memAXI_0_aw_valid = mem2axi_io_axi4_aw_valid; // @[Core.scala 40:19]
  assign io_memAXI_0_aw_bits_addr = mem2axi_io_axi4_aw_bits_addr; // @[Core.scala 40:19]
  assign io_memAXI_0_aw_bits_prot = 3'h0; // @[Core.scala 40:19]
  assign io_memAXI_0_aw_bits_id = mem2axi_io_axi4_aw_bits_id; // @[Core.scala 40:19]
  assign io_memAXI_0_aw_bits_user = 1'h0; // @[Core.scala 40:19]
  assign io_memAXI_0_aw_bits_len = mem2axi_io_axi4_aw_bits_len; // @[Core.scala 40:19]
  assign io_memAXI_0_aw_bits_size = mem2axi_io_axi4_aw_bits_size; // @[Core.scala 40:19]
  assign io_memAXI_0_aw_bits_burst = 2'h1; // @[Core.scala 40:19]
  assign io_memAXI_0_aw_bits_lock = 1'h0; // @[Core.scala 40:19]
  assign io_memAXI_0_aw_bits_cache = 4'h0; // @[Core.scala 40:19]
  assign io_memAXI_0_aw_bits_qos = 4'h0; // @[Core.scala 40:19]
  assign io_memAXI_0_w_valid = mem2axi_io_axi4_w_valid; // @[Core.scala 40:19]
  assign io_memAXI_0_w_bits_data = mem2axi_io_axi4_w_bits_data; // @[Core.scala 40:19]
  assign io_memAXI_0_w_bits_strb = 8'hff; // @[Core.scala 40:19]
  assign io_memAXI_0_w_bits_last = mem2axi_io_axi4_w_bits_last; // @[Core.scala 40:19]
  assign io_memAXI_0_b_ready = mem2axi_io_axi4_b_ready; // @[Core.scala 40:19]
  assign io_memAXI_0_ar_valid = mem2axi_io_axi4_ar_valid; // @[Core.scala 40:19]
  assign io_memAXI_0_ar_bits_addr = mem2axi_io_axi4_ar_bits_addr; // @[Core.scala 40:19]
  assign io_memAXI_0_ar_bits_prot = 3'h0; // @[Core.scala 40:19]
  assign io_memAXI_0_ar_bits_id = mem2axi_io_axi4_ar_bits_id; // @[Core.scala 40:19]
  assign io_memAXI_0_ar_bits_user = 1'h0; // @[Core.scala 40:19]
  assign io_memAXI_0_ar_bits_len = mem2axi_io_axi4_ar_bits_len; // @[Core.scala 40:19]
  assign io_memAXI_0_ar_bits_size = mem2axi_io_axi4_ar_bits_size; // @[Core.scala 40:19]
  assign io_memAXI_0_ar_bits_burst = 2'h1; // @[Core.scala 40:19]
  assign io_memAXI_0_ar_bits_lock = 1'h0; // @[Core.scala 40:19]
  assign io_memAXI_0_ar_bits_cache = 4'h0; // @[Core.scala 40:19]
  assign io_memAXI_0_ar_bits_qos = 4'h0; // @[Core.scala 40:19]
  assign io_memAXI_0_r_ready = mem2axi_io_axi4_r_ready; // @[Core.scala 40:19]
  assign datapath_clock = clock;
  assign datapath_reset = reset;
  assign datapath_io_icacahe_req_ready = icache_io_cpu_req_ready; // @[Core.scala 21:23]
  assign datapath_io_icacahe_resp_valid = icache_io_cpu_resp_valid; // @[Core.scala 21:23]
  assign datapath_io_icacahe_resp_bits_data = icache_io_cpu_resp_bits_data; // @[Core.scala 21:23]
  assign datapath_io_icacahe_resp_bits_cmd = icache_io_cpu_resp_bits_cmd; // @[Core.scala 21:23]
  assign datapath_io_dcache_req_ready = dcache_io_cpu_req_ready; // @[Core.scala 22:22]
  assign datapath_io_dcache_resp_valid = dcache_io_cpu_resp_valid; // @[Core.scala 22:22]
  assign datapath_io_dcache_resp_bits_data = dcache_io_cpu_resp_bits_data; // @[Core.scala 22:22]
  assign datapath_io_dcache_resp_bits_cmd = dcache_io_cpu_resp_bits_cmd; // @[Core.scala 22:22]
  assign datapath_io_control_signal_pc_sel = control_io_signal_pc_sel; // @[Core.scala 23:23]
  assign datapath_io_control_signal_a_sel = control_io_signal_a_sel; // @[Core.scala 23:23]
  assign datapath_io_control_signal_b_sel = control_io_signal_b_sel; // @[Core.scala 23:23]
  assign datapath_io_control_signal_imm_sel = control_io_signal_imm_sel; // @[Core.scala 23:23]
  assign datapath_io_control_signal_alu_op = control_io_signal_alu_op; // @[Core.scala 23:23]
  assign datapath_io_control_signal_br_type = control_io_signal_br_type; // @[Core.scala 23:23]
  assign datapath_io_control_signal_kill = control_io_signal_kill; // @[Core.scala 23:23]
  assign datapath_io_control_signal_st_type = control_io_signal_st_type; // @[Core.scala 23:23]
  assign datapath_io_control_signal_ld_type = control_io_signal_ld_type; // @[Core.scala 23:23]
  assign datapath_io_control_signal_wb_type = control_io_signal_wb_type; // @[Core.scala 23:23]
  assign datapath_io_control_signal_wen = control_io_signal_wen; // @[Core.scala 23:23]
  assign datapath_io_control_signal_csr_cmd = control_io_signal_csr_cmd; // @[Core.scala 23:23]
  assign datapath_io_control_signal_illegal = control_io_signal_illegal; // @[Core.scala 23:23]
  assign datapath_io_time_interrupt = clint_io_interrupt; // @[Core.scala 24:30]
  assign datapath_io_fence_i_done = dcache_io_fence_i_done; // @[Core.scala 28:28]
  assign icache_clock = clock;
  assign icache_reset = reset;
  assign icache_io_cpu_req_valid = datapath_io_icacahe_req_valid; // @[Core.scala 21:23]
  assign icache_io_cpu_req_bits_addr = datapath_io_icacahe_req_bits_addr; // @[Core.scala 21:23]
  assign icache_io_cpu_req_bits_data = datapath_io_icacahe_req_bits_data; // @[Core.scala 21:23]
  assign icache_io_cpu_req_bits_mask = datapath_io_icacahe_req_bits_mask; // @[Core.scala 21:23]
  assign icache_io_cpu_req_bits_op = datapath_io_icacahe_req_bits_op; // @[Core.scala 21:23]
  assign icache_io_mem_req_ready = crossbar_io_in_0_req_ready; // @[Core.scala 33:8]
  assign icache_io_mem_resp_valid = crossbar_io_in_0_resp_valid; // @[Core.scala 33:8]
  assign icache_io_mem_resp_bits_data = crossbar_io_in_0_resp_bits_data; // @[Core.scala 33:8]
  assign icache_io_mem_resp_bits_cmd = crossbar_io_in_0_resp_bits_cmd; // @[Core.scala 33:8]
  assign icache_io_fence_i = datapath_io_fence_i_do; // @[Core.scala 26:21]
  assign dcache_clock = clock;
  assign dcache_reset = reset;
  assign dcache_io_cpu_req_valid = datapath_io_dcache_req_valid; // @[Core.scala 22:22]
  assign dcache_io_cpu_req_bits_addr = datapath_io_dcache_req_bits_addr; // @[Core.scala 22:22]
  assign dcache_io_cpu_req_bits_data = datapath_io_dcache_req_bits_data; // @[Core.scala 22:22]
  assign dcache_io_cpu_req_bits_mask = datapath_io_dcache_req_bits_mask; // @[Core.scala 22:22]
  assign dcache_io_cpu_req_bits_op = datapath_io_dcache_req_bits_op; // @[Core.scala 22:22]
  assign dcache_io_mem_req_ready = crossbar_io_in_1_req_ready; // @[Core.scala 33:8]
  assign dcache_io_mem_resp_valid = crossbar_io_in_1_resp_valid; // @[Core.scala 33:8]
  assign dcache_io_mem_resp_bits_data = crossbar_io_in_1_resp_bits_data; // @[Core.scala 33:8]
  assign dcache_io_mem_resp_bits_cmd = crossbar_io_in_1_resp_bits_cmd; // @[Core.scala 33:8]
  assign dcache_io_fence_i = datapath_io_fence_i_do; // @[Core.scala 27:21]
  assign control_io_inst = datapath_io_control_inst; // @[Core.scala 23:23]
  assign crossbar_clock = clock;
  assign crossbar_reset = reset;
  assign crossbar_io_in_0_req_valid = icache_io_mem_req_valid; // @[Core.scala 33:8]
  assign crossbar_io_in_0_req_bits_addr = icache_io_mem_req_bits_addr; // @[Core.scala 33:8]
  assign crossbar_io_in_0_req_bits_data = icache_io_mem_req_bits_data; // @[Core.scala 33:8]
  assign crossbar_io_in_0_req_bits_cmd = icache_io_mem_req_bits_cmd; // @[Core.scala 33:8]
  assign crossbar_io_in_0_req_bits_len = icache_io_mem_req_bits_len; // @[Core.scala 33:8]
  assign crossbar_io_in_0_req_bits_mask = icache_io_mem_req_bits_mask; // @[Core.scala 33:8]
  assign crossbar_io_in_0_resp_ready = icache_io_mem_resp_ready; // @[Core.scala 33:8]
  assign crossbar_io_in_1_req_valid = dcache_io_mem_req_valid; // @[Core.scala 33:8]
  assign crossbar_io_in_1_req_bits_addr = dcache_io_mem_req_bits_addr; // @[Core.scala 33:8]
  assign crossbar_io_in_1_req_bits_data = dcache_io_mem_req_bits_data; // @[Core.scala 33:8]
  assign crossbar_io_in_1_req_bits_cmd = dcache_io_mem_req_bits_cmd; // @[Core.scala 33:8]
  assign crossbar_io_in_1_req_bits_len = dcache_io_mem_req_bits_len; // @[Core.scala 33:8]
  assign crossbar_io_in_1_req_bits_mask = dcache_io_mem_req_bits_mask; // @[Core.scala 33:8]
  assign crossbar_io_in_1_resp_ready = dcache_io_mem_resp_ready; // @[Core.scala 33:8]
  assign crossbar_io_out_0_resp_valid = clint_io_cpu_resp_valid; // @[Core.scala 37:72]
  assign crossbar_io_out_0_resp_bits_data = clint_io_cpu_resp_bits_data; // @[Core.scala 37:72]
  assign crossbar_io_out_0_resp_bits_cmd = clint_io_cpu_resp_bits_cmd; // @[Core.scala 37:72]
  assign crossbar_io_out_0_resp_bits_id = clint_io_cpu_resp_bits_id; // @[Core.scala 37:72]
  assign crossbar_io_out_1_req_ready = mem2axi_io_in_req_ready; // @[Core.scala 37:72]
  assign crossbar_io_out_1_resp_valid = mem2axi_io_in_resp_valid; // @[Core.scala 37:72]
  assign crossbar_io_out_1_resp_bits_data = mem2axi_io_in_resp_bits_data; // @[Core.scala 37:72]
  assign crossbar_io_out_1_resp_bits_cmd = mem2axi_io_in_resp_bits_cmd; // @[Core.scala 37:72]
  assign crossbar_io_out_1_resp_bits_id = mem2axi_io_in_resp_bits_id; // @[Core.scala 37:72]
  assign mem2axi_clock = clock;
  assign mem2axi_reset = reset;
  assign mem2axi_io_in_req_valid = crossbar_io_out_1_req_valid; // @[Core.scala 37:72]
  assign mem2axi_io_in_req_bits_addr = crossbar_io_out_1_req_bits_addr; // @[Core.scala 37:72]
  assign mem2axi_io_in_req_bits_data = crossbar_io_out_1_req_bits_data; // @[Core.scala 37:72]
  assign mem2axi_io_in_req_bits_cmd = crossbar_io_out_1_req_bits_cmd; // @[Core.scala 37:72]
  assign mem2axi_io_in_req_bits_len = crossbar_io_out_1_req_bits_len; // @[Core.scala 37:72]
  assign mem2axi_io_in_req_bits_id = crossbar_io_out_1_req_bits_id; // @[Core.scala 37:72]
  assign mem2axi_io_in_req_bits_mask = crossbar_io_out_1_req_bits_mask; // @[Core.scala 37:72]
  assign mem2axi_io_in_resp_ready = crossbar_io_out_1_resp_ready; // @[Core.scala 37:72]
  assign mem2axi_io_axi4_aw_ready = io_memAXI_0_aw_ready; // @[Core.scala 40:19]
  assign mem2axi_io_axi4_w_ready = io_memAXI_0_w_ready; // @[Core.scala 40:19]
  assign mem2axi_io_axi4_b_valid = io_memAXI_0_b_valid; // @[Core.scala 40:19]
  assign mem2axi_io_axi4_b_bits_id = io_memAXI_0_b_bits_id; // @[Core.scala 40:19]
  assign mem2axi_io_axi4_ar_ready = io_memAXI_0_ar_ready; // @[Core.scala 40:19]
  assign mem2axi_io_axi4_r_valid = io_memAXI_0_r_valid; // @[Core.scala 40:19]
  assign mem2axi_io_axi4_r_bits_data = io_memAXI_0_r_bits_data; // @[Core.scala 40:19]
  assign mem2axi_io_axi4_r_bits_last = io_memAXI_0_r_bits_last; // @[Core.scala 40:19]
  assign mem2axi_io_axi4_r_bits_id = io_memAXI_0_r_bits_id; // @[Core.scala 40:19]
  assign clint_clock = clock;
  assign clint_reset = reset;
  assign clint_io_cpu_req_valid = crossbar_io_out_0_req_valid; // @[Core.scala 37:72]
  assign clint_io_cpu_req_bits_addr = crossbar_io_out_0_req_bits_addr; // @[Core.scala 37:72]
  assign clint_io_cpu_req_bits_data = crossbar_io_out_0_req_bits_data; // @[Core.scala 37:72]
  assign clint_io_cpu_req_bits_cmd = crossbar_io_out_0_req_bits_cmd; // @[Core.scala 37:72]
  assign clint_io_cpu_req_bits_id = crossbar_io_out_0_req_bits_id; // @[Core.scala 37:72]
  assign clint_io_cpu_resp_ready = crossbar_io_out_0_resp_ready; // @[Core.scala 37:72]
endmodule
module ysyx_210013(
  input         clock,
  input         reset,
  input         io_interrupt,
  input         io_master_awready,
  output        io_master_awvalid,
  output [31:0] io_master_awaddr,
  output [3:0]  io_master_awid,
  output [7:0]  io_master_awlen,
  output [2:0]  io_master_awsize,
  output [1:0]  io_master_awburst,
  input         io_master_wready,
  output        io_master_wvalid,
  output [63:0] io_master_wdata,
  output [7:0]  io_master_wstrb,
  output        io_master_wlast,
  output        io_master_bready,
  input         io_master_bvalid,
  input  [1:0]  io_master_bresp,
  input  [3:0]  io_master_bid,
  input         io_master_arready,
  output        io_master_arvalid,
  output [31:0] io_master_araddr,
  output [3:0]  io_master_arid,
  output [7:0]  io_master_arlen,
  output [2:0]  io_master_arsize,
  output [1:0]  io_master_arburst,
  output        io_master_rready,
  input         io_master_rvalid,
  input  [1:0]  io_master_rresp,
  input  [63:0] io_master_rdata,
  input         io_master_rlast,
  input  [3:0]  io_master_rid,
  output        io_slave_awready,
  input         io_slave_awvalid,
  input  [31:0] io_slave_awaddr,
  input  [3:0]  io_slave_awid,
  input  [7:0]  io_slave_awlen,
  input  [2:0]  io_slave_awsize,
  input  [1:0]  io_slave_awburst,
  output        io_slave_wready,
  input         io_slave_wvalid,
  input  [63:0] io_slave_wdata,
  input  [7:0]  io_slave_wstrb,
  input         io_slave_wlast,
  input         io_slave_bready,
  output        io_slave_bvalid,
  output [1:0]  io_slave_bresp,
  output [3:0]  io_slave_bid,
  output        io_slave_arready,
  input         io_slave_arvalid,
  input  [31:0] io_slave_araddr,
  input  [3:0]  io_slave_arid,
  input  [7:0]  io_slave_arlen,
  input  [2:0]  io_slave_arsize,
  input  [1:0]  io_slave_arburst,
  input         io_slave_rready,
  output        io_slave_rvalid,
  output [1:0]  io_slave_rresp,
  output [63:0] io_slave_rdata,
  output        io_slave_rlast,
  output [3:0]  io_slave_rid
);
  wire  core_clock; // @[Core.scala 86:20]
  wire  core_reset; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_aw_ready; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_aw_valid; // @[Core.scala 86:20]
  wire [63:0] core_io_memAXI_0_aw_bits_addr; // @[Core.scala 86:20]
  wire [2:0] core_io_memAXI_0_aw_bits_prot; // @[Core.scala 86:20]
  wire [3:0] core_io_memAXI_0_aw_bits_id; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_aw_bits_user; // @[Core.scala 86:20]
  wire [7:0] core_io_memAXI_0_aw_bits_len; // @[Core.scala 86:20]
  wire [2:0] core_io_memAXI_0_aw_bits_size; // @[Core.scala 86:20]
  wire [1:0] core_io_memAXI_0_aw_bits_burst; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_aw_bits_lock; // @[Core.scala 86:20]
  wire [3:0] core_io_memAXI_0_aw_bits_cache; // @[Core.scala 86:20]
  wire [3:0] core_io_memAXI_0_aw_bits_qos; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_w_ready; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_w_valid; // @[Core.scala 86:20]
  wire [63:0] core_io_memAXI_0_w_bits_data; // @[Core.scala 86:20]
  wire [7:0] core_io_memAXI_0_w_bits_strb; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_w_bits_last; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_b_ready; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_b_valid; // @[Core.scala 86:20]
  wire [1:0] core_io_memAXI_0_b_bits_resp; // @[Core.scala 86:20]
  wire [3:0] core_io_memAXI_0_b_bits_id; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_b_bits_user; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_ar_ready; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_ar_valid; // @[Core.scala 86:20]
  wire [63:0] core_io_memAXI_0_ar_bits_addr; // @[Core.scala 86:20]
  wire [2:0] core_io_memAXI_0_ar_bits_prot; // @[Core.scala 86:20]
  wire [3:0] core_io_memAXI_0_ar_bits_id; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_ar_bits_user; // @[Core.scala 86:20]
  wire [7:0] core_io_memAXI_0_ar_bits_len; // @[Core.scala 86:20]
  wire [2:0] core_io_memAXI_0_ar_bits_size; // @[Core.scala 86:20]
  wire [1:0] core_io_memAXI_0_ar_bits_burst; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_ar_bits_lock; // @[Core.scala 86:20]
  wire [3:0] core_io_memAXI_0_ar_bits_cache; // @[Core.scala 86:20]
  wire [3:0] core_io_memAXI_0_ar_bits_qos; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_r_ready; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_r_valid; // @[Core.scala 86:20]
  wire [1:0] core_io_memAXI_0_r_bits_resp; // @[Core.scala 86:20]
  wire [63:0] core_io_memAXI_0_r_bits_data; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_r_bits_last; // @[Core.scala 86:20]
  wire [3:0] core_io_memAXI_0_r_bits_id; // @[Core.scala 86:20]
  wire  core_io_memAXI_0_r_bits_user; // @[Core.scala 86:20]
  ysyx_210013_Core core ( // @[Core.scala 86:20]
    .clock(core_clock),
    .reset(core_reset),
    .io_memAXI_0_aw_ready(core_io_memAXI_0_aw_ready),
    .io_memAXI_0_aw_valid(core_io_memAXI_0_aw_valid),
    .io_memAXI_0_aw_bits_addr(core_io_memAXI_0_aw_bits_addr),
    .io_memAXI_0_aw_bits_prot(core_io_memAXI_0_aw_bits_prot),
    .io_memAXI_0_aw_bits_id(core_io_memAXI_0_aw_bits_id),
    .io_memAXI_0_aw_bits_user(core_io_memAXI_0_aw_bits_user),
    .io_memAXI_0_aw_bits_len(core_io_memAXI_0_aw_bits_len),
    .io_memAXI_0_aw_bits_size(core_io_memAXI_0_aw_bits_size),
    .io_memAXI_0_aw_bits_burst(core_io_memAXI_0_aw_bits_burst),
    .io_memAXI_0_aw_bits_lock(core_io_memAXI_0_aw_bits_lock),
    .io_memAXI_0_aw_bits_cache(core_io_memAXI_0_aw_bits_cache),
    .io_memAXI_0_aw_bits_qos(core_io_memAXI_0_aw_bits_qos),
    .io_memAXI_0_w_ready(core_io_memAXI_0_w_ready),
    .io_memAXI_0_w_valid(core_io_memAXI_0_w_valid),
    .io_memAXI_0_w_bits_data(core_io_memAXI_0_w_bits_data),
    .io_memAXI_0_w_bits_strb(core_io_memAXI_0_w_bits_strb),
    .io_memAXI_0_w_bits_last(core_io_memAXI_0_w_bits_last),
    .io_memAXI_0_b_ready(core_io_memAXI_0_b_ready),
    .io_memAXI_0_b_valid(core_io_memAXI_0_b_valid),
    .io_memAXI_0_b_bits_resp(core_io_memAXI_0_b_bits_resp),
    .io_memAXI_0_b_bits_id(core_io_memAXI_0_b_bits_id),
    .io_memAXI_0_b_bits_user(core_io_memAXI_0_b_bits_user),
    .io_memAXI_0_ar_ready(core_io_memAXI_0_ar_ready),
    .io_memAXI_0_ar_valid(core_io_memAXI_0_ar_valid),
    .io_memAXI_0_ar_bits_addr(core_io_memAXI_0_ar_bits_addr),
    .io_memAXI_0_ar_bits_prot(core_io_memAXI_0_ar_bits_prot),
    .io_memAXI_0_ar_bits_id(core_io_memAXI_0_ar_bits_id),
    .io_memAXI_0_ar_bits_user(core_io_memAXI_0_ar_bits_user),
    .io_memAXI_0_ar_bits_len(core_io_memAXI_0_ar_bits_len),
    .io_memAXI_0_ar_bits_size(core_io_memAXI_0_ar_bits_size),
    .io_memAXI_0_ar_bits_burst(core_io_memAXI_0_ar_bits_burst),
    .io_memAXI_0_ar_bits_lock(core_io_memAXI_0_ar_bits_lock),
    .io_memAXI_0_ar_bits_cache(core_io_memAXI_0_ar_bits_cache),
    .io_memAXI_0_ar_bits_qos(core_io_memAXI_0_ar_bits_qos),
    .io_memAXI_0_r_ready(core_io_memAXI_0_r_ready),
    .io_memAXI_0_r_valid(core_io_memAXI_0_r_valid),
    .io_memAXI_0_r_bits_resp(core_io_memAXI_0_r_bits_resp),
    .io_memAXI_0_r_bits_data(core_io_memAXI_0_r_bits_data),
    .io_memAXI_0_r_bits_last(core_io_memAXI_0_r_bits_last),
    .io_memAXI_0_r_bits_id(core_io_memAXI_0_r_bits_id),
    .io_memAXI_0_r_bits_user(core_io_memAXI_0_r_bits_user)
  );
  assign io_master_awvalid = core_io_memAXI_0_aw_valid; // @[Core.scala 89:32]
  assign io_master_awaddr = core_io_memAXI_0_aw_bits_addr[31:0]; // @[Core.scala 90:32]
  assign io_master_awid = core_io_memAXI_0_aw_bits_id; // @[Core.scala 91:32]
  assign io_master_awlen = core_io_memAXI_0_aw_bits_len; // @[Core.scala 92:32]
  assign io_master_awsize = core_io_memAXI_0_aw_bits_size; // @[Core.scala 93:32]
  assign io_master_awburst = core_io_memAXI_0_aw_bits_burst; // @[Core.scala 94:32]
  assign io_master_wvalid = core_io_memAXI_0_w_valid; // @[Core.scala 97:32]
  assign io_master_wdata = core_io_memAXI_0_w_bits_data; // @[Core.scala 98:32]
  assign io_master_wstrb = core_io_memAXI_0_w_bits_strb; // @[Core.scala 99:32]
  assign io_master_wlast = core_io_memAXI_0_w_bits_last; // @[Core.scala 100:32]
  assign io_master_bready = core_io_memAXI_0_b_ready; // @[Core.scala 102:35]
  assign io_master_arvalid = core_io_memAXI_0_ar_valid; // @[Core.scala 108:32]
  assign io_master_araddr = core_io_memAXI_0_ar_bits_addr[31:0]; // @[Core.scala 109:32]
  assign io_master_arid = core_io_memAXI_0_ar_bits_id; // @[Core.scala 110:32]
  assign io_master_arlen = core_io_memAXI_0_ar_bits_len; // @[Core.scala 111:32]
  assign io_master_arsize = core_io_memAXI_0_ar_bits_size; // @[Core.scala 112:32]
  assign io_master_arburst = core_io_memAXI_0_ar_bits_burst; // @[Core.scala 113:32]
  assign io_master_rready = core_io_memAXI_0_r_ready; // @[Core.scala 115:35]
  assign io_slave_awready = 1'h0; // @[Core.scala 122:36 Core.scala 122:36]
  assign io_slave_wready = 1'h0; // @[Core.scala 122:36 Core.scala 122:36]
  assign io_slave_bvalid = 1'h0; // @[Core.scala 122:36 Core.scala 122:36]
  assign io_slave_bresp = 2'h0; // @[Core.scala 122:36 Core.scala 122:36]
  assign io_slave_bid = 4'h0; // @[Core.scala 122:36 Core.scala 122:36]
  assign io_slave_arready = 1'h0; // @[Core.scala 122:36 Core.scala 122:36]
  assign io_slave_rvalid = 1'h0; // @[Core.scala 122:36 Core.scala 122:36]
  assign io_slave_rresp = 2'h0; // @[Core.scala 122:36 Core.scala 122:36]
  assign io_slave_rdata = 64'h0; // @[Core.scala 122:36 Core.scala 122:36]
  assign io_slave_rlast = 1'h0; // @[Core.scala 122:36 Core.scala 122:36]
  assign io_slave_rid = 4'h0; // @[Core.scala 122:36 Core.scala 122:36]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_memAXI_0_aw_ready = io_master_awready; // @[Core.scala 88:32]
  assign core_io_memAXI_0_w_ready = io_master_wready; // @[Core.scala 96:32]
  assign core_io_memAXI_0_b_valid = io_master_bvalid; // @[Core.scala 103:35]
  assign core_io_memAXI_0_b_bits_resp = io_master_bresp; // @[Core.scala 104:35]
  assign core_io_memAXI_0_b_bits_id = io_master_bid; // @[Core.scala 105:35]
  assign core_io_memAXI_0_b_bits_user = 1'h0; // @[Core.scala 125:35]
  assign core_io_memAXI_0_ar_ready = io_master_arready; // @[Core.scala 107:32]
  assign core_io_memAXI_0_r_valid = io_master_rvalid; // @[Core.scala 116:35]
  assign core_io_memAXI_0_r_bits_resp = io_master_rresp; // @[Core.scala 117:35]
  assign core_io_memAXI_0_r_bits_data = io_master_rdata; // @[Core.scala 118:35]
  assign core_io_memAXI_0_r_bits_last = io_master_rlast; // @[Core.scala 119:35]
  assign core_io_memAXI_0_r_bits_id = io_master_rid; // @[Core.scala 120:35]
  assign core_io_memAXI_0_r_bits_user = 1'h0; // @[Core.scala 126:35]
endmodule

module Compute_S1
(
  input  wire	[(`N*`SYMBOL_WIDTH)-1:0] v,
  output wire	[`SYMBOL_WIDTH-1:0]      s1
);
  
  wire [(`SYMBOL_WIDTH)-1:0] m1_out;
  wire [(`SYMBOL_WIDTH)-1:0] m2_out;
  wire [(`SYMBOL_WIDTH)-1:0] m3_out;
  wire [(`SYMBOL_WIDTH)-1:0] m4_out;
  wire [(`SYMBOL_WIDTH)-1:0] m5_out;
  wire [(`SYMBOL_WIDTH)-1:0] m6_out;
  wire [(`SYMBOL_WIDTH)-1:0] m7_out;
  wire [(`SYMBOL_WIDTH)-1:0] m8_out;
  wire [(`SYMBOL_WIDTH)-1:0] m9_out;
  wire [(`SYMBOL_WIDTH)-1:0] m10_out;
  wire [(`SYMBOL_WIDTH)-1:0] m11_out;
  wire [(`SYMBOL_WIDTH)-1:0] m12_out;
  wire [(`SYMBOL_WIDTH)-1:0] m13_out;
  wire [(`SYMBOL_WIDTH)-1:0] m14_out;
  wire [(`SYMBOL_WIDTH)-1:0] m15_out;
  wire [(`SYMBOL_WIDTH)-1:0] m16_out;
  wire [(`SYMBOL_WIDTH)-1:0] m17_out;
  
  wire [(`SYMBOL_WIDTH)-1:0] a01_out;
  wire [(`SYMBOL_WIDTH)-1:0] a23_out;
  wire [(`SYMBOL_WIDTH)-1:0] a45_out;
  wire [(`SYMBOL_WIDTH)-1:0] a67_out;
  wire [(`SYMBOL_WIDTH)-1:0] a89_out;
  wire [(`SYMBOL_WIDTH)-1:0] a1011_out;
  wire [(`SYMBOL_WIDTH)-1:0] a1213_out;
  wire [(`SYMBOL_WIDTH)-1:0] a1415_out;
  wire [(`SYMBOL_WIDTH)-1:0] a1617_out;
  
  wire [(`SYMBOL_WIDTH)-1:0] a03_out;
  wire [(`SYMBOL_WIDTH)-1:0] a47_out;
  wire [(`SYMBOL_WIDTH)-1:0] a811_out;
  wire [(`SYMBOL_WIDTH)-1:0] a1215_out;
  
  wire [(`SYMBOL_WIDTH)-1:0] a07_out;
  wire [(`SYMBOL_WIDTH)-1:0] a815_out;
  wire [(`SYMBOL_WIDTH)-1:0] a817_out;
  wire [(`SYMBOL_WIDTH)-1:0] a017_out;
    
  
  GF_Multiplier m1(.in0(v[15:8]),  .in1(8'd2), .out(m1_out));
  GF_Multiplier m2(.in0(v[23:16]), .in1(8'd3), .out(m2_out));
  GF_Multiplier m3(.in0(v[31:24]), .in1(8'd4), .out(m3_out));
  GF_Multiplier m4(.in0(v[39:32]), .in1(8'd4), .out(m4_out));
  GF_Multiplier m5(.in0(v[47:40]), .in1(8'd5), .out(m5_out));
  GF_Multiplier m6(.in0(v[55:48]), .in1(8'd6), .out(m6_out));
  GF_Multiplier m7(.in0(v[63:56]), .in1(8'd7), .out(m7_out));
  GF_Multiplier m8(.in0(v[71:64]), .in1(8'd8), .out(m8_out));
  GF_Multiplier m9(.in0(v[79:72]), .in1(8'd9), .out(m9_out));
  GF_Multiplier m10(.in0(v[87:80]), .in1(8'd10), .out(m10_out));
  GF_Multiplier m11(.in0(v[95:88]), .in1(8'd11), .out(m11_out));
  GF_Multiplier m12(.in0(v[103:96]), .in1(8'd12), .out(m12_out));
  GF_Multiplier m13(.in0(v[111:104]), .in1(8'd13), .out(m13_out));
  GF_Multiplier m14(.in0(v[119:112]), .in1(8'd14), .out(m14_out));
  GF_Multiplier m15(.in0(v[127:120]), .in1(8'd15), .out(m15_out));
  GF_Multiplier m16(.in0(v[135:128]), .in1(8'd16), .out(m16_out));
  GF_Multiplier m17(.in0(v[143:136]), .in1(8'd17), .out(m17_out));
  
  GF_Adder a01(.in0(v[7:0]), .in1(m1_out), .out(a01_out));
  GF_Adder a23(.in0(m2_out), .in1(m3_out), .out(a23_out));
  GF_Adder a45(.in0(m4_out), .in1(m5_out), .out(a45_out));
  GF_Adder a67(.in0(m6_out), .in1(m7_out), .out(a67_out));
  GF_Adder a89(.in0(m8_out), .in1(m9_out), .out(a89_out));
  GF_Adder a1011(.in0(m10_out), .in1(m11_out), .out(a1011_out));
  GF_Adder a1213(.in0(m12_out), .in1(m13_out), .out(a1213_out));
  GF_Adder a1415(.in0(m14_out), .in1(m15_out), .out(a1415_out));
  GF_Adder a1617(.in0(m16_out), .in1(m17_out), .out(a1617_out));
  
  GF_Adder a03(.in0(a01_out), .in1(a23_out), .out(a03_out));
  GF_Adder a47(.in0(a45_out), .in1(a67_out), .out(a47_out));
  GF_Adder a811(.in0(a89_out), .in1(a89_out), .out(a811_out));
  GF_Adder a1215(.in0(a1213_out), .in1(a1415_out), .out(a1215_out));
  
  GF_Adder a07(.in0(a03_out), .in1(a47_out), .out(a07_out));
  GF_Adder a815(.in0(a811_out), .in1(a1215_out), .out(a815_out));
  GF_Adder a817(.in0(a815_out), .in1(a1617_out), .out(a817_out));
  GF_Adder a017(.in0(a07_out), .in1(a817_out), .out(s1));
  
  
endmodule
  
module Compute_S2
(
  input  wire	[(`N*`SYMBOL_WIDTH)-1:0] v,
  output wire	[`SYMBOL_WIDTH-1:0]      s2
);
  
    wire [(`SYMBOL_WIDTH)-1:0] m1_out;
  wire [(`SYMBOL_WIDTH)-1:0] m2_out;
  wire [(`SYMBOL_WIDTH)-1:0] m3_out;
  wire [(`SYMBOL_WIDTH)-1:0] m4_out;
  wire [(`SYMBOL_WIDTH)-1:0] m5_out;
  wire [(`SYMBOL_WIDTH)-1:0] m6_out;
  wire [(`SYMBOL_WIDTH)-1:0] m7_out;
  wire [(`SYMBOL_WIDTH)-1:0] m8_out;
  wire [(`SYMBOL_WIDTH)-1:0] m9_out;
  wire [(`SYMBOL_WIDTH)-1:0] m10_out;
  wire [(`SYMBOL_WIDTH)-1:0] m11_out;
  wire [(`SYMBOL_WIDTH)-1:0] m12_out;
  wire [(`SYMBOL_WIDTH)-1:0] m13_out;
  wire [(`SYMBOL_WIDTH)-1:0] m14_out;
  wire [(`SYMBOL_WIDTH)-1:0] m15_out;
  wire [(`SYMBOL_WIDTH)-1:0] m16_out;
  wire [(`SYMBOL_WIDTH)-1:0] m17_out;
  
  wire [(`SYMBOL_WIDTH)-1:0] a01_out;
  wire [(`SYMBOL_WIDTH)-1:0] a23_out;
  wire [(`SYMBOL_WIDTH)-1:0] a45_out;
  wire [(`SYMBOL_WIDTH)-1:0] a67_out;
  wire [(`SYMBOL_WIDTH)-1:0] a89_out;
  wire [(`SYMBOL_WIDTH)-1:0] a1011_out;
  wire [(`SYMBOL_WIDTH)-1:0] a1213_out;
  wire [(`SYMBOL_WIDTH)-1:0] a1415_out;
  wire [(`SYMBOL_WIDTH)-1:0] a1617_out;
  
  wire [(`SYMBOL_WIDTH)-1:0] a03_out;
  wire [(`SYMBOL_WIDTH)-1:0] a47_out;
  wire [(`SYMBOL_WIDTH)-1:0] a811_out;
  wire [(`SYMBOL_WIDTH)-1:0] a1215_out;
  
  wire [(`SYMBOL_WIDTH)-1:0] a07_out;
  wire [(`SYMBOL_WIDTH)-1:0] a815_out;
  wire [(`SYMBOL_WIDTH)-1:0] a817_out;
  wire [(`SYMBOL_WIDTH)-1:0] a017_out;
    
  
  GF_Multiplier m1(.in0(v[15:8]),  .in1(8'd2), .out(m1_out));
  GF_Multiplier m2(.in0(v[23:16]), .in1(8'd4), .out(m2_out));
  GF_Multiplier m3(.in0(v[31:24]), .in1(8'd6), .out(m3_out));
  GF_Multiplier m4(.in0(v[39:32]), .in1(8'd8), .out(m4_out));
  GF_Multiplier m5(.in0(v[47:40]), .in1(8'd10), .out(m5_out));
  GF_Multiplier m6(.in0(v[55:48]), .in1(8'd12), .out(m6_out));
  GF_Multiplier m7(.in0(v[63:56]), .in1(8'd14), .out(m7_out));
  GF_Multiplier m8(.in0(v[71:64]), .in1(8'd16), .out(m8_out));
  GF_Multiplier m9(.in0(v[79:72]), .in1(8'd18), .out(m9_out));
  GF_Multiplier m10(.in0(v[87:80]), .in1(8'd20), .out(m10_out));
  GF_Multiplier m11(.in0(v[95:88]), .in1(8'd22), .out(m11_out));
  GF_Multiplier m12(.in0(v[103:96]), .in1(8'd24), .out(m12_out));
  GF_Multiplier m13(.in0(v[111:104]), .in1(8'd26), .out(m13_out));
  GF_Multiplier m14(.in0(v[119:112]), .in1(8'd28), .out(m14_out));
  GF_Multiplier m15(.in0(v[127:120]), .in1(8'd30), .out(m15_out));
  GF_Multiplier m16(.in0(v[135:128]), .in1(8'd32), .out(m16_out));
  GF_Multiplier m17(.in0(v[143:136]), .in1(8'd34), .out(m17_out));
  
  GF_Adder a01(.in0(v[7:0]), .in1(m1_out), .out(a01_out));
  GF_Adder a23(.in0(m2_out), .in1(m3_out), .out(a23_out));
  GF_Adder a45(.in0(m4_out), .in1(m5_out), .out(a45_out));
  GF_Adder a67(.in0(m6_out), .in1(m7_out), .out(a67_out));
  GF_Adder a89(.in0(m8_out), .in1(m9_out), .out(a89_out));
  GF_Adder a1011(.in0(m10_out), .in1(m11_out), .out(a1011_out));
  GF_Adder a1213(.in0(m12_out), .in1(m13_out), .out(a1213_out));
  GF_Adder a1415(.in0(m14_out), .in1(m15_out), .out(a1415_out));
  GF_Adder a1617(.in0(m16_out), .in1(m17_out), .out(a1617_out));
  
  GF_Adder a03(.in0(a01_out), .in1(a23_out), .out(a03_out));
  GF_Adder a47(.in0(a45_out), .in1(a67_out), .out(a47_out));
  GF_Adder a811(.in0(a89_out), .in1(a89_out), .out(a811_out));
  GF_Adder a1215(.in0(a1213_out), .in1(a1415_out), .out(a1215_out));
  
  GF_Adder a07(.in0(a03_out), .in1(a47_out), .out(a07_out));
  GF_Adder a815(.in0(a811_out), .in1(a1215_out), .out(a815_out));
  GF_Adder a817(.in0(a815_out), .in1(a1617_out), .out(a817_out));
  GF_Adder a017(.in0(a07_out), .in1(a817_out), .out(s1));
  
  
endmodule


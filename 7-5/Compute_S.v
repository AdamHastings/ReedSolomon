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
  
  wire [(`SYMBOL_WIDTH)-1:0] a12_out;
  wire [(`SYMBOL_WIDTH)-1:0] a34_out;
  wire [(`SYMBOL_WIDTH)-1:0] a56_out;
  
  wire [(`SYMBOL_WIDTH)-1:0] a36_out;
  wire [(`SYMBOL_WIDTH)-1:0] a02_out;
    
  
  GF_Multiplier m1(.in0(v[5:3]),   .in1(3'd2), .out(m1_out));
  GF_Multiplier m2(.in0(v[8:6]),   .in1(3'd3), .out(m2_out));
  GF_Multiplier m3(.in0(v[11:9]),  .in1(3'd4), .out(m3_out));
  GF_Multiplier m4(.in0(v[14:12]), .in1(3'd5), .out(m4_out));
  GF_Multiplier m5(.in0(v[17:15]), .in1(3'd6), .out(m5_out));
  GF_Multiplier m6(.in0(v[20:18]), .in1(3'd7), .out(m6_out));
  
  GF_Adder a12(.in0(m1_out), .in1(m2_out), .out(a12_out));
  GF_Adder a34(.in0(m3_out), .in1(m4_out), .out(a34_out));
  GF_Adder a56(.in0(m5_out), .in1(m6_out), .out(a56_out));
  GF_Adder a36(.in0(a34_out), .in1(a56_out), .out(a36_out));
  GF_Adder a02(.in0(a12_out), .in1(v[2:0]), .out(a02_out));
  GF_Adder a06(.in0(a02_out), .in1(a36_out), .out(s1));
  
  
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
  
  wire [(`SYMBOL_WIDTH)-1:0] a12_out;
  wire [(`SYMBOL_WIDTH)-1:0] a34_out;
  wire [(`SYMBOL_WIDTH)-1:0] a56_out;
  
  wire [(`SYMBOL_WIDTH)-1:0] a36_out;
  wire [(`SYMBOL_WIDTH)-1:0] a02_out;
    
  
  GF_Multiplier m1(.in0(v[5:3]),   .in1(3'd3), .out(m1_out));
  GF_Multiplier m2(.in0(v[8:6]),   .in1(3'd5), .out(m2_out));
  GF_Multiplier m3(.in0(v[11:9]),  .in1(3'd7), .out(m3_out));
  GF_Multiplier m4(.in0(v[14:12]), .in1(3'd2), .out(m4_out));
  GF_Multiplier m5(.in0(v[17:15]), .in1(3'd4), .out(m5_out));
  GF_Multiplier m6(.in0(v[20:18]), .in1(3'd6), .out(m6_out));
  
  GF_Adder a12(.in0(m1_out), .in1(m2_out), .out(a12_out));
  GF_Adder a34(.in0(m3_out), .in1(m4_out), .out(a34_out));
  GF_Adder a56(.in0(m5_out), .in1(m6_out), .out(a56_out));
  GF_Adder a36(.in0(a34_out), .in1(a56_out), .out(a36_out));
  GF_Adder a02(.in0(a12_out), .in1(v[2:0]), .out(a02_out));
  GF_Adder a06(.in0(a02_out), .in1(a36_out), .out(s2));
  
  
endmodule


`define SYMBOL_WIDTH 3
`define N 7
`define K 5


module RS_Encoder
(
  input wire [(`SYMBOL_WIDTH * `K)-1:0] in,
  output wire [(`SYMBOL_WIDTH * `N)-1:0] out
);
  
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_0;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_1;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_2;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_3;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_4;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_5;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_6;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_7;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_8;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_9;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_10;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_11;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_12;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_13;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_14;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_15;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_16;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_17;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_18;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_19;
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_20;
  
  assign G_row_0  = 15'b100000000000000;
  assign G_row_1  = 15'b010000000000000;
  assign G_row_2  = 15'b001000000000000;
  assign G_row_3  = 15'b000100000000000;
  assign G_row_4  = 15'b000010000000000;
  assign G_row_5  = 15'b000001000000000;
  assign G_row_6  = 15'b000000100000000;
  assign G_row_7  = 15'b000000010000000;
  assign G_row_8  = 15'b000000001000000;
  assign G_row_9  = 15'b000000000100000;
  assign G_row_10 = 15'b000000000010000;
  assign G_row_11 = 15'b000000000001000;
  assign G_row_12 = 15'b000000000000100;
  assign G_row_13 = 15'b000000000000010;
  assign G_row_14 = 15'b000000000000001;
  assign G_row_15 = 15'b011111111100011;
  assign G_row_16 = 15'b110100100010110;
  assign G_row_17 = 15'b111110110001111;
  assign G_row_18 = 15'b001001101100101;
  assign G_row_19 = 15'b101101111010111;
  assign G_row_20 = 15'b010010011001011;
  
  
  assign out[20] =^(in & G_row_0)  ;
  assign out[19] =^(in & G_row_1)  ;
  assign out[18] =^(in & G_row_2)  ;
  assign out[17] =^(in & G_row_3)  ;
  assign out[16] =^(in & G_row_4)  ;
  assign out[15] =^(in & G_row_5)  ;
  assign out[14] =^(in & G_row_6)  ;
  assign out[13] =^(in & G_row_7)  ;
  assign out[12] =^(in & G_row_8)  ;
  assign out[11] =^(in & G_row_9)  ;
  assign out[10] =^(in & G_row_10) ;
  assign out[9]  =^(in & G_row_11) ;
  assign out[8]  =^(in & G_row_12) ;
  assign out[7]  =^(in & G_row_13) ;
  assign out[6]  =^(in & G_row_14) ;
  assign out[5]  =^(in & G_row_15) ;
  assign out[4]  =^(in & G_row_16) ;
  assign out[3]  =^(in & G_row_17) ;
  assign out[2]  =^(in & G_row_18) ;
  assign out[1]  =^(in & G_row_19) ;
  assign out[0]  =^(in & G_row_20) ;
  
  
endmodule


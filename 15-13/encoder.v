//`define SYMBOL_WIDTH 8
//`define N 18
//`define K 16


module RS_Encoder
(
  input [(`SYMBOL_WIDTH * `K)-1:0] in,
  output [(`SYMBOL_WIDTH * `N)-1:0] out
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
  wire  [(`SYMBOL_WIDTH * `N):0] G_row_21;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_22;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_23;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_24;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_25;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_26;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_27;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_28;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_29;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_30;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_31;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_32;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_33;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_34;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_35;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_36;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_37;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_38;
wire  [(`SYMBOL_WIDTH * `N):0] G_row_39;


assign G_row_0 = 32'b10000011000001000000000000000011;
assign G_row_1 = 32'b00000100000000001000000101101000;
assign G_row_2 = 32'b10001000000001000000011000000011;
assign G_row_3 = 32'b00100000000010001000000101101011;
assign G_row_4 = 32'b01000100100000001110000001100001;
assign G_row_5 = 32'b00000011000100000000000000000110;
assign G_row_6 = 32'b01100000100011001010000011000001;
assign G_row_7 = 32'b10011000000011000000011000000000;
assign G_row_8 = 32'b01000001100001000100000101000011;
assign G_row_9 = 32'b00000001100000001000000111100001;
assign G_row_10 = 32'b10000000110110100000000000000110;
assign G_row_11 = 32'b11000000000001001100000000000010;
assign G_row_12 = 32'b00000000000000100011110000000001;
assign G_row_13 = 32'b11000001001001000100000110001111;
assign G_row_14 = 32'b01000001000000000000001010000000;
assign G_row_15 = 32'b10010000010001100000000001100000;
assign G_row_16 = 32'b10010000100000100000000001100001;
assign G_row_17 = 32'b00000000010000100000110000110001;
assign G_row_18 = 32'b01100000001010001000000000001111;
assign G_row_19 = 32'b01000000000000000000001100000000;
assign G_row_20 = 32'b00000000000010001000000101000110;
assign G_row_21 = 32'b00010000000001000000110000000001;
assign G_row_22 = 32'b00000000000000000011101000000000;
assign G_row_23 = 32'b00000100000000000000000101000000;
assign G_row_24 = 32'b00000000000000000000000000001111;
assign G_row_25 = 32'b00100100110000000000000000000101;
assign G_row_26 = 32'b00000000001001100001010000011000;
assign G_row_27 = 32'b01000000010000001000101010010000;
assign G_row_28 = 32'b01000000000000011000110010100001;
assign G_row_29 = 32'b00001100000000000000000000001111;
assign G_row_30 = 32'b00000000111000000000000000011000;
assign G_row_31 = 32'b01010000001011000001100000011000;
assign G_row_32 = 32'b01010000001111000001100000000000;
assign G_row_33 = 32'b00000010000000010000111100000001;
assign G_row_34 = 32'b00001000000000011000000000101000;
assign G_row_35 = 32'b01000000001000000000000000011000;
assign G_row_36 = 32'b01000000000000000000000000000000;
assign G_row_37 = 32'b00000100001100000111100000000000;
assign G_row_38 = 32'b00000010000001000000001110100011;
assign G_row_39 = 32'b00000000000000010000000000000000;
  
/*
assign out[143]  =^(in & G_row_0) ;
assign out[142]  =^(in & G_row_1) ;
assign out[141]  =^(in & G_row_2) ;
assign out[140]  =^(in & G_row_3) ;
assign out[139]  =^(in & G_row_4) ;
assign out[138]  =^(in & G_row_5) ;
assign out[137]  =^(in & G_row_6) ;
assign out[136]  =^(in & G_row_7) ;
assign out[135]  =^(in & G_row_8) ;
assign out[134]  =^(in & G_row_9) ;
assign out[133]  =^(in & G_row_10) ;
assign out[132]  =^(in & G_row_11) ;
assign out[131]  =^(in & G_row_12) ;
assign out[130]  =^(in & G_row_13) ;
assign out[129]  =^(in & G_row_14) ;
assign out[128]  =^(in & G_row_15) ;
assign out[127]  =^(in & G_row_16) ;
assign out[126]  =^(in & G_row_17) ;
assign out[125]  =^(in & G_row_18) ;
assign out[124]  =^(in & G_row_19) ;
assign out[123]  =^(in & G_row_20) ;
assign out[122]  =^(in & G_row_21) ;
assign out[121]  =^(in & G_row_22) ;
assign out[120]  =^(in & G_row_23) ;
assign out[119]  =^(in & G_row_24) ;
assign out[118]  =^(in & G_row_25) ;
assign out[117]  =^(in & G_row_26) ;
assign out[116]  =^(in & G_row_27) ;
assign out[115]  =^(in & G_row_28) ;
assign out[114]  =^(in & G_row_29) ;
assign out[113]  =^(in & G_row_30) ;
assign out[112]  =^(in & G_row_31) ;
assign out[111]  =^(in & G_row_32) ;
assign out[110]  =^(in & G_row_33) ;
assign out[109]  =^(in & G_row_34) ;
assign out[108]  =^(in & G_row_35) ;
assign out[107]  =^(in & G_row_36) ;
assign out[106]  =^(in & G_row_37) ;
assign out[105]  =^(in & G_row_38) ;
assign out[104]  =^(in & G_row_39) ;
*/
  
assign out[0]  =^(in & G_row_0) ;
assign out[1]  =^(in & G_row_1) ;
assign out[2]  =^(in & G_row_2) ;
assign out[3]  =^(in & G_row_3) ;
assign out[4]  =^(in & G_row_4) ;
assign out[5]  =^(in & G_row_5) ;
assign out[6]  =^(in & G_row_6) ;
assign out[7]  =^(in & G_row_7) ;
assign out[8]  =^(in & G_row_8) ;
assign out[9]  =^(in & G_row_9) ;
assign out[10]  =^(in & G_row_10) ;
assign out[11]  =^(in & G_row_11) ;
assign out[12]  =^(in & G_row_12) ;
assign out[13]  =^(in & G_row_13) ;
assign out[14]  =^(in & G_row_14) ;
assign out[15]  =^(in & G_row_15) ;
assign out[16]  =^(in & G_row_16) ;
assign out[17]  =^(in & G_row_17) ;
assign out[18]  =^(in & G_row_18) ;
assign out[19]  =^(in & G_row_19) ;
assign out[20]  =^(in & G_row_20) ;
assign out[21]  =^(in & G_row_21) ;
assign out[22]  =^(in & G_row_22) ;
assign out[23]  =^(in & G_row_23) ;
assign out[24]  =^(in & G_row_24) ;
assign out[25]  =^(in & G_row_25) ;
assign out[26]  =^(in & G_row_26) ;
assign out[27]  =^(in & G_row_27) ;
assign out[28]  =^(in & G_row_28) ;
assign out[29]  =^(in & G_row_29) ;
assign out[30]  =^(in & G_row_30) ;
assign out[31]  =^(in & G_row_31) ;
assign out[32]  =^(in & G_row_32) ;
assign out[33]  =^(in & G_row_33) ;
assign out[34]  =^(in & G_row_34) ;
assign out[35]  =^(in & G_row_35) ;
assign out[36]  =^(in & G_row_36) ;
assign out[37]  =^(in & G_row_37) ;
assign out[38]  =^(in & G_row_38) ;
assign out[39]  =^(in & G_row_39) ;

  
endmodule

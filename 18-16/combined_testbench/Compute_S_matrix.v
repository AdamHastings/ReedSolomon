module Compute_S
(
  input  wire [(`N*`SYMBOL_WIDTH)-1:0] v,
  output wire [`SYMBOL_WIDTH-1:0]      s1,
  output wire [`SYMBOL_WIDTH-1:0]      s2
);
  
  wire  [143:0] H_row_0;
  wire  [143:0] H_row_1;
  wire  [143:0] H_row_2;
  wire  [143:0] H_row_3;
  wire  [143:0] H_row_4;
  wire  [143:0] H_row_5;
  wire  [143:0] H_row_6;
  wire  [143:0] H_row_7;
  wire  [143:0] H_row_8;
  wire  [143:0] H_row_9;
  wire  [143:0] H_row_10;
  wire  [143:0] H_row_11;
  wire  [143:0] H_row_12;
  wire  [143:0] H_row_13;
  wire  [143:0] H_row_14;
  wire  [143:0] H_row_15;
  
assign H_row_0 = 144'b010010110010010100010010100010011100010011100010011100010011100000011100100011100100011100100011000100010000100000000100000000100000000110000000;
assign H_row_1 = 144'b001001010001001010001001110001001110001001110001001110000001110010001110010001110010001100010001000010000000010000000010000000011000000001000000;
assign H_row_2 = 144'b010110011010110011010110011010111011010111011010011011011011011001011011101011010101011000101011000101010000101000000101100000100100000100100000;
assign H_row_3 = 144'b111001111111001101111001001111000001111010001111110001110110001110110001110110000110110000110110000110110000110110000110010000110010000100010000;
assign H_row_4 = 144'b101110000101110000101110100101110100101100100101000100101000100111000100111000100111000100111000000111001000111001000111001000110001000100001000;
assign H_row_5 = 144'b010111000010111010010111010010110010010100010010100010011100010011100010011100010011100000011100100011100100011100100011000100010000100000000100;
assign H_row_6 = 144'b001011101001011101001011001001010001001010001001110001001110001001110001001110000001110010001110010001110010001100010001000010000000010000000010;
assign H_row_7 = 144'b100101110100101100100101000100101000100111000100111000100111000100111000000111001000111001000111001000110001000100001000000001000000001000000001;
assign H_row_8 = 144'b001001001100100100110010000011000000001111000000011100000101110010010111001001011000100111100010001110001000111000100011000010000000001010000000;
assign H_row_9 = 144'b100100100110010000011001000001101000000111100000101110000010111001001011000100101100010001110001000111000100011100010001000001000000000101000000;
assign H_row_10 = 144'b111011011111101100111110000011111100001110110000001011001100101110110010101011000110101111011010101101101010110100101011000010101000001000100000;
assign H_row_11 = 144'b110100101011010000101101100010110110001010011000111001100011100111001110111100110011110010001111011000111101100000110110000011010100001100010000;
assign H_row_12 = 144'b010011011001001100100100110010010011001000001100000000111100000001110000010111001001011100100101100010011110001000111000100011100010001100001000;
assign H_row_13 = 144'b001001100100100110010010011001000001100100000110100000011110000010111000001011100100101100010010110001000111000100011100010001110001000100000100;
assign H_row_14 = 144'b100100110010010011001001001100100000110000000011110000000111000001011100100101110010010110001001111000100011100010001110001000110000100000000010;
assign H_row_15 = 144'b010010011001001001100100000110010000011010000001111000001011100000101110010010110001001011000100011100010001110001000111000100010000010000000001;
  
  assign s1[0] =^(v & H_row_0) ;
  assign s1[1] =^(v & H_row_1) ;
  assign s1[2] =^(v & H_row_2) ;
  assign s1[3] =^(v & H_row_3) ;
  assign s1[4] =^(v & H_row_4) ;
  assign s1[5] =^(v & H_row_5) ;
  assign s1[6] =^(v & H_row_6)  ;
  assign s1[7] =^(v & H_row_7)  ;
  assign s2[0] =^(v & H_row_8)  ;
  assign s2[1] =^(v & H_row_9)  ;
  assign s2[2] =^(v & H_row_10) ;
  assign s2[3] =^(v & H_row_11) ;
  assign s2[4] =^(v & H_row_12) ;
  assign s2[5] =^(v & H_row_13) ;
  assign s2[6] =^(v & H_row_14) ;
  assign s2[7] =^(v & H_row_15) ;
  
endmodule
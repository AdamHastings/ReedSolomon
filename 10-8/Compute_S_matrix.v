module Compute_S
(
  input  wire [(`N*`SYMBOL_WIDTH)-1:0] v,
  output wire [`SYMBOL_WIDTH-1:0]      s1,
  output wire [`SYMBOL_WIDTH-1:0]      s2
);
  
  wire  [(`SYMBOL_WIDTH * `N)-1:0] H_row_0;
  wire  [(`SYMBOL_WIDTH * `N)-1:0] H_row_1;
  wire  [(`SYMBOL_WIDTH * `N)-1:0] H_row_2;
  wire  [(`SYMBOL_WIDTH * `N)-1:0] H_row_3;
  wire  [(`SYMBOL_WIDTH * `N)-1:0] H_row_4;
  wire  [(`SYMBOL_WIDTH * `N)-1:0] H_row_5;
  wire  [(`SYMBOL_WIDTH * `N)-1:0] H_row_6;
  wire  [(`SYMBOL_WIDTH * `N)-1:0] H_row_7;
  
assign H_row_0 = 40'b0101101011010110001110010100001000011000;
assign H_row_1 = 40'b1111011110110101101011010110001110010100;
assign H_row_2 = 40'b0111101101011010110101100011100101000010;
assign H_row_3 = 40'b1011010110101101011000111001010000100001;
assign H_row_4 = 40'b0100000111001111101110100110100100101000;
assign H_row_5 = 40'b0110100100101000111001110101110100110100;
assign H_row_6 = 40'b0011010000011100111110111010011010010010;
assign H_row_7 = 40'b1001001010001110011101011101001101000001;
  
  
  /*
  assign s1[0] =^(v & H_row_0) ;
  assign s1[1] =^(v & H_row_1) ;
  assign s1[2] =^(v & H_row_2) ;
  assign s1[3] =^(v & H_row_3) ;
  assign s2[0] =^(v & H_row_4) ;
  assign s2[1] =^(v & H_row_5) ;
  assign s2[2] =^(v & H_row_6) ;
  assign s2[3] =^(v & H_row_7) ;
  */
  
  
  assign s1[3] =^(v & H_row_0) ;
  assign s1[2] =^(v & H_row_1) ;
  assign s1[1] =^(v & H_row_2) ;
  assign s1[0] =^(v & H_row_3) ;
  assign s2[3] =^(v & H_row_4) ;
  assign s2[2] =^(v & H_row_5) ;
  assign s2[1] =^(v & H_row_6) ;
  assign s2[0] =^(v & H_row_7) ;
  
  
endmodule
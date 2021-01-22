module Compute_S
(
  input  wire [(`N*`SYMBOL_WIDTH)-1:0] v,
  output wire [`SYMBOL_WIDTH-1:0]      s1,
  output wire [`SYMBOL_WIDTH-1:0]      s2
);
  
  wire  [21:0] H_row_0;
  wire  [21:0] H_row_1;
  wire  [21:0] H_row_2;
  wire  [21:0] H_row_3;
  wire  [21:0] H_row_4;
  wire  [21:0] H_row_5;
  
assign H_row_0 = 21'b011111111100011100000;
assign H_row_1 = 21'b110100100010110010000;
assign H_row_2 = 21'b111110110001111001000;
assign H_row_3 = 21'b001001101100101000100;
assign H_row_4 = 21'b101101111010111000010;
assign H_row_5 = 21'b010010011001011000001;
  
  assign s1[0] =^(v & H_row_0) ;
  assign s1[1] =^(v & H_row_1) ;
  assign s1[2] =^(v & H_row_2) ;
  assign s2[0] =^(v & H_row_3) ;
  assign s2[1] =^(v & H_row_4) ;
  assign s2[2] =^(v & H_row_5) ;
  
endmodule
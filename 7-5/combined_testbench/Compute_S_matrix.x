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
  
assign H_row_0 = 21'b110111011101010001100;
assign H_row_1 = 21'b001100110111011101010;
assign H_row_2 = 21'b100110111011101010001;
assign H_row_3 = 21'b111101001110011010100;
assign H_row_4 = 21'b100111101001110011010;
assign H_row_5 = 21'b110011010100111101001;
  
  assign s1[0] =^(v & H_row_0) ;
  assign s1[1] =^(v & H_row_1) ;
  assign s1[2] =^(v & H_row_2) ;
  assign s2[0] =^(v & H_row_3) ;
  assign s2[1] =^(v & H_row_4) ;
  assign s2[2] =^(v & H_row_5) ;
  
endmodule

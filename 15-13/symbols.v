`define SYMBOL_WIDTH 4
`define N 15
`define K 13

module Symbol_Lookup
(
  input   wire [`SYMBOL_WIDTH-1:0] in,
  output  reg  [`SYMBOL_WIDTH-1:0] out
);
  always @* begin
    case(in)
      4'd0  : out <= 4'b0000;
      4'd1  : out <= 4'b1000;
      4'd2  : out <= 4'b0100;
      4'd3  : out <= 4'b0010;
      4'd4  : out <= 4'b0001;
      4'd5  : out <= 4'b1100;
      4'd6  : out <= 4'b0110;
      4'd7  : out <= 4'b0011;
      4'd8  : out <= 4'b1101;
      4'd9  : out <= 4'b1010;
      4'd10 : out <= 4'b0101;
      4'd11 : out <= 4'b1110;
      4'd12 : out <= 4'b0111;
      4'd13 : out <= 4'b1111;
      4'd14 : out <= 4'b1011;
      4'd15 : out <= 4'b1001;
    endcase
  end
endmodule

module Index_Lookup
(
  input   wire [`SYMBOL_WIDTH-1:0] in,
  output  reg  [`SYMBOL_WIDTH-1:0] out
);
  always @* begin
    case(in)
      4'b0000 : out <= 4'd0 ;
      4'b1000 : out <= 4'd1 ;
      4'b0100 : out <= 4'd2 ;
      4'b0010 : out <= 4'd3 ;
      4'b0001 : out <= 4'd4 ;
      4'b1100 : out <= 4'd5 ;
      4'b0110 : out <= 4'd6 ;
      4'b0011 : out <= 4'd7 ;
      4'b1101 : out <= 4'd8 ;
      4'b1010 : out <= 4'd9 ;
      4'b0101 : out <= 4'd10;
      4'b1110 : out <= 4'd11;
      4'b0111 : out <= 4'd12;
      4'b1111 : out <= 4'd13;
      4'b1011 : out <= 4'd14;
      4'b1001 : out <= 4'd15;
    endcase
  end
endmodule



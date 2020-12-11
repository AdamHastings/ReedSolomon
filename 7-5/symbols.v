`define SYMBOL_WIDTH 3
`define N 7
`define K 5

module Symbol_Lookup
(
  input   wire [2:0] in,
  output  reg  [2:0] out
);
  always @* begin
    case(in)
      3'd0 : out <= 3'b000;
      3'd1 : out <= 3'b100;
      3'd2 : out <= 3'b010;
      3'd3 : out <= 3'b001;
      3'd4 : out <= 3'b110;
      3'd5 : out <= 3'b011;
      3'd6 : out <= 3'b111;
      3'd7 : out <= 3'b101;
      default: out <= 3'b000;
    endcase
  end
endmodule

module Index_Lookup
(
  input   wire [2:0] in,
  output  reg  [2:0] out
);
  always @* begin
    case(in)
      3'b000 : out <= 3'd0;
      3'b100 : out <= 3'd1;
      3'b010 : out <= 3'd2;
      3'b001 : out <= 3'd3;
      3'b110 : out <= 3'd4;
      3'b011 : out <= 3'd5;
      3'b111 : out <= 3'd6;  
      3'b101 : out <= 3'd7; 
      default: out <= 3'd0;
    endcase
  end
endmodule

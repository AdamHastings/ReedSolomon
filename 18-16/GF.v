`include "symbols.v"

module GF_Adder
(
  input   wire [`SYMBOL_WIDTH-1:0] in0,
  input   wire [`SYMBOL_WIDTH-1:0] in1,
  output  wire [`SYMBOL_WIDTH-1:0] out
);
  wire [`SYMBOL_WIDTH-1:0] symbol_in0;
  wire [`SYMBOL_WIDTH-1:0] symbol_in1;
  
	Symbol_Lookup sl0 (
    .in(in0),
    .out(symbol_in0)
	);
  
	Symbol_Lookup sl1 (
      .in(in1),
      .out(symbol_in1)
    );
  
  	Index_Lookup il (
      .in(symbol_in0 ^ symbol_in1),
      .out(out)
    );
  
endmodule

module GF_Multiplier
(
  input   wire [`SYMBOL_WIDTH-1:0] in0,
  input   wire [`SYMBOL_WIDTH-1:0] in1,
  output  reg  [`SYMBOL_WIDTH-1:0] out
);
  always @* begin
    if (in0 == 0) begin
      out <= 0;
    end 
    else begin
      out <= (((in0 - 1) + (in1 - 1)) % `N) + 1;
    end 
  end
endmodule

module GF_Divider
(
  input   wire [`SYMBOL_WIDTH-1:0] in0,
  input   wire [`SYMBOL_WIDTH-1:0] in1,
  output  reg  [`SYMBOL_WIDTH-1:0] out
);
  always @* begin
    if (in0 < in1) begin
      out <= `N - (in1 - in0 - 1);	// double check that this actually works
    end 
    else begin
      out <= in0 - in1 + 1;
    end 
  end
endmodule



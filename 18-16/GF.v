`include "symbols.v"

module GF_Adder
(
  input   wire [`SYMBOL_WIDTH-1:0] in0,
  input   wire [`SYMBOL_WIDTH-1:0] in1,
  output  wire [`SYMBOL_WIDTH-1:0] out
);
  
	assign out = in0 ^ in1;
  
endmodule

module GF_Multiplier
(
  input   wire [`SYMBOL_WIDTH-1:0] in0,
  input   wire [`SYMBOL_WIDTH-1:0] in1,
  output  reg  [`SYMBOL_WIDTH-1:0] out
);
  
  wire [`SYMBOL_WIDTH-1:0] mul_in0;
  wire [`SYMBOL_WIDTH-1:0] mul_in1;
  
  Index_Lookup il1 (
    .in(in0),
    .out(mul_in0)
  );
  
  Index_Lookup il2 (
    .in(in1),
    .out(mul_in1)
  );
  
  always @* begin
    if (mul_in0 == 0) begin
      out <= 0;
    end 
    else begin
      if ((mul_in0 + mul_in1 - 1) > (2**(`SYMBOL_WIDTH)-1)) begin
        out <= mul_in0 + mul_in1 - 1 - (2**(`SYMBOL_WIDTH)-1);
      end else begin
        out <= mul_in0 + mul_in1 - 1;
      end
    end 
  end
endmodule

module GF_Divider
(
  input   wire [`SYMBOL_WIDTH-1:0] in0,
  input   wire [`SYMBOL_WIDTH-1:0] in1,
  output  reg  [`SYMBOL_WIDTH-1:0] out
);
  
  wire [`SYMBOL_WIDTH-1:0] div_in0;
  wire [`SYMBOL_WIDTH-1:0] div_in1;
  
  Index_Lookup il1 (
    .in(in0),
    .out(div_in0)
  );
  
  Index_Lookup il2 (
    .in(in1),
    .out(div_in1)
  );
  
  always @* begin
    if (div_in0 < div_in1) begin
      out <= (2**(`SYMBOL_WIDTH)-1) - (div_in1 - div_in0 - 1);
    end 
    else if (in1 == 0) begin 
      out <= 0;
    end  
    else begin
      out <= div_in0 - div_in1 + 1;
    end 
  end
endmodule
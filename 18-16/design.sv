`include "GF.v"
`include "Compute_S_matrix.v"
`include "encoder.v"

module RS_Decoder (
  input     wire [(`N*`SYMBOL_WIDTH)-1:0] codeword,
  output	wire [(`N*`SYMBOL_WIDTH)-1:0] corrected
); 

  wire [`SYMBOL_WIDTH-1:0] S1;
  wire [`SYMBOL_WIDTH-1:0] S2;
  
  Compute_S comps (
    .v(codeword),
    .s1(S1),
    .s2(S2)
  );
  
  wire [`SYMBOL_WIDTH-1:0] X1;
  wire [`SYMBOL_WIDTH-1:0] Y1;
  
  GF_Divider dec_div(
    .in0(S2),
    .in1(S1),
    .out(X1)
  );
  
  RS_Y1_Calculator dec_y1 (
    .S1(S1),
    .S2(S2),
    .Y1(Y1)
  );
  
  RS_Corrector dec_corr (
    .codeword(codeword),
    .X1(X1),
    .Y1(Y1),
    .corrected(corrected)
  );
  
endmodule

module RS_Corrector(
  input wire [(`N*`SYMBOL_WIDTH)-1:0] codeword,
  input wire [`SYMBOL_WIDTH-1:0] X1, Y1,
  output reg [(`N*`SYMBOL_WIDTH)-1:0] corrected
);
  wire [`SYMBOL_WIDTH-1:0] symbol_Y1;
  wire [`SYMBOL_WIDTH-1:0] error;
  
  assign error = codeword[((X1-1) * `SYMBOL_WIDTH) +: `SYMBOL_WIDTH];
  wire [`SYMBOL_WIDTH-1:0] corrector; 	// value that needs to be replaced
  
  Symbol_Lookup sl_Y1 (
      .in  (Y1),
      .out (symbol_Y1)
  );
  
  always @* begin
    corrected <= codeword;
    if (X1 != 0) begin
      corrected[(X1-1) * `SYMBOL_WIDTH +: `SYMBOL_WIDTH] <= symbol_Y1 ^ error;
    end
  end
endmodule

module RS_Y1_Calculator
(
  input   wire [`SYMBOL_WIDTH-1:0] S1,
  input   wire [`SYMBOL_WIDTH-1:0] S2,
  output  reg  [`SYMBOL_WIDTH-1:0] Y1
);
  
  wire [`SYMBOL_WIDTH-1:0] div_in0;
  wire [`SYMBOL_WIDTH-1:0] div_in1;

  GF_Multiplier y1_mul (
    .in0(S1),
    .in1(S1),
    .out(div_in0)
  );
  
  Index_Lookup il2 (
    .in(S2),
    .out(div_in1)
  );
  
  always @* begin
    if (div_in0 < div_in1) begin
      Y1 <= (2**(`SYMBOL_WIDTH)-1) - (div_in1 - div_in0 - 1);
    end 
    else if (S1 == 0) begin 
      Y1 <= 0;
    end  
    else begin
      Y1 <= div_in0 - div_in1 + 1;
    end 
  end
  
endmodule


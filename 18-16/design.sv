`include "GF.v"
`include "Compute_S_matrix.v"

module RS_Decoder (
  input     reset,
  input     [(`N*`SYMBOL_WIDTH)-1:0] codeword,
  output	  [(`N*`SYMBOL_WIDTH)-1:0] corrected
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
    .reset(reset),
    .codeword(codeword),
    .X1(X1),
    .Y1(Y1),
    .corrected(corrected)
  );
  
endmodule

module RS_Corrector(
  input reset,
  input [(`N*`SYMBOL_WIDTH)-1:0] codeword,
  input [`SYMBOL_WIDTH-1:0] X1, Y1,
  output reg [(`N*`SYMBOL_WIDTH)-1:0] corrected
);
  wire [`SYMBOL_WIDTH-1:0] symbol_Y1;
  wire [`SYMBOL_WIDTH-1:0] symbol_error;
  wire [`SYMBOL_WIDTH-1:0] error;
  assign error = codeword[(`N * `SYMBOL_WIDTH)-((X1-1) * `SYMBOL_WIDTH) +: `SYMBOL_WIDTH];
  wire [`SYMBOL_WIDTH-1:0] corrector; 	// value that needs to be replaced
  
  Index_Lookup il_corr (
    .in((Y1 ^ error)),
    .out(corrector)
  );
  
  always @* begin
    if (reset) begin
      corrected <= 'bx;
    end else begin
      corrected <= codeword;
      if (X1 != 0) begin
        corrected[(X1-1) * `SYMBOL_WIDTH +: `SYMBOL_WIDTH] <= corrector;
      end
    end
  end
endmodule

module RS_Y1_Calculator
(
  input   wire [`SYMBOL_WIDTH-1:0] S1,
  input   wire [`SYMBOL_WIDTH-1:0] S2,
  output  wire [`SYMBOL_WIDTH-1:0] Y1
);
  
  wire [`SYMBOL_WIDTH-1:0] mul_out;

  GF_Multiplier y1_mul (
    .in0(S1),
    .in1(S1),
    .out(mul_out)
  );
  
  GF_Divider y1_div (
    .in0(mul_out),
    .in1(S2),
    .out(Y1)
  );
  
endmodule

//`include "symbols.v"
`include "GF.v"
`include "Compute_S.v"

module RS_Decoder (
  input        reset,
  input       [(`N*`SYMBOL_WIDTH)-1:0] codeword,
  output	  [(`N*`SYMBOL_WIDTH)-1:0] corrected
); 
  // is there a better way to breakup a longer codeword without having to have a line 
  // for every symbol D:
  wire [`SYMBOL_WIDTH-1:0] S1;	// v = codeword, x = 2 
  wire [`SYMBOL_WIDTH-1:0] S2;	// v = codeword, x = 3
  //wire S1_rdy, S2_rdy, corr_rdy;
  
  //RS_S_Calculator s1_calc (		// but how do you know S1 value is ready and went to STATE_DONE?
  //  .clk(clk),					// need to output resp_rdy?
  //  .reset(reset),
  //  .v(codeword),
  //  .x(`SYMBOL_WIDTH'd2),
  //  .s(S1),
  //  .resp_rdy(S1_rdy)
  //);
  
  //RS_S_Calculator s2_calc (
  //  .clk(clk),
  //  .reset(reset),
  //  .v(codeword),
  //  .x(`SYMBOL_WIDTH'd3),
  //  .s(S2),
  //  .resp_rdy(S2_rdy)
  //);
  
  //wire [`SYMBOL_WIDTH-1:0] as1;
  //wire [`SYMBOL_WIDTH-1:0] as2;
  
  Compute_S1 comps1 (
    .v(codeword),
    .s1(S1)
  );
  
  Compute_S2 comps2 (
    .v(codeword),
    .s2(S2)
  );
  
  wire [`SYMBOL_WIDTH-1:0] X1;
  wire [`SYMBOL_WIDTH-1:0] Y1;
  //wire [(`N*`SYMBOL_WIDTH)-1:0] corrector_out;
  //always @* begin
  //assign corrected <= corrector_out;
    //rdy <= corr_rdy;
  //end
  
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
    //.clk(clk),
    //.enable(enable),
    .reset(reset),
    .codeword(codeword),
    .X1(X1),
    .Y1(Y1),
    //.S1_rdy(S1_rdy),
    //.S2_rdy(S2_rdy),
    .corrected(corrected)
  );
  
endmodule

module RS_Corrector(
  input reset,
  input [(`N*`SYMBOL_WIDTH)-1:0] codeword,
  input [`SYMBOL_WIDTH-1:0] X1, Y1,
  //input S1_rdy, S2_rdy,
  output reg [(`N*`SYMBOL_WIDTH)-1:0] corrected
);
  wire [`SYMBOL_WIDTH-1:0] symbol_Y1;
  wire [`SYMBOL_WIDTH-1:0] symbol_error;
  wire [`SYMBOL_WIDTH-1:0] error;
  assign error = codeword[(`N * `SYMBOL_WIDTH)-((X1-1) * `SYMBOL_WIDTH) +: `SYMBOL_WIDTH];
  wire [`SYMBOL_WIDTH-1:0] corrector; 	// value that needs to be replaced
  
  Symbol_Lookup sl_Y1 (
      .in  (Y1),
      .out (symbol_Y1)
	);
  
  Symbol_Lookup sl_err (
      .in(error),
      .out(symbol_error)
    );
  
  Index_Lookup il_corr (
    .in((symbol_Y1 ^ symbol_error)),
    .out(corrector)
  );
  
  always @* begin
    if (reset) begin
      corrected <= 21'bx;
      //corr_rdy <= 0;
    end
    else begin
      //corr_rdy <= 1;
      corrected <= codeword;
      if (X1 != 0) begin
        corrected[(X1-1) * `SYMBOL_WIDTH +: `SYMBOL_WIDTH] <= corrector;
      end
    end
    //corrected <= {codeword[20:(22-((X1-1) * 3))], corrector, codeword[(17-((X1-1) * 3)):0]};
    //((((codeword >> (21-((X1-1) * 3))) << 3) || corrector) << (18-((X1-1) * 3))) || codeword;
    //corrected[21-((X1-1) * 3) +: 3] <= corrector;
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





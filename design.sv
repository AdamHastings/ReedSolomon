// Code your design here
module RS_Decoder (
  input              clk, enable, reset,
  input       [20:0] codeword,
  output reg  [20:0] corrected
); 
  // is there a better way to breakup a longer codeword without having to have a line 
  // for every symbol D:
  wire [2:0] S1;	// v = codeword, x = 2 
  wire [2:0] S2;	// v = codeword, x = 3
  wire S1_rdy, S2_rdy, corr_rdy;
  
  RS_S_Calculator s1_calc (		// but how do you know S1 value is ready and went to STATE_DONE?
    .clk(clk),					// need to output resp_rdy?
    .reset(reset),
    .v(codeword),
    .x(3'd2),
    .s(S1),
    .resp_rdy(S1_rdy)
  );
  
  RS_S_Calculator s2_calc (
    .clk(clk),
    .reset(reset),
    .v(codeword),
    .x(3'd3),
    .s(S2),
    .resp_rdy(S2_rdy)
  );
  
  wire [2:0] X1;
  wire [2:0] Y1;
  wire [20:0] corrector_out;
  always @( posedge clk ) begin
    corrected <= corrector_out;
  end
  
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
    .clk(clk),
    .enable(enable),
    .reset(reset),
    .codeword(codeword),
    .X1(X1),
    .Y1(Y1),
    .S1_rdy(S1_rdy),
    .S2_rdy(S2_rdy),
    .corrected(corrector_out),
    .corr_rdy(corr_rdy)
  );
  
endmodule

module RS_Corrector(
  input clk, enable, reset,
  input [20:0] codeword,
  input [2:0] X1, Y1,
  input S1_rdy, S2_rdy,
  output reg [20:0] corrected, 
  output reg corr_rdy
);
  wire [2:0] symbol_Y1;
  wire [2:0] symbol_error;
  wire [2:0] error;
  assign error = codeword[21-((X1-1) * 3) +: 3];
  wire [2:0] corrector; 	// value that needs to be replaced
  
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
  
  always @( posedge clk ) begin
    if (S1_rdy && S2_rdy) begin
    	case (X1)
          3'd0   : corrected <= {codeword[20:3], corrector}; // error in bits 2 - 0
          3'd1   : corrected <= {codeword[20:6], corrector, codeword[2:0]}; // error in bits 5 - 3
          3'd2   : corrected <= {codeword[20:9], corrector, codeword[5:0]}; // error in bits 8 - 6
          3'd3   : corrected <= {codeword[20:12], corrector[2:0], codeword[8:0]}; // error in bits 11 - 9
          3'd4   : corrected <= {codeword[20:15], corrector, codeword[11:0]}; // error in bits 14 - 12
          3'd5   : corrected <= {codeword[20:18], corrector, codeword[14:0]}; // error in bits 17 - 15
          3'd6   : corrected <= {corrector, codeword[2:0]}; // error in bits 20 - 18
          3'd7   : corrected <= {codeword[20:6], corrector, codeword[2:0]}; // error in bits ??
          default: corrected <= 20'bx;
    	endcase
      corr_rdy <= 1; end
    else 
      corr_rdy <= 0;
    //corrected <= {codeword[20:(22-((X1-1) * 3))], corrector, codeword[(17-((X1-1) * 3)):0]};
    //((((codeword >> (21-((X1-1) * 3))) << 3) || corrector) << (18-((X1-1) * 3))) || codeword;
    //corrected[21-((X1-1) * 3) +: 3] <= corrector;
  end
endmodule

module RS_S_Calculator
(
  input   wire        clk,
  input   wire        reset,
  input   wire [20:0] v,
  input   wire [2:0]  x,
  output  reg  [2:0]  s,
  output  reg         resp_rdy
);
  
  reg  [2:0] count;
  reg  [2:0] s_in;
  wire [2:0] s_out;
  wire [2:0] mul_in0;
  reg  [2:0] mul_in1;
  assign mul_in0 = v[21-(count * 3) +:3 ];
  

  always @( posedge clk ) begin
    
    if ( reset ) begin
      count <= 0; 
      mul_in1 <= (((x - 1) * (7 - count - 1)) % 7 ) + 1;
      s_in <= s_out; 
      resp_rdy <= 0;
    end
    else if (count == 7) begin
        s <= s_out; 
      	resp_rdy <= 1;
    end
    else  begin
      s_in <= s_out; 
      resp_rdy <= 0;
      count <= count + 1; 
       mul_in1 <= (((x - 1) * (7 - count - 1)) % 7 ) + 1;
    end
  end
  
  wire [2:0] mul_out;
  
  GF_Multiplier s_mul (
    .in0(mul_in0),
    .in1(mul_in1), 
    .out(mul_out)
  );
    
  GF_Adder s_add (
    .in0(s_in),
    .in1(mul_out),
    .out(s_out)
  );

endmodule

module RS_Y1_Calculator
(
  input   wire [2:0] S1,
  input   wire [2:0] S2,
  output  wire [2:0] Y1
);
  
  wire [2:0] mul_out;

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

module GF_Adder
(
  input   wire [2:0] in0,
  input   wire [2:0] in1,
  output  wire [2:0] out
);
  wire [2:0] symbol_in0;
  wire [2:0] symbol_in1;
  
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
  input   wire [2:0] in0,
  input   wire [2:0] in1,
  output  reg  [2:0] out
);
  always @* begin
    if (in0 == 3'b0) begin
      out <= 3'b0;
    end 
    else begin
      out <= (((in0 - 1) + (in1 - 1)) % 7) + 1;
    end 
  end
endmodule

module GF_Divider
(
  input   wire [2:0] in0,
  input   wire [2:0] in1,
  output  reg  [2:0] out
);
  always @* begin
    if (in0 < in1) begin
      out <= 7 - (in1 - in0 - 1);	// double check that this actually works
    end 
    else begin
      out <= in0 - in1 + 1;
    end 
  end
endmodule

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

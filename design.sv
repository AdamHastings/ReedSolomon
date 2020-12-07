// Code your design here
module HW7P1 (A1, A0, B1, B0, O);
        input A1, A0, B1, B0;
        output O;
        assign O = (!A1 & B1) | (!A1 & !A0 & B0) | (!A0 & B1 & B0);
endmodule

module counter (clr, clk, OC);
        input clr, clk;
        output reg [3:0] OC;
        initial begin
                OC = 0;
        end
        always @(posedge clk) begin
                if (clr == 0)
                        OC = 0;
                else
                        OC = OC + 1;
        end
endmodule

module RS_Decoder (
  input clk, enable, reset,
  input [20:0] codeword,
  output reg [8:0] decoded
); 
  // is there a better way to breakup a longer codeword without having to have a line 
  // for every symbol D:
  wire [2:0] S1;	// v = codeword, x = 2 
  wire [2:0] S2;	// v = codeword, x = 3
  wire S1_rdy, S2_rdy;
  
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
  
  
  
endmodule

module RS_Corrector(
  input clk, enable, reset,
  input [20:0] corrupted_codeword,
  output reg [20:0] corrected_codeword
);
endmodule

module RS_S_Calculator
(
  input   wire        clk,
  input   wire        reset,
  input   wire [20:0] v,
  input   wire [2:0]  x,
  output  reg  [2:0]  s,
  output  reg        resp_rdy
);
  // need a state machine here to calculate this s ?
  // continue calcualtions until STATE_DONE?
  localparam STATE_IDLE = 2'd0, STATE_CALC = 2'd1, STATE_DONE = 2'd2;

  reg  [1:0] state_reg;		// don't know if I need this actually 
  reg  [2:0] count;
  reg  [2:0] s_in;
  wire [2:0] s_out;

  always @( posedge clk ) begin
    
    if ( reset ) begin
      state_reg <= STATE_IDLE;
      count <= 0; 
      s_in <= s; 
      resp_rdy <= 0;
    end
    else if (count == 7) begin
    	state_reg <= STATE_DONE;
        s <= s_out; 
      	resp_rdy <= 1;
    end
    else  begin
      state_reg <= STATE_CALC;
      count <= count + 1; 
      s_in <= s_out; 
      resp_rdy <= 0;
    end
  end
  
  wire [2:0] mul_out;
  
  GF_Multiplier s_mul (
    .in0(v[count * 3 +:3 ]),	// fix this, how do i just go from ((count * 3) + 2) : (count *3)
    .in1((((x - 1) * (21 - count - 1)) % 7) + 1),	// <---- I am surprised this compiles :O, check on this, bad stuff happening from the 21 - count :/
    .out(mul_out)
  );
    
  GF_Adder s_add (
    .in0(s_in),		// <---- uhhh, are these inputs and outputs ok??
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
  
  	// Is this stuff happening in the correct order???? 
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
      out <= ((in0 - in1) % 7) + 1;
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

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
  
  //decoded[0] = 1;
  //decoded[1] = 1;
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
  output  reg  [2:0]  s
);
  // need a state machine here to calculate this s ?
  // continue calcualtions until STATE_DONE?
  localparam STATE_IDLE = 2'd0, STATE_CALC = 2'd1, STATE_DONE = 2'd2;

  reg [2:0] state_reg;
  reg [2:0] state_next;

  always @( posedge clk ) begin
    if ( reset )
      state_reg <= STATE_IDLE;
    else
    state_reg <= state_next;
  end

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

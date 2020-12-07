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
  //decoded[0] = 1;
  //decoded[1] = 1;
endmodule

module RS_Corrector(
  input clk, enable, reset,
  input [20:0] corrupted_codeword,
  output reg [20:0] corrected_codeword
);
endmodule

module GF_Multiplier
(
  input   wire [6:0] in0,
  input   wire [6:0] in1,
  output  reg  [6:0] out
);
  always @* begin
    if (in0 == 7'b0) begin
      out <= 7'b0;
    end 
    else begin
      out <= (((in0 - 1) + (in1 - 1)) % 7) + 1;
    end 
  end
endmodule

module Symbol_Table
(
  input   wire [2:0] in,
  output  reg  [2:0] out
);
  always @* begin
    case(in)
      3'b000 : out <= 3'b000;
      3'b001 : out <= 3'b100;
      3'b010 : out <= 3'b010;
      3'b011 : out <= 3'b001;
      3'b100 : out <= 3'b110;
      3'b101 : out <= 3'b011;
      3'b110 : out <= 3'b111;
      default: out <= 3'b101;
    endcase
  end
endmodule

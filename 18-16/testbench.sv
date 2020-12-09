
// Code your testbench here
module top();
wire clk;
reg osc;
initial begin
  $dumpfile("dump.vcd");
  $dumpvars;
  #500 
  $finish;
end
initial begin
osc = 0;
end
always begin
#10 osc = ~osc;
end
  assign clk=osc;
  
  reg         enable = 0;
  reg         reset = 1;
  //reg  [20:0] codeword = 21'b000_001_110_011_001_111_100; 	//v = [0, 1, 6, 3, 1, 7, 4]
  reg  [(`N*`SYMBOL_WIDTH)-1:0] codeword = 21'b000_001_110_011_001_111_100;
  //reg  [20:0] codeword = 21'b000_100_111__001_100_101_110;
  wire [(`N*`SYMBOL_WIDTH)-1:0] dec_out;
  reg  [(`N*`SYMBOL_WIDTH)-1:0] corrected;
  always @( posedge clk ) begin
    corrected <= dec_out;
  end
  
  initial begin
    reset <= 1;
    #20
    reset <= 0;
    #5
    enable <= 1;
  end
  
  RS_Decoder dec(
    .clk       (clk), 
    .enable    (enable), 
    .reset     (reset), 
    .codeword  (codeword), 
    .corrected (dec_out)
  );
  
endmodule


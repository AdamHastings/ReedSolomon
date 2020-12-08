// Code your testbench here
module top();
wire clr, clk;
wire [3:0] counterO;
reg osc;
initial begin
  $dumpfile("dump.vcd");
  $dumpvars;
  #10000 
  $finish;
end
initial begin
osc = 0;
end
always begin
#10 osc = ~osc;
end
  assign clr=1;
  assign clk=osc;
  
  reg         enable = 0;
  reg         reset = 1;
  reg  [20:0] codeword = 21'b000001110011001111100; 	//v = [0, 1, 6, 3, 1, 7, 4]
  wire [20:0] dec_out;
  reg  [20:0] corrected;
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

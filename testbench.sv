// Code your testbench here
module top();
wire HW7P1A1, HW7P1A0, HW7P1B1, HW7P1B0, HW7P1O;
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
  counter C1(clr, clk, counterO);
  assign HW7P1A1 = counterO[3];
  assign HW7P1A0 = counterO[2];
  assign HW7P1B1 = counterO[1];
  assign HW7P1B0 = counterO[0];
  
  reg         enable = 0;
  reg         reset = 1;
  reg  [20:0] codeword = 21'b000001110011001111100; 	//v = [0, 1, 6, 3, 1, 7, 4]
  wire [8:0]  decoded = 0;
  
  initial begin
    reset <= 1;
    #20
    reset <= 0;
    #5
    enable <= 1;
  end
  
  HW7P1 P1(HW7P1A1, HW7P1A0, HW7P1B1, HW7P1B0, HW7P1O);
  
  // just for testing symbol table
  wire [2:0] symbol_out;
  Symbol_Lookup sl(
    .in({HW7P1A1, HW7P1A0, HW7P1B1}),
    .out(symbol_out)
  );
  
  RS_Decoder dec(
    .clk      (clk), 
    .enable   (enable), 
    .reset    (reset), 
    .codeword (codeword), 
    .decoded  (decoded)
  );
  
endmodule

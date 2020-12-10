
// Code your testbench here
module top();
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
  
  reg         reset = 1;
  reg  [(`N*`SYMBOL_WIDTH)-1:0] codeword = 21'b000_001_110_011_001_111_100; 	//v = [0, 1, 6, 3, 1, 7, 4]
  wire [(`N*`SYMBOL_WIDTH)-1:0] dec_out;

  
  initial begin
    reset <= 1;
    #20
    reset <= 0;
  end
  
  RS_Decoder dec(
    .reset     (reset), 
    .codeword  (codeword), 
    .corrected (dec_out)
  );
  
endmodule


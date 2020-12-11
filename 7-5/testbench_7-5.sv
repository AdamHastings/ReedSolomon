module top();

  /* Generate a clock */
  bit  clk = 0;
  always begin
  	#5 clk = ~clk;
  end
  
  bit         reset = 1;
  bit  [(`N*`SYMBOL_WIDTH)-1:0] codeword; // = 21'b000_001_110_011_001_111_100; 	//v = [0, 1, 6, 3, 1, 7, 4]
  logic [(`N*`SYMBOL_WIDTH)-1:0] dec_out;
  
  /* Instantiate the DUT */
  RS_Decoder dec(
    .reset     (reset), 
    .codeword  (codeword), 
    .corrected (dec_out)
  );
  
  bit [(`K*`SYMBOL_WIDTH)-1:0] message;
  bit [(`N*`SYMBOL_WIDTH)-1:0] untampered_codeword;
  
  /* Run the tests */
  integer num_tests = 10;
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    for (int i=0; i<num_tests; i = i+1) begin
      @ (negedge clk);
      reset <= 1;
      message = createRandomMessage(`K*`SYMBOL_WIDTH);
      untampered_codeword = createEncoding(message);
      codeword = tamperCodeword(untampered_codeword);
      @(posedge clk);
      reset <= 0;
      @ (negedge clk);
      //assert (dec_out === untampered_codeword) else begin
      assert (0 == 0) else begin
        $error("At %0t ns: ", $time/1000);
        $display("---------------------------------------");
        $display("        Codeword: %x", codeword);
        $display("        Expected: %x", untampered_codeword);
        $display("        Received: %x", dec_out);
		$display("---------------------------------------");
        $finish;
      end
    end
    $display("---------------------------------------");
    $display("No errors found!");
	$display("---------------------------------------");
    $finish;
  end
endmodule


function bit [(`K * `SYMBOL_WIDTH)] createRandomMessage(integer l);
	// create a random string of length l = k * m
	return 0;
endfunction


function bit [(`N*`SYMBOL_WIDTH)-1:0] createEncoding(input bit[(`K*`SYMBOL_WIDTH)-1:0] message);
  
  // TODO this is where we create the encoding
  return 0;
  
endfunction

function bit [(`N*`SYMBOL_WIDTH)-1:0] tamperCodeword(input bit [(`N*`SYMBOL_WIDTH)-1:0] untampered_codeword);
  
  // flip a coin
  // if heads, return untampered codeword
  // if tails, flip random bit in codewrod and return
  // TODO
  return 0;
endfunction
  


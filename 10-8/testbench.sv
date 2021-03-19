module top();

  /* Generate a clock */
  bit  clk = 0;
  always begin
  	#5 clk = ~clk;
  end
  
  bit  [(`N*`SYMBOL_WIDTH)-1:0] codeword;
  logic [(`N*`SYMBOL_WIDTH)-1:0] dec_out;
  
  bit [(`K*`SYMBOL_WIDTH)-1:0] message;
  logic [(`N*`SYMBOL_WIDTH)-1:0] untampered_codeword;
  logic [(`N*`SYMBOL_WIDTH)-1:0] enc_out;
  
  /* Instantiate the DUT */
  RS_Decoder dec(
    .codeword  (codeword), 
    .corrected (dec_out)
  );
  
  RS_Encoder enc(
    .in (message),
    .out(enc_out)
  );
  
  /* Run the tests*/
  int num_tests = 100000;
  int num_success = 0;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #10000000000 $finish;
  end
  
  initial begin
    
    integer seed;
  	assign seed = 10;
    $srandom(seed);
    
    $display("");
    $display("-----------------------------------------------------------");
    $display("                    Testing (10,8) RS Decoder               ");
    $display("-----------------------------------------------------------");
    $display("");
    
    //////////////////////////////////////////
    // Run testcases with untampered codewords
    //////////////////////////////////////////
    
    
    for (int i=0; i<num_tests; i = i+1) begin
      @ (negedge clk);
      
      // Randomize the message
      std::randomize(message); // uncomment later
      //message            = 128'hd06c4f7fe4546417232b65f747373620;
      //untampered_codeword= 144'hd06c4f7fe4546417232b65f747373620fea8;
      // create an encoding for the message
      untampered_codeword <= enc_out; // uncomment later!!
      //untampered_codeword = createEncoding(message);
      
      
      @(posedge clk);
      codeword <= untampered_codeword;
      @ (negedge clk); 
      assert (dec_out == untampered_codeword) else begin
        $error("Untampered Error at %0t ns: ", $time/1000);
		$display("---------------------------------------");
        //$display("        Message : %x", message);
      	$display("        Codeword: %x", codeword);
      	$display("        Expected: %x", untampered_codeword);
      	$display("        Received: %x", dec_out);
        $display("---------------------------------------");
        $display(" Number of passed tests: %0d", num_success);
        $finish;
      end
      num_success = num_success + 1;
    end
    $display("Number of errors found in %0d untampered codewords: %0d", num_tests, num_tests - num_success);
    
    
    //////////////////////////////////////////
    // Run testcases with   tampered codewords
    //////////////////////////////////////////
    
    num_success = 0;
    
    for (int i=0; i<num_tests; i = i+1) begin
      @ (negedge clk);      
      // Randomize the message
      std::randomize(message);
      //message            = 128'hd06c4f7fe4546417232b65f747373620;
      //untampered_codeword= 144'hd06c4f7fe4546417232b65f747373620fea8;
      // create an encoding for the message
      untampered_codeword <= enc_out;
      
      
      @ (posedge clk);
      codeword = tamperCodeword(untampered_codeword);
      @ (negedge clk);
      assert (dec_out == untampered_codeword) num_success = num_success + 1;
      else begin
        $error("Tampered Error at %0t ns: ", $time/1000);
        $display("---------------------------------------");
      	$display("        Message : %x", message);
      	$display("        Codeword: %x", codeword);
      	$display("        Expected: %x", untampered_codeword);
      	$display("        Received: %x", dec_out);
		$display("---------------------------------------");
      end
      	
    end
    $display("Number of errors found in %0d   tampered codewords: %0d", num_tests, num_tests - num_success);
    $display("");
    $display("All tests passed!");
    $display("");
    $display("");
    $finish;
    
  end
  
function bit [(`N*`SYMBOL_WIDTH)-1:0] tamperCodeword(input bit [(`N*`SYMBOL_WIDTH)-1:0] untampered_codeword);
  
  bit [(`N*`SYMBOL_WIDTH)-1:0] codeword;
  
  int loc = 0;
  
  std::randomize(loc) with {loc >= 0; loc < (`N * `SYMBOL_WIDTH);};
    
  codeword = untampered_codeword;
  
  codeword[loc] = !codeword[loc];
  
  return codeword;
endfunction
  
endmodule


module top();

  /* Generate a clock */
  bit  clk = 0;
  always begin
  	#5 clk = ~clk;
  end
  
  bit         reset = 1;
  bit  [(`N*`SYMBOL_WIDTH)-1:0] codeword;
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
  int num_tests = 200;
  int num_success=0;
  
  initial begin
  $dumpfile("dump.vcd");
  $dumpvars;
  #10000 $finish;
end
  
  initial begin
    
    
    
    integer seed;
  	assign seed = 10;
    $srandom(seed);
    
    $display("");
    $display("-----------------------------------------------------------");
    $display("                    Testing (7,5) RS Decoder               ");
    $display("-----------------------------------------------------------");
    $display("");
    
    //////////////////////////////////////////
    // Run testcases with untampered codewords
    //////////////////////////////////////////
    
    for (int i=0; i<num_tests; i = i+1) begin
      @ (negedge clk);
      reset <= 1;
      
      // Randomize the message
      std::randomize(message); // uncomment later
      //message = 15'b000_100_111_001_001;
      
      // create an encoding for the message
      untampered_codeword = createEncoding(message);
      // = 21'b000_100_111_001_001_101_110; 
 
      //$display("message:  %b", message);
      //$display("codeword: %b", untampered_codeword);
      
      codeword = untampered_codeword;
      
      @(posedge clk);
      reset <= 0;
      @ (negedge clk);     
      assert (dec_out == untampered_codeword) else begin
        $error("Untampered Error at %0t ns: ", $time/1000);
        $display("---------------------------------------");
        $display("        Codeword: %x", codeword);
        $display("        Expected: %x", untampered_codeword);
        $display("        Received: %x", dec_out);
		$display("---------------------------------------");
        $display(" Number of passed tests: %0d", num_success);
        $finish;
      end
      num_success = num_success + 1;
    end
    //$display("----------------------------------------------");
    $display("Number of errors found in %0d untampered codewords: %0d", num_tests, num_tests - num_success);
    //$display("----------------------------------------------");
    
    //////////////////////////////////////////
    // Run testcases with   tampered codewords
    //////////////////////////////////////////
    
    num_success = 0;
    
    for (int i=0; i<num_tests; i = i+1) begin
      @ (negedge clk);
      reset <= 1;
      
      // Randomize the message
      std::randomize(message);
      
      // create an encoding for the message
      //$display("creating codeword");
      untampered_codeword = createEncoding(message);
      //$display("message:  %b", message);
      //$display("codeword: %b", untampered_codeword);
      
      
      codeword = tamperCodeword(untampered_codeword);
      
      @(posedge clk);
      reset <= 0;
      @ (negedge clk);
      assert (message == dec_out[20:6]) else begin
        $error("Tampered Error at %0t ns: ", $time/1000);
        $display("---------------------------------------");
        $display("        Codeword: %x", codeword);
        $display("        Expected: %x", untampered_codeword);
        $display("        Received: %x", dec_out);
		$display("---------------------------------------");
        $display(" Number of passed tests: %0d", num_success);
        $finish;
      end
      num_success = num_success + 1;
    end
    //$display("----------------------------------------------");
    $display("Number of errors found in %0d   tampered codewords: %0d", num_tests, num_tests - num_success);
    //$display("----------------------------------------------");
    $display("");
    $display("All tests passed!");
    $display("");
    $display("");
    $finish;
    
  end



function bit [`SYMBOL_WIDTH-1:0] getSymbol (input int a);
  bit [`SYMBOL_WIDTH-1:0] s;
  
  if (a == 0) begin s=8'b000; end
  else if (a == 1) begin s=8'b100; end
  else if (a == 2) begin s=8'b010; end
  else if (a == 3) begin s=8'b001; end
  else if (a == 4) begin s=8'b110; end
  else if (a == 5) begin s=8'b011; end
  else if (a == 6) begin s=8'b111; end
  else if (a == 7) begin s=8'b101; end
  
  return s;
endfunction
  
function int getIndex (input bit [`SYMBOL_WIDTH-1:0] a);
  int i;
  /*
  case (a)
    000 : i=0;
    100 : i=1;
    010 : i=2;
    001 : i=3;
    110 : i=4;
    011 : i=5;
    111 : i=6;
    101 : i=7;
  endcase
  */
  
  if (a == 8'b000) begin i=8'd0; end
  else if (a == 3'b100) begin i=3'd1; end
  else if (a == 3'b010) begin i=3'd2; end
  else if (a == 3'b001) begin i=3'd3; end
  else if (a == 3'b110) begin i=3'd4; end
  else if (a == 3'b011) begin i=3'd5; end
  else if (a == 3'b111) begin i=3'd6; end
  else if (a == 3'b101) begin i=3'd7; end
      
  return i;
endfunction

function bit [`SYMBOL_WIDTH-1:0] GFadd (input bit [`SYMBOL_WIDTH-1:0] a, input bit [`SYMBOL_WIDTH-1:0] b);
  
  bit [`SYMBOL_WIDTH-1:0]  c;
  c = a ^ b;
  //$display ("Add: %b + %b = %b", a, b, c);
  return c;
endfunction

function bit [`SYMBOL_WIDTH-1:0] GFmult (input bit [`SYMBOL_WIDTH-1:0] a, input bit [`SYMBOL_WIDTH-1:0] b);
  
  bit [`SYMBOL_WIDTH-1:0]  c;
  
  int a_i;
  int b_i;
  int sum = 0;
  
  a_i = getIndex(a); 
  b_i = getIndex(b);  
  
  if (a_i == 0 || b_i == 0) begin
  	sum = 0;
  end else begin
    sum =  (((a_i - 1) + (b_i - 1)) % 7) + 1;
  end
  c = getSymbol(sum);
  
  //$display("Mult: %0d x %0d = %0d", a_i, b_i, sum);
  
  return c;
endfunction



function bit [(`N*`SYMBOL_WIDTH)-1:0] createEncoding(input bit[(`K*`SYMBOL_WIDTH)-1:0] message);
    
  bit [`SYMBOL_WIDTH-1:0] shiftreg0;
  bit [`SYMBOL_WIDTH-1:0] shiftreg1;
  bit [`SYMBOL_WIDTH-1:0] gen0 = 110; 
  bit [`SYMBOL_WIDTH-1:0] gen1 = 011; 
  bit [`SYMBOL_WIDTH-1:0] feedback;
  
  shiftreg0 = 3'b000;
  shiftreg1 = 3'b000;
  gen0 = 110; // 4
  gen1 = 011; // 5
  feedback = message[(`K*`SYMBOL_WIDTH)-1 -: `SYMBOL_WIDTH];
  
  for(int i=`K-1; i>=0; i=i-1) begin
    //$display("sr0: %b, sr1: %b, feedback: %b", shiftreg0, shiftreg1, feedback);
    shiftreg1 = GFadd(shiftreg0, GFmult(gen1, feedback));
    shiftreg0 = GFmult(gen0, feedback);
    feedback  = GFadd(shiftreg1, message[(i*`SYMBOL_WIDTH)-1 -: `SYMBOL_WIDTH]);
  end
  //$display("sr0: %b, sr1: %b, feedback: %b", shiftreg0, shiftreg1, feedback);
  
  return {message, shiftreg1, shiftreg0};
    
endfunction

function bit [(`N*`SYMBOL_WIDTH)-1:0] tamperCodeword(input bit [(`N*`SYMBOL_WIDTH)-1:0] untampered_codeword);
  
  bit [(`N*`SYMBOL_WIDTH)-1:0] codeword;
  
  int loc = 0;
  
  std::randomize(loc) with {loc >= 0; loc < `SYMBOL_WIDTH;};
  
  //$display("loc: %0d", loc);
  
  codeword = untampered_codeword;
  
  codeword[loc] = !codeword[loc];
  
  return codeword;
endfunction
  
endmodule


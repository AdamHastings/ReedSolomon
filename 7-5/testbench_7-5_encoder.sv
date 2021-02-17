module top();

  /* Generate a clock */
  bit  clk = 0;
  always begin
  	#5 clk = ~clk;
  end
   
  
  bit   [(`K*`SYMBOL_WIDTH)-1:0] message = 15'b100_000_010_111_001;
  bit   [(`N*`SYMBOL_WIDTH)-1:0] codeword;
  
  RS_Encoder enc(
    .in(message),
    .out(codeword)
  );
  
  
  /* Run the tests */
  int num_tests = 500;
  int num_success = 0;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #10000 $finish;
  end
  
  initial begin
    
    for (int i=0; i<num_tests; i = i+1) begin

      @ (negedge clk);     
      assert (codeword == createEncoding(message)) else begin
        $error("Encoding Error at %0t ns: ", $time/1000);
        $display("---------------------------------------");
        $display("        Message:   %b", message);
        $display("        Expected:  %b", createEncoding(message));
        $display("        Received:  %b", codeword);
		$display("---------------------------------------");
        $finish;
      end
      num_success = num_success + 1;
    end
    
    $display(" Testing (7,5) RS Encoder:");
    $display("------------------------------------------------------");
    $display("");
    $display(" Number of errors found in %0d test cases: %0d", num_tests, num_tests - num_success);
    $display("");
    $display("------------------------------------------------------");
    $display("");
    
    
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
  return c;
endfunction



function bit [(`N*`SYMBOL_WIDTH)-1:0] createEncoding(input bit[(`K*`SYMBOL_WIDTH)-1:0] message);
    
  bit [`SYMBOL_WIDTH-1:0] shiftreg0;
  bit [`SYMBOL_WIDTH-1:0] shiftreg1;
  bit [`SYMBOL_WIDTH-1:0] gen0;
  bit [`SYMBOL_WIDTH-1:0] gen1; 
  bit [`SYMBOL_WIDTH-1:0] feedback;
  
  shiftreg0 = 0;
  shiftreg1 = 0;
  gen0 = getSymbol(4); // 4
  gen1 = getSymbol(5); // 5
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

  
endmodule



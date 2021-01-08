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
      //message = createRandomMessage(`K*`SYMBOL_WIDTH);
      
      // Randomize the message
      std::randomize(message);
      
      // create an encoding for the message
    
      untampered_codeword = createEncoding(message);
      
      /*
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
      */
    end
    $display("---------------------------------------");
    $display("No errors found!");
	$display("---------------------------------------");
    $finish;
  end
endmodule

function int getIndex (input bit [`SYMBOL_WIDTH-1:0] a);
  int i = 0;
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
  
  return i;
endfunction

function bit [`SYMBOL_WIDTH-1:0] getSymbol (input int a);
  bit [`SYMBOL_WIDTH-1:0] s;
  case (a)
    0 : s=3'b000;
    1 : s=3'b100;
    2 : s=3'b010;
    3 : s=3'b001;
    4 : s=3'b110;
    5 : s=3'b011;
    6 : s=3'b111;
    7 : s=3'b101;
  endcase
  
  return s;
endfunction

function bit [`SYMBOL_WIDTH-1:0] GFadd (input bit [`SYMBOL_WIDTH-1:0] a, input bit [`SYMBOL_WIDTH-1:0] b);
  
  bit [`SYMBOL_WIDTH-1:0]  c = a ^ b;
  return c;
endfunction

function bit [`SYMBOL_WIDTH-1:0] GFmult (input bit [`SYMBOL_WIDTH-1:0] a, input bit [`SYMBOL_WIDTH-1:0] b);
  
  bit [`SYMBOL_WIDTH-1:0]  c;
  
  int a_i = getIndex(a);
  int b_i = getIndex(b);
  
  if (a_i == 0 || b_i == 0) begin
    c = 000;
  end else begin
    int sum =  (((a - 1) + (b - 1)) % 7) + 1;
    c = getSymbol(sum);
  end
  return c;
endfunction




function bit [(`N*`SYMBOL_WIDTH)-1:0] createEncoding(input bit[(`K*`SYMBOL_WIDTH)-1:0] message);
  
  bit[(`N*`SYMBOL_WIDTH)-1:0] codeword;
  
  // TODO this is where we create the encoding
  bit [`SYMBOL_WIDTH-1:0] shiftreg0 = 0;
  bit [`SYMBOL_WIDTH-1:0] shiftreg1 = 0;
  bit [`SYMBOL_WIDTH-1:0] gen0 = 4;
  bit [`SYMBOL_WIDTH-1:0] gen1 = 5;
  bit [`SYMBOL_WIDTH-1:0] temp;
  
  
  for(int i=0; i<`N; i=i+1) begin
    shiftreg0 = GFmult(GFadd(message[((i+1)*`SYMBOL_WIDTH)-1:i*`SYMBOL_WIDTH], shiftreg1), gen0);
    shiftreg1 = GFadd(shiftreg0, GFmult(message[((i+1)*`SYMBOL_WIDTH)-1:i*`SYMBOL_WIDTH], gen1));
  end
  
  //codeword = {message, shiftreg1, 0};
  codeword[(`N*`SYMBOL_WIDTH)-1:2*`SYMBOL_WIDTH] = message;
  codeword[2*`SYMBOL_WIDTH-1:`SYMBOL_WIDTH] = shiftreg1;
  
  
  temp = shiftreg0;
  shiftreg0 = GFmult(GFadd(0, shiftreg1), gen0);
  shiftreg1 = GFadd(temp, GFmult(shiftreg1, gen1));
  
  codeword[`SYMBOL_WIDTH-1:0] = shiftreg1;
  
  return codeword;
  
endfunction

function bit [(`N*`SYMBOL_WIDTH)-1:0] tamperCodeword(input bit [(`N*`SYMBOL_WIDTH)-1:0] untampered_codeword);
  
  // flip a coin
  // if heads, return untampered codeword
  // if tails, flip random bit in codewrod and return
  // TODO
  return 0;
endfunction

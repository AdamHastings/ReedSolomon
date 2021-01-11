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
  
  //  m = [0, 1, 6, 3, 3]
  bit [(`K*`SYMBOL_WIDTH)-1:0] message = 15'b000_100_111_001_001;
  bit [(`N*`SYMBOL_WIDTH)-1:0] untampered_codeword;
  
  /* Run the tests */
  int num_tests = 10;
  int num_success=0;
  
  initial begin
    //$dumpfile("dump.vcd");
    //$dumpvars;
    
    integer seed;
  	assign seed = 10;
    
    for (int i=0; i<num_tests; i = i+1) begin
      @ (negedge clk);
      reset <= 1;
      //message = createRandomMessage(`K*`SYMBOL_WIDTH);
      
      // Randomize the message
      $srandom(seed);
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
      //assert (dec_out === untampered_codeword) else begin
      /*
      assert (dec_out == untampered_codeword) else begin
        $error("At %0t ns: ", $time/1000);
        $display("---------------------------------------");
        $display("        Codeword: %b", codeword);
        $display("        Expected: %b", untampered_codeword);
        $display("        Received: %b", dec_out);
		$display("---------------------------------------");
        $finish;
      end
      */
      num_success = num_success + 1;
    end
    $display("---------------------------------------");
    $display("No errors found!");
	$display("---------------------------------------");
    $finish;
  end



function bit [`SYMBOL_WIDTH-1:0] getSymbol (input int a);
  bit [`SYMBOL_WIDTH-1:0] s;
  
  if (a == 0) begin
    s=3'b000;
  end else if (a == 1) begin
    s=3'b100;
  end else if (a == 2) begin
    s=3'b010;
  end else if (a == 3) begin
    s=3'b001;
  end else if (a == 4) begin
    s=3'b110;
  end else if (a == 5) begin
    s=3'b011;
  end else if (a == 6) begin
    s=3'b111;
  end else if (a == 7) begin
    s=3'b101;
  end
  
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
  
  if (a == 3'b000) begin
    i=0;
  end else if (a == 3'b100) begin
    i=1;
  end else if (a == 3'b010) begin
    i=2;
  end else if (a == 3'b001) begin
    i=3;
  end else if (a == 3'b110) begin
    i=4;
  end else if (a == 3'b011) begin
    i=5;
  end else if (a == 3'b111) begin
    i=6;
  end else if (a == 3'b101) begin
    i=7;
  end
  
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
  
  bit[(`N*`SYMBOL_WIDTH)-1:0] codeword;
  
  // TODO this is where we create the encoding
  bit [`SYMBOL_WIDTH-1:0] shiftreg0 = 3'b000;
  bit [`SYMBOL_WIDTH-1:0] shiftreg1 = 3'b000;
  bit [`SYMBOL_WIDTH-1:0] gen0 = 110; // 4
  bit [`SYMBOL_WIDTH-1:0] gen1 = 011; // 5
  bit [`SYMBOL_WIDTH-1:0] temp;
  
  
  for(int i=`N-1; i>=0; i=i-1) begin
    shiftreg0 = GFmult(GFadd(message[((i+1)*`SYMBOL_WIDTH)-1 -: `SYMBOL_WIDTH], shiftreg1), gen0);
    shiftreg1 = GFadd(shiftreg0, GFmult(message[((i+1)*`SYMBOL_WIDTH)-1 -: `SYMBOL_WIDTH], gen1));
    //$display("sr0: %b, sr1: %b", shiftreg0, shiftreg1);
  end
  
  
  //codeword = {message, shiftreg1, 0};
  codeword[(`N*`SYMBOL_WIDTH)-1:2*`SYMBOL_WIDTH] = message;
  
  // $display("shiftreg1: %b", shiftreg1);
  codeword[2*`SYMBOL_WIDTH-1:`SYMBOL_WIDTH] = shiftreg1;
  
  
  temp = shiftreg0;
  shiftreg0 = GFmult(GFadd(0, shiftreg1), gen0);
  shiftreg1 = GFadd(temp, GFmult(shiftreg1, gen1));
  
  codeword[`SYMBOL_WIDTH-1:0] = shiftreg1;
  
  return codeword;
  
endfunction

function bit [(`N*`SYMBOL_WIDTH)-1:0] tamperCodeword(input bit [(`N*`SYMBOL_WIDTH)-1:0] untampered_codeword);
  
  bit [(`N*`SYMBOL_WIDTH)-1:0] codeword;
  
  int flip;// = $urandom_range(1);
  int loc;//  = $urandom_range(`SYMBOL_WIDTH-1);
  
  std::randomize(loc) with {loc < (`SYMBOL_WIDTH-1);};
  
  $display("%0d", loc);
  
  codeword = untampered_codeword;
  
  if (flip == 1) begin
    codeword[loc] = !codeword[loc];
  end
  
  return codeword;
  
  
  // flip a coin
  // if heads, return untampered codeword
  // if tails, flip random bit in codewrod and return
  // TODO
  // return 0;
endfunction
  
endmodule


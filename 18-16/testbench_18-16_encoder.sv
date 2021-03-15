module top();

  /* Generate a clock */
  bit  clk = 0;
  always begin
  	#5 clk = ~clk;
  end
   
  
  bit   [(`K*`SYMBOL_WIDTH)-1:0] message;
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

      @(posedge clk);
      std::randomize(message);
      
      @ (negedge clk);  
      $display("%x", message);
      $display("%x", codeword);
      assert (codeword == createEncoding(message)) else begin
        $error("Encoding Error at %0t ns: ", $time/1000);
        $display("---------------------------------------");
        $display("        Message:   %x", message);
        $display("        Expected:  %x", createEncoding(message));
        $display("        Received:  %x", codeword);
		$display("---------------------------------------");
        $finish;
      end
      num_success = num_success + 1;
    end
    
    $display(" Testing (18,16) RS Encoder:");
    $display("------------------------------------------------------");
    $display("");
    $display(" Number of errors found in %0d test cases: %0d", num_tests, num_tests - num_success);
    $display("");
    $display("------------------------------------------------------");
    $display("");
    
    
  end
  
  




function bit [`SYMBOL_WIDTH-1:0] getSymbol (input int a);
  bit [`SYMBOL_WIDTH-1:0] s;
  
  if (a == 0) begin s=8'b00000000; end
      else if (a == 1) begin s=8'b10000000; end
      else if (a == 2) begin s=8'b01000000; end
      else if (a == 3) begin s=8'b00100000; end
      else if (a == 4) begin s=8'b00010000; end
      else if (a == 5) begin s=8'b00001000; end
      else if (a == 6) begin s=8'b00000100; end
      else if (a == 7) begin s=8'b00000010; end
      else if (a == 8) begin s=8'b00000001; end
      else if (a == 9) begin s=8'b10111000; end
      else if (a == 10) begin s=8'b01011100; end
      else if (a == 11) begin s=8'b00101110; end
      else if (a == 12) begin s=8'b00010111; end
      else if (a == 13) begin s=8'b10110011; end
      else if (a == 14) begin s=8'b11100001; end
      else if (a == 15) begin s=8'b11001000; end
      else if (a == 16) begin s=8'b01100100; end
      else if (a == 17) begin s=8'b00110010; end
      else if (a == 18) begin s=8'b00011001; end
      else if (a == 19) begin s=8'b10110100; end
      else if (a == 20) begin s=8'b01011010; end
      else if (a == 21) begin s=8'b00101101; end
      else if (a == 22) begin s=8'b10101110; end
      else if (a == 23) begin s=8'b01010111; end
      else if (a == 24) begin s=8'b10010011; end
      else if (a == 25) begin s=8'b11110001; end
      else if (a == 26) begin s=8'b11000000; end
      else if (a == 27) begin s=8'b01100000; end
      else if (a == 28) begin s=8'b00110000; end
      else if (a == 29) begin s=8'b00011000; end
      else if (a == 30) begin s=8'b00001100; end
      else if (a == 31) begin s=8'b00000110; end
      else if (a == 32) begin s=8'b00000011; end
      else if (a == 33) begin s=8'b10111001; end
      else if (a == 34) begin s=8'b11100100; end
      else if (a == 35) begin s=8'b01110010; end
      else if (a == 36) begin s=8'b00111001; end
      else if (a == 37) begin s=8'b10100100; end
      else if (a == 38) begin s=8'b01010010; end
      else if (a == 39) begin s=8'b00101001; end
      else if (a == 40) begin s=8'b10101100; end
      else if (a == 41) begin s=8'b01010110; end
      else if (a == 42) begin s=8'b00101011; end
      else if (a == 43) begin s=8'b10101101; end
      else if (a == 44) begin s=8'b11101110; end
      else if (a == 45) begin s=8'b01110111; end
      else if (a == 46) begin s=8'b10000011; end
      else if (a == 47) begin s=8'b11111001; end
      else if (a == 48) begin s=8'b11000100; end
      else if (a == 49) begin s=8'b01100010; end
      else if (a == 50) begin s=8'b00110001; end
      else if (a == 51) begin s=8'b10100000; end
      else if (a == 52) begin s=8'b01010000; end
      else if (a == 53) begin s=8'b00101000; end
      else if (a == 54) begin s=8'b00010100; end
      else if (a == 55) begin s=8'b00001010; end
      else if (a == 56) begin s=8'b00000101; end
      else if (a == 57) begin s=8'b10111010; end
      else if (a == 58) begin s=8'b01011101; end
      else if (a == 59) begin s=8'b10010110; end
      else if (a == 60) begin s=8'b01001011; end
      else if (a == 61) begin s=8'b10011101; end
      else if (a == 62) begin s=8'b11110110; end
      else if (a == 63) begin s=8'b01111011; end
      else if (a == 64) begin s=8'b10000101; end
      else if (a == 65) begin s=8'b11111010; end
      else if (a == 66) begin s=8'b01111101; end
      else if (a == 67) begin s=8'b10000110; end
      else if (a == 68) begin s=8'b01000011; end
      else if (a == 69) begin s=8'b10011001; end
      else if (a == 70) begin s=8'b11110100; end
      else if (a == 71) begin s=8'b01111010; end
      else if (a == 72) begin s=8'b00111101; end
      else if (a == 73) begin s=8'b10100110; end
      else if (a == 74) begin s=8'b01010011; end
      else if (a == 75) begin s=8'b10010001; end
      else if (a == 76) begin s=8'b11110000; end
      else if (a == 77) begin s=8'b01111000; end
      else if (a == 78) begin s=8'b00111100; end
      else if (a == 79) begin s=8'b00011110; end
      else if (a == 80) begin s=8'b00001111; end
      else if (a == 81) begin s=8'b10111111; end
      else if (a == 82) begin s=8'b11100111; end
      else if (a == 83) begin s=8'b11001011; end
      else if (a == 84) begin s=8'b11011101; end
      else if (a == 85) begin s=8'b11010110; end
      else if (a == 86) begin s=8'b01101011; end
      else if (a == 87) begin s=8'b10001101; end
      else if (a == 88) begin s=8'b11111110; end
      else if (a == 89) begin s=8'b01111111; end
      else if (a == 90) begin s=8'b10000111; end
      else if (a == 91) begin s=8'b11111011; end
      else if (a == 92) begin s=8'b11000101; end
      else if (a == 93) begin s=8'b11011010; end
      else if (a == 94) begin s=8'b01101101; end
      else if (a == 95) begin s=8'b10001110; end
      else if (a == 96) begin s=8'b01000111; end
      else if (a == 97) begin s=8'b10011011; end
      else if (a == 98) begin s=8'b11110101; end
      else if (a == 99) begin s=8'b11000010; end
      else if (a == 100) begin s=8'b01100001; end
      else if (a == 101) begin s=8'b10001000; end
      else if (a == 102) begin s=8'b01000100; end
      else if (a == 103) begin s=8'b00100010; end
      else if (a == 104) begin s=8'b00010001; end
      else if (a == 105) begin s=8'b10110000; end
      else if (a == 106) begin s=8'b01011000; end
      else if (a == 107) begin s=8'b00101100; end
      else if (a == 108) begin s=8'b00010110; end
      else if (a == 109) begin s=8'b00001011; end
      else if (a == 110) begin s=8'b10111101; end
      else if (a == 111) begin s=8'b11100110; end
      else if (a == 112) begin s=8'b01110011; end
      else if (a == 113) begin s=8'b10000001; end
      else if (a == 114) begin s=8'b11111000; end
      else if (a == 115) begin s=8'b01111100; end
      else if (a == 116) begin s=8'b00111110; end
      else if (a == 117) begin s=8'b00011111; end
      else if (a == 118) begin s=8'b10110111; end
      else if (a == 119) begin s=8'b11100011; end
      else if (a == 120) begin s=8'b11001001; end
      else if (a == 121) begin s=8'b11011100; end
      else if (a == 122) begin s=8'b01101110; end
      else if (a == 123) begin s=8'b00110111; end
      else if (a == 124) begin s=8'b10100011; end
      else if (a == 125) begin s=8'b11101001; end
      else if (a == 126) begin s=8'b11001100; end
      else if (a == 127) begin s=8'b01100110; end
      else if (a == 128) begin s=8'b00110011; end
      else if (a == 129) begin s=8'b10100001; end
      else if (a == 130) begin s=8'b11101000; end
      else if (a == 131) begin s=8'b01110100; end
      else if (a == 132) begin s=8'b00111010; end
      else if (a == 133) begin s=8'b00011101; end
      else if (a == 134) begin s=8'b10110110; end
      else if (a == 135) begin s=8'b01011011; end
      else if (a == 136) begin s=8'b10010101; end
      else if (a == 137) begin s=8'b11110010; end
      else if (a == 138) begin s=8'b01111001; end
      else if (a == 139) begin s=8'b10000100; end
      else if (a == 140) begin s=8'b01000010; end
      else if (a == 141) begin s=8'b00100001; end
      else if (a == 142) begin s=8'b10101000; end
      else if (a == 143) begin s=8'b01010100; end
      else if (a == 144) begin s=8'b00101010; end
      else if (a == 145) begin s=8'b00010101; end
      else if (a == 146) begin s=8'b10110010; end
      else if (a == 147) begin s=8'b01011001; end
      else if (a == 148) begin s=8'b10010100; end
      else if (a == 149) begin s=8'b01001010; end
      else if (a == 150) begin s=8'b00100101; end
      else if (a == 151) begin s=8'b10101010; end
      else if (a == 152) begin s=8'b01010101; end
      else if (a == 153) begin s=8'b10010010; end
      else if (a == 154) begin s=8'b01001001; end
      else if (a == 155) begin s=8'b10011100; end
      else if (a == 156) begin s=8'b01001110; end
      else if (a == 157) begin s=8'b00100111; end
      else if (a == 158) begin s=8'b10101011; end
      else if (a == 159) begin s=8'b11101101; end
      else if (a == 160) begin s=8'b11001110; end
      else if (a == 161) begin s=8'b01100111; end
      else if (a == 162) begin s=8'b10001011; end
      else if (a == 163) begin s=8'b11111101; end
      else if (a == 164) begin s=8'b11000110; end
      else if (a == 165) begin s=8'b01100011; end
      else if (a == 166) begin s=8'b10001001; end
      else if (a == 167) begin s=8'b11111100; end
      else if (a == 168) begin s=8'b01111110; end
      else if (a == 169) begin s=8'b00111111; end
      else if (a == 170) begin s=8'b10100111; end
      else if (a == 171) begin s=8'b11101011; end
      else if (a == 172) begin s=8'b11001101; end
      else if (a == 173) begin s=8'b11011110; end
      else if (a == 174) begin s=8'b01101111; end
      else if (a == 175) begin s=8'b10001111; end
      else if (a == 176) begin s=8'b11111111; end
      else if (a == 177) begin s=8'b11000111; end
      else if (a == 178) begin s=8'b11011011; end
      else if (a == 179) begin s=8'b11010101; end
      else if (a == 180) begin s=8'b11010010; end
      else if (a == 181) begin s=8'b01101001; end
      else if (a == 182) begin s=8'b10001100; end
      else if (a == 183) begin s=8'b01000110; end
      else if (a == 184) begin s=8'b00100011; end
      else if (a == 185) begin s=8'b10101001; end
      else if (a == 186) begin s=8'b11101100; end
      else if (a == 187) begin s=8'b01110110; end
      else if (a == 188) begin s=8'b00111011; end
      else if (a == 189) begin s=8'b10100101; end
      else if (a == 190) begin s=8'b11101010; end
      else if (a == 191) begin s=8'b01110101; end
      else if (a == 192) begin s=8'b10000010; end
      else if (a == 193) begin s=8'b01000001; end
      else if (a == 194) begin s=8'b10011000; end
      else if (a == 195) begin s=8'b01001100; end
      else if (a == 196) begin s=8'b00100110; end
      else if (a == 197) begin s=8'b00010011; end
      else if (a == 198) begin s=8'b10110001; end
      else if (a == 199) begin s=8'b11100000; end
      else if (a == 200) begin s=8'b01110000; end
      else if (a == 201) begin s=8'b00111000; end
      else if (a == 202) begin s=8'b00011100; end
      else if (a == 203) begin s=8'b00001110; end
      else if (a == 204) begin s=8'b00000111; end
      else if (a == 205) begin s=8'b10111011; end
      else if (a == 206) begin s=8'b11100101; end
      else if (a == 207) begin s=8'b11001010; end
      else if (a == 208) begin s=8'b01100101; end
      else if (a == 209) begin s=8'b10001010; end
      else if (a == 210) begin s=8'b01000101; end
      else if (a == 211) begin s=8'b10011010; end
      else if (a == 212) begin s=8'b01001101; end
      else if (a == 213) begin s=8'b10011110; end
      else if (a == 214) begin s=8'b01001111; end
      else if (a == 215) begin s=8'b10011111; end
      else if (a == 216) begin s=8'b11110111; end
      else if (a == 217) begin s=8'b11000011; end
      else if (a == 218) begin s=8'b11011001; end
      else if (a == 219) begin s=8'b11010100; end
      else if (a == 220) begin s=8'b01101010; end
      else if (a == 221) begin s=8'b00110101; end
      else if (a == 222) begin s=8'b10100010; end
      else if (a == 223) begin s=8'b01010001; end
      else if (a == 224) begin s=8'b10010000; end
      else if (a == 225) begin s=8'b01001000; end
      else if (a == 226) begin s=8'b00100100; end
      else if (a == 227) begin s=8'b00010010; end
      else if (a == 228) begin s=8'b00001001; end
      else if (a == 229) begin s=8'b10111100; end
      else if (a == 230) begin s=8'b01011110; end
      else if (a == 231) begin s=8'b00101111; end
      else if (a == 232) begin s=8'b10101111; end
      else if (a == 233) begin s=8'b11101111; end
      else if (a == 234) begin s=8'b11001111; end
      else if (a == 235) begin s=8'b11011111; end
      else if (a == 236) begin s=8'b11010111; end
      else if (a == 237) begin s=8'b11010011; end
      else if (a == 238) begin s=8'b11010001; end
      else if (a == 239) begin s=8'b11010000; end
      else if (a == 240) begin s=8'b01101000; end
      else if (a == 241) begin s=8'b00110100; end
      else if (a == 242) begin s=8'b00011010; end
      else if (a == 243) begin s=8'b00001101; end
      else if (a == 244) begin s=8'b10111110; end
      else if (a == 245) begin s=8'b01011111; end
      else if (a == 246) begin s=8'b10010111; end
      else if (a == 247) begin s=8'b11110011; end
      else if (a == 248) begin s=8'b11000001; end
      else if (a == 249) begin s=8'b11011000; end
      else if (a == 250) begin s=8'b01101100; end
      else if (a == 251) begin s=8'b00110110; end
      else if (a == 252) begin s=8'b00011011; end
      else if (a == 253) begin s=8'b10110101; end
      else if (a == 254) begin s=8'b11100010; end
      else if (a == 255) begin s=8'b01110001; end
  
  return s;
endfunction
  
function int getIndex (input bit [`SYMBOL_WIDTH-1:0] a);
  int i;
  
  if (a == 8'b00000000) begin i=8'd0; end
      else if (a == 8'b10000000) begin i=8'd1; end
      else if (a == 8'b01000000) begin i=8'd2; end
      else if (a == 8'b00100000) begin i=8'd3; end
      else if (a == 8'b00010000) begin i=8'd4; end
      else if (a == 8'b00001000) begin i=8'd5; end
      else if (a == 8'b00000100) begin i=8'd6; end
      else if (a == 8'b00000010) begin i=8'd7; end
      else if (a == 8'b00000001) begin i=8'd8; end
      else if (a == 8'b10111000) begin i=8'd9; end
      else if (a == 8'b01011100) begin i=8'd10; end
      else if (a == 8'b00101110) begin i=8'd11; end
      else if (a == 8'b00010111) begin i=8'd12; end
      else if (a == 8'b10110011) begin i=8'd13; end
      else if (a == 8'b11100001) begin i=8'd14; end
      else if (a == 8'b11001000) begin i=8'd15; end
      else if (a == 8'b01100100) begin i=8'd16; end
      else if (a == 8'b00110010) begin i=8'd17; end
      else if (a == 8'b00011001) begin i=8'd18; end
      else if (a == 8'b10110100) begin i=8'd19; end
      else if (a == 8'b01011010) begin i=8'd20; end
      else if (a == 8'b00101101) begin i=8'd21; end
      else if (a == 8'b10101110) begin i=8'd22; end
      else if (a == 8'b01010111) begin i=8'd23; end
      else if (a == 8'b10010011) begin i=8'd24; end
      else if (a == 8'b11110001) begin i=8'd25; end
      else if (a == 8'b11000000) begin i=8'd26; end
      else if (a == 8'b01100000) begin i=8'd27; end
      else if (a == 8'b00110000) begin i=8'd28; end
      else if (a == 8'b00011000) begin i=8'd29; end
      else if (a == 8'b00001100) begin i=8'd30; end
      else if (a == 8'b00000110) begin i=8'd31; end
      else if (a == 8'b00000011) begin i=8'd32; end
      else if (a == 8'b10111001) begin i=8'd33; end
      else if (a == 8'b11100100) begin i=8'd34; end
      else if (a == 8'b01110010) begin i=8'd35; end
      else if (a == 8'b00111001) begin i=8'd36; end
      else if (a == 8'b10100100) begin i=8'd37; end
      else if (a == 8'b01010010) begin i=8'd38; end
      else if (a == 8'b00101001) begin i=8'd39; end
      else if (a == 8'b10101100) begin i=8'd40; end
      else if (a == 8'b01010110) begin i=8'd41; end
      else if (a == 8'b00101011) begin i=8'd42; end
      else if (a == 8'b10101101) begin i=8'd43; end
      else if (a == 8'b11101110) begin i=8'd44; end
      else if (a == 8'b01110111) begin i=8'd45; end
      else if (a == 8'b10000011) begin i=8'd46; end
      else if (a == 8'b11111001) begin i=8'd47; end
      else if (a == 8'b11000100) begin i=8'd48; end
      else if (a == 8'b01100010) begin i=8'd49; end
      else if (a == 8'b00110001) begin i=8'd50; end
      else if (a == 8'b10100000) begin i=8'd51; end
      else if (a == 8'b01010000) begin i=8'd52; end
      else if (a == 8'b00101000) begin i=8'd53; end
      else if (a == 8'b00010100) begin i=8'd54; end
      else if (a == 8'b00001010) begin i=8'd55; end
      else if (a == 8'b00000101) begin i=8'd56; end
      else if (a == 8'b10111010) begin i=8'd57; end
      else if (a == 8'b01011101) begin i=8'd58; end
      else if (a == 8'b10010110) begin i=8'd59; end
      else if (a == 8'b01001011) begin i=8'd60; end
      else if (a == 8'b10011101) begin i=8'd61; end
      else if (a == 8'b11110110) begin i=8'd62; end
      else if (a == 8'b01111011) begin i=8'd63; end
      else if (a == 8'b10000101) begin i=8'd64; end
      else if (a == 8'b11111010) begin i=8'd65; end
      else if (a == 8'b01111101) begin i=8'd66; end
      else if (a == 8'b10000110) begin i=8'd67; end
      else if (a == 8'b01000011) begin i=8'd68; end
      else if (a == 8'b10011001) begin i=8'd69; end
      else if (a == 8'b11110100) begin i=8'd70; end
      else if (a == 8'b01111010) begin i=8'd71; end
      else if (a == 8'b00111101) begin i=8'd72; end
      else if (a == 8'b10100110) begin i=8'd73; end
      else if (a == 8'b01010011) begin i=8'd74; end
      else if (a == 8'b10010001) begin i=8'd75; end
      else if (a == 8'b11110000) begin i=8'd76; end
      else if (a == 8'b01111000) begin i=8'd77; end
      else if (a == 8'b00111100) begin i=8'd78; end
      else if (a == 8'b00011110) begin i=8'd79; end
      else if (a == 8'b00001111) begin i=8'd80; end
      else if (a == 8'b10111111) begin i=8'd81; end
      else if (a == 8'b11100111) begin i=8'd82; end
      else if (a == 8'b11001011) begin i=8'd83; end
      else if (a == 8'b11011101) begin i=8'd84; end
      else if (a == 8'b11010110) begin i=8'd85; end
      else if (a == 8'b01101011) begin i=8'd86; end
      else if (a == 8'b10001101) begin i=8'd87; end
      else if (a == 8'b11111110) begin i=8'd88; end
      else if (a == 8'b01111111) begin i=8'd89; end
      else if (a == 8'b10000111) begin i=8'd90; end
      else if (a == 8'b11111011) begin i=8'd91; end
      else if (a == 8'b11000101) begin i=8'd92; end
      else if (a == 8'b11011010) begin i=8'd93; end
      else if (a == 8'b01101101) begin i=8'd94; end
      else if (a == 8'b10001110) begin i=8'd95; end
      else if (a == 8'b01000111) begin i=8'd96; end
      else if (a == 8'b10011011) begin i=8'd97; end
      else if (a == 8'b11110101) begin i=8'd98; end
      else if (a == 8'b11000010) begin i=8'd99; end
      else if (a == 8'b01100001) begin i=8'd100; end
      else if (a == 8'b10001000) begin i=8'd101; end
      else if (a == 8'b01000100) begin i=8'd102; end
      else if (a == 8'b00100010) begin i=8'd103; end
      else if (a == 8'b00010001) begin i=8'd104; end
      else if (a == 8'b10110000) begin i=8'd105; end
      else if (a == 8'b01011000) begin i=8'd106; end
      else if (a == 8'b00101100) begin i=8'd107; end
      else if (a == 8'b00010110) begin i=8'd108; end
      else if (a == 8'b00001011) begin i=8'd109; end
      else if (a == 8'b10111101) begin i=8'd110; end
      else if (a == 8'b11100110) begin i=8'd111; end
      else if (a == 8'b01110011) begin i=8'd112; end
      else if (a == 8'b10000001) begin i=8'd113; end
      else if (a == 8'b11111000) begin i=8'd114; end
      else if (a == 8'b01111100) begin i=8'd115; end
      else if (a == 8'b00111110) begin i=8'd116; end
      else if (a == 8'b00011111) begin i=8'd117; end
      else if (a == 8'b10110111) begin i=8'd118; end
      else if (a == 8'b11100011) begin i=8'd119; end
      else if (a == 8'b11001001) begin i=8'd120; end
      else if (a == 8'b11011100) begin i=8'd121; end
      else if (a == 8'b01101110) begin i=8'd122; end
      else if (a == 8'b00110111) begin i=8'd123; end
      else if (a == 8'b10100011) begin i=8'd124; end
      else if (a == 8'b11101001) begin i=8'd125; end
      else if (a == 8'b11001100) begin i=8'd126; end
      else if (a == 8'b01100110) begin i=8'd127; end
      else if (a == 8'b00110011) begin i=8'd128; end
      else if (a == 8'b10100001) begin i=8'd129; end
      else if (a == 8'b11101000) begin i=8'd130; end
      else if (a == 8'b01110100) begin i=8'd131; end
      else if (a == 8'b00111010) begin i=8'd132; end
      else if (a == 8'b00011101) begin i=8'd133; end
      else if (a == 8'b10110110) begin i=8'd134; end
      else if (a == 8'b01011011) begin i=8'd135; end
      else if (a == 8'b10010101) begin i=8'd136; end
      else if (a == 8'b11110010) begin i=8'd137; end
      else if (a == 8'b01111001) begin i=8'd138; end
      else if (a == 8'b10000100) begin i=8'd139; end
      else if (a == 8'b01000010) begin i=8'd140; end
      else if (a == 8'b00100001) begin i=8'd141; end
      else if (a == 8'b10101000) begin i=8'd142; end
      else if (a == 8'b01010100) begin i=8'd143; end
      else if (a == 8'b00101010) begin i=8'd144; end
      else if (a == 8'b00010101) begin i=8'd145; end
      else if (a == 8'b10110010) begin i=8'd146; end
      else if (a == 8'b01011001) begin i=8'd147; end
      else if (a == 8'b10010100) begin i=8'd148; end
      else if (a == 8'b01001010) begin i=8'd149; end
      else if (a == 8'b00100101) begin i=8'd150; end
      else if (a == 8'b10101010) begin i=8'd151; end
      else if (a == 8'b01010101) begin i=8'd152; end
      else if (a == 8'b10010010) begin i=8'd153; end
      else if (a == 8'b01001001) begin i=8'd154; end
      else if (a == 8'b10011100) begin i=8'd155; end
      else if (a == 8'b01001110) begin i=8'd156; end
      else if (a == 8'b00100111) begin i=8'd157; end
      else if (a == 8'b10101011) begin i=8'd158; end
      else if (a == 8'b11101101) begin i=8'd159; end
      else if (a == 8'b11001110) begin i=8'd160; end
      else if (a == 8'b01100111) begin i=8'd161; end
      else if (a == 8'b10001011) begin i=8'd162; end
      else if (a == 8'b11111101) begin i=8'd163; end
      else if (a == 8'b11000110) begin i=8'd164; end
      else if (a == 8'b01100011) begin i=8'd165; end
      else if (a == 8'b10001001) begin i=8'd166; end
      else if (a == 8'b11111100) begin i=8'd167; end
      else if (a == 8'b01111110) begin i=8'd168; end
      else if (a == 8'b00111111) begin i=8'd169; end
      else if (a == 8'b10100111) begin i=8'd170; end
      else if (a == 8'b11101011) begin i=8'd171; end
      else if (a == 8'b11001101) begin i=8'd172; end
      else if (a == 8'b11011110) begin i=8'd173; end
      else if (a == 8'b01101111) begin i=8'd174; end
      else if (a == 8'b10001111) begin i=8'd175; end
      else if (a == 8'b11111111) begin i=8'd176; end
      else if (a == 8'b11000111) begin i=8'd177; end
      else if (a == 8'b11011011) begin i=8'd178; end
      else if (a == 8'b11010101) begin i=8'd179; end
      else if (a == 8'b11010010) begin i=8'd180; end
      else if (a == 8'b01101001) begin i=8'd181; end
      else if (a == 8'b10001100) begin i=8'd182; end
      else if (a == 8'b01000110) begin i=8'd183; end
      else if (a == 8'b00100011) begin i=8'd184; end
      else if (a == 8'b10101001) begin i=8'd185; end
      else if (a == 8'b11101100) begin i=8'd186; end
      else if (a == 8'b01110110) begin i=8'd187; end
      else if (a == 8'b00111011) begin i=8'd188; end
      else if (a == 8'b10100101) begin i=8'd189; end
      else if (a == 8'b11101010) begin i=8'd190; end
      else if (a == 8'b01110101) begin i=8'd191; end
      else if (a == 8'b10000010) begin i=8'd192; end
      else if (a == 8'b01000001) begin i=8'd193; end
      else if (a == 8'b10011000) begin i=8'd194; end
      else if (a == 8'b01001100) begin i=8'd195; end
      else if (a == 8'b00100110) begin i=8'd196; end
      else if (a == 8'b00010011) begin i=8'd197; end
      else if (a == 8'b10110001) begin i=8'd198; end
      else if (a == 8'b11100000) begin i=8'd199; end
      else if (a == 8'b01110000) begin i=8'd200; end
      else if (a == 8'b00111000) begin i=8'd201; end
      else if (a == 8'b00011100) begin i=8'd202; end
      else if (a == 8'b00001110) begin i=8'd203; end
      else if (a == 8'b00000111) begin i=8'd204; end
      else if (a == 8'b10111011) begin i=8'd205; end
      else if (a == 8'b11100101) begin i=8'd206; end
      else if (a == 8'b11001010) begin i=8'd207; end
      else if (a == 8'b01100101) begin i=8'd208; end
      else if (a == 8'b10001010) begin i=8'd209; end
      else if (a == 8'b01000101) begin i=8'd210; end
      else if (a == 8'b10011010) begin i=8'd211; end
      else if (a == 8'b01001101) begin i=8'd212; end
      else if (a == 8'b10011110) begin i=8'd213; end
      else if (a == 8'b01001111) begin i=8'd214; end
      else if (a == 8'b10011111) begin i=8'd215; end
      else if (a == 8'b11110111) begin i=8'd216; end
      else if (a == 8'b11000011) begin i=8'd217; end
      else if (a == 8'b11011001) begin i=8'd218; end
      else if (a == 8'b11010100) begin i=8'd219; end
      else if (a == 8'b01101010) begin i=8'd220; end
      else if (a == 8'b00110101) begin i=8'd221; end
      else if (a == 8'b10100010) begin i=8'd222; end
      else if (a == 8'b01010001) begin i=8'd223; end
      else if (a == 8'b10010000) begin i=8'd224; end
      else if (a == 8'b01001000) begin i=8'd225; end
      else if (a == 8'b00100100) begin i=8'd226; end
      else if (a == 8'b00010010) begin i=8'd227; end
      else if (a == 8'b00001001) begin i=8'd228; end
      else if (a == 8'b10111100) begin i=8'd229; end
      else if (a == 8'b01011110) begin i=8'd230; end
      else if (a == 8'b00101111) begin i=8'd231; end
      else if (a == 8'b10101111) begin i=8'd232; end
      else if (a == 8'b11101111) begin i=8'd233; end
      else if (a == 8'b11001111) begin i=8'd234; end
      else if (a == 8'b11011111) begin i=8'd235; end
      else if (a == 8'b11010111) begin i=8'd236; end
      else if (a == 8'b11010011) begin i=8'd237; end
      else if (a == 8'b11010001) begin i=8'd238; end
      else if (a == 8'b11010000) begin i=8'd239; end
      else if (a == 8'b01101000) begin i=8'd240; end
      else if (a == 8'b00110100) begin i=8'd241; end
      else if (a == 8'b00011010) begin i=8'd242; end
      else if (a == 8'b00001101) begin i=8'd243; end
      else if (a == 8'b10111110) begin i=8'd244; end
      else if (a == 8'b01011111) begin i=8'd245; end
      else if (a == 8'b10010111) begin i=8'd246; end
      else if (a == 8'b11110011) begin i=8'd247; end
      else if (a == 8'b11000001) begin i=8'd248; end
      else if (a == 8'b11011000) begin i=8'd249; end
      else if (a == 8'b01101100) begin i=8'd250; end
      else if (a == 8'b00110110) begin i=8'd251; end
      else if (a == 8'b00011011) begin i=8'd252; end
      else if (a == 8'b10110101) begin i=8'd253; end
      else if (a == 8'b11100010) begin i=8'd254; end
      else if (a == 8'b01110001) begin i=8'd255; end
  
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


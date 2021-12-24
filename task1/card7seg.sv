module card7seg(input logic [3:0] SW, 
                output logic [6:0] HEX0);
		
	always @(SW) begin  // purely combinational block
	
		case (SW)
		    0: HEX0 = 7'b1111111;   
			1: HEX0 = 7'b0001000;  
			2: HEX0 = 7'b0100100;
			3: HEX0 = 7'b0110000;
			4: HEX0 = 7'b0011001;
			5: HEX0 = 7'b0010010;
			6: HEX0 = 7'b0000010;
			7: HEX0 = 7'b1111000;
			8: HEX0 = 7'b0000000;
			9: HEX0 = 7'b0010000;
		  10: HEX0 = 7'b1000000;
		  11: HEX0 = 7'b1100001;
		  12: HEX0 = 7'b0011000;
		  13: HEX0 = 7'b0001001;		
			default: HEX0 = 7'b1111111;   // takes care of 0 14 and 15 cases
		endcase
	
	end
	
endmodule


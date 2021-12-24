module card7seg(input logic [3:0] card, output logic [6:0] seg7);

   always @(card) begin  // purely combinational block
	
		case (card)
		   	0: seg7 = 7'b1111111;   
			1: seg7 = 7'b0001000;  
			2: seg7 = 7'b0100100;
			3: seg7 = 7'b0110000;
			4: seg7 = 7'b0011001;
			5: seg7 = 7'b0010010;
			6: seg7 = 7'b0000010;
			7: seg7 = 7'b1111000;
			8: seg7 = 7'b0000000;
			9: seg7 = 7'b0010000;
			10: seg7 = 7'b1000000; // show 0
		    11: seg7 = 7'b1100001; // show J
		   	12: seg7 = 7'b0011000; // show q
		   	13: seg7 = 7'b0001001; // show H (for king)		
	  		default: seg7 = 7'b1111111;   // takes care of 14 and 15 cases
		endcase
	
	end

endmodule


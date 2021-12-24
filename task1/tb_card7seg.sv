module tb_card7seg();

reg [3:0] SW;
wire [6:0] HEX0;

localparam delay =  10; // set delay to 10 ns
integer i = 0;

card7seg u_card7seg (  // instantiate design under test
    .SW      (SW),
    .HEX0    (HEX0)
);

initial
	begin
        while (i < 16)
			begin
				SW = i;
				#delay; 
				i = i + 1;
			end
	end						
endmodule


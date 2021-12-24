module scorehand(input logic [3:0] card1, 
                input logic [3:0] card2, 
                input logic [3:0] card3, 
                output logic [3:0] total);

// The code describing scorehand will go here.  Remember this is a combinational
// block. The function is described in the handout. Be sure to review Verilog
// notes on bitwidth mismatches and signed/unsigned numbers.

always_comb begin
    integer a, b, c;

    if (card1 >= 10) begin
        a = 0;
    end
    else begin
        a = card1;      
    end
       
    if (card2 >= 10) begin
        b = 0;
    end
    else begin
        b = card2;
    end

    if (card3 >= 10) begin
        c = 0;
    end
    else begin
        c = card3;
    end

    total = (a + b + c) % 10;
end

endmodule


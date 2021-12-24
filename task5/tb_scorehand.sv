module tb_scorehand();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").

logic [3:0] card_1;
logic [3:0] card_2;
logic [3:0] card_3;
wire [3:0] total;

integer i;
localparam delay = 10;

scorehand u_scorehand_test ( // instantiate scorehand module
    .card1    (card_1),
    .card2    (card_2),
    .card3    (card_3),
    .total    (total)
);

initial begin

    // test that when card1, card2, and card 3 equal 0, total is 0
    for (i = 0; i < 16; i=i+1) begin
        card_1 = i;
        card_2 = i;
        card_3 = i;

        #delay;
    end

    // check that total always falls within range of [0,9]
    label_range: assert ((total >= 0) && (total <= 9))
        else $error("total is out of range");

    #delay;

    
end
endmodule

module datapath(input logic slow_clock, input logic fast_clock, input logic resetb,
                input logic load_pcard1, input logic load_pcard2, input logic load_pcard3,
                input logic load_dcard1, input logic load_dcard2, input logic load_dcard3,
                output logic [3:0] pcard3_out,
                output logic [3:0] pscore_out, output logic [3:0] dscore_out,
                output logic [6:0] HEX5, output logic [6:0] HEX4, output logic [6:0] HEX3,
                output logic [6:0] HEX2, output logic [6:0] HEX1, output logic [6:0] HEX0);

// Datapath keeps track of all the player and dealer hands, and computes score.
// Datapath code describes 6 card7seg, 2 scorehand, 3 player registers,
// 3 dealer registers, and the dealercard.  

logic [3:0] new_card;
logic [3:0] pcard1, pcard2, pcard3;
logic [3:0] dcard1, dcard2, dcard3;

// instantiate six card7seg blocks

card7seg u_card7seg_p1 (
    .card    (pcard1),
    .seg7    (HEX0)
);

card7seg u_card7seg_p2 (
    .card    (pcard2),
    .seg7    (HEX1)
);

card7seg u_card7seg_p3 (
    .card    (pcard3),
    .seg7    (HEX2)
);

card7seg u_card7seg_d1 (
    .card    (dcard1),
    .seg7    (HEX3)
);

card7seg u_card7seg_d2 (
    .card    (dcard2),
    .seg7    (HEX4)
);

card7seg u_card7seg_d3 (
    .card    (dcard3),
    .seg7    (HEX5)
);

// instantiate 2 scorehand blocks

scorehand u_scorehand_p (
    .card1    (pcard1),
    .card2    (pcard2),
    .card3    (pcard3),
    .total    (pscore_out)
);

scorehand u_scorehand_d (
    .card1    (dcard1),
    .card2    (dcard2),
    .card3    (dcard3),
    .total    (dscore_out)
);

// instantiate dealercard

dealcard u_dealcard (
    .clock       (fast_clock),
    .resetb      (resetb),
    .new_card    (new_card)
);

// writing 6 D-FFs

// 3 for player
always_ff @(posedge slow_clock)     // pcard1
    if (resetb == 0)
        pcard1 <= 0;
    else begin
        if (load_pcard1 == 1)
            pcard1 <= new_card;
    end        

always_ff @(posedge slow_clock)     // pcard2
    if (resetb == 0)
        pcard2 <= 0;
    else begin
        if (load_pcard2 == 1)
            pcard2 <= new_card;
    end        

always_ff @(posedge slow_clock)     // pcard3
    if (resetb == 0)
        pcard3 <= 0;
    else begin
        if (load_pcard3 == 1)
            pcard3 <= new_card;
    end

// 3 for dealer
always_ff @(posedge slow_clock)     // dcard1
    if (resetb == 0)
        dcard1 <= 0;
    else begin
        if (load_dcard1 == 1)
            dcard1 <= new_card;
    end        

always_ff @(posedge slow_clock)     // card2
    if (resetb == 0)
        dcard2 <= 0;
    else begin
        if (load_dcard2 == 1)
            dcard2 <= new_card;
    end        

always_ff @(posedge slow_clock)     // dcard3
    if (resetb == 0)
        dcard3 <= 0;
    else begin
        if (load_dcard3 == 1)
            dcard3 <= new_card;
    end

assign pcard3_out = pcard3;

endmodule


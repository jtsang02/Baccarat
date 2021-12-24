module tb_datapath();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").

logic slow_clock, fast_clock, resetb;
logic load_dcard1, load_dcard2, load_dcard3;
logic load_pcard1, load_pcard2, load_pcard3;
logic [3:0] pcard1, pcard2, pcard3;
logic [3:0] dcard1, dcard2, dcard3;
logic [3:0] pcard3_out; 
logic [3:0] pscore_out, dscore_out;
wire [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

localparam delay = 10;

datapath u_datapath (
    .slow_clock     (slow_clock), // inputs
    .fast_clock     (fast_clock),
    .resetb         (resetb),
    .load_pcard1    (load_pcard1),
    .load_pcard2    (load_pcard2),
    .load_pcard3    (load_pcard3),
    .load_dcard1    (load_dcard1),
    .load_dcard2    (load_dcard2),
    .load_dcard3    (load_dcard3),
    .pcard3_out     (pcard3_out),  // outputs
    .pscore_out     (pscore_out),
    .dscore_out     (dscore_out),
    .HEX5           (HEX5),
    .HEX4           (HEX4),
    .HEX3           (HEX3),
    .HEX2           (HEX2),
    .HEX1           (HEX1),
    .HEX0           (HEX0)
);

// generate clocks
initial begin
    slow_clock = 0;
    forever #5 slow_clock = ~ slow_clock;
end

initial begin
    fast_clock = 0;
    forever #2 fast_clock = ~ fast_clock;
end

initial begin
    
    resetb <= 0;
    load_pcard1 <= 0;
    load_pcard2 <= 0;
    load_pcard3 <= 0;
    load_dcard1 <= 0;
    load_dcard2 <= 0;
    load_dcard3 <= 0;
    #delay;

    resetb <= 1;
    load_pcard1 <= 1;
    load_pcard2 <= 0;
    load_pcard3 <= 0;
    load_dcard1 <= 1;
    load_dcard2 <= 0;
    load_dcard3 <= 0;
    #delay; 

    resetb <= 0;
    #delay; 

    resetb <= 1;
    load_pcard1 <= 1;
    load_pcard2 <= 1;
    load_pcard3 <= 1;
    load_dcard1 <= 1;
    load_dcard2 <= 1;
    load_dcard3 <= 1;
    #delay; 

end

endmodule

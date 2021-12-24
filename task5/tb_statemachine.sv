module tb_statemachine();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").


logic slow_clock, resetb;
logic [3:0] dscore, pscore, pcard3;
logic load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3;
logic player_win_light, dealer_win_light;

statemachine u_statemachine (
    .slow_clock (slow_clock),
    .resetb (resetb),
    .dscore (dscore),
    .pscore (pscore),
    .pcard3 (pcard3),
    .load_pcard1 (load_pcard1),
    .load_pcard2 (load_pcard2),
    .load_pcard3 (load_pcard3),
    .load_dcard1 (load_dcard1),
    .load_dcard2 (load_dcard2),
    .load_dcard3 (load_dcard3),
    .player_win_light (player_win_light),
    .dealer_win_light (dealer_win_light)
);

typedef enum logic [3:0] { START, LOAD_P1, LOAD_D1, LOAD_P2, LOAD_D2, LOAD_P3, LOAD_D3, RESULT } State;
State current_state, next_state;

initial
    begin
        resetb <= 0;    #10;

        resetb <= 1;

            #10;        // LOAD_P1
            loadP1: assert (load_pcard1 == 1)
                else $error("Assertion loadP1 failed!");
            #10;        // LOAD_D1
            loadD1: assert (load_dcard1 == 1)
                else $error("Assertion loadD2 failed!");
            #10;        // LOAD_P2
            loadP2: assert (load_pcard2 == 1)
                else $error("Assertion loadP2 failed!");
            #10;        // LOAD_D2
            loadD2: assert (load_dcard2 == 1)
                else $error("Assertion loadD2 failed!");

            dscore = 5; // Case 1 - natural
            pscore = 9; 
            pcard3 = 2;

            #10; 
            CaseNatural: assert (player_win_light == 1)
                else $error("player should win!");

            #10;
            CaseStart: assert (load_pcard1 == 0 &&
                                load_pcard2 == 0 &&
                                load_pcard3 == 0 &&
                                load_dcard1 == 0 &&
                                load_dcard2 == 0 &&
                                load_dcard3 == 0 &&
                                player_win_light == 0 &&
                                dealer_win_light == 0)
                else $error("Assertion CaseStart failed!");

            #40;        // LOAD_P1 - LOAD_D2

            dscore = 7; // Case 2a - player 3rd card and banker no 3rd card
            pscore = 3; 
            pcard3 = 2;

            #10;
            Case3rdCardP: assert (load_pcard3 == 1 && load_dcard3 == 0)
                else $error("failed to load card 3 for player!");

            #10;
            CaseDWin: assert (dealer_win_light == 1)
                else $error("dealer should win");

            #40;        // LOAD_P1 - LOAD_D2

            dscore = 6; // Case 2b - player 3rd card and banker 3rd card
            pscore = 4;  
            pcard3 = 6;

            #10; 
            Case3rdCard1: assert (load_pcard3 == load_dcard1 == 1)
                else $error("load card 3 for player and banker failed!");

            #10; #10;

            dscore = 6; 
            pscore = 6;  
            pcard3 = 6;
           
            CaseTie: assert (player_win_light == dealer_win_light == 1)
                else $error("should be a tie");

            #40;        // LOAD_P1 - LOAD_D2

            dscore = 5; // Case 2c - player 3rd card and banker 3rd card
            pscore = 5;  
            pcard3 = 5;

            #10; 
            Case3rdCard2: assert (load_pcard3 == load_dcard1 == 1)
                else $error("load card 3 for player and banker failed!");
            
            #10; #10;

            dscore = 5; 
            pscore = 6;  
            pcard3 = 5;
           
            #10;

            #40;        // LOAD_P1 - LOAD_D2

            dscore = 4; // Case 2d - player 3rd card and banker 3rd card
            pscore = 0;  
            pcard3 = 3;

            #10; 
            Case3rdCard3: assert (load_pcard3 == load_dcard1 == 1)
                else $error("load card 3 for player and banker failed!");
            
            #10; #10;

            dscore = 8; 
            pscore = 4;  
            pcard3 = 5;
           
           #10;
            CaseDWin3: assert (dealer_win_light == 1)
                else $error("dealer should win");  

            #40;        // LOAD_P1 - LOAD_D2

            dscore = 3; // Case 2e - player 3rd card and banker 3rd card
            pscore = 0;  
            pcard3 = 2;

            #10; 
            Case3rdCard4: assert (load_pcard3 == load_dcard1 == 1)
                else $error("load card 3 for player and banker failed!");
            
            #30;
            CaseDWin4: assert (dealer_win_light == 1)
                else $error("dealer should win");  

            #40;        // LOAD_P1 - LOAD_D2

            dscore = 1; // Case 2f - player 3rd card and banker 3rd card
            pscore = 0;  
            pcard3 = 0;

            #10; 
            Case3rdCard5: assert (load_pcard3 == load_dcard1 == 1)
                else $error("load card 3 for player and banker failed!");
            
            #30;
            CaseDWin5: assert (dealer_win_light == 1)
                else $error("dealer should win");  
            
            #40;        // LOAD_P1 - LOAD_D2

            dscore = 5; // Case 3 - player no 3rd card and banker gets 3rd card
            pscore = 6;  
            pcard3 = 2;

            #20;
            Case3rdCardD: assert (load_dcard3 == 1)
                else $error("load card 3 for banker failed!");
            
            #30;
            CasePWin5: assert (player_win_light == 1)
                else $error("player should win");  
            
            #40;        // LOAD_P1 - LOAD_D2
                    
    end

always
    begin
        slow_clock <= 1;    #5;
        slow_clock <= 0;    #5;
    end

endmodule

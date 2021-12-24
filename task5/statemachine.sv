module statemachine(input logic slow_clock, input logic resetb,
                    input logic [3:0] dscore, input logic [3:0] pscore, input logic [3:0] pcard3,
                    output logic load_pcard1, output logic load_pcard2, output logic load_pcard3,
                    output logic load_dcard1, output logic load_dcard2, output logic load_dcard3,
                    output logic player_win_light, output logic dealer_win_light);

typedef enum logic [3:0] { START, LOAD_P1, LOAD_D1, LOAD_P2, LOAD_D2, LOAD_P3, LOAD_D3, RESULT } State;
State current_state, next_state;

// sequential logic for when user presses KEY0
always_ff @(posedge slow_clock) begin
    if (resetb == 0)
        current_state <= START;
    else
        current_state <= next_state;

    case (current_state)        // output logic
    
        START: begin
            // (A) default (starting) state: pscore = 0; dscore = 0;
            load_pcard1 <= 0;
            load_pcard2 <= 0;
            load_pcard3 <= 0;
            load_dcard1 <= 0;
            load_dcard2 <= 0;
            load_dcard3 <= 0;
            dealer_win_light <= 0;
            player_win_light <= 0;
        end

        LOAD_P1: begin
            // (B) load 1st card to player, pscore = 0; dscore = 0;
            load_pcard1 <= 1;
            load_pcard2 <= 0;
            load_pcard3 <= 0;
            load_dcard1 <= 0;
            load_dcard2 <= 0;
            load_dcard3 <= 0;
        end

        LOAD_D1: begin
            // (C) load first card to dealer, pscore = 0; dscore = 0;
            load_pcard1 <= 0;
            load_pcard2 <= 0;
            load_pcard3 <= 0;
            load_dcard1 <= 1;
            load_dcard2 <= 0;
            load_dcard3 <= 0;
        end 
    
        LOAD_P2: begin    
            // (D) load 2nd card to player: pscore = 0; dscore = 0;
            load_pcard1 <= 0;
            load_pcard2 <= 1;
            load_pcard3 <= 0;
            load_dcard1 <= 0;
            load_dcard2 <= 0;
            load_dcard3 <= 0;
        end

        LOAD_D2: begin
            // (E) load 2nd card to dealer: pscore = 0; dscore = 0;
            load_pcard1 <= 0;
            load_pcard2 <= 0;
            load_pcard3 <= 0;
            load_dcard1 <= 0;
            load_dcard2 <= 1;
            load_dcard3 <= 0; 
        end

        LOAD_P3: begin    
            // (F) load 3rd card to player: pscore = 0; dscore = 0;
            load_pcard1 <= 0;
            load_pcard2 <= 0;
            load_pcard3 <= 1;
            load_dcard1 <= 0;
            load_dcard2 <= 0;
            load_dcard3 <= 0;
        end

        LOAD_D3: begin
            // (G) load 3rd card to dealer: pscore = 0; dscore = 0;
            load_pcard1 <= 0;
            load_pcard2 <= 0;
            load_pcard3 <= 0;
            load_dcard1 <= 0;
            load_dcard2 <= 0;
            load_dcard3 <= 1; 
        end

        RESULT: begin
            // determine who wins or tie
            load_pcard1 <= 0;
            load_pcard2 <= 0;
            load_pcard3 <= 0;
            load_dcard1 <= 0;
            load_dcard2 <= 0;
            load_dcard3 <= 0; 
        
            if (pscore > dscore) begin        // player wins
                dealer_win_light <= 0;
                player_win_light <= 1;
            end 
            else if (dscore > pscore) begin  // dealer wins
                dealer_win_light <= 1;
                player_win_light <= 0;
            end
            else begin                       // tie                        
                dealer_win_light <= 1;
                player_win_light <= 1;
            end  
        end

        default: begin
            load_pcard1 <= 0;
            load_pcard2 <= 0;
            load_pcard3 <= 0;
            load_dcard1 <= 0;
            load_dcard2 <= 0;
            load_dcard3 <= 0;
            dealer_win_light <= 0;
            player_win_light <= 0;
        end

    endcase

end

always_comb begin

    case (current_state)        // next state logic

        START: next_state = LOAD_P1;
        LOAD_P1: next_state = LOAD_D1;
        LOAD_D1: next_state = LOAD_P2;  
        LOAD_P2: next_state = LOAD_D2;
        LOAD_D2: begin
            if ((pscore >= 8) || (dscore >= 8))
                next_state = RESULT;
            else if (pscore <= 5)
                next_state = LOAD_P3;
            else begin
                if ((dscore >= 0) && (dscore <= 5))
                    next_state = LOAD_D3;
                else
                    next_state = RESULT;                   
            end
        end
        LOAD_P3: begin
            if ((dscore == 6) && ((pcard3 == 6) || (pcard3 == 7)))      // condition b.
                next_state = LOAD_D3;
            else if ((dscore == 5) && ((pcard3 >= 4) && (pcard3 <= 7))) // condition c.
                next_state = LOAD_D3;
            else if ((dscore == 4) && ((pcard3 >= 2) && (pcard3 <= 7))) // condition d.           
                next_state = LOAD_D3;
            else if ((dscore == 3) && (pcard3 != 8))                    // condition e.
                next_state = LOAD_D3;
            else if (dscore <= 2)                                       // condition f.       
                next_state = LOAD_D3;    
            else
                next_state = RESULT;              
        end
        LOAD_D3: next_state = RESULT;
        RESULT: next_state = START;
        default: next_state = START;

    endcase

end

endmodule


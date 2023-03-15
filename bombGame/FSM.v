module FSM(i_Clk, i_Rst, i_Remove_Glitch_fStart, i_Score, i_Sec30Tick, o_State);

input i_Clk, i_Rst;
input i_Remove_Glitch_fStart;
input [4:0] i_Score;
input i_Sec30Tick;
output [2:0] o_State;

//Parameters
parameter state_idle = 3'b000;
parameter state_game_start = 3'b001;
parameter state_game_clear = 3'b010;
parameter state_game_fail = 3'b011;

reg[2:0] c_State, n_State;

always @ (posedge i_Clk or negedge i_Rst) begin
    if(~i_Rst) c_State <= state_idle;
    else c_State <= n_State;
end

// if fStart in >> game_start // Score >=10 >> game_clear // Sec30Tick >> game_fail
always @ (*) begin
    case(c_State)
        state_idle: begin
            if(i_Remove_Glitch_fStart) n_State = state_game_start;
            else n_State = c_State;
        end
        state_game_start: begin
            if(i_Score >= 5'd10) n_State = state_game_clear;
            else if(i_Sec30Tick) begin
                n_State = state_game_fail;
            end
            else n_State = c_State;
        end
        default: n_State = c_State;
    endcase
end
    
    
assign o_State = c_State;

endmodule

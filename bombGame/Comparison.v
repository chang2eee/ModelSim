module Comparison(i_Clk, i_Rst, i_Remove_Glitch_fStart, i_State, i_Sec1Tick, i_Led, i_Switch, o_Comparison);

input i_Clk;//50MHz
input i_Rst;
input i_Remove_Glitch_fStart;
input [2:0] i_State;
input i_Sec1Tick;
input [7:0] i_Led;
input [7:0] i_Switch;
output reg o_Comparison;

//Parameters
parameter state_idle = 3'b000;
parameter state_game_start = 3'b001;
parameter state_game_clear = 3'b010;
parameter state_game_fail = 3'b011;

wire [7:0] And8_Led_Switch;
assign And8_Led_Switch = i_Led & i_Switch;


always @ (posedge i_Clk or negedge i_Rst) begin
    if(~i_Rst) begin
        o_Comparison <= 1'b0;
    end 
    else begin
        case(i_State)
            state_idle: if(i_Remove_Glitch_fStart) o_Comparison <= 1'b0;
            state_game_start: begin
                if(i_Sec1Tick) o_Comparison <= 1'b0;
                if(And8_Led_Switch[0] | And8_Led_Switch[1] | And8_Led_Switch[2] | And8_Led_Switch[3] | 
                                    And8_Led_Switch[4] | And8_Led_Switch[5] | And8_Led_Switch[6] | And8_Led_Switch[7]) o_Comparison <= 1'b1;
            end 
            default: o_Comparison <= 1'b0;            
        endcase
        
    end
end


endmodule

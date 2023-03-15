module Score(i_Clk, i_Rst, i_State, i_Sec1Tick, i_Comparison, o_Score, o_Score10, o_Score1);

input i_Clk;//50MHz
input i_Rst;
input [2:0] i_State;
input i_Sec1Tick;
input i_Comparison;

output reg [4:0] o_Score;
output wire [3:0] o_Score10, o_Score1;

//Parameters
parameter state_idle = 3'b000;
parameter state_game_start = 3'b001;
parameter state_game_clear = 3'b010;
parameter state_game_fail = 3'b011;

always @ (posedge i_Clk or negedge i_Rst) begin
    if(~i_Rst) o_Score <= 5'd0;
    else begin
        if( (i_State == state_game_start) & (i_Sec1Tick) & i_Comparison) begin            
            o_Score <= o_Score + 5'd1;
        end        
    end
end

assign o_Score10 = (o_Score >= 5'd10) ? 4'd1 : 4'd0;
assign o_Score1 = o_Score - 10*o_Score10;

endmodule

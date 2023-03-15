module LED_On(i_Clk, i_Rst, i_Remove_Glitch_fStart, i_Sec1Tick, i_State, i_Random4Bit, o_Led);

input i_Clk; //50MHz
input i_Rst;
input i_Remove_Glitch_fStart;
input i_Sec1Tick;
input [2:0] i_State;
input [3:0] i_Random4Bit;

output reg [7:0] o_Led;

//Parameters
parameter state_idle = 3'b000;
parameter state_game_start = 3'b001;
parameter state_game_clear = 3'b010;
parameter state_game_fail = 3'b011;

always @ (posedge i_Clk or negedge i_Rst) begin
    if(~i_Rst) o_Led <= 8'd0;
    else begin
        case(i_State)
            state_idle: begin
                if(i_Remove_Glitch_fStart) begin
                    case(i_Random4Bit[2:0])
                        3'd0: o_Led <= 8'd1;
                        3'd1: o_Led <= 8'd2;
                        3'd2: o_Led <= 8'd4;
                        3'd3: o_Led <= 8'd8;
                        3'd4: o_Led <= 8'd16;
                        3'd5: o_Led <= 8'd32;
                        3'd6: o_Led <= 8'd64;
                        3'd7: o_Led <= 8'd128;
                        default: o_Led <= 8'd0;
                    endcase                
                end
                else o_Led <= 8'd0;
            end
            state_game_start: begin
                if(i_Sec1Tick) begin
                    case(i_Random4Bit[2:0])
                        3'd0: o_Led <= 8'd1;
                        3'd1: o_Led <= 8'd2;
                        3'd2: o_Led <= 8'd4;
                        3'd3: o_Led <= 8'd8;
                        3'd4: o_Led <= 8'd16;
                        3'd5: o_Led <= 8'd32;
                        3'd6: o_Led <= 8'd64;
                        3'd7: o_Led <= 8'd128;
                        default: o_Led <= 8'd0;
                    endcase                    
                end
            end
            default: o_Led <= 8'd0;
        endcase
    end
end


endmodule

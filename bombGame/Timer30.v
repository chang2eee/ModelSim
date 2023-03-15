module Timer30(i_Clk, i_Rst, i_State, i_Sec1Tick, o_Sec10Tick, o_Sec30Tick);

input i_Clk; //50MHz
input i_Rst;
input [2:0] i_State;
input i_Sec1Tick;

output wire o_Sec10Tick;
output wire o_Sec30Tick;

parameter state_idle = 3'b000;
parameter state_game_start = 3'b001;
parameter state_game_clear = 3'b010;
parameter state_game_fail = 3'b011;

reg [4:0] cnt;

always @ (posedge i_Clk or negedge i_Rst) begin
    if(~i_Rst) cnt <= 5'd0;
    else begin
        case(i_State) 
            state_game_start: if(i_Sec1Tick) cnt <= cnt + 5'd1;     
            default: cnt <= 5'd0;
        endcase
    end
end

reg Sec10Count, Sec30Count;
reg Sec10Count_buf, Sec30Count_buf;

always @ (posedge i_Clk or negedge i_Rst) begin
    if(~i_Rst) begin
        Sec10Count <= 1'b0;
        Sec30Count <= 1'b0;
        Sec10Count_buf <= 1'b0;
        Sec30Count_buf <= 1'b0;
    end
    else begin
        if( (cnt == 5'd10) | (cnt == 5'd20) | (cnt == 5'd30) ) Sec10Count <= 1'b1;
        else Sec10Count <= 1'b0; 
        if(cnt == 5'd30) Sec30Count <= 1'b1;
        else Sec30Count <= 1'b0;
        
        Sec10Count_buf <= Sec10Count;
        Sec30Count_buf <= Sec30Count;
    end
end

assign o_Sec10Tick = Sec10Count & (~Sec10Count_buf);
assign o_Sec30Tick = Sec30Count & (~Sec30Count_buf);
// https://moltak.tistory.com/250
endmodule

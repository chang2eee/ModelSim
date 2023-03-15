module Gen_Sec1Tick(i_Clk, i_Rst, i_State, o_Sec1Tick);
    
input i_Clk;//50MHz
input i_Rst;
input [2:0] i_State;
output reg o_Sec1Tick;

// Parameters
parameter Sec1_Cnt = 26'd50_000_000-26'd1; 
//parameter Sec1_Cnt = 26'd100-26'd1;

parameter state_idle = 3'b000;
parameter state_game_start = 3'b001;
parameter state_game_clear = 3'b010;
parameter state_game_fail = 3'b011;

// Registers
reg [25:0] Clk_Cnt=0;

always @ (posedge i_Clk) begin
    if(i_State == state_game_start) begin
        if(Clk_Cnt >= Sec1_Cnt) Clk_Cnt <= 0;
        else Clk_Cnt <= Clk_Cnt + 26'd1;
    end
    else Clk_Cnt <= 0;
end

always @ (posedge i_Clk or negedge i_Rst) begin
    if(~i_Rst) o_Sec1Tick <= 1'b0;
    else begin
        if(Clk_Cnt >= Sec1_Cnt) o_Sec1Tick <= 1'b1;
        else o_Sec1Tick <= 1'b0;
    end
end

endmodule

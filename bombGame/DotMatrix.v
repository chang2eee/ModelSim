module DotMatrixTop(i_Clk, i_Rst, i_Remove_Glitch_fStart, i_State, i_Sec10Tick, o_DM_Col, o_DM_Row);
input	i_Clk;	// 50MHz
input	i_Rst;
input   i_Remove_Glitch_fStart;
input [2:0] i_State;
input i_Sec10Tick;
output	wire [7:0] o_DM_Col, o_DM_Row;

reg		[ 7:0]	c_Cnt	, n_Cnt;
reg		[63:0]	c_Data	, n_Data;

wire	DM_o_fDone;	// 16ms

// <= counterclockwise rotation
parameter	STARTGAME = {
	8'b11100111,
	8'b11100111,
	8'b11100111,
	8'b11000011,
	8'b10111101,
	8'b10111101,
	8'b10111101,
	8'b11000011};

parameter	LIFEPOINT1	= {
	8'b11111111,
	8'b11100111,
	8'b11100111,
	8'b11000011,
	8'b10111101,
	8'b10111101,
	8'b10111101,
	8'b11000011};

parameter	LIFEPOINT2	= {
	8'b11111111,
	8'b11111111,
	8'b11100111,
	8'b11000011,
	8'b10111101,
	8'b10111101,
	8'b10111101,
	8'b11000011};

parameter	LIFEPOINT3	= {
	8'b11111111,
	8'b11111111,
	8'b11111111,
	8'b11000011,
	8'b10111101,
	8'b10111101,
	8'b10111101,
	8'b11000011};

parameter GAMECLEAR = {
	8'b11000011,
	8'b10111101,
	8'b01011010,
	8'b01111110,
	8'b01011010,
	8'b01100110,
	8'b10111101,
	8'b11000011};

parameter	GAMEFAIL	= {
	8'b11000011,
	8'b10111101,
	8'b01111110,
	8'b00000000,
	8'b01011010,
	8'b01011010,
	8'b10111101,
	8'b11000011};

parameter state_idle = 3'b000;
parameter state_game_start = 3'b001;
parameter state_game_clear = 3'b010;
parameter state_game_fail = 3'b011;

DotMatrix	DM0(i_Clk, i_Rst, c_Data, o_DM_Col, o_DM_Row, DM_o_fDone);

always@(posedge i_Clk, negedge i_Rst)
	if(~i_Rst) begin
		c_Cnt	= 0;
		c_Data	= 0;
	end else begin
		c_Cnt	= n_Cnt;
		c_Data	= n_Data;
	end

always@*
begin
    n_Cnt	= DM_o_fDone ? c_Cnt + 1 : c_Cnt;
    case(i_State)
        state_idle: begin
            if(i_Remove_Glitch_fStart) n_Data = STARTGAME;
            else n_Data = {64{1'b1}};
        end
        state_game_start: begin
            if(i_Sec10Tick) begin
                if(c_Data == STARTGAME) n_Data = LIFEPOINT1;
                else if(c_Data == LIFEPOINT1) n_Data = LIFEPOINT2;
                else if(c_Data == LIFEPOINT2) n_Data = LIFEPOINT3;
                else n_Data = c_Data;
            end
            else n_Data = c_Data;
        end
        state_game_clear: n_Data = GAMECLEAR;
        state_game_fail: n_Data = GAMEFAIL;
        default: n_Data = {64{1'b1}};
    endcase
end

endmodule

///////////////////////////////////////////////////////////////////////////////////

module DotMatrix(i_Clk, i_Rst, i_Data, o_DM_Col, o_DM_Row, o_fDone);
input	i_Clk;	// 50MHz
input	i_Rst;
input	[63:0]	i_Data;
output	wire [7:0] o_DM_Col, o_DM_Row;
output	wire o_fDone;

reg		[7:0]	c_Row, n_Row;
reg		[16:0]	c_Cnt, n_Cnt;

wire	f2ms;

assign o_fDone	= c_Row[7] && f2ms;
assign o_DM_Row = c_Row;
assign o_DM_Col =	
	(c_Row[7] ? i_Data[8*7+:8] : 0) |
	(c_Row[6] ? i_Data[8*6+:8] : 0) |
	(c_Row[5] ? i_Data[8*5+:8] : 0) |
	(c_Row[4] ? i_Data[8*4+:8] : 0) |
	(c_Row[3] ? i_Data[8*3+:8] : 0) |
	(c_Row[2] ? i_Data[8*2+:8] : 0) |
	(c_Row[1] ? i_Data[8*1+:8] : 0) |
	(c_Row[0] ? i_Data[8*0+:8] : 0);			

assign	f2ms	= c_Cnt == 100000 - 1;

always@(posedge i_Clk, negedge i_Rst)
	if(~i_Rst) begin
		c_Row	= 1;		
		c_Cnt	= 0;
	end else begin
		c_Row	= n_Row;		
		c_Cnt	= n_Cnt;
	end

always@*
begin
	n_Cnt	= f2ms	? 0 : c_Cnt + 1;
	n_Row	= f2ms	? {c_Row[6:0], c_Row[7]} : c_Row;
end

endmodule

module DotMatrixTop(i_Clk, i_Rst, o_DM_Col, o_DM_Row);
input	i_Clk;	// 50MHz
input	i_Rst;
output	wire [7:0] o_DM_Col, o_DM_Row;

reg		[ 7:0]	c_Cnt	, n_Cnt;
reg		[63:0]	c_Data	, n_Data;

wire	DM_o_fDone;	// 16ms

// <= counterclockwise rotation
parameter	HEART	= {
	8'b11100011,
	8'b11011101,
	8'b10111101,
	8'b01111011,
	8'b00000011,
	8'b10000001,
	8'b11000001,
	8'b11100011};

parameter	SMILE	= {
	8'b11000011,
	8'b10111101,
	8'b01101010,
	8'b01011110,
	8'b01011110,
	8'b01101010,
	8'b10111101,
	8'b11000011};

parameter	ARROW	= {
	8'b11000011,
	8'b11000011,
	8'b11000011,
	8'b11000011,
	8'b00000000,
	8'b10000001,
	8'b11000011,
	8'b11100111};

parameter	PLUS = {
	8'b11100111,
	8'b11100111,
	8'b11100111,
	8'b00000000,
	8'b00000000,
	8'b11100111,
	8'b11100111,
	8'b11100111};

	
DotMatrix	DM0(i_Clk, i_Rst, c_Data, o_DM_Col, o_DM_Row, DM_o_fDone);

always@(posedge i_Clk, posedge i_Rst)
	if(i_Rst) begin
		c_Cnt	= 0;
		c_Data	= 0;
	end else begin
		c_Cnt	= n_Cnt;
		c_Data	= n_Data;
	end

always@*
begin
	n_Cnt	= DM_o_fDone ? c_Cnt + 1 : c_Cnt;
	case(c_Cnt[7:6])
		2'h0	: n_Data = HEART;
		2'h1	: n_Data = SMILE;
		2'h2	: n_Data = PLUS;
		default	: n_Data = ARROW;
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

assign	f2ms	= c_Cnt == 9999;

always@(posedge i_Clk, posedge i_Rst)
	if(i_Rst) begin
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

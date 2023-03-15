module Bomb_Top(i_Clk, i_Rst, i_fStart, i_Switch, o_Led, o_DM_Col, o_DM_Row, o_HEX1, o_HEX0);

input i_Clk;//50MHz
input i_Rst;
input i_fStart;
input [7:0] i_Switch;

output [7:0] o_Led;
output [7:0] o_DM_Col, o_DM_Row;

output [6:0] o_HEX1, o_HEX0;

// SubModules
wire Remove_Glitch_fStart;
wire Sec1Tick;
wire [3:0] Random4Bit;
wire Sec10Tick, Sec30Tick;
wire [2:0] State;
wire Comparison;
wire [4:0] Score;
wire [3:0] Score10, Score1;


Remove_Glitch   U0_Remove_Glitch(i_Clk, i_Rst, i_fStart, Remove_Glitch_fStart);
Gen_Sec1Tick    U1_Gen_Sec1Tick(i_Clk, i_Rst, State, Sec1Tick);
LFSR            U2_LFSR(i_Clk, i_Rst, Random4Bit);
Timer30         U3_Timer30s(i_Clk, i_Rst, State, Sec1Tick, Sec10Tick, Sec30Tick);
FSM             U4_FSM(i_Clk, i_Rst, Remove_Glitch_fStart, Score, Sec30Tick, State);
LED_On          U5_LED_On(i_Clk, i_Rst, Remove_Glitch_fStart, Sec1Tick, State, Random4Bit, o_Led);
Comparison      U6_Comparison(i_Clk, i_Rst, Remove_Glitch_fStart, State, Sec1Tick, o_Led, i_Switch, Comparison);
Score           U7_Score(i_Clk, i_Rst, State, Sec1Tick, Comparison, Score, Score10, Score1);
DotMatrixTop    U8_DotMatrixTop(i_Clk, i_Rst, Remove_Glitch_fStart, State, Sec10Tick, o_DM_Col, o_DM_Row);
FND             U9_FND(Score10, o_HEX1); //10 digit
FND             U10_FND(Score1, o_HEX0); //1 digit

endmodule










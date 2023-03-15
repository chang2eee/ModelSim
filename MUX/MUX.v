module MUX(i_Sel, i_Data, o_Data);
  
input [1:0] i_Sel;
input [3:0] i_Data;
output reg o_Data;

always@(*)
  case(i_Sel)
    2'b00: o_Data = i_Data[0];
    2'b01: o_Data = i_Data[1];
    2'b10: o_Data = i_Data[2];
    default : o_Data = i_Data[3];

  endcase
endmodule
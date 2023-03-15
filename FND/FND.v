module FND(i_Num, o_FND);
  
input wire [3:0] i_Num;
output reg [6:0] o_FND;

always@*
  case(i_Num)
    4'h0: o_FND = 7'b0000001;
    4'h1: o_FND = 7'b1001111;
    4'h2: o_FND = 7'b0010010;
    4'h3: o_FND = 7'b0000110;
    4'h4: o_FND = 7'b1001100;
    4'h5: o_FND = 7'b0100100;
    4'h6: o_FND = 7'b1100000;
    4'h7: o_FND = 7'b0001111;
    4'h8: o_FND = 7'b0000000;
    default o_FND = 7'b0001010;
endcase
endmodule
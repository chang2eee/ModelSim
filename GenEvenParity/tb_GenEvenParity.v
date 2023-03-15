module tb_GenEvenParity;
  
reg [7:0] i_Data;
wire[7:0] o_Data;
wire o_Parity;

GenEvenParity U0(i_Data, o_Data, o_Parity);

initial
begin
  
i_Data = 8'b11111111; 

#20 i_Data = 8'b01111111; 
#20 i_Data = 8'b10111111;
#20 i_Data = 8'b11011111;
#20 i_Data = 8'b11101111;
#20 i_Data = 8'b11110111;
#20 i_Data = 8'b11111011;
#20 i_Data = 8'b11111101;
#20 i_Data = 8'b11111111;



end
endmodule
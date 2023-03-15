module tb_FND;
  
reg [3:0] i_Num;
wire [6:0] o_FND;

FND U0(i_Num, o_FND);

initial
begin
  
  i_Num = 0;
  #10 i_Num = 1;
  #10 i_Num = 2;
  #10 i_Num = 3;
  #10 i_Num = 4;
  #10 i_Num = 5;
  #10 i_Num = 6;
  #10 i_Num = 7;
  #10 i_Num = 8;
  #10 i_Num = 9;  
  
end
endmodule
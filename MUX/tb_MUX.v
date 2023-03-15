module tb_MUX;
reg [1:0] MUX_i_sel;
reg [3:0] MUX_i_Data;
wire MUX_o_Data;




MUX U0(MUX_i_sel, MUX_i_Data, MUX_o_Data);

initial
begin
  MUX_i_Data = 4'b0010;
  MUX_i_sel = 2'b00; 
  #10 MUX_i_sel = 2'b01; 
  #10 MUX_i_sel = 2'b10; 
  #10 MUX_i_sel = 2'b11; 

  
  
  
  
end
endmodule

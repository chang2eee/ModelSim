module LFSR(i_Clk, i_Rst, o_Random4Bit);

input i_Clk, i_Rst;
output reg [3:0] o_Random4Bit;

parameter seed = 4'b0001;

always @ (posedge i_Clk or negedge i_Rst) begin
    if(~i_Rst) o_Random4Bit <= seed; 
    else begin
        o_Random4Bit[0] <= o_Random4Bit[0] ^ o_Random4Bit[3];
        o_Random4Bit[3:1] <= o_Random4Bit[2:0];
    end
end    

endmodule
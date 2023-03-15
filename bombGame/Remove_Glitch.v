module Remove_Glitch(i_Clk, i_Rst, i_fStart, o_Remove_Glitch_fStart);


input i_Clk;//50MHz
input i_Rst;
input i_fStart;
output o_Remove_Glitch_fStart;

reg i_fStart_buf;

always @ (posedge i_Clk or negedge i_Rst) begin
    if(~i_Rst) i_fStart_buf <= 1'b0;
    else i_fStart_buf <= i_fStart;
end

assign o_Remove_Glitch_fStart = i_fStart & (~i_fStart_buf);

endmodule

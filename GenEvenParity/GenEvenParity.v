module GenEvenParity(i_Data, o_Data, o_Parity);
  
input [7:0] i_Data;

output wire [7:0] o_Data;
output wire o_Parity;

assign o_Data = i_Data;
assign o_Parity = ^o_Data;

endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2025 02:35:01 PM
// Design Name: 
// Module Name: shift_rows
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module shift_rows (sr_i, enc_or_dec_i, sr_o);

input enc_or_dec_i;
input [127:0] sr_i;
output [127:0] sr_o;

wire [31:0] row0_i, row1_i, row2_i, row3_i,

		    enc_row0_o, enc_row1_o, enc_row2_o, enc_row3_o,
		    enc_col0_o, enc_col1_o, enc_col2_o, enc_col3_o,
		    
		    
		    dec_row0_o, dec_row1_o, dec_row2_o, dec_row3_o,
		    dec_col0_o, dec_col1_o, dec_col2_o, dec_col3_o;

assign row0_i = { sr_i[127:120], sr_i[95:88], sr_i[63:56], sr_i[31:24]};
assign row1_i = { sr_i[119:112], sr_i[87:80], sr_i[55:48], sr_i[23:16]};
assign row2_i = { sr_i[111:104], sr_i[79:72], sr_i[47:40], sr_i[15:8]};
assign row3_i = { sr_i[103:96], sr_i[71:64], sr_i[39:32], sr_i[7:0]};

/* Circular left shift in encryption */
assign enc_row0_o =  row0_i;
assign enc_row1_o = { row1_i[23:0], row1_i[31:24] };
assign enc_row2_o = { row2_i[15:0], row2_i[31:16] };
assign enc_row3_o = { row3_i[7:0],  row3_i[31:8] };

assign enc_col0_o = {enc_row0_o[31:24], enc_row1_o[31:24], enc_row2_o[31:24], enc_row3_o[31:24]};
assign enc_col1_o = {enc_row0_o[23:16], enc_row1_o[23:16], enc_row2_o[23:16], enc_row3_o[23:16]};
assign enc_col2_o = {enc_row0_o[15:8], enc_row1_o[15:8], enc_row2_o[15:8], enc_row3_o[15:8]};
assign enc_col3_o = {enc_row0_o[7:0], enc_row1_o[7:0], enc_row2_o[7:0], enc_row3_o[7:0]};



/* Circular right shift in decryption */
assign dec_row0_o =  row0_i;
assign dec_row1_o = { row1_i[7:0],   row1_i[31:8] };
assign dec_row2_o = { row2_i[15:0],  row2_i[31:16] };
assign dec_row3_o = { row3_i[23:0],  row3_i[31:24] };

assign dec_col0_o = {dec_row0_o[31:24], dec_row1_o[31:24], dec_row2_o[31:24], dec_row3_o[31:24]};
assign dec_col1_o = {dec_row0_o[23:16], dec_row1_o[23:16], dec_row2_o[23:16], dec_row3_o[23:16]};
assign dec_col2_o = {dec_row0_o[15:8],  dec_row1_o[15:8],  dec_row2_o[15:8],  dec_row3_o[15:8]};
assign dec_col3_o = {dec_row0_o[7:0],   dec_row1_o[7:0],   dec_row2_o[7:0],   dec_row3_o[7:0]};


/* Assign the output based on encryption / decryption */
assign sr_o = (enc_or_dec_i == 1) ? {enc_col0_o, enc_col1_o, enc_col2_o, enc_col3_o} : 
                                      {dec_col0_o, dec_col1_o, dec_col2_o, dec_col3_o};




endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2025 02:17:49 PM
// Design Name: 
// Module Name: sub_word
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

//Sub word for 1 colum
module sub_word (enc_or_dec_i, word_i, word_o);

input enc_or_dec_i;
input [31:0] word_i;
output [31:0] word_o;

wire [31:0] sbox_o, inv_sbox_o;

assign word_o = (enc_or_dec_i == 1'h1) ? sbox_o : inv_sbox_o;

/* Instantiate S-Box modules to substitute bytes */
S_box
	sbox_e1 (word_i[31:24], sbox_o[31:24]),
	sbox_e2 (word_i[23:16], sbox_o[23:16]),
	sbox_e3 (word_i[15:8],   sbox_o[15:8]),
	sbox_e4 (word_i[7:0],     sbox_o[7:0]);
	
/* Instantiate inverse S-Box modules to substitute bytes */
inv_S_Box
	inv_sbox_e1 (word_i[31:24], inv_sbox_o[31:24]),
	inv_sbox_e2 (word_i[23:16], inv_sbox_o[23:16]),
	inv_sbox_e3 (word_i[15:8],   inv_sbox_o[15:8]),
	inv_sbox_e4 (word_i[7:0],     inv_sbox_o[7:0]);

endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 08:51:47 AM
// Design Name: 
// Module Name: sub_bytes
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


module sub_bytes(sb_i, enc_or_dec_i, sb_o);
    input enc_or_dec_i;
    input [127:0] sb_i;
    output [127:0] sb_o;
    
    wire [31:0] col0_i, col1_i, col2_i, col3_i,
		        col0_o, col1_o, col2_o, col3_o;
		        
    sub_word sub_word_col1 (.enc_or_dec_i(enc_or_dec_i), .word_i(sb_i[127:96]), .word_o(col0_o));
    sub_word sub_word_col2 (.enc_or_dec_i(enc_or_dec_i), .word_i(sb_i[95:64]), .word_o(col1_o));
    sub_word sub_word_col3 (.enc_or_dec_i(enc_or_dec_i), .word_i(sb_i[63:32]), .word_o(col2_o));
    sub_word sub_word_col4 (.enc_or_dec_i(enc_or_dec_i), .word_i(sb_i[31:0]), .word_o(col3_o));
	
	assign sb_o = { col0_o, col1_o, col2_o, col3_o };	        
    
endmodule

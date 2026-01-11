`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2025 04:28:45 PM
// Design Name: 
// Module Name: mul_cols_enc
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


module mul_cols_enc (col_i, col_o);

input [31:0] col_i;
output [31:0] col_o;

wire [31:0] col_enc_o;

wire [7:0] c0_mul_2_o, c0_mul_3_o,
           c1_mul_2_o, c1_mul_3_o,
           c2_mul_2_o, c2_mul_3_o,
           c3_mul_2_o, c3_mul_3_o;

/* Instantiate the multiply by 2 LUT */     
mul_by_2
    c0_2 (col_i[31:24], c0_mul_2_o),
    c1_2 (col_i[23:16], c1_mul_2_o),
    c2_2 (col_i[15:8],  c2_mul_2_o),
    c3_2 (col_i[7:0],   c3_mul_2_o);

/* Instantiate the multiply by 3 LUT */
mul_by_3
    c0_3 (col_i[23:16], c0_mul_3_o),
    c1_3 (col_i[15:8],  c1_mul_3_o),
    c2_3 (col_i[7:0],   c2_mul_3_o),
    c3_3 (col_i[31:24], c3_mul_3_o);

/* Multiply the results from LUT */
assign col_enc_o[31:24] = (c0_mul_2_o   ^ c0_mul_3_o   ^ col_i[15:8] ^ col_i[7:0]);
assign col_enc_o[23:16] = (col_i[31:24] ^ c1_mul_2_o   ^ c1_mul_3_o  ^ col_i[7:0]);
assign col_enc_o[15:8]  = (col_i[31:24] ^ col_i[23:16] ^ c2_mul_2_o  ^ c2_mul_3_o);
assign col_enc_o[7:0]   = (c3_mul_3_o   ^ col_i[23:16] ^ col_i[15:8] ^ c3_mul_2_o);

assign col_o = col_enc_o;

endmodule

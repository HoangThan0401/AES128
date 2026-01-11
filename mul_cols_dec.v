`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 11:09:01 AM
// Design Name: 
// Module Name: mul_cols_dec
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


module mul_cols_dec (col_i, col_o);

input [31:0] col_i;
output [31:0] col_o;

wire [31:0] col_dec_o;

wire [7:0] c0_mul_9_o, c0_mul_b_o, c0_mul_d_o, c0_mul_e_o,
           c1_mul_9_o, c1_mul_b_o, c1_mul_d_o, c1_mul_e_o,
           c2_mul_9_o, c2_mul_b_o, c2_mul_d_o, c2_mul_e_o,
           c3_mul_9_o, c3_mul_b_o, c3_mul_d_o, c3_mul_e_o;

/* Instantiate the multiply by 9 LUT */
mul_by_9
    c0_9 (col_i[7:0],   c0_mul_9_o),
    c1_9 (col_i[31:24], c1_mul_9_o),
    c2_9 (col_i[23:16], c2_mul_9_o),
    c3_9 (col_i[15:8],  c3_mul_9_o);

/* Instantiate the multiply by b LUT */
mul_by_b
    c0_b (col_i[23:16], c0_mul_b_o),
    c1_b (col_i[15:8],  c1_mul_b_o),
    c2_b (col_i[7:0],   c2_mul_b_o),
    c3_b (col_i[31:24], c3_mul_b_o);

/* Instantiate the multiply by d LUT */
mul_by_d
    c0_d (col_i[15:8],  c0_mul_d_o),
    c1_d (col_i[7:0],   c1_mul_d_o),
    c2_d (col_i[31:24], c2_mul_d_o),
    c3_d (col_i[23:16], c3_mul_d_o);

/* Instantiate the multiply by e LUT */
mul_by_e
    c0_e (col_i[31:24], c0_mul_e_o),
    c1_e (col_i[23:16], c1_mul_e_o),
    c2_e (col_i[15:8],  c2_mul_e_o),
    c3_e (col_i[7:0],   c3_mul_e_o);

/* Multiply the results from LUT */
assign col_dec_o[31:24] = (c0_mul_9_o ^ c0_mul_b_o ^ c0_mul_d_o ^ c0_mul_e_o);
assign col_dec_o[23:16] = (c1_mul_9_o ^ c1_mul_b_o ^ c1_mul_d_o ^ c1_mul_e_o);
assign col_dec_o[15:8]  = (c2_mul_9_o ^ c2_mul_b_o ^ c2_mul_d_o ^ c2_mul_e_o);
assign col_dec_o[7:0]   = (c3_mul_9_o ^ c3_mul_b_o ^ c3_mul_d_o ^ c3_mul_e_o);

assign col_o = col_dec_o;

endmodule 

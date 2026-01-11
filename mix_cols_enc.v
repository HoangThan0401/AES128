`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2025 05:04:14 PM
// Design Name: 
// Module Name: mix_cols_enc
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


module mix_cols_enc (mix_col_i, mc_i, mc_o);

input mix_col_i;
input [127:0] mc_i;
output [127:0] mc_o;

wire [31:0] row0_i, row1_i, row2_i, row3_i,
            row0_o, row1_o, row2_o, row3_o,
            col0_i, col1_i, col2_i, col3_i,
            col0_o, col1_o, col2_o, col3_o;

mul_cols_enc mul_col0_inst (.col_i(mc_i[127:96]), .col_o(col0_o));
mul_cols_enc mul_col1_inst (.col_i(mc_i[95:64]), .col_o(col1_o));
mul_cols_enc mul_col2_inst (.col_i(mc_i[63:32]), .col_o(col2_o));
mul_cols_enc mul_col3_inst (.col_i(mc_i[31:0]), .col_o(col3_o));

assign mc_o = (mix_col_i == 1) ? {col0_o, col1_o, col2_o, col3_o} : 0;


endmodule

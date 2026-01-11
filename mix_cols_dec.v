`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 01:39:20 PM
// Design Name: 
// Module Name: mix_cols_dec
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


module mix_cols_dec (mix_col_en, mc_i, mc_o);

    input mix_col_en;
    input [127:0] mc_i;
    output [127:0] mc_o;
    
   wire [31:0] col0_o, col1_o, col2_o, col3_o;

mul_cols_dec mul_col0_inst1 (.col_i(mc_i[127:96]), .col_o(col0_o));
mul_cols_dec mul_col1_inst2 (.col_i(mc_i[95:64]), .col_o(col1_o));
mul_cols_dec mul_col2_inst3 (.col_i(mc_i[63:32]), .col_o(col2_o));
mul_cols_dec mul_col3_inst4 (.col_i(mc_i[31:0]), .col_o(col3_o));

assign mc_o = (mix_col_en == 1) ? {col0_o, col1_o, col2_o, col3_o} : mc_i; 
                                            
endmodule
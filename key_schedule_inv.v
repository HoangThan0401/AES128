`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2026 04:50:30 PM
// Design Name: 
// Module Name: key_schedule_inv
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


module key_schedule_inv(round_num, key_i, key_r);

input [7:0] round_num;
input [127:0] key_i;
output [127:0] key_r;


/* Keys are same for encryption and decryption (used in other modules) */

/* Rows and columns used in key schedule */
wire [31:0] 
            col0_i, col1_i, col2_i, col3_i,
            col0_o, col1_o, col2_o, col3_o,
            rot_col_3_o, sub_col_o,
            trans_o;
wire [7:0] rcon_o;     

assign col0_i = key_i[127:96];
assign col1_i = key_i[95:64];
assign col2_i = key_i[63:32];
assign col3_i = key_i[31:0];
   

/* Rotate column 3 */
assign rot_col_3_o = {col3_i[23:0], col3_i[31:24]};

/* Substitute word */
sub_word
    trans_col3 (.word_i(rot_col_3_o), .word_o(sub_col_o));

/* Rcon column based on the key schedule round */
rcon
    rcon_sub (.in(round_num), .out(rcon_o));

assign trans_o = sub_col_o ^ {rcon_o, 24'b0};
/* Multiply the column with Rcon and previous column */
assign col0_o = col0_i ^ sub_col_o ^ {rcon_o, 24'b0};
assign col1_o = col1_i ^ col0_o;
assign col2_o = col2_i ^ col1_o;
assign col3_o = col3_i ^ col2_o;

/* Result key in the key round */
assign key_r = { col0_o, col1_o, col2_o, col3_o };
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2026 04:02:09 PM
// Design Name: 
// Module Name: inv_round
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


/* Module to perform one round in AES128 encryption */
module inv_round (state_i, key_i, mix_col_en, state_o);

    input [127:0] state_i, key_i;  // The state and round key input 
    input mix_col_en;
    output [127:0] state_o;        // The state output
    
/* 
    Input and output wires connecting the following blocks:
    1. Substitute Bytes
    2. Shift Rows
    3. Mix Columns
    4. Add round Key
*/
wire [127:0] sr_o, bytes_out, ark_o;


/* Instantiate all the modules for encryption / decryption of one round */
inv_shift_rows
    inv_sr (.sr_i(state_i), .sr_o(sr_o));

inv_Sub_bytes
	inv_sb (.bytes_in(sr_o), .bytes_out(bytes_out));

add_round_key
        rk (.ark_i(bytes_out), .key_i(key_i), .ark_o(ark_o));

/* Have different modules for encryption and decryption due to DRC in FPGA (Artix-7 PL) implementation */
mix_cols_dec
	dec_mc (.mc_i(ark_o), .mix_col_en(mix_col_en), .mc_o(state_o));
	



endmodule

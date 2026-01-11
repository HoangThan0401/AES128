`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 03:03:44 PM
// Design Name: 
// Module Name: round
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
module round_dec (state_i, key_i, mix_col_i, enc_or_dec_i, state_o);

input mix_col_i, enc_or_dec_i; // Mix columns enable and encryption / decryption select
input [127:0] state_i, key_i;  // The state and round key input 
output [127:0] state_o;        // The state output

/* 
    Input and output wires connecting the following blocks:
    1. Substitute Bytes
    2. Shift Rows
    3. Mix Columns
    4. Add round Key
*/
wire [127:0] sb_i, sr_i, mc_i, ark_i, sb_o, sr_o, mc_o, ark_o, enc_mc_i, dec_mc_i, enc_mc_o, dec_mc_o;

assign enc_mc_i = (enc_or_dec_i == 1) ? mc_i: 0; // Connect the input of mix column module based on encrypt / decrypt
assign dec_mc_i = (enc_or_dec_i == 1) ? 0 : mc_i;
assign mc_o = (enc_or_dec_i == 1) ? enc_mc_o : dec_mc_o; // Connect the output of mix column module based on encrypt / decrypt 

/* Instantiate all the modules for encryption / decryption of one round */
sub_bytes
	sb (.sb_i(sb_i), .enc_or_dec_i(enc_or_dec_i), .sb_o(sb_o));

shift_rows
    sr (.sr_i(sr_i), .enc_or_dec_i(enc_or_dec_i), .sr_o(sr_o));

/* Have different modules for encryption and decryption due to DRC in FPGA (Artix-7 PL) implementation */
mix_cols_enc
	enc_mc (.mix_col_i(mix_col_i), .mc_i(enc_mc_i), .mc_o(enc_mc_o));
	
mix_cols_dec
	dec_mc (.mix_col_i(mix_col_i), .mc_i(dec_mc_i), .mc_o(dec_mc_o));
	
add_round_key
    rk (.ark_i(ark_i), .key_i(key_i), .ark_o(ark_o));

/* 
    Re-order the round procedure based on the operation: Encryption / Decryption
    Encryption: Sub Bytes -> Shift Rows -> Mix Columns -> Add Round Key
    Decryption: Inv Shift Rows -> Inv Sub Bytes -> Add Round Key -> Inv Mix Columns
*/
assign sb_i =    (enc_or_dec_i == 1) ? state_i : sr_o; //fixed
assign sr_i =    (enc_or_dec_i == 1) ? sb_o : state_i;
assign mc_i =    (enc_or_dec_i == 1) ? sr_o : ark_o;
assign ark_i =   (enc_or_dec_i == 1) ? mc_o : sb_o;
assign state_o = (enc_or_dec_i == 1) ? ark_o : mc_o;

endmodule

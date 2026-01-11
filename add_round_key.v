`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 02:56:39 PM
// Design Name: 
// Module Name: add_round_key
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


/* Module to add round key */
module add_round_key (ark_i, key_i, ark_o);

input [127:0] ark_i, key_i;
output [127:0] ark_o;

/* XOR the round key with state input */
assign ark_o = ark_i ^ key_i;

endmodule

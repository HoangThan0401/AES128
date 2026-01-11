`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2025 02:48:39 PM
// Design Name: 
// Module Name: aes128_modify
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


module aes128_modify(
        input clk_i,
        input reset_key_i,
        input enc_or_dec_i,
        
        input [127:0] key_i,
        input [127:0] plain_text_i, //data_i
        
        output [127:0] plain_text_o

    );
    
    wire [127:0] key_out;
    wire key_ready;
    
    keyExpansion key_exp_inst(
                .clk_i(clk_i),
                .reset_key_i(reset_key_i),
                .enc_or_dec_i(enc_or_dec_i),
                .key_i(key_i),
                .key_o(key_out),
                .key_ready_o(key_ready)

    );
                 

    /* Instaintiate the round module to perform one round of encryption / decryption with selective mix columns */
    round rounds (
                    .state_i(plain_text_i), 
                    .key_i(key_out), 
                    .mix_col_i(1), 
                    .enc_or_dec_i(key_ready), 
                    .state_o(plain_text_o));


endmodule
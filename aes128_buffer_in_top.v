`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2026 08:40:34 AM
// Design Name: 
// Module Name: aes128_buffer_in_top
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


module aes128_buffer_in_top #(parameter NUM_BYTES =16)
(
                              input clk,
                              input reset,
                              input data_valid_i,
                              input [7:0] byte_in,
                              input [7:0] num_of_bytes,
                              input [127:0] key_in, 
                              
                              output start_enc,
                              output [127:0] key_o,
                              output [127:0] plain_text_o,
                              output done
                              
    );
    
    wire [127:0] plain_text_i;
    input_buffer #(
            .NUM_BYTES(NUM_BYTES)  // Test với 10 bytes
        ) input_buffer (
            .clk_i(clk),
            .reset_i(reset),
            .data_valid_i(data_valid_i),
            .byte_in(byte_in),
            .num_of_bytes(num_of_bytes),
            
            .buffer_ready(start_enc),
            .buffer_out(plain_text_i)
            
        );
    
    aes128_enc_top datapath(
                        .clk_i(clk),
                        .reset_key_i(reset),
                        .start_i(start_enc),
                        .key_i(key_in),
                        .plain_text_i(plain_text_i),
                        
                        .key_o(key_o),
                        .plain_text_o(plain_text_o),
                        .done_o(done)
    
        );
        
    
    
    
endmodule

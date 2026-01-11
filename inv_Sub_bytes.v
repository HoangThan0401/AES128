`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2026 02:06:34 PM
// Design Name: 
// Module Name: inv_Sub_bytes
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


module inv_Sub_bytes(
    input [127:0] bytes_in,
    output [127:0] bytes_out
    );
    
    wire [31:0] word_col0_o , word_col1_o, word_col2_o, word_col3_o;
    
    inv_S_Box  
        inv_sbox_0 (.in(bytes_in[127:120]), .out(word_col0_o[31:24])),
        inv_sbox_1 (.in(bytes_in[119:112]), .out(word_col0_o[23:16])),
        inv_sbox_2 (.in(bytes_in[111:104]), .out(word_col0_o[15:8])),
        inv_sbox_3 (.in(bytes_in[103:96]), .out(word_col0_o [7:0])),
        
        
        inv_sbox_4 (.in(bytes_in[95:88]), .out(word_col1_o[31:24])),
        inv_sbox_5 (.in(bytes_in[87:80]), .out(word_col1_o[23:16])),
        inv_sbox_6 (.in(bytes_in[79:72]), .out(word_col1_o[15:8])),
        inv_sbox_7 (.in(bytes_in[71:64]), .out(word_col1_o[7:0])),
        
        
        inv_sbox_8 (.in(bytes_in[63:56]),  .out(word_col2_o[31:24])),
        inv_sbox_9 (.in(bytes_in[55:48]),  .out(word_col2_o[23:16])),
        inv_sbox_10 (.in(bytes_in[47:40]), .out(word_col2_o[15:8])),
        inv_sbox_11 (.in(bytes_in[39:32]), .out(word_col2_o[7:0])),
        
        
        inv_sbox_12 (.in(bytes_in[31:24]), .out(word_col3_o[31:24])),
        inv_sbox_13 (.in(bytes_in[23:16]), .out(word_col3_o[23:16])),
        inv_sbox_14 (.in(bytes_in[15:8]), .out(word_col3_o[15:8])),
        inv_sbox_15 (.in(bytes_in[7:0]), .out(word_col3_o[7:0]))     ;
        
   assign bytes_out = {word_col0_o, word_col1_o ,word_col2_o, word_col3_o};  
   
    
    
endmodule

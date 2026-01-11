`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2026 04:47:37 PM
// Design Name: 
// Module Name: rcon_inv
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


module rcon_inv(in, out);
    input [7:0] in;
    output reg [7:0] out;

    always @ (in)
    case (in)
        8'h01: out = 8'h36;
        8'h02: out = 8'h1b;
        8'h03: out = 8'h80;
        8'h04: out = 8'h40;
        8'h05: out = 8'h20;
        8'h06: out = 8'h10;
        8'h07: out = 8'h8;
        8'h08: out = 8'h4;
        8'h09: out = 8'h2;
        8'h0A: out = 8'h1;

    endcase
endmodule

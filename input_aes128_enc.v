`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2026 10:46:31 AM
// Design Name: 
// Module Name: input_aes128_enc
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


module input_aes128_enc #(parameter NUM_BYTES =16,
                          parameter DEPTH = 256,
                          parameter DWIDTH = 8)
    
                         ( input clk,
                           input rst,
                           input wr_en,
                           input rd_en,
                           input [7:0] din, 
                           
                           output buffer_ready,
                           output [127:0] buffer_out
                           );
    
    wire [7:0] dout;
    
    fifo_256bytes #(.DEPTH(DEPTH), 
                    .DWIDTH(DWIDTH))
    
       u_sync_fifo (         .rst(rst),
                             .wr_en(wr_en),
                             .rd_en(rd_en),
                             .clk(clk),
                             .din(din),
                             .dout(dout),
                             .empty(),
                             .full()
                            );
                            
        input_buffer #(
                                .NUM_BYTES(NUM_BYTES) 
                            ) buffer (
                                .clk_i(clk),
                                .reset_i(rst),
                                .data_valid_i(rd_en),
                                .byte_in(dout),
                                .buffer_ready(buffer_ready),
                                .buffer_out(buffer_out)
                            );                                          
endmodule

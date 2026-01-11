`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2026 04:44:51 PM
// Design Name: 
// Module Name: key_expansion_inv
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


module key_expansion_inv(
    input clk_i,
    input reset_key_i,
    input enable,
    input [127:0] key_i,
    output reg key_ready_o,
    //output [127:0] key_o,  // Round key hiện tại (round_num)
    output reg [127:0]  key_o_inv
);

    /* Key schedule states - 4 trạng thái ho� n chỉnh */
    localparam STATE_IDLE          = 3'd0,  // Ch�? reset/key change
               STATE_KEYGEN_IN_PROG = 3'd1,  // Tạo keys 1-10
               STATE_KEY_GEN_DONE   = 3'd2;  // Ready, ch�? key mới

    reg [2:0] key_schedule_state;
    reg [7:0] key_round_num;
    reg [127:0] key_schedule_i;
    reg [127:0]key_out;
    /* Memory lưu 11 round keys */
    reg [127:0] round_keys [0:10];
    wire [127:0] key_schedule_o;
    
    /* Detect key change */
    wire key_changed = (key_i != round_keys[0]);
    wire [127:0] key_o;
    /* Key schedule instantiation */
    key_schedule trans_inst (
        .round_num(key_round_num), 
        .key_i(key_schedule_i), 
        .key_r(key_schedule_o)
    );

    /* FSM chính - Sửa to� n bộ logic */
    always @(posedge clk_i or posedge reset_key_i) begin
        if (reset_key_i) begin
            key_schedule_state <= STATE_IDLE;
            key_ready_o <= 1'b0;
        end
        else begin
            case (key_schedule_state)
                
                STATE_IDLE: begin
                    key_ready_o <= 1'b0;
                    if ((key_changed || key_i != 128'h0) && enable) begin  // Bắt �'ầu khi có key mới
                        round_keys[0] <= key_i;           // Lưu key g�'c
                        key_round_num <= 8'h1;            // Round 1
                        key_schedule_i <= key_i;          // Input cho key_schedule
                        key_schedule_state <= STATE_KEYGEN_IN_PROG;
                    end
                end
                
                STATE_KEYGEN_IN_PROG: begin
                    round_keys[key_round_num] <= key_schedule_o;  // Lưu round key
                    
                    if (key_round_num == 8'hA) begin  // Round 10 ho� n tất
                        key_out <= key_schedule_o;
                        key_schedule_state <= STATE_KEY_GEN_DONE;
                        key_ready_o <= 1'b1;
                    end
                    else begin
                        key_schedule_i <= key_schedule_o;     // Chain key
                        key_round_num <= key_round_num + 1;   // Round tiếp theo
                    end
                end
                
                STATE_KEY_GEN_DONE: begin
                    key_ready_o <= 1'b0;                  // Giữ ready
                    //key_out <= key_schedule_o;
                    //if (key_changed) begin                // Key mới �' restart
                        key_schedule_state <= STATE_IDLE;
                    //end
                end
                
                default: key_schedule_state <= STATE_IDLE;
            endcase
        end
    end

    /* Output: round key hiện tại theo key_round_num */
    assign key_o = (key_schedule_state == STATE_KEY_GEN_DONE || key_schedule_state == STATE_IDLE) ? 0 : key_schedule_o;
    
reg [3:0] inv_index;
reg auto_out_active;
reg key_ready_o_inv;
   
    always @(posedge clk_i or posedge reset_key_i) begin
        if (reset_key_i) begin
            inv_index       <= 4'd10;
            key_o_inv       <= 128'd0;
            auto_out_active <= 1'b0;
        end else begin
            // Khi key expansion ho�n t?t ? b?t ch? ?? xu?t ng??c
            if (key_ready_o) begin
                auto_out_active <= 1'b1;
                inv_index       <= 4'd10;
            end
    
            // N?u ?ang trong ch? ?? xu?t ng??c
            if (auto_out_active) begin
                key_o_inv <= round_keys[inv_index];
                if (inv_index > 0) begin
                    inv_index <= inv_index - 1;
                end else begin
                    auto_out_active <= 1'b0; // k?t th�c sau khi xu?t round 0
                end
            end
        end
    end

        
endmodule

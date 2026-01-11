`timescale 1ns / 1ps

module keyExpansion(
    input clk_i,
    input reset_key_i,
    input enc_or_dec_i,
    input [127:0] key_i,
    output reg key_ready_o,
    output [127:0] key_o  // Round key hiện tại (round_num)
);

    /* Key schedule states - 4 trạng thái hoàn chỉnh */
    localparam STATE_IDLE          = 3'd0,  // Chờ reset/key change
              STATE_KEYGEN_IN_PROG = 3'd1,  // Tạo keys 1-10
              STATE_KEY_GEN_DONE   = 3'd2;  // Ready, chờ key mới

    reg [2:0] key_schedule_state;
    reg [7:0] key_round_num;
    reg [127:0] key_schedule_i;
    reg [127:0]key_out;
    /* Memory lưu 11 round keys */
    reg [127:0] round_keys [0:10];
    wire [127:0] key_schedule_o;

    /* Detect key change */
    wire key_changed = (key_i != round_keys[0]);

    /* Key schedule instantiation */
    key_schedule trans_inst (
        .enc_or_dec_i(enc_or_dec_i),
        .round_num(key_round_num), 
        .key_i(key_schedule_i), 
        .key_r(key_schedule_o)
    );

    /* FSM chính - Sửa toàn bộ logic */
    always @(posedge clk_i or posedge reset_key_i) begin
        if (reset_key_i) begin
            key_schedule_state <= STATE_IDLE;
            key_ready_o <= 1'b0;
        end
        else begin
            case (key_schedule_state)
                
                STATE_IDLE: begin
                    key_ready_o <= 1'b0;
                    if (key_changed || key_i != 128'h0) begin  // Bắt đầu khi có key mới
                        round_keys[0] <= key_i;           // Lưu key gốc
                        key_round_num <= 8'h1;            // Round 1
                        key_schedule_i <= key_i;          // Input cho key_schedule
                        key_schedule_state <= STATE_KEYGEN_IN_PROG;
                    end
                end
                
                STATE_KEYGEN_IN_PROG: begin
                    round_keys[key_round_num] <= key_schedule_o;  // Lưu round key
                    
                    if (key_round_num == 8'hA) begin  // Round 10 hoàn tất
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
                    key_ready_o <= 1'b1;                  // Giữ ready
                    //key_out <= key_schedule_o;
                    if (key_changed) begin                // Key mới → restart
                        key_schedule_state <= STATE_IDLE;
                    end
                end
                
                default: key_schedule_state <= STATE_IDLE;
            endcase
        end
    end

    /* Output: round key hiện tại theo key_round_num */
    assign key_o = key_out;

endmodule

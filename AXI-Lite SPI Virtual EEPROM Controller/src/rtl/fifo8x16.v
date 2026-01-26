`timescale 1ns/1ps

module fifo8x16 (
    input  wire       clk,
    input  wire       rst,

    input  wire       push,
    input  wire [7:0] din,
    output wire       full,
    output wire       empty,

    input  wire       pop,
    output wire [7:0] dout,
    output wire [4:0] level
);
    reg [7:0] mem [0:15];
    reg [3:0] wptr;
    reg [3:0] rptr;
    reg [4:0] cnt;

    assign full  = (cnt == 5'd16);
    assign empty = (cnt == 5'd0);
    assign level = cnt;

    // 组合读：dout 永远指向当前 rptr 元素（便于 AXI "读即出数"）
    assign dout = mem[rptr];

    always @(posedge clk) begin
        if (rst) begin
            wptr <= 4'd0;
            rptr <= 4'd0;
            cnt  <= 5'd0;
        end else begin
            // push only
            if (push && !full && !(pop && !empty)) begin
                mem[wptr] <= din;
                wptr <= wptr + 4'd1;
                cnt  <= cnt + 5'd1;
            end
            // pop only
            else if (pop && !empty && !(push && !full)) begin
                rptr <= rptr + 4'd1;
                cnt  <= cnt - 5'd1;
            end
            // push and pop same cycle (cnt unchanged)
            else if (push && !full && pop && !empty) begin
                mem[wptr] <= din;
                wptr <= wptr + 4'd1;
                rptr <= rptr + 4'd1;
                cnt  <= cnt; // unchanged
            end
        end
    end
endmodule

module spi_master_minimal_mode0 (
    input  wire        clk_i,
    input  wire        rst_i,

    input  wire        en_i,
    input  wire        start_i,        // 1clk pulse
    input  wire [15:0] div_half_i,     // >=1
    input  wire [7:0]  tx_byte_i,
    output reg  [7:0]  rx_byte_o,
    output reg         busy_o,
    output reg         done_o,          // 1clk pulse

    // SPI pins
    output reg         sclk_o,          // CPOL=0
    input  wire        csn_i,           // <<< 外部帧级CS控制
    output wire        csn_o,           // <<< 透传（可选）
    output reg         mosi_o,
    input  wire        miso_i
);

    assign csn_o = csn_i;

    reg [15:0] div_cnt;
    reg [2:0]  bit_cnt;
    reg [7:0]  sh_tx;
    reg [7:0]  sh_rx;

    reg        finish_pending;

    wire [15:0] div_half = (div_half_i == 16'd0) ? 16'd1 : div_half_i;

    always @(posedge clk_i) begin
        if (rst_i) begin
            sclk_o         <= 1'b0;
            mosi_o         <= 1'b0;

            div_cnt        <= 16'd0;
            bit_cnt        <= 3'd0;
            sh_tx          <= 8'd0;
            sh_rx          <= 8'd0;

            rx_byte_o      <= 8'd0;
            busy_o         <= 1'b0;
            done_o         <= 1'b0;
            finish_pending <= 1'b0;
        end else begin
            done_o <= 1'b0;

            // IDLE
            if (!busy_o) begin
                sclk_o  <= 1'b0;
                div_cnt <= 16'd0;
                finish_pending <= 1'b0;

                // 只有CS有效(低)时才允许开始一个byte
                if (en_i && start_i && (csn_i == 1'b0)) begin
                    sh_tx   <= tx_byte_i;
                    sh_rx   <= 8'd0;
                    bit_cnt <= 3'd0;

                    // preload MOSI (MSB) while SCLK low
                    mosi_o  <= tx_byte_i[7];

                    busy_o  <= 1'b1;
                end
            end
            // BUSY
            else begin
                if (div_cnt == (div_half - 16'd1)) begin
                    div_cnt <= 16'd0;
                    sclk_o  <= ~sclk_o;

                    if (sclk_o == 1'b0) begin
                        // rising: sample MISO
                        sh_rx <= {sh_rx[6:0], miso_i};

                        if (bit_cnt == 3'd7) begin
                            rx_byte_o <= {sh_rx[6:0], miso_i};
                            finish_pending <= 1'b1;
                        end else begin
                            bit_cnt <= bit_cnt + 3'd1;
                            sh_tx   <= {sh_tx[6:0], 1'b0};
                        end
                    end else begin
                        // falling: update MOSI for next rising
                        mosi_o <= sh_tx[7];

                        if (finish_pending) begin
                            finish_pending <= 1'b0;
                            busy_o <= 1'b0;
                            done_o <= 1'b1;
                        end
                    end
                end else begin
                    div_cnt <= div_cnt + 16'd1;
                end
            end
        end
    end

endmodule

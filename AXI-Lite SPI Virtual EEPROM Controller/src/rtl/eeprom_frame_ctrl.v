module eeprom_frame_ctrl (
    input  wire        clk_i,
    input  wire        rst_i,

    input  wire        en_i,
    input  wire        go_wr_i,
    input  wire        go_rd_i,
    input  wire [15:0] addr_i,
    input  wire [15:0] len_i,
    input  wire [15:0] div_half_i,

    output reg         busy_o,
    output reg         done_o,

    // TX FIFO (for burst write)
    input  wire [7:0]  tx_dout_i,
    input  wire        tx_empty_i,
    output reg         tx_pop_o,

    // RX FIFO (for burst read)
    output reg  [7:0]  rx_din_o,
    output reg         rx_push_o,
    input  wire        rx_full_i,

    // to SPI byte-master
    output reg         m_en_o,
    output reg         m_start_o,
    output reg  [15:0] m_div_half_o,
    output reg  [7:0]  m_tx_byte_o,
    input  wire [7:0]  m_rx_byte_i,
    input  wire        m_busy_i,
    input  wire        m_done_i,

    output reg         csn_o
);

    localparam [2:0]
        S_IDLE   = 3'd0,
        S_CS_L   = 3'd1,
        S_HDR    = 3'd2,
        S_DATA   = 3'd3,
        S_CS_H   = 3'd4,
        S_DONE   = 3'd5;

    reg [2:0]  st;
    reg        is_read;
    reg [1:0]  hdr_idx;      // 0:CMD 1:AH 2:AL
    reg [15:0] addr_r;
    reg [15:0] len_r;
    reg [4:0]  data_cnt;     // 0..16

    always @(posedge clk_i) begin
        if (rst_i) begin
            st <= S_IDLE;

            is_read <= 1'b0;
            hdr_idx <= 2'd0;
            addr_r  <= 16'd0;
            len_r   <= 16'd0;
            data_cnt<= 5'd0;

            busy_o  <= 1'b0;
            done_o  <= 1'b0;

            tx_pop_o  <= 1'b0;
            rx_din_o  <= 8'd0;
            rx_push_o <= 1'b0;

            m_en_o       <= 1'b0;
            m_start_o    <= 1'b0;
            m_div_half_o <= 16'd1;
            m_tx_byte_o  <= 8'd0;

            csn_o <= 1'b1;
        end else begin
            done_o    <= 1'b0;
            m_start_o <= 1'b0;
            tx_pop_o  <= 1'b0;
            rx_push_o <= 1'b0;

            m_en_o       <= en_i;
            m_div_half_o <= div_half_i;

            case (st)
                S_IDLE: begin
                    csn_o  <= 1'b1;
                    busy_o <= 1'b0;

                    if (en_i && !m_busy_i) begin
                        if (go_wr_i) begin
                            is_read <= 1'b0;
                            addr_r  <= addr_i;
                            len_r   <= len_i;
                            hdr_idx <= 2'd0;
                            data_cnt<= 5'd0;
                            busy_o  <= 1'b1;
                            st      <= S_CS_L;
                        end else if (go_rd_i) begin
                            is_read <= 1'b1;
                            addr_r  <= addr_i;
                            len_r   <= len_i;
                            hdr_idx <= 2'd0;
                            data_cnt<= 5'd0;
                            busy_o  <= 1'b1;
                            st      <= S_CS_L;
                        end
                    end
                end

                S_CS_L: begin
                    csn_o <= 1'b0;
                    st    <= S_HDR;
                end

                // send 3 header bytes: CMD, AH, AL
                S_HDR: begin
                    if (!m_busy_i && !m_start_o && !m_done_i) begin
                        if (hdr_idx == 2'd0)       m_tx_byte_o <= (is_read ? 8'h03 : 8'h02);
                        else if (hdr_idx == 2'd1)  m_tx_byte_o <= addr_r[15:8];
                        else                       m_tx_byte_o <= addr_r[7:0];

                        m_start_o <= 1'b1;
                    end

                    if (m_done_i) begin
                        if (hdr_idx == 2'd2) begin
                            st <= S_DATA;
                        end else begin
                            hdr_idx <= hdr_idx + 2'd1;
                        end
                    end
                end

                // data phase: LEN bytes
                S_DATA: begin
                    // finish condition
                    if (data_cnt == len_r[4:0]) begin
                        st <= S_CS_H;
                    end else begin
                        // only start next byte if allowed:
                        // write: need TX not empty
                        // read : need RX not full (to push incoming)
                        if (!m_busy_i && !m_start_o && !m_done_i) begin
                            if (!is_read) begin
                                if (!tx_empty_i) begin
                                    m_tx_byte_o <= tx_dout_i;
                                    m_start_o   <= 1'b1;
                                    tx_pop_o    <= 1'b1;  // consume 1 byte for this transfer
                                end
                            end else begin
                                if (!rx_full_i) begin
                                    m_tx_byte_o <= 8'h00; // dummy
                                    m_start_o   <= 1'b1;
                                end
                            end
                        end

                        if (m_done_i) begin
                            if (is_read) begin
                                // push received byte into RX FIFO
                                if (!rx_full_i) begin
                                    rx_din_o  <= m_rx_byte_i;
                                    rx_push_o <= 1'b1;
                                end
                            end
                            data_cnt <= data_cnt + 5'd1;
                        end
                    end
                end

                S_CS_H: begin
                    csn_o <= 1'b1;
                    st    <= S_DONE;
                end

                S_DONE: begin
                    busy_o <= 1'b0;
                    done_o <= 1'b1;
                    st     <= S_IDLE;
                end

                default: st <= S_IDLE;
            endcase
        end
    end

endmodule

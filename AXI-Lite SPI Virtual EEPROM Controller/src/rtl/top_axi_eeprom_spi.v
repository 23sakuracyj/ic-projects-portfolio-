module top_axi_eeprom_spi_sim #(
    parameter integer AXI_ADDR_WIDTH = 6
)(
    input  wire                       s_axi_aclk,
    input  wire                       s_axi_aresetn,

    // AXI4-Lite
    input  wire [AXI_ADDR_WIDTH-1:0]  s_axi_awaddr,
    input  wire                       s_axi_awvalid,
    output wire                       s_axi_awready,

    input  wire [31:0]                s_axi_wdata,
    input  wire [3:0]                 s_axi_wstrb,
    input  wire                       s_axi_wvalid,
    output wire                       s_axi_wready,

    output wire [1:0]                 s_axi_bresp,
    output wire                       s_axi_bvalid,
    input  wire                       s_axi_bready,

    input  wire [AXI_ADDR_WIDTH-1:0]  s_axi_araddr,
    input  wire                       s_axi_arvalid,
    output wire                       s_axi_arready,

    output wire [31:0]                s_axi_rdata,
    output wire [1:0]                 s_axi_rresp,
    output wire                       s_axi_rvalid,
    input  wire                       s_axi_rready,

    // export SPI waveform
    output wire                       spi_sclk_o,
    output wire                       spi_csn_o,
    output wire                       spi_mosi_o,
    output wire                       spi_miso_o
);

    // -----------------------------
    // AXI regs <-> frame_ctrl
    // -----------------------------
    wire        reg_en;
    wire [15:0] reg_div_half;
    wire [15:0] reg_addr;
    wire [15:0] reg_len;
    wire        go_wr_pulse;
    wire        go_rd_pulse;

    wire        fc_busy;
    wire        fc_done;

    // -----------------------------
    // FIFO wires
    // -----------------------------
    wire        tx_push;
    wire [7:0]  tx_din;
    wire        tx_full, tx_empty;
    wire        tx_pop;
    wire [7:0]  tx_dout;

    wire        rx_push;
    wire [7:0]  rx_din;
    wire        rx_full, rx_empty;
    wire        rx_pop;
    wire [7:0]  rx_dout;

    // -----------------------------
    // frame_ctrl <-> byte master
    // -----------------------------
    wire        m_en;
    wire        m_start;
    wire [15:0] m_div;
    wire [7:0]  m_tx;
    wire [7:0]  m_rx;
    wire        m_busy;
    wire        m_done;

    wire        csn_frame;

    // -----------------------------
    // SPI wires inside TOP
    // -----------------------------
    wire spi_sclk;
    wire spi_csn;
    wire spi_mosi;

    // EEPROM tri-state MISO
    wire e_miso_o;
    wire e_miso_t; // 1:Hi-Z
    wire spi_miso_line = (e_miso_t) ? 1'b1 : e_miso_o; // Hi-Z -> pull-up to '1'

    // export for viewing
    assign spi_sclk_o = spi_sclk;
    assign spi_csn_o  = spi_csn;
    assign spi_mosi_o = spi_mosi;
    assign spi_miso_o = spi_miso_line;

    // -----------------------------
    // TX FIFO (8x16)
    // -----------------------------
    fifo8x16 u_tx_fifo (
        .clk   (s_axi_aclk),
        .rst   (~s_axi_aresetn),
        .push  (tx_push),
        .din   (tx_din),
        .full  (tx_full),
        .empty (tx_empty),
        .pop   (tx_pop),
        .dout  (tx_dout),
        .level ()
    );

    // -----------------------------
    // RX FIFO (8x16)
    // -----------------------------
    fifo8x16 u_rx_fifo (
        .clk   (s_axi_aclk),
        .rst   (~s_axi_aresetn),
        .push  (rx_push),
        .din   (rx_din),
        .full  (rx_full),
        .empty (rx_empty),
        .pop   (rx_pop),
        .dout  (rx_dout),
        .level ()
    );

    // -----------------------------
    // AXI-Lite register block (FIFO + LEN version)
    // -----------------------------
    axi_lite_eeprom_spi_core32 #(
        .ADDR_WIDTH(AXI_ADDR_WIDTH)
    ) u_axi_regs (
        .s_axi_aclk    (s_axi_aclk),
        .s_axi_aresetn (s_axi_aresetn),

        .s_axi_awaddr  (s_axi_awaddr),
        .s_axi_awvalid (s_axi_awvalid),
        .s_axi_awready (s_axi_awready),

        .s_axi_wdata   (s_axi_wdata),
        .s_axi_wstrb   (s_axi_wstrb),
        .s_axi_wvalid  (s_axi_wvalid),
        .s_axi_wready  (s_axi_wready),

        .s_axi_bresp   (s_axi_bresp),
        .s_axi_bvalid  (s_axi_bvalid),
        .s_axi_bready  (s_axi_bready),

        .s_axi_araddr  (s_axi_araddr),
        .s_axi_arvalid (s_axi_arvalid),
        .s_axi_arready (s_axi_arready),

        .s_axi_rdata   (s_axi_rdata),
        .s_axi_rresp   (s_axi_rresp),
        .s_axi_rvalid  (s_axi_rvalid),
        .s_axi_rready  (s_axi_rready),

        // to frame_ctrl
        .en_o          (reg_en),
        .div_half_o    (reg_div_half),
        .addr_o        (reg_addr),
        .len_o         (reg_len),
        .go_wr_o       (go_wr_pulse),
        .go_rd_o       (go_rd_pulse),

        // from frame_ctrl
        .busy_i        (fc_busy),
        .done_i        (fc_done),

        // TX FIFO
        .tx_push_o     (tx_push),
        .tx_din_o      (tx_din),
        .tx_full_i     (tx_full),
        .tx_empty_i    (tx_empty),

        // RX FIFO
        .rx_pop_o      (rx_pop),
        .rx_dout_i     (rx_dout),
        .rx_empty_i    (rx_empty),
        .rx_full_i     (rx_full)
    );

    // -----------------------------
    // EEPROM frame controller (burst + FIFO version)
    // -----------------------------
    eeprom_frame_ctrl u_fc (
        .clk_i        (s_axi_aclk),
        .rst_i        (~s_axi_aresetn),

        .en_i         (reg_en),
        .go_wr_i      (go_wr_pulse),
        .go_rd_i      (go_rd_pulse),
        .addr_i       (reg_addr),
        .len_i        (reg_len),
        .div_half_i   (reg_div_half),

        .busy_o       (fc_busy),
        .done_o       (fc_done),

        // TX FIFO
        .tx_dout_i    (tx_dout),
        .tx_empty_i   (tx_empty),
        .tx_pop_o     (tx_pop),

        // RX FIFO
        .rx_din_o     (rx_din),
        .rx_push_o    (rx_push),
        .rx_full_i    (rx_full),

        // to SPI master
        .m_en_o       (m_en),
        .m_start_o    (m_start),
        .m_div_half_o (m_div),
        .m_tx_byte_o  (m_tx),
        .m_rx_byte_i  (m_rx),
        .m_busy_i     (m_busy),
        .m_done_i     (m_done),

        .csn_o        (csn_frame)
    );

    // -----------------------------
    // Byte SPI master (unchanged)
    // -----------------------------
    spi_master_minimal_mode0 u_master (
        .clk_i      (s_axi_aclk),
        .rst_i      (~s_axi_aresetn),

        .en_i       (m_en),
        .start_i    (m_start),
        .div_half_i (m_div),
        .tx_byte_i  (m_tx),
        .rx_byte_o  (m_rx),
        .busy_o     (m_busy),
        .done_o     (m_done),

        .sclk_o     (spi_sclk),
        .csn_i      (csn_frame),
        .csn_o      (),
        .mosi_o     (spi_mosi),
        .miso_i     (spi_miso_line)
    );

    assign spi_csn = csn_frame;

    // -----------------------------
    // EEPROM slave model
    // -----------------------------
    eeprom_spi u_eeprom (
        .clk_i    (s_axi_aclk),
        .rst_i    (~s_axi_aresetn),
        .sclk_i   (spi_sclk),
        .csn_i    (spi_csn),
        .mosi_i   (spi_mosi),
        .miso_o   (e_miso_o),
        .miso_t_o (e_miso_t)
    );

endmodule

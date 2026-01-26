`timescale 1ns/1ps
`default_nettype none

module uart (
    input  wire clk_in1_0,
    output wire uart_tx_o,
    input  wire uart_rx_i
);

    // ------------------------------------------------------------
    // GPIO debug (keep your original)
    // ------------------------------------------------------------
    wire [15:0] probe_in0;
    wire [15:0] probe_out0;

    // ------------------------------------------------------------
    // AXI signals from design_1 (MicroBlaze system)
    // ------------------------------------------------------------
    wire [31:0] axi_araddr;
    wire        axi_arready;
    wire        axi_arvalid;

    wire [31:0] axi_rdata;
    wire        axi_rready;
    wire [1:0]  axi_rresp;
    wire        axi_rvalid;

    wire [31:0] axi_awaddr;
    wire        axi_awready;
    wire        axi_awvalid;

    wire [31:0] axi_wdata;
    wire        axi_wready;
    wire        axi_wvalid;

    wire        axi_bready;
    wire [1:0]  axi_bresp;
    wire        axi__bvalid;   // keep your naming to avoid touching other code

    wire        peripheral_reset;
    wire        clk_100m_o;

    // ------------------------------------------------------------
    // Instantiate your MicroBlaze system (unchanged ports style)
    // ------------------------------------------------------------
    design_1 inst_mb_cpu (
        .GPIO_0_tri_i          (probe_in0),
        .GPIO_0_tri_o          (probe_out0),
        .GPIO_0_tri_t          (),

        .clk_100m_o            (clk_100m_o),
        .clk_in1_0             (clk_in1_0),

        .reset_rtl_0           (1'b0),

        .uart_rtl_0_rxd        (uart_rx_i),
        .uart_rtl_0_txd        (uart_tx_o),

        // AXI (note: many unused AXI4 full signals are left open)
        .axi_interface_araddr  (axi_araddr),
        .axi_interface_arburst (),
        .axi_interface_arcache (),
        .axi_interface_arlen   (),
        .axi_interface_arlock  (),
        .axi_interface_arprot  (),
        .axi_interface_arqos   (),
        .axi_interface_arready (axi_arready),
        .axi_interface_arregion(),
        .axi_interface_arsize  (),
        .axi_interface_arvalid (axi_arvalid),

        .axi_interface_awaddr  (axi_awaddr),
        .axi_interface_awburst (),
        .axi_interface_awcache (),
        .axi_interface_awlen   (),
        .axi_interface_awlock  (),
        .axi_interface_awprot  (),
        .axi_interface_awqos   (),
        .axi_interface_awready (axi_awready),
        .axi_interface_awregion(),
        .axi_interface_awsize  (),
        .axi_interface_awvalid (axi_awvalid),

        .axi_interface_bready  (axi_bready),
        .axi_interface_bresp   (axi_bresp),
        .axi_interface_bvalid  (axi__bvalid),

        .axi_interface_rdata   (axi_rdata),
        .axi_interface_rlast   (),            // unused for AXI-Lite style
        .axi_interface_rready  (axi_rready),
        .axi_interface_rresp   (axi_rresp),
        .axi_interface_rvalid  (axi_rvalid),

        .axi_interface_wdata   (axi_wdata),
        .axi_interface_wlast   (),            // unused for AXI-Lite style
        .axi_interface_wready  (axi_wready),
        .axi_interface_wstrb   (),            // not exported here in your design_1
        .axi_interface_wvalid  (axi_wvalid),

        .peripheral_reset_0    (peripheral_reset)
    );

    // ------------------------------------------------------------
    // Replace axiregs with your AXI-Lite SPI+Virtual EEPROM TOP
    // Keep EXACT TB-style address meaning: 6-bit byte offsets 0x00/0x04/...
    // ------------------------------------------------------------
    localparam integer AXI_ADDR_WIDTH = 6;

    // peripheral_reset is usually ACTIVE-HIGH, while s_axi_aresetn is ACTIVE-LOW
    wire s_axi_aresetn = ~peripheral_reset;

    // Keep TB mapping (byte offsets): take low 6 bits directly, DO NOT shift
    wire [AXI_ADDR_WIDTH-1:0] awaddr_lite = axi_awaddr[AXI_ADDR_WIDTH-1:0];
    wire [AXI_ADDR_WIDTH-1:0] araddr_lite = axi_araddr[AXI_ADDR_WIDTH-1:0];

    // No WSTRB exported from design_1 -> force full-word writes (same as your TB)
    wire [3:0] wstrb_lite = 4'b1111;

    // Optional: export SPI waveforms to ILA (board has no EEPROM, internal model handles MISO)
    wire spi_sclk_o, spi_csn_o, spi_mosi_o, spi_miso_o;

    top_axi_eeprom_spi_sim #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH)
    ) u_axi_spi_eeprom (
        .s_axi_aclk    (clk_100m_o),
        .s_axi_aresetn (s_axi_aresetn),

        .s_axi_awaddr  (awaddr_lite),
        .s_axi_awvalid (axi_awvalid),
        .s_axi_awready (axi_awready),

        .s_axi_wdata   (axi_wdata),
        .s_axi_wstrb   (wstrb_lite),
        .s_axi_wvalid  (axi_wvalid),
        .s_axi_wready  (axi_wready),

        .s_axi_bresp   (axi_bresp),
        .s_axi_bvalid  (axi__bvalid),
        .s_axi_bready  (axi_bready),

        .s_axi_araddr  (araddr_lite),
        .s_axi_arvalid (axi_arvalid),
        .s_axi_arready (axi_arready),

        .s_axi_rdata   (axi_rdata),
        .s_axi_rresp   (axi_rresp),
        .s_axi_rvalid  (axi_rvalid),
        .s_axi_rready  (axi_rready),

        .spi_sclk_o    (spi_sclk_o),
        .spi_csn_o     (spi_csn_o),
        .spi_mosi_o    (spi_mosi_o),
        .spi_miso_o    (spi_miso_o)
    );

    // ------------------------------------------------------------
    // Debug cores (keep your style)
    // ------------------------------------------------------------
    vio_0 b_vio_0 (
        .clk        (clk_100m_o),
        .probe_in0  (probe_out0),
        .probe_out0 (probe_in0)
    );

    // UART ILA:建议用同域时钟采样（这里用 clk_100m_o 更稳）
    ila_0_uart ila_uart (
        .clk   (clk_100m_o),
        .probe0({
            uart_tx_o,
            uart_rx_i
        })
    );

    // Optional: SPI ILA（如果你有一个 ILA 核，就把下面 probe 接进去）
    // ila_spi u_ila_spi (
    //   .clk(clk_100m_o),
    //   .probe0({spi_sclk_o, spi_csn_o, spi_mosi_o, spi_miso_o})
    // );

endmodule

`default_nettype wire

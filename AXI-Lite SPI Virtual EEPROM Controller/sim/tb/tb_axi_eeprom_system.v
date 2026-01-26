`timescale 1ns/1ps

module tb_axi_eeprom_system;

  // ============================================================
  // Clock / Reset
  // ============================================================
  reg s_axi_aclk = 1'b0;
  reg s_axi_aresetn = 1'b0;

  localparam integer CLK_TNS = 10; // 100MHz

  always #(CLK_TNS/2) s_axi_aclk = ~s_axi_aclk;

  // ============================================================
  // AXI4-Lite Signals
  // ============================================================
  reg  [5:0]  s_axi_awaddr;
  reg         s_axi_awvalid;
  wire        s_axi_awready;

  reg  [31:0] s_axi_wdata;
  reg  [3:0]  s_axi_wstrb;
  reg         s_axi_wvalid;
  wire        s_axi_wready;

  wire [1:0]  s_axi_bresp;
  wire        s_axi_bvalid;
  reg         s_axi_bready;

  reg  [5:0]  s_axi_araddr;
  reg         s_axi_arvalid;
  wire        s_axi_arready;

  wire [31:0] s_axi_rdata;
  wire [1:0]  s_axi_rresp;
  wire        s_axi_rvalid;
  reg         s_axi_rready;

  // ============================================================
  // SPI wires between AXI core and EEPROM slave
  // ============================================================
  wire spi_sclk;
  wire spi_csn;
  wire spi_mosi;
  wire spi_miso;

  wire miso_o_w;
  wire miso_t_w;

  // EEPROM MISO tri-state resolve (hi-z -> pull-up 1)
  assign spi_miso = (miso_t_w) ? 1'b1 : miso_o_w;

  // ============================================================
  // DUT: AXI-Lite EEPROM SPI core (your core module)
  // ============================================================
  axi_lite_eeprom_spi_core32 #(
    .ADDR_WIDTH(6)
  ) dut (
    .s_axi_aclk     (s_axi_aclk),
    .s_axi_aresetn  (s_axi_aresetn),

    .s_axi_awaddr   (s_axi_awaddr),
    .s_axi_awvalid  (s_axi_awvalid),
    .s_axi_awready  (s_axi_awready),

    .s_axi_wdata    (s_axi_wdata),
    .s_axi_wstrb    (s_axi_wstrb),
    .s_axi_wvalid   (s_axi_wvalid),
    .s_axi_wready   (s_axi_wready),

    .s_axi_bresp    (s_axi_bresp),
    .s_axi_bvalid   (s_axi_bvalid),
    .s_axi_bready   (s_axi_bready),

    .s_axi_araddr   (s_axi_araddr),
    .s_axi_arvalid  (s_axi_arvalid),
    .s_axi_arready  (s_axi_arready),

    .s_axi_rdata    (s_axi_rdata),
    .s_axi_rresp    (s_axi_rresp),
    .s_axi_rvalid   (s_axi_rvalid),
    .s_axi_rready   (s_axi_rready),

    .spi_sclk       (spi_sclk),
    .spi_csn        (spi_csn),
    .spi_mosi       (spi_mosi),
    .spi_miso       (spi_miso)
  );

  // ============================================================
  // DUT: EEPROM SPI slave (your provided module)
  // clk_i is 100MHz system clk, sclk_i is spi_sclk from master/core
  // ============================================================
  eeprom_spi u_eeprom (
    .clk_i    (s_axi_aclk),
    .rst_i    (~s_axi_aresetn),
    .sclk_i   (spi_sclk),
    .csn_i    (spi_csn),
    .mosi_i   (spi_mosi),
    .miso_o   (miso_o_w),
    .miso_t_o (miso_t_w)
  );

  // ============================================================
  // Register offsets (match the core module)
  // ============================================================
  localparam [5:0] REG_CTRL   = 6'h00;
  localparam [5:0] REG_DIV    = 6'h04;
  localparam [5:0] REG_ADDR   = 6'h08;
  localparam [5:0] REG_WDATA  = 6'h0C;
  localparam [5:0] REG_RDATA  = 6'h10;
  localparam [5:0] REG_STATUS = 6'h14;

  // CTRL bits
  localparam [31:0] CTRL_EN    = 32'h0000_0001;
  localparam [31:0] CTRL_GO_WR = 32'h0000_0002;
  localparam [31:0] CTRL_GO_RD = 32'h0000_0004;

  // ============================================================
  // TB "CPU" state
  // ============================================================
  reg pass, fail;
  reg [7:0] rd10, rd11;

  // ============================================================
  // AXI-Lite helper tasks (single-beat)
  // ============================================================

  task axi_write32;
    input [5:0]  addr;
    input [31:0] data;
    begin
      // default
      s_axi_awaddr  <= addr;
      s_axi_awvalid <= 1'b1;
      s_axi_wdata   <= data;
      s_axi_wstrb   <= 4'b1111; // PS端32位写，高位为0也没问题
      s_axi_wvalid  <= 1'b1;
      s_axi_bready  <= 1'b1;

      // wait handshake for address and data
      while (!(s_axi_awready && s_axi_wready)) begin
        @(posedge s_axi_aclk);
      end

      // deassert valids after accepted
      @(posedge s_axi_aclk);
      s_axi_awvalid <= 1'b0;
      s_axi_wvalid  <= 1'b0;

      // wait for response
      while (!s_axi_bvalid) @(posedge s_axi_aclk);

      // accept response
      @(posedge s_axi_aclk);
      s_axi_bready <= 1'b0;
    end
  endtask

  task axi_read32;
    input  [5:0]  addr;
    output [31:0] data;
    begin
      s_axi_araddr  <= addr;
      s_axi_arvalid <= 1'b1;
      s_axi_rready  <= 1'b1;

      // wait address accept
      while (!s_axi_arready) @(posedge s_axi_aclk);

      @(posedge s_axi_aclk);
      s_axi_arvalid <= 1'b0;

      // wait read data
      while (!s_axi_rvalid) @(posedge s_axi_aclk);
      data = s_axi_rdata;

      @(posedge s_axi_aclk);
      s_axi_rready <= 1'b0;
    end
  endtask

  // poll STATUS until DONE==1 (also checks BUSY can be ignored)
  task wait_done;
    reg [31:0] st;
    begin
      st = 32'd0;
      // DONE is bit1
      while (st[1] != 1'b1) begin
        axi_read32(REG_STATUS, st);
        @(posedge s_axi_aclk);
      end
      // reading STATUS clears DONE inside DUT (per core design)
    end
  endtask

  // high-level EEPROM ops via registers
  task eeprom_write8;
    input [15:0] addr;
    input [7:0]  data8;
    begin
      axi_write32(REG_ADDR,  {16'h0000, addr});           // WDATA[15:0] used
      axi_write32(REG_WDATA, {24'h000000, data8});        // WDATA[7:0] used
      axi_write32(REG_CTRL,  CTRL_EN | CTRL_GO_WR);       // start write transaction
      wait_done();
    end
  endtask

  task eeprom_read8;
    input  [15:0] addr;
    output [7:0]  data8;
    reg [31:0] tmp;
    begin
      axi_write32(REG_ADDR, {16'h0000, addr});
      axi_write32(REG_CTRL, CTRL_EN | CTRL_GO_RD);
      wait_done();
      axi_read32(REG_RDATA, tmp);
      data8 = tmp[7:0];
    end
  endtask

  // ============================================================
  // Test sequence (NO console output)
  // ============================================================
  initial begin
    // init AXI
    s_axi_awaddr  = 6'd0;
    s_axi_awvalid = 1'b0;
    s_axi_wdata   = 32'd0;
    s_axi_wstrb   = 4'b0000;
    s_axi_wvalid  = 1'b0;
    s_axi_bready  = 1'b0;

    s_axi_araddr  = 6'd0;
    s_axi_arvalid = 1'b0;
    s_axi_rready  = 1'b0;

    pass = 1'b0;
    fail = 1'b0;
    rd10 = 8'h00;
    rd11 = 8'h00;

    // reset
    repeat (10) @(posedge s_axi_aclk);
    s_axi_aresetn = 1'b0;
    repeat (20) @(posedge s_axi_aclk);
    s_axi_aresetn = 1'b1;
    repeat (20) @(posedge s_axi_aclk);

    // set SCLK = 10MHz => DIV_HALF=5
    axi_write32(REG_DIV, 32'h0000_0005);

    // write BE/EF
    eeprom_write8(16'h0010, 8'hBE);
    eeprom_write8(16'h0011, 8'hEF);

    // delay (optional; EEPROM model is immediate, but keep per spec)
    repeat (2000) @(posedge s_axi_aclk);

    // read back
    eeprom_read8(16'h0010, rd10);
    eeprom_read8(16'h0011, rd11);

    // check silently
    if ((rd10 === 8'hBE) && (rd11 === 8'hEF)) pass = 1'b1;
    else fail = 1'b1;

    repeat (50) @(posedge s_axi_aclk);
    $finish;
  end

endmodule

`timescale 1ns/1ps

module tb_spi_master_with_eeprom;

  // ----------------------------
  // Clock / Reset
  // ----------------------------
  reg clk_i = 1'b0;
  reg rst_i = 1'b1;

  localparam integer CLK_TNS = 10; // 100MHz

  always #(CLK_TNS/2) clk_i = ~clk_i;

  // ----------------------------
  // SPI signals
  // ----------------------------
  wire sclk_w;
  wire mosi_w;

  reg  csn_tb;            // TB-controlled CS (IMPORTANT)
  wire miso_o_w;
  wire miso_t_w;

  // resolve slave tri-state: when hi-z -> treat as pulled-up '1'
  wire miso_line = (miso_t_w) ? 1'b1 : miso_o_w;

  // ----------------------------
  // Master control signals
  // ----------------------------
  reg        en_i;
  reg        start_i;
  reg [15:0] div_half_i;
  reg [7:0]  tx_byte_i;
  wire [7:0] rx_byte_o;
  wire       busy_o;
  wire       done_o;

  // ----------------------------
  // DUTs
  // ----------------------------
  spi_master_minimal_mode0 u_master (
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .en_i       (en_i),
    .start_i    (start_i),
    .div_half_i (div_half_i),
    .tx_byte_i  (tx_byte_i),
    .rx_byte_o  (rx_byte_o),
    .busy_o     (busy_o),
    .done_o     (done_o),
    .sclk_o     (sclk_w),
    .csn_o      (),          // not used
    .mosi_o     (mosi_w),
    .miso_i     (miso_line)
  );

  eeprom_spi u_slave (
    .clk_i    (clk_i),
    .rst_i    (rst_i),
    .sclk_i   (sclk_w),
    .csn_i    (csn_tb),
    .mosi_i   (mosi_w),
    .miso_o   (miso_o_w),
    .miso_t_o (miso_t_w)
  );

  // ----------------------------
  // Test result flags (no console output)
  // ----------------------------
  reg pass, fail;
  reg [7:0] r10, r11;

  // ----------------------------
  // Helpers
  // ----------------------------

  // 1-byte SPI shift (Mode0). CS is controlled outside this task.
  task automatic spi_xfer_byte(input [7:0] tx, output [7:0] rx);
    begin
      // wait master idle
      while (busy_o) @(posedge clk_i);

      tx_byte_i <= tx;
      start_i   <= 1'b1;
      @(posedge clk_i);
      start_i   <= 1'b0;

      // wait done pulse
      while (!done_o) @(posedge clk_i);

      rx = rx_byte_o;
      @(posedge clk_i); // small settle gap
    end
  endtask

  // EEPROM write 1 byte: [02][AH][AL][DATA] within one CS low window
  task automatic eeprom_write8(input [15:0] addr, input [7:0] data);
    reg [7:0] dummy;
    begin
      csn_tb <= 1'b0;
      @(posedge clk_i);

      spi_xfer_byte(8'h02, dummy);
      spi_xfer_byte(addr[15:8], dummy);
      spi_xfer_byte(addr[7:0],  dummy);
      spi_xfer_byte(data,       dummy);

      @(posedge clk_i);
      csn_tb <= 1'b1;
      @(posedge clk_i);
    end
  endtask

  // EEPROM read 1 byte: [03][AH][AL][00] -> rx on last byte
  task automatic eeprom_read8(input [15:0] addr, output [7:0] data);
    reg [7:0] dummy;
    reg [7:0] rx;
    begin
      csn_tb <= 1'b0;
      @(posedge clk_i);

      spi_xfer_byte(8'h03, dummy);
      spi_xfer_byte(addr[15:8], dummy);
      spi_xfer_byte(addr[7:0],  dummy);
      spi_xfer_byte(8'h00,      rx);    // dummy clocks data out
      data = rx;

      @(posedge clk_i);
      csn_tb <= 1'b1;
      @(posedge clk_i);
    end
  endtask

  // ----------------------------
  // Test sequence
  // ----------------------------
  initial begin
    // init
    en_i       = 1'b0;
    start_i    = 1'b0;
    tx_byte_i  = 8'h00;

    // 100MHz clk -> choose 10MHz SCLK: div_half = 5 (SCLK = 100/(2*5)=10MHz)
    div_half_i = 16'd5;

    csn_tb = 1'b1;
    pass = 1'b0;
    fail = 1'b0;
    r10  = 8'h00;
    r11  = 8'h00;

    // reset
    #(20*CLK_TNS);
    rst_i = 1'b0;
    en_i  = 1'b1;

    // give some cycles
    repeat (20) @(posedge clk_i);

    // write
    eeprom_write8(16'h0010, 8'hBE);
    eeprom_write8(16'h0011, 8'hEF);

    // delay (model写入是立即的，这里只是模拟"写周期等待")
    repeat (2000) @(posedge clk_i);

    // read back (same addresses)
    eeprom_read8(16'h0010, r10);
    eeprom_read8(16'h0011, r11);

    // silent check
    if ((r10 === 8'hBE) && (r11 === 8'hEF)) pass = 1'b1;
    else fail = 1'b1;

    // optional: assertions (no printing by default)
    // assert(r10 === 8'hBE);
    // assert(r11 === 8'hEF);

    repeat (20) @(posedge clk_i);
    $finish;
  end

endmodule

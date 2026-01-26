`timescale 1ns/1ps

// ============================================================
// Readable TB for eeprom_spi
// - 100MHz clk_i fixed
// - SPI SCLK frequency configurable
// - Macro-based WRITE/READ sequences
// - No console output ($display/$monitor etc.)
// ============================================================

// -----------------------------
// User-config macros
// -----------------------------
`define CMD_WRITE 8'h02
`define CMD_READ  8'h03

`define ADDR_10   16'h0010
`define ADDR_11   16'h0011

`define DATA_BE   8'hBE
`define DATA_EF   8'hEF

// Use these two macros to perform transactions
`define EEPROM_WRITE8(_addr,_data) eeprom_write8((_addr), (_data))
`define EEPROM_READ8(_addr,_var)   eeprom_read8((_addr), (_var))

module tb_eeprom_spi;

  // -----------------------------
  // Clocks
  // -----------------------------
  localparam integer CLK_TNS = 10; // 100MHz => 10ns period

  // SPI SCLK (edit freely)
  localparam integer SCLK_HZ = 10_000_000; // 10MHz
  localparam integer SCLK_HALF_NS = (1_000_000_000 / (2*SCLK_HZ));

  // -----------------------------
  // DUT I/O
  // -----------------------------
  reg  clk_i;
  reg  rst_i;
  reg  sclk_i;
  reg  csn_i;
  reg  mosi_i;

  wire miso_o;
  wire miso_t_o;

  // master-side MISO with tri-state handling
  wire miso = (miso_t_o) ? 1'bz : miso_o;

  // -----------------------------
  // Instantiate DUT
  // -----------------------------
  eeprom_spi dut (
    .clk_i    (clk_i),
    .rst_i    (rst_i),
    .sclk_i   (sclk_i),
    .csn_i    (csn_i),
    .mosi_i   (mosi_i),
    .miso_o   (miso_o),
    .miso_t_o (miso_t_o)
  );

  // -----------------------------
  // 100MHz system clock
  // -----------------------------
  initial begin
    clk_i = 1'b0;
    forever #(CLK_TNS/2) clk_i = ~clk_i;
  end

  // ============================================================
  // SPI Mode-0 helpers (CPOL=0, CPHA=0)
  // - Drive MOSI while SCLK low
  // - Sample MISO on rising edge
  // ============================================================

  task spi_idle;
    begin
      sclk_i = 1'b0;
      mosi_i = 1'b0;
      csn_i  = 1'b1;
      #(SCLK_HALF_NS);
    end
  endtask

  task spi_csn_low;
    begin
      csn_i = 1'b0;
      #(SCLK_HALF_NS);
    end
  endtask

  task spi_csn_high;
    begin
      #(SCLK_HALF_NS);
      csn_i = 1'b1;
      #(SCLK_HALF_NS);
    end
  endtask

  // One-byte transfer, MSB-first
  task spi_xfer_byte;
    input  [7:0] tx;
    output [7:0] rx;
    integer i;
    reg [7:0] r;
    begin
      r = 8'h00;
      for (i = 7; i >= 0; i = i - 1) begin
        // setup MOSI at SCLK low
        mosi_i = tx[i];
        #(SCLK_HALF_NS);

        // rising edge: sample MISO
        sclk_i = 1'b1;
        #(1);
        r[i] = miso;
        #(SCLK_HALF_NS - 1);

        // falling edge
        sclk_i = 1'b0;
        #(SCLK_HALF_NS);
      end
      rx = r;
    end
  endtask

  // ============================================================
  // EEPROM transactions
  // ============================================================

  task eeprom_write8;
    input [15:0] addr;
    input [7:0]  data;
    reg   [7:0]  rx;
    begin
      spi_csn_low();
      spi_xfer_byte(`CMD_WRITE, rx);
      spi_xfer_byte(addr[15:8], rx);
      spi_xfer_byte(addr[7:0],  rx);
      spi_xfer_byte(data,       rx);
      spi_csn_high();
    end
  endtask

  task eeprom_read8;
    input  [15:0] addr;
    output [7:0]  data;
    reg   [7:0]   rx;
    begin
      spi_csn_low();
      spi_xfer_byte(`CMD_READ, rx);
      spi_xfer_byte(addr[15:8], rx);
      spi_xfer_byte(addr[7:0],  rx);
      spi_xfer_byte(8'h00,      rx); // dummy to clock out one byte
      data = rx;
      spi_csn_high();
    end
  endtask

  // ============================================================
  // Test sequence (no console output)
  // ============================================================
  reg [7:0] r10, r11;
  reg       fail;

  initial begin
    // init
    rst_i  = 1'b1;
    sclk_i = 1'b0;
    csn_i  = 1'b1;
    mosi_i = 1'b0;
    fail   = 1'b0;

    // reset release
    #(20*CLK_TNS);
    rst_i = 1'b0;

    spi_idle();
    #(200);

    // Writes
    `EEPROM_WRITE8(`ADDR_10, `DATA_BE);
    `EEPROM_WRITE8(`ADDR_11, `DATA_EF);

    // delay (model writes immediately, but keep "program time" gap)
    #(5000);

    // Reads
    `EEPROM_READ8(`ADDR_10, r10);
    `EEPROM_READ8(`ADDR_11, r11);

    // Silent check (no prints)
    if (r10 !== `DATA_BE) fail = 1'b1;
    if (r11 !== `DATA_EF) fail = 1'b1;

    // End simulation (silent)
    #(1000);
    $finish;
  end

endmodule

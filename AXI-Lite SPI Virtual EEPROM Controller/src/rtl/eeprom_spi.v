module eeprom_spi #(
    parameter integer ADDR_WIDTH = 16,   // keep interface width (15-bit requirement satisfied by using low bits)
    parameter integer MEM_DEPTH  = 4096  // 4KB mirror storage
)(
    input  wire clk_i,
    input  wire rst_i,
    input  wire sclk_i,
    input  wire csn_i,
    input  wire mosi_i,
    output wire miso_o,
    output wire miso_t_o // 1: Hi-Z, 0: drive
);

    // -----------------------------
    // Sync external SPI pins into clk_i domain
    // -----------------------------
    reg sclk_ff1, sclk_ff2, sclk_d;
    reg csn_ff1,  csn_ff2,  csn_d;
    reg mosi_ff1, mosi_ff2;

    always @(posedge clk_i) begin
        if (rst_i) begin
            sclk_ff1 <= 1'b0;
            sclk_ff2 <= 1'b0;
            sclk_d   <= 1'b0;

            csn_ff1  <= 1'b1;
            csn_ff2  <= 1'b1;
            csn_d    <= 1'b1;

            mosi_ff1 <= 1'b0;
            mosi_ff2 <= 1'b0;
        end else begin
            sclk_ff1 <= sclk_i;
            sclk_ff2 <= sclk_ff1;
            sclk_d   <= sclk_ff2;

            csn_ff1  <= csn_i;
            csn_ff2  <= csn_ff1;
            csn_d    <= csn_ff2;

            mosi_ff1 <= mosi_i;
            mosi_ff2 <= mosi_ff1;
        end
    end

    wire csn       = csn_ff2;
    wire mosi      = mosi_ff2;
    wire sclk_rise =  sclk_ff2 & ~sclk_d;
    wire sclk_fall = ~sclk_ff2 &  sclk_d;
    wire csn_fall  = ~csn_ff2  &  csn_d;
    wire csn_rise  =  csn_ff2  & ~csn_d;
    wire active    = ~csn;

    // -----------------------------
    // Memory: 4KB mirror (4096 x 8)
    // Access uses low 12 bits of address: addr[11:0]
    // -----------------------------
    reg [7:0] mem [0:MEM_DEPTH-1];

    // -----------------------------
    // States
    // -----------------------------
    localparam [2:0]
        ST_IDLE  = 3'd0,
        ST_CMD   = 3'd1,
        ST_AH    = 3'd2,
        ST_AL    = 3'd3,
        ST_READ  = 3'd4,
        ST_WRITE = 3'd5;

    reg [2:0]  st;
    reg [7:0]  cmd;
    reg [15:0] addr;
    reg [2:0]  bitcnt;
    reg [7:0]  sh_in;
    reg [7:0]  sh_out;
    reg        rd_prime; // skip first fall after entering READ

    // MISO drive / tri-state
    assign miso_o   = sh_out[7];
    assign miso_t_o = csn; // csn=1 -> Hi-Z, csn=0 -> drive

    // byte done on rising edge when bitcnt==7
    wire byte_done_rise = sclk_rise && (bitcnt == 3'd7);
    wire [7:0] rx_byte  = {sh_in[6:0], mosi};

    // Verilog-safe helpers (no slicing on concatenation)
    wire [15:0] addr_assembled = {addr[15:8], rx_byte};
    wire [15:0] addr_next      = addr + 16'd1;

    always @(posedge clk_i) begin
        if (rst_i) begin
            st       <= ST_IDLE;
            cmd      <= 8'h00;
            addr     <= 16'h0000;
            bitcnt   <= 3'd0;
            sh_in    <= 8'h00;
            sh_out   <= 8'hFF;
            rd_prime <= 1'b0;
        end else begin
            // -----------------------------
            // CS boundary priority
            // -----------------------------
            if (csn_rise) begin
                st       <= ST_IDLE;
                bitcnt   <= 3'd0;
                sh_in    <= 8'h00;
                sh_out   <= 8'hFF;
                rd_prime <= 1'b0;
            end else if (csn_fall) begin
                st       <= ST_CMD;
                bitcnt   <= 3'd0;
                sh_in    <= 8'h00;
                sh_out   <= 8'hFF;
                rd_prime <= 1'b0;
            end else if (active) begin

                // -----------------------------
                // Rising edge: sample MOSI
                // -----------------------------
                if (sclk_rise) begin
                    sh_in <= {sh_in[6:0], mosi};

                    // bit counter
                    if (bitcnt == 3'd7)
                        bitcnt <= 3'd0;
                    else
                        bitcnt <= bitcnt + 3'd1;

                    // byte complete
                    if (byte_done_rise) begin
                        case (st)
                            ST_CMD: begin
                                cmd <= rx_byte;
                                st  <= ST_AH;
                            end

                            ST_AH: begin
                                addr[15:8] <= rx_byte;
                                st         <= ST_AL;
                            end

                            ST_AL: begin
                                addr[7:0] <= rx_byte;

                                if (cmd == 8'h03) begin
                                    // preload FIRST data at assembled address (mirror -> low 12 bits)
                                    sh_out   <= mem[addr_assembled[11:0]];
                                    st       <= ST_READ;
                                    rd_prime <= 1'b1;
                                end else if (cmd == 8'h02) begin
                                    st <= ST_WRITE;
                                end else begin
                                    st <= ST_IDLE;
                                end
                            end

                            ST_WRITE: begin
                                // write 1 byte then auto-increment address (mirror mapping)
                                mem[addr[11:0]] <= rx_byte;
                                addr <= addr + 16'd1;
                            end

                           ST_READ: begin
                                addr     <= addr_next;
                                sh_out   <= mem[addr_next[11:0]];
                                rd_prime <= 1'b1;   // 关键：每个新字节装载后，跳过紧跟的第一次fall
                            end

                            default: begin
                                st <= ST_IDLE;
                            end
                        endcase
                    end
                end

                // -----------------------------
                // Falling edge: shift MISO (ONLY in READ)
                // -----------------------------
                if (sclk_fall && st == ST_READ) begin
                    if (rd_prime) begin
                        rd_prime <= 1'b0; // first fall: just clear flag
                    end else begin
                        sh_out <= {sh_out[6:0], 1'b1};
                    end
                end
            end
        end
    end

endmodule

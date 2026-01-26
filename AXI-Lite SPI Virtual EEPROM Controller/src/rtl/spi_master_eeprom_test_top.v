module spi_master_eeprom_test_top #(
    parameter [15:0] DIV_HALF = 16'd5,   // 100MHz/(2*5)=10MHz
    parameter integer DELAY_CYC = 2000    // 写后等待(按clk_i计)
)(
    input  wire clk_i,
    input  wire rst_i,

    output reg  [7:0] rd_10_o,
    output reg  [7:0] rd_11_o,
    output reg        pass_o,
    output reg        fail_o,
    output reg        done_o
);
    // -------- SPI interconnect --------
    wire sclk_w, mosi_w;
    wire miso_o_w, miso_t_w;
    reg  csn_ctrl;

    // MISO tri-state resolve (csn=1时从机hi-z；等效上拉为1)
    wire miso_line = (miso_t_w) ? 1'b1 : miso_o_w;

    // -------- Master controls --------
    reg        en_r;
    reg        start_r;
    reg [7:0]  tx_r;
    wire [7:0] rx_w;
    wire       busy_w;
    wire       done_w;

    // ====== your minimal master ======
    spi_master_minimal_mode0 u_m (
        .clk_i      (clk_i),
        .rst_i      (rst_i),
        .en_i       (en_r),
        .start_i    (start_r),
        .div_half_i (DIV_HALF),
        .tx_byte_i  (tx_r),
        .rx_byte_o  (rx_w),
        .busy_o     (busy_w),
        .done_o     (done_w),
        .sclk_o     (sclk_w),
        .csn_o      (),          // 不用master的CS
        .mosi_o     (mosi_w),
        .miso_i     (miso_line)
    );

    // ====== your EEPROM slave ======
    eeprom_spi u_s (
        .clk_i    (clk_i),
        .rst_i    (rst_i),
        .sclk_i   (sclk_w),
        .csn_i    (csn_ctrl),
        .mosi_i   (mosi_w),
        .miso_o   (miso_o_w),
        .miso_t_o (miso_t_w)
    );

    // -------- Test FSM --------
    localparam [5:0]
      ST_IDLE=0,

      ST_W10_CSL=1, ST_W10_B0=2, ST_W10_B1=3, ST_W10_B2=4, ST_W10_B3=5, ST_W10_CSH=6,
      ST_W11_CSL=7, ST_W11_B0=8, ST_W11_B1=9, ST_W11_B2=10,ST_W11_B3=11,ST_W11_CSH=12,

      ST_DELAY=13,

      ST_R10_CSL=14, ST_R10_B0=15, ST_R10_B1=16, ST_R10_B2=17, ST_R10_B3=18, ST_R10_CSH=19,
      ST_R11_CSL=20, ST_R11_B0=21, ST_R11_B1=22, ST_R11_B2=23, ST_R11_B3=24, ST_R11_CSH=25,

      ST_CHECK=26, ST_DONE=27;

    reg [5:0] st;
    reg [31:0] delay_cnt;

    // 小工具：触发一次"单字节移位"
    task automatic kick_byte(input [7:0] b);
      begin
        tx_r    <= b;
        start_r <= 1'b1; // 1clk pulse
      end
    endtask

    always @(posedge clk_i) begin
      if (rst_i) begin
        st <= ST_IDLE;
        csn_ctrl <= 1'b1;
        en_r <= 1'b0;
        start_r <= 1'b0;
        tx_r <= 8'h00;

        rd_10_o <= 8'h00;
        rd_11_o <= 8'h00;

        pass_o <= 1'b0;
        fail_o <= 1'b0;
        done_o <= 1'b0;

        delay_cnt <= 32'd0;
      end else begin
        start_r <= 1'b0; // 默认拉回0
        done_o  <= 1'b0;

        case (st)
          ST_IDLE: begin
            pass_o <= 1'b0; fail_o <= 1'b0;
            en_r <= 1'b1;
            csn_ctrl <= 1'b1;
            st <= ST_W10_CSL;
          end

          // ---- WRITE 0x0010 <= BE : 02 00 10 BE ----
          ST_W10_CSL: begin csn_ctrl <= 1'b0; st <= ST_W10_B0; end
          ST_W10_B0:  begin if (!busy_w) begin kick_byte(8'h02); st <= ST_W10_B1; end end
          ST_W10_B1:  begin if (done_w) begin kick_byte(8'h00); st <= ST_W10_B2; end end
          ST_W10_B2:  begin if (done_w) begin kick_byte(8'h10); st <= ST_W10_B3; end end
          ST_W10_B3:  begin if (done_w) begin kick_byte(8'hBE); st <= ST_W10_CSH; end end
          ST_W10_CSH: begin if (done_w) begin csn_ctrl <= 1'b1; st <= ST_W11_CSL; end end

          // ---- WRITE 0x0011 <= EF : 02 00 11 EF ----
          ST_W11_CSL: begin csn_ctrl <= 1'b0; st <= ST_W11_B0; end
          ST_W11_B0:  begin if (!busy_w) begin kick_byte(8'h02); st <= ST_W11_B1; end end
          ST_W11_B1:  begin if (done_w) begin kick_byte(8'h00); st <= ST_W11_B2; end end
          ST_W11_B2:  begin if (done_w) begin kick_byte(8'h11); st <= ST_W11_B3; end end
          ST_W11_B3:  begin if (done_w) begin kick_byte(8'hEF); st <= ST_W11_CSH; end end
          ST_W11_CSH: begin if (done_w) begin csn_ctrl <= 1'b1; delay_cnt <= 0; st <= ST_DELAY; end end

          // ---- delay ----
          ST_DELAY: begin
            if (delay_cnt == DELAY_CYC) st <= ST_R10_CSL;
            else delay_cnt <= delay_cnt + 1;
          end

          // ---- READ 0x0010 : 03 00 10 00 -> rx=BE on last byte ----
          ST_R10_CSL: begin csn_ctrl <= 1'b0; st <= ST_R10_B0; end
          ST_R10_B0:  begin if (!busy_w) begin kick_byte(8'h03); st <= ST_R10_B1; end end
          ST_R10_B1:  begin if (done_w) begin kick_byte(8'h00); st <= ST_R10_B2; end end
          ST_R10_B2:  begin if (done_w) begin kick_byte(8'h10); st <= ST_R10_B3; end end
          ST_R10_B3:  begin
            if (done_w) begin
              kick_byte(8'h00); // dummy
              st <= ST_R10_CSH;
            end
          end
          ST_R10_CSH: begin
            if (done_w) begin
              rd_10_o <= rx_w;     // dummy这次的rx就是数据
              csn_ctrl <= 1'b1;
              st <= ST_R11_CSL;
            end
          end

          // ---- READ 0x0011 : 03 00 11 00 -> rx=EF ----
          ST_R11_CSL: begin csn_ctrl <= 1'b0; st <= ST_R11_B0; end
          ST_R11_B0:  begin if (!busy_w) begin kick_byte(8'h03); st <= ST_R11_B1; end end
          ST_R11_B1:  begin if (done_w) begin kick_byte(8'h00); st <= ST_R11_B2; end end
          ST_R11_B2:  begin if (done_w) begin kick_byte(8'h11); st <= ST_R11_B3; end end
          ST_R11_B3:  begin
            if (done_w) begin
              kick_byte(8'h00); // dummy
              st <= ST_R11_CSH;
            end
          end
          ST_R11_CSH: begin
            if (done_w) begin
              rd_11_o <= rx_w;
              csn_ctrl <= 1'b1;
              st <= ST_CHECK;
            end
          end

          // ---- check (silent) ----
          ST_CHECK: begin
            if (rd_10_o == 8'hBE && rd_11_o == 8'hEF) pass_o <= 1'b1;
            else fail_o <= 1'b1;
            st <= ST_DONE;
          end

          ST_DONE: begin
            done_o <= 1'b1; // 可持续1拍（或你也可以一直拉高）
            st <= ST_DONE;
          end
        endcase
      end
    end

endmodule

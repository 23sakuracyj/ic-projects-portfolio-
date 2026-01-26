module axi_lite_eeprom_spi_core32 #(
    parameter integer ADDR_WIDTH = 6
)(
    input  wire                  s_axi_aclk,
    input  wire                  s_axi_aresetn,

    input  wire [ADDR_WIDTH-1:0] s_axi_awaddr,
    input  wire                  s_axi_awvalid,
    output reg                   s_axi_awready,

    input  wire [31:0]           s_axi_wdata,
    input  wire [3:0]            s_axi_wstrb,
    input  wire                  s_axi_wvalid,
    output reg                   s_axi_wready,

    output reg  [1:0]            s_axi_bresp,
    output reg                   s_axi_bvalid,
    input  wire                  s_axi_bready,

    input  wire [ADDR_WIDTH-1:0] s_axi_araddr,
    input  wire                  s_axi_arvalid,
    output reg                   s_axi_arready,

    output reg  [31:0]           s_axi_rdata,
    output reg  [1:0]            s_axi_rresp,
    output reg                   s_axi_rvalid,
    input  wire                  s_axi_rready,

    // ---- to frame_ctrl ----
    output reg                   en_o,
    output reg  [15:0]           div_half_o,
    output reg  [15:0]           addr_o,
    output reg  [15:0]           len_o,
    output reg                   go_wr_o,
    output reg                   go_rd_o,

    input  wire                  busy_i,
    input  wire                  done_i,

    // ---- TX FIFO interface (WDATA push) ----
    output reg                   tx_push_o,
    output reg  [7:0]            tx_din_o,
    input  wire                  tx_full_i,
    input  wire                  tx_empty_i,

    // ---- RX FIFO interface (RDATA pop) ----
    output reg                   rx_pop_o,
    input  wire [7:0]            rx_dout_i,
    input  wire                  rx_empty_i,
    input  wire                  rx_full_i
);

    localparam [1:0] RESP_OKAY = 2'b00;

    reg [ADDR_WIDTH-1:0] awaddr_latched;
    reg have_aw, have_w;
    wire [3:0] waddr = awaddr_latched[5:2];
    wire [3:0] raddr = s_axi_araddr[5:2];

    reg done_sticky;

    always @(posedge s_axi_aclk) begin
        if (!s_axi_aresetn) begin
            s_axi_awready <= 1'b0;
            s_axi_wready  <= 1'b0;
            s_axi_bvalid  <= 1'b0;
            s_axi_bresp   <= RESP_OKAY;

            s_axi_arready <= 1'b0;
            s_axi_rvalid  <= 1'b0;
            s_axi_rresp   <= RESP_OKAY;
            s_axi_rdata   <= 32'd0;

            awaddr_latched<= {ADDR_WIDTH{1'b0}};
            have_aw <= 1'b0;
            have_w  <= 1'b0;

            en_o        <= 1'b0;
            div_half_o  <= 16'd5;
            addr_o      <= 16'd0;
            len_o       <= 16'd1;

            go_wr_o     <= 1'b0;
            go_rd_o     <= 1'b0;

            tx_push_o   <= 1'b0;
            tx_din_o    <= 8'd0;
            rx_pop_o    <= 1'b0;

            done_sticky <= 1'b0;
        end else begin
            s_axi_bresp <= RESP_OKAY;
            s_axi_rresp <= RESP_OKAY;

            go_wr_o   <= 1'b0;
            go_rd_o   <= 1'b0;
            tx_push_o <= 1'b0;
            rx_pop_o  <= 1'b0;

            if (done_i) done_sticky <= 1'b1;

            // ----------------- WRITE -----------------
            s_axi_awready <= (!have_aw) && (!s_axi_bvalid);
            s_axi_wready  <= (!have_w)  && (!s_axi_bvalid);

            if (s_axi_awready && s_axi_awvalid) begin
                awaddr_latched <= s_axi_awaddr;
                have_aw <= 1'b1;
            end

            if (s_axi_wready && s_axi_wvalid) begin
                have_w <= 1'b1;
            end

            if (have_aw && have_w && !s_axi_bvalid) begin
                case (waddr)
                    4'h0: begin // CTRL: bit0 EN, bit1 GO_WR, bit2 GO_RD
                        if (s_axi_wstrb[0]) begin
                            en_o <= s_axi_wdata[0];

                            if (s_axi_wdata[1] && !busy_i) go_wr_o <= 1'b1;
                            if (s_axi_wdata[2] && !busy_i) go_rd_o <= 1'b1;
                        end
                    end
                    4'h1: begin // DIV [15:0]
                        if (s_axi_wstrb[0]) div_half_o[7:0]  <= s_axi_wdata[7:0];
                        if (s_axi_wstrb[1]) div_half_o[15:8] <= s_axi_wdata[15:8];
                    end
                    4'h2: begin // ADDR [15:0]
                        if (s_axi_wstrb[0]) addr_o[7:0]  <= s_axi_wdata[7:0];
                        if (s_axi_wstrb[1]) addr_o[15:8] <= s_axi_wdata[15:8];
                    end
                    4'h3: begin // WDATA: push TX FIFO
                        if (s_axi_wstrb[0] && !tx_full_i) begin
                            tx_din_o  <= s_axi_wdata[7:0];
                            tx_push_o <= 1'b1;
                        end
                    end
                    4'h6: begin // LEN @ 0x18  (waddr=0x6 when off=0x18)
                        if (s_axi_wstrb[0]) len_o[7:0]  <= s_axi_wdata[7:0];
                        if (s_axi_wstrb[1]) len_o[15:8] <= s_axi_wdata[15:8];
                    end
                    default: begin end
                endcase

                s_axi_bvalid <= 1'b1;
                s_axi_bresp  <= RESP_OKAY;
                have_aw <= 1'b0;
                have_w  <= 1'b0;
            end

            if (s_axi_bvalid && s_axi_bready) begin
                s_axi_bvalid <= 1'b0;
            end

            // ----------------- READ -----------------
            s_axi_arready <= (!s_axi_rvalid);

            if (s_axi_arready && s_axi_arvalid) begin
                case (raddr)
                    4'h0: s_axi_rdata <= {31'd0, en_o};                         // CTRL
                    4'h1: s_axi_rdata <= {16'd0, div_half_o};                   // DIV
                    4'h2: s_axi_rdata <= {16'd0, addr_o};                       // ADDR
                    4'h4: begin // RDATA: pop RX FIFO
                        s_axi_rdata <= {24'd0, (rx_empty_i ? 8'h00 : rx_dout_i)};
                        if (!rx_empty_i) rx_pop_o <= 1'b1;
                    end
                    4'h5: s_axi_rdata <= {26'd0, rx_empty_i, rx_full_i, tx_empty_i, tx_full_i, done_sticky, busy_i}; // STATUS扩展
                    4'h6: s_axi_rdata <= {16'd0, len_o};                        // LEN
                    default: s_axi_rdata <= 32'd0;
                endcase

                s_axi_rvalid <= 1'b1;

                if (raddr == 4'h5) begin
                    done_sticky <= 1'b0; // read-to-clear DONE
                end
            end

            if (s_axi_rvalid && s_axi_rready) begin
                s_axi_rvalid <= 1'b0;
            end
        end
    end

endmodule

module dut_top(
 input        RSTX,
 input        CS,
 input        SCLK,
 input        SDATA,
 output [7:0] REG_00,
 output [7:0] REG_00
);

wire       wen;
wire [7:0] waddr;
wire [7:0] wdata;
spi_slave i_spi_slave (
 .CS    (CS),
 .SCLK  (SCLK),
 .SDATA (SDATA),
 .WEN   (wen),
 .WADDR (waddr),
 .WDATA (wdata)
);

register i_register (
 .RSTX   (RSTX),
 .CLK    (CS),
 .WEN    (wen),
 .WADDR  (waddr),
 .WDATA  (wdata),
 .REG_00 (REG_00),
 .REG_01 (REG_01)
);

endmodule

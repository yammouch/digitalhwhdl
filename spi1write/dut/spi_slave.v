module spi_slave(
 input        CS,
 input        SCLK,
 input        SDATA,
 output       WEN,
 output [7:0] WADDR,
 output [7:0] WDATA
);

reg [14:0] shift_reg;
always @(posedge SCLK) shift_reg <= {shift_reg[13:0], SDATA};
assign WADDR = shift_reg[14:7];
assign WDATA = {shift_reg[6:0], SDATA};

reg [3:0] cnt;
always @(posedge SCLK or negedge CS)
  if (!CS) cnt <= 4'd0;
  else     cnt <= cnt + 4'd1;

assign WEN = (cnt == 4'd15);

endmodule

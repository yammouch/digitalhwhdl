module register(
 input            RSTX,
 input            CLK,
 input            WEN,
 input      [7:0] WADDR,
 input      [7:0] WDATA,
 output reg [7:0] REG_00,
 output reg [7:0] REG_01
);

always @(posedge CLK or negedge RSTX)
  if (!RSTX)                      REG_00 <= 8'h00;
  else if (WEN && WADDR == 8'h00) REG_00 <= WDATA;
always @(posedge CLK or negedge RSTX)
  if (!RSTX)                      REG_01 <= 8'h00;
  else if (WEN && WADDR == 8'h01) REG_01 <= WDATA;

endmodule

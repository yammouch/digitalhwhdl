module cordic_sqrt_seq (
 input         rstx,
 input         clk,
 input         start,
 input  [15:0] din,
 output        busy,
 output [15:0] dout
);

reg [3:0] cnt;
wire tracing = (cnt <= 4'd8);
always @(posedge clk or negedge rstx)
  if (!rstx)         cnt <= ~4'd0;
  else if (start)    cnt <=  4'd0;
  else if (!tracing) cnt <= ~4'd0;
  else               cnt <= cnt + 4'd1;

reg [4:0] shamt;
always @(*)
  case (cnt)
  4'd0: shamt = 5'd1;
  4'd1: shamt = 5'd2;
  4'd2: shamt = 5'd3;
  4'd3: shamt = 5'd4;
  4'd4: shamt = 5'd4;
  4'd5: shamt = 5'd5;
  4'd6: shamt = 5'd6;
  4'd7: shamt = 5'd7;
  4'd8: shamt = 5'd8;
  default: shamt = 5'd1;
  endcase

reg signed [21:0] coordy;
reg signed [21:0] coordx;
always @(posedge clk or negedge rstx)
  if (!rstx)        coordy <= 22'd0;
  else if (start)   coordy <= {{2'd0, din} - 18'h04000, 4'd0};
  else if (tracing) coordy <= coordy
                            + ((coordx >>> shamt) ^ {22{~coordy[21]}})
                            + {21'd0, ~coordy[21]};
always @(posedge clk or negedge rstx)
  if (!rstx)        coordx <= 22'd0;
  else if (start)   coordx <= {{2'd0, din} + 18'h04000, 4'd0};
  else if (tracing) coordx <= coordx
                            + ((coordy >>> shamt) ^ {22{~coordy[21]}})
                            + {21'd0, ~coordy[21]};
wire kick_mult = (cnt == 4'd9);
wire mult_busy;
wire [40:0] prod;
mult #(.BW_CNT(5), .BW_MCAND(22), .BW_MLIER(19)) i_mult (
 .mcand_is_signed (1'b1),
 .mlier_is_signed (1'b0),
 .rstx            (rstx),
 .clk             (clk),
 .start           (kick_mult),
 .mcand           (coordx),
 .mlier           (19'h6A013),
 .busy            (mult_busy),
 .prod            (prod)
);

assign busy = tracing | kick_mult | mult_busy;
assign dout = prod[38:23] + {15'd0, prod[22]};

endmodule

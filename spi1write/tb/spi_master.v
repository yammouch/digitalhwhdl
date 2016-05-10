`timescale 1ns/1ps

module spi_master(
 output reg CS,
 output reg SCLK,
 output reg SDATA
);

integer cycle;

initial begin
  cycle = 1000; // 1MHz
  CS    = 1'b1;
  SCLK  = 1'b0;
  SDATA = 1'b0;
end

task write(input [7:0] addr, input [7:0] data);
begin
  CS = 1'b0; #(cycle/2);
  repeat (8) begin
    {SCLK, SDATA} = {1'b0, addr[0]}; #(cycle/2);
    {SCLK, SDATA} = {1'b1, addr[0]}; #(cycle/2);
    addr = addr >> 1;
  end
  repeat (8) begin
    {SCLK, SDATA} = {1'b0, data[0]}; #(cycle/2);
    {SCLK, SDATA} = {1'b1, data[0]}; #(cycle/2);
    data = data >> 1;
  end
  {SCLK, SDATA} = 2'b00; #(cycle/2);
  CS = 1'b1; #(cycle/2);
end
endtask

endmodule

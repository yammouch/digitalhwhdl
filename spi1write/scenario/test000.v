`timescale 1ns/1ps

module tb;

`include "inst.vinc"

task test1(input [31:0] fh, input [7:0] addr, input [7:0] data);
reg [7:0] written;
begin
  spi.write(addr, data);
  case (addr)
  8'h00: written = dut.REG_00;
  8'h01: written = dut.REG_01;
  default: written = 8'hxx;
  endcase
  if (written == data) $fwrite(fh, "[OK]");
  else                 $fwrite(fh, "[ER]");
  $fwrite(fh, " addr: %02X, data: %02X, exp: %02X\n", addr, written, data);
end
endtask

task test_main;
reg [31:0] f_hdl;
reg [ 7:0] data;
begin
  f_hdl = $fopen("result/test000.log");
  #1000; // 1us
  RSTX = 1'b0; spi.CS = 1'b0; #1000; // 1us
  RSTX = 1'b1; spi.CS = 1'b1; #1000; // 1us
  test1(f_hdl, 8'h00, 8'h01);
  data = 8'h01; repeat (8) begin
    test1(f_hdl, 8'h01, data);
    data = data << 1;
  end
  $fclose(f_hdl);
end
endtask

initial begin
  $dumpfile("result/test000.vcd");
  $dumpvars;
  test_main;
end

endmodule

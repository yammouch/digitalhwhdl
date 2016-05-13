`timescale 1ps/1ps

module tb;

`include "inst.vinc"

task test1(input [31:0] fh, input [15:0] my_din);
begin
  @(posedge clk);
  din = my_din;
  start = 1'b1;
  @(posedge clk);
  start = 1'b0;
  @(negedge clk);
  wait(dut.busy == 1'b0);
  @(negedge clk);
  $fwrite( fh, "in: %f, out: %f, exp: %f, err: %f\n"
         , $itor(my_din) / (1 << 15)
         , $itor(dut.dout) / (1 << 15)
         , ($itor(my_din) / (1 << 15)) ** 0.5
         ,   ($itor(dut.dout) / (1 << 15))
           / ($itor(my_din) / (1 << 15)) ** 0.5 - 1.0 );
end
endtask

task test_main;
reg [31:0] f_hdl;
begin
  f_hdl = $fopen("result/test000.log");
  start = 1'b0;
  rstx  = 1'b0; #1_000_000; // 1us
  cg.en = 1'b1;
  repeat (4) @(posedge clk);
  rstx  = 1'b1;
  test1(f_hdl, 16'h4000);
  test1(f_hdl, 16'h5000);
  test1(f_hdl, 16'h6000);
  test1(f_hdl, 16'h7000);
  test1(f_hdl, 16'h8000);
  test1(f_hdl, 16'h9000);
  test1(f_hdl, 16'hA000);
  test1(f_hdl, 16'hB000);
  test1(f_hdl, 16'hC000);
  $fclose(f_hdl);
end
endtask

initial begin
  $dumpfile("result/test000.vcd");
  $dumpvars;
  test_main;
  $finish;
end

endmodule

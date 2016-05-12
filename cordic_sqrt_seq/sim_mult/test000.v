`timescale 1ps/1ps
`define BW_CNT 3
`define BW_MCAND 3
`define BW_MLIER 4

module tb;

wire                clk;
reg                 rstx;
reg                 mcand_is_signed;
reg                 mlier_is_signed;
reg                 start;
reg [`BW_MCAND-1:0] mcand;
reg [`BW_MLIER-1:0] mlier;

tb_clk_gen cg(.clk (clk));

mult #(.BW_CNT(`BW_CNT), .BW_MCAND(`BW_MCAND), .BW_MLIER(`BW_MLIER)) dut(
 .clk             (clk),
 .rstx            (rstx),
 .mcand_is_signed (mcand_is_signed),
 .mlier_is_signed (mlier_is_signed),
 .start           (start),
 .mcand           (mcand),
 .mlier           (mlier),
 .prod            (),
 .busy            ()
);

task init;
begin
  rstx  = 1'b0;
  start = 1'b0; #100_000; // 1us
  rstx  = 1'b1; #100_000; // 1us
  cg.en = 1'b1;
  repeat (4) @(posedge clk);
end
endtask

task test1;
input [31:0] fh;
input my_mcand_is_signed;
input my_mlier_is_signed;
input [`BW_MCAND-1:0] my_mcand;
input [`BW_MLIER-1:0] my_mlier;
integer int_mcand;
integer int_mlier;
integer int_prod;
begin
  @(posedge clk)
  mcand <= my_mcand;
  mlier <= my_mlier;
  start <= 1'b1;
  @(posedge clk)
  start <= 1'b0;
  @(posedge clk)
  wait(dut.busy == 1'b0);
  @(negedge clk)
  if (my_mcand_is_signed) int_mcand = $signed(my_mcand);
  else                    int_mcand = my_mcand;
  if (my_mlier_is_signed) int_mlier = $signed(my_mlier);
  else                    int_mlier = my_mlier;
  if (my_mcand_is_signed | my_mlier_is_signed) int_prod = $signed(dut.prod);
  else                                         int_prod = dut.prod;
  if (int_prod == int_mcand * int_mlier) $fwrite(fh, "[OK]");
  else                                   $fwrite(fh, "[ER]");
  $fwrite( fh, " mcand: %d, mlier: %d, prod: %d\n"
         , int_mcand, int_mlier, int_prod );
end
endtask

task main_loop;
input [31:0] fh;
input my_mcand_is_signed;
input my_mlier_is_signed;
reg [`BW_MCAND-1:0] my_mcand;
reg [`BW_MLIER-1:0] my_mlier;
begin
  mcand_is_signed = my_mcand_is_signed;
  mlier_is_signed = my_mlier_is_signed;
  my_mlier = 0; repeat (1 << `BW_MLIER) begin
    my_mcand = 0; repeat (1 << `BW_MCAND) begin
      test1(fh, my_mcand_is_signed, my_mlier_is_signed, my_mcand, my_mlier);
      my_mcand = my_mcand + 1;
    end
    my_mlier = my_mlier + 1;
  end
end
endtask

reg [31:0] fh;
reg [80*8:1] file_name;
reg [80*8:1] file_name_waveform;

initial begin
  $sformat( file_name_waveform, "result/test000_%02d_%02d_%02d.vcd"
         , `BW_CNT, `BW_MCAND, `BW_MLIER );
  $dumpfile(file_name_waveform);
  $dumpvars;
  $sformat( file_name, "result/test000_%02d_%02d_%02d.log"
          , `BW_CNT, `BW_MCAND, `BW_MLIER );
  fh = $fopen(file_name);
  init;
  main_loop(fh, 1'b0, 1'b0);
  main_loop(fh, 1'b0, 1'b1);
  main_loop(fh, 1'b1, 1'b0);
  main_loop(fh, 1'b1, 1'b1);
  $finish;
end

endmodule

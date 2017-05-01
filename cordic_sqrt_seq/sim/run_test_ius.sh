# A script to run testcase for Icarus Verilog.
# usage: sh run_test.sh test000

irun \
 +access+r \
 +incdir+../tb \
 ../tb/tb_clk_gen.v \
 ../rtl/mult.v \
 ../rtl/cordic_sqrt_seq.v \
 ../scenario/$1.v

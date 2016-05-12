# A script to run testcase for Icarus Verilog.
# usage: sh run_test.sh test000

iverilog \
 -g2001 \
 -o intermediate/$1.vvp \
 -I ../tb \
 ../tb/tb_clk_gen.v \
 ../rtl/mult.v \
 ../rtl/cordic_sqrt_seq.v \
 ../scenario/$1.v

if [ $? -eq 0 ] ; then
  vvp intermediate/$1.vvp
fi

# A script to run testcase for Icarus Verilog.
# usage: sh run_test.sh test000

iverilog \
 -g2001 \
 -o intermediate/$1.vvp \
 spi_master.v \
 ../dut/dut_top.v \
 ../dut/spi_slave.v \
 ../dut/register.v \
 $1.v

if [ $? -eq 0 ] ; then
  vvp intermediate/$1.vvp
fi

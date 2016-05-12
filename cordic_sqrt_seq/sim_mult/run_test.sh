iverilog \
 -o intermediate/$1.vvp \
 ../tb/tb_clk_gen.v \
 ../rtl/mult.v \
 $1.v

if [ $? -eq 0 ] ; then
  vvp intermediate/$1.vvp
fi

# A script to run testcase for Icarus Verilog.
# usage: sh run_test.sh test000

cat > intermediate/$1_dump.tcl <<!
database result/$1.shm
probe \
 -create tb -shm -depth all \
 -all -tasks -functions -uvm -packed 4k -unpacked 16k -ports \
 -waveform -database result/$1.shm
run
!

irun \
 -input intermediate/$1_dump.tcl \
 +access+r \
 +incdir+../tb \
 ../tb/tb_clk_gen.v \
 ../rtl/mult.v \
 ../rtl/cordic_sqrt_seq.v \
 ../scenario/$1.v

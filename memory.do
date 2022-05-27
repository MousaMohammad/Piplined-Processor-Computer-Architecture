vsim -gui work.memory
add wave -position insertpoint  \
sim:/memory/writeEnable \
sim:/memory/dataOut \
sim:/memory/dataIn \
sim:/memory/Clk \
sim:/memory/address
force -freeze sim:/memory/writeEnable 0 0
force -freeze sim:/memory/address 16#12345 0
force -freeze sim:/memory/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/memory/dataIn 16#ABCD1234 0
run
force -freeze sim:/memory/writeEnable 1 0
run
run
run

vsim -gui work.integration
add wave -position insertpoint  \
sim:/integration/clk \
sim:/integration/rst \
sim:/integration/PC_IF_IFID \
sim:/integration/MemDataOut \
sim:/integration/writeData_WB_DEC \
sim:/integration/writeEnable_WB_DEC \
sim:/integration/writeAddress_WB_DEC \
sim:/integration/IN_PORT \
sim:/integration/OUT_PORT
force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
run
mem load -filltype value -filldata 10000000000001000000000000000000 -fillradix symbolic /integration/mem/ram(0)
force -freeze sim:/integration/rst 0 0
run
force -freeze sim:/integration/IN_PORT 16#10000000 0
run
run
run
run
run
run
run
run
run
run
run



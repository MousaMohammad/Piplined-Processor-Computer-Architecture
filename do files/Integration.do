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
sim:/integration/OUT_PORT \
sim:/integration/ALU_MEMWB_WB \
sim:/integration/WBControlSignal_MEMWB_WB
force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
run
mem load -filltype value -filldata 10010000000000100000000000000000 -fillradix symbolic /integration/mem/ram(0)
mem load -filltype value -filldata 10100000000000000000000000000000 -fillradix symbolic /integration/mem/ram(1)
mem load -filltype value -filldata 10100000000000000000000000000000 -fillradix symbolic /integration/mem/ram(2)
mem load -filltype value -filldata 10100000000000000000000000000000 -fillradix symbolic /integration/mem/ram(3)
mem load -filltype value -filldata 10100000000000000000000000000000 -fillradix symbolic /integration/mem/ram(4)
mem load -filltype value -filldata 01010000100001000000000000000000 -fillradix symbolic /integration/mem/ram(5)
mem load -filltype value -filldata 10100000000000000000000000000000 -fillradix symbolic /integration/mem/ram(6)
mem load -filltype value -filldata 10100000000000000000000000000000 -fillradix symbolic /integration/mem/ram(7)
mem load -filltype value -filldata 10100000000000000000000000000000 -fillradix symbolic /integration/mem/ram(8)
mem load -filltype value -filldata 10000000000001000000000000000000 -fillradix symbolic /integration/mem/ram(9)
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



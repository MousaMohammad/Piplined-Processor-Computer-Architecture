vsim -gui work.integration
add wave -position insertpoint  \
sim:/integration/clk \
sim:/integration/rst \
sim:/integration/writeData_WB_DEC \
sim:/integration/writeEnable_WB_DEC \
sim:/integration/writeAddress_WB_DEC \
sim:/integration/WBControlSignal_MEMWB_WB \
sim:/integration/OUT_PORT \
sim:/integration/MemDataIn \
sim:/integration/MemAddress \
sim:/integration/MemWriteEnable
force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
run
mem load -filltype value -filldata 00001000000001000000000000001000 -fillradix symbolic /integration/mem/ram(0)
mem load -filltype value -filldata 10000000000001000000000000000000 -fillradix symbolic /integration/mem/ram(1)
mem load -filltype value -filldata 10000000000001000000000000000000 -fillradix symbolic /integration/mem/ram(2)
mem load -filltype value -filldata 10000000000001000000000000000000 -fillradix symbolic /integration/mem/ram(8)
force -freeze sim:/integration/rst 0 0
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
run
run
run
run
run
run
run
run
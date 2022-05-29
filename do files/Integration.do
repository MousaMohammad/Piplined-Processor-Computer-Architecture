vsim -gui work.integration
add wave -position insertpoint  \
sim:/integration/clk \
sim:/integration/rst \
sim:/integration/PC_IF_IFID \
sim:/integration/PC_IFID_IDEX \
sim:/integration/PC_IDEX_EX \
sim:/integration/PC_EXMEM_MEM \
sim:/integration/Immediate_dec_IDEX \
sim:/integration/Immediate_IDEX_EX \
sim:/integration/PC_Ex_EXMEM \
sim:/integration/MemDataOut \
sim:/integration/writeData_WB_DEC \
sim:/integration/writeEnable_WB_DEC \
sim:/integration/writeAddress_WB_DEC \
sim:/integration/regFileAddr_MEM_MEMWB \
sim:/integration/IN_PORT \
sim:/integration/WBControlSignal_MEMWB_WB \
sim:/integration/writeBackControlSignal_EXMEM_MEM \
sim:/integration/writeBackSignal_IDEX_EXMEM \
sim:/integration/writeBackSignal_dec_IDEX \
sim:/integration/instruction_IF_IFID \
sim:/integration/instruction_IFID_ID
force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
run
mem load -filltype value -filldata 10010000000000100000000000000000 -fillradix symbolic /integration/mem/ram(0)
mem load -filltype value -filldata 01010000100001000000000000000000 -fillradix symbolic /integration/mem/ram(1)
force -freeze sim:/integration/rst 0 0
run
force -freeze sim:/integration/IN_PORT 16#10000000 0
run
run
run
run




vsim -gui work.integration
add wave -position insertpoint  \
sim:/integration/clk \
sim:/integration/rst \
sim:/integration/PC_IF_IFID \
sim:/integration/PC_IFID_IDEX \
sim:/integration/PC_IDEX_EX \
sim:/integration/jumpPC_EXMEM_IF \
sim:/integration/PC_EXMEM_MEM \
sim:/integration/Immediate_dec_IDEX \
sim:/integration/Immediate_IDEX_EX \
sim:/integration/PC_Ex_EXMEM \
sim:/integration/MemDataOut \
sim:/integration/writeData_WB_DEC \
sim:/integration/writeEnable_WB_DEC \
sim:/integration/writeAddress_WB_DEC \
sim:/integration/MemAddress \
sim:/integration/MemDataIn \
sim:/integration/MemDataOut \
sim:/integration/Memory_MEMWB_WB \
sim:/integration/MemRead_dec_IDEX \
sim:/integration/MemRead_IDEX_EXMEM \
sim:/integration/MemReadEnable \
sim:/integration/MemWrite_dec_IDEX \
sim:/integration/MemWrite_IDEX_EXMEM \
sim:/integration/MemWriteEnable \
sim:/integration/freezePC_MEM_IF \
sim:/integration/instruction_IF_IFID
mem load -filltype value -filldata {00010100000000000000000000001000} -fillradix symbolic /integration/mem/ram(0)
mem load -filltype value -filldata {00010100000100000000000000001001} -fillradix symbolic /integration/mem/ram(1)
mem load -filltype value -filldata 00010100001000000000000000001010 -fillradix symbolic /integration/mem/ram(2)
mem load -filltype value -filldata 00010100011000000000000000001011 -fillradix symbolic /integration/mem/ram(3)
mem load -filltype value -filldata 00010100010000000000000000001100 -fillradix symbolic /integration/mem/ram(4)
mem load -filltype value -filldata 00010100010100000000000000001101 -fillradix symbolic /integration/mem/ram(5)
mem load -filltype value -filldata 00010100011000000000000000001110 -fillradix symbolic /integration/mem/ram(6)
mem load -filltype value -filldata 00000000000000000000000000000000 -fillradix symbolic /integration/mem/ram(7)
mem load -filltype value -filldata 00010000000000000000000000000000 -fillradix symbolic /integration/mem/ram(8)
mem load -filltype value -filldata 00100000000000000000000000000000 -fillradix symbolic /integration/mem/ram(9)
mem load -filltype value -filldata 00110000000000000000000000000000 -fillradix symbolic /integration/mem/ram(10)
mem load -filltype value -filldata 01000000000000000000000000000000 -fillradix symbolic /integration/mem/ram(11)
mem load -filltype value -filldata 01010000000000000000000000000000 -fillradix symbolic /integration/mem/ram(12)
mem load -filltype value -filldata 01100000000000000000000000000000 -fillradix symbolic /integration/mem/ram(13)
mem load -filltype value -filldata 01110000000000000000000000000000 -fillradix symbolic /integration/mem/ram(14)
force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
run
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




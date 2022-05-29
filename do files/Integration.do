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
sim:/integration/MemDataOut
mem load -filltype value -filldata 00010100000000000000000000001000 -fillradix symbolic /integration/mem/ram(0)
mem load -filltype value -filldata {00000000000000000000000000000000 } -fillradix symbolic /integration/mem/ram(1)
mem load -filltype value -filldata 00000000000000000000000000000000 -fillradix symbolic /integration/mem/ram(2)
mem load -filltype value -filldata 00000000000000000000000000000000 -fillradix symbolic /integration/mem/ram(3)
mem load -filltype value -filldata 00000000000000000000000000000000 -fillradix symbolic /integration/mem/ram(4)
mem load -filltype value -filldata 00000000000000000000000000000000 -fillradix symbolic /integration/mem/ram(5)
mem load -filltype value -filldata 00000000000000000000000000000000 -fillradix symbolic /integration/mem/ram(6)
mem load -filltype value -filldata 00000000000000000000000000000000 -fillradix symbolic /integration/mem/ram(7)
mem load -filltype value -filldata 11111111111111111111111111111111 -fillradix symbolic /integration/mem/ram(8)
force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
run
force -freeze sim:/integration/rst 0 0
run




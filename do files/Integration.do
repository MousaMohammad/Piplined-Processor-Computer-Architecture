vsim -gui work.integration
add wave -position insertpoint  \
sim:/integration/clk \
sim:/integration/rst \
sim:/integration/writeData_WB_DEC \
sim:/integration/IN_PORT \
sim:/integration/OUT_PORT \
sim:/integration/writeEnable_WB_DEC \
sim:/integration/writeAddress_WB_DEC \
sim:/integration/WBControlSignal_MEMWB_WB \
sim:/integration/Rsrc1_address_IDEX_FU \
sim:/integration/Rsrc2_address_IDEX_FU \
sim:/integration/Rsrc1_address_dec_IDEX \
sim:/integration/Rsrc2_address_dec_IDEX \
sim:/integration/regFileAddr_EXMEM_MEM \
sim:/integration/regFileAddr_MEMWB_WB \
sim:/integration/FU_ALU_Rs1_Sel \
sim:/integration/FU_ALU_Rs2_Sel
force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
run
mem load -filltype value -filldata 10010000000000100000000000000000 -fillradix symbolic /integration/mem/ram(0)
#NOP
#mem load -filltype value -filldata 10100000000000000000000000000000 -fillradix symbolic /integration/mem/ram(1)
mem load -filltype value -filldata 10000000000000100000000000000000 -fillradix symbolic /integration/mem/ram(1)
force -freeze sim:/integration/rst 0 0
force -freeze sim:/integration/IN_PORT 16#00000020 0
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
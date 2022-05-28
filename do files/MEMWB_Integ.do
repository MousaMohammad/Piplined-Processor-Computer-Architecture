vsim -gui work.memwb_integ
add wave -position insertpoint  \
sim:/memwb_integ/Clk \
sim:/memwb_integ/Rst \
sim:/memwb_integ/CCR_i \
sim:/memwb_integ/PC_i \
sim:/memwb_integ/ALU_i \
sim:/memwb_integ/WriteData_i \
sim:/memwb_integ/ALU_i \
sim:/memwb_integ/WriteData_i \
sim:/memwb_integ/jumpControlSignal_i \
sim:/memwb_integ/memWriteControlSignal_i \
sim:/memwb_integ/SPControlSignal_i \
sim:/memwb_integ/writeBackControlSignal_i \
sim:/memwb_integ/RegFileAddressWB_i \
force -freeze sim:/memwb_integ/Rst 1 0
force -freeze sim:/memwb_integ/Clk 1 0, 0 {50 ps} -r 100
run

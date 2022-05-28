vsim -gui work.memwb_integ
add wave -position insertpoint  \
sim:/memwb_integ/Clk \
sim:/memwb_integ/Rst \
sim:/memwb_integ/CCR_i \
sim:/memwb_integ/PC_MUX_Selector \
sim:/memwb_integ/jumpControlSignal_i
force -freeze sim:/memwb_integ/Rst 1 0
force -freeze sim:/memwb_integ/Clk 1 0, 0 {50 ps} -r 100
run
force -freeze sim:/memwb_integ/Rst 0 0
force -freeze sim:/memwb_integ/CCR_i 101 0
#JMP
force -freeze sim:/memwb_integ/jumpControlSignal_i 100 0
run
run
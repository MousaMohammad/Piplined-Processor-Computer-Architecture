vsim -gui work.memwb_integ
add wave -position insertpoint  \
sim:/memwb_integ/Clk \
sim:/memwb_integ/Rst \
sim:/memwb_integ/SPControlSignal \
sim:/memwb_integ/memWriteControlSignal \
sim:/memwb_integ/memReadControlSignal \
sim:/memwb_integ/ALU_Output_Input \
sim:/memwb_integ/WriteDataBuff_In \
sim:/memwb_integ/readData_Mem
force -freeze sim:/memwb_integ/Rst 1 0
force -freeze sim:/memwb_integ/Clk 1 0, 0 {50 ps} -r 100
run
force -freeze sim:/memwb_integ/Rst 0 0
force -freeze sim:/memwb_integ/SPControlSignal 0000 0
force -freeze sim:/memwb_integ/memReadControlSignal 0 0
force -freeze sim:/memwb_integ/memWriteControlSignal 1 0
force -freeze sim:/memwb_integ/ALU_Output_Input 16#45678 0
force -freeze sim:/memwb_integ/WriteDataBuff_In 16#ABCDABCD 0
run
force -freeze sim:/memwb_integ/ALU_Output_Input 16#12345 0
force -freeze sim:/memwb_integ/WriteDataBuff_In 16#12345678 0
run
force -freeze sim:/memwb_integ/memReadControlSignal 1 0
force -freeze sim:/memwb_integ/memWriteControlSignal 0 0
force -freeze sim:/memwb_integ/ALU_Output_Input 16#45678 0
force -freeze sim:/memwb_integ/WriteDataBuff_In 16#ABCDABCD 0
run
force -freeze sim:/memwb_integ/memReadControlSignal 0 0
run
force -freeze sim:/memwb_integ/memReadControlSignal 1 0
force -freeze sim:/memwb_integ/ALU_Output_Input 16#12345 0
run
force -freeze sim:/memwb_integ/memWriteControlSignal 1 0
force -freeze sim:/memwb_integ/memReadControlSignal 0 0
force -freeze sim:/memwb_integ/ALU_Output_Input 16#ABCDE 0
force -freeze sim:/memwb_integ/SPControlSignal 1010 0
run
force -freeze sim:/memwb_integ/memWriteControlSignal 0 0
force -freeze sim:/memwb_integ/memReadControlSignal 1 0
force -freeze sim:/memwb_integ/ALU_Output_Input 16#FFFFF 0
force -freeze sim:/memwb_integ/SPControlSignal 0000 0
run
force -freeze sim:/memwb_integ/SPControlSignal 1000 0
run
force -freeze sim:/memwb_integ/memReadControlSignal 0 0
force -freeze sim:/memwb_integ/SPControlSignal 0000 0
run
force -freeze sim:/memwb_integ/memWriteControlSignal 1 0
force -freeze sim:/memwb_integ/memReadControlSignal 0 0
force -freeze sim:/memwb_integ/ALU_Output_Input 16#78945612 0
force -freeze sim:/memwb_integ/SPControlSignal 1010 0
run
force -freeze sim:/memwb_integ/memWriteControlSignal 1 0
force -freeze sim:/memwb_integ/memReadControlSignal 0 0
force -freeze sim:/memwb_integ/ALU_Output_Input 16#45617585 0
force -freeze sim:/memwb_integ/SPControlSignal 1010 0
run
force -freeze sim:/memwb_integ/memWriteControlSignal 0 0
force -freeze sim:/memwb_integ/memReadControlSignal 1 0
force -freeze sim:/memwb_integ/SPControlSignal 1000 0
run
run
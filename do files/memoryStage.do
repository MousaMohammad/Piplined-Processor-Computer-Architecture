vsim -gui work.memorystage
add wave -position insertpoint  \
sim:/memorystage/Clk \
sim:/memorystage/Rst \
sim:/memorystage/writeData_Mem \
sim:/memorystage/address_Out \
sim:/memorystage/writeDataBuff_In \
sim:/memorystage/PC \
sim:/memorystage/ALU_Output_In \
sim:/memorystage/SPControlSignal \
sim:/memorystage/memWriteControlSignal_In \
sim:/memorystage/memReadControlSignal_In
force -freeze sim:/memorystage/Rst 1 0
force -freeze sim:/memorystage/Clk 1 0, 0 {50 ps} -r 100
run
force -freeze sim:/memorystage/Rst 0 0
force -freeze sim:/memorystage/memWriteControlSignal_In 1 0
force -freeze sim:/memorystage/memReadControlSignal_In 0 0
force -freeze sim:/memorystage/SPControlSignal 0000 0
force -freeze sim:/memorystage/writeDataBuff_In 16#12345678 0
force -freeze sim:/memorystage/PC 16#ABCDABCD 0
force -freeze sim:/memorystage/ALU_Output_In 16#FD112345 0
run
force -freeze sim:/memorystage/memReadControlSignal_In 1 0
force -freeze sim:/memorystage/memWriteControlSignal_In 0 0
force -freeze sim:/memorystage/ALU_Output_In 16#14789524 0
force -freeze sim:/memorystage/writeDataBuff_In 16#78945123 0
run
force -freeze sim:/memorystage/SPControlSignal 1010 0
run
force -freeze sim:/memorystage/SPControlSignal 1001 0
run
force -freeze sim:/memorystage/SPControlSignal 1011 0
run
force -freeze sim:/memorystage/SPControlSignal 1100 0
run
force -freeze sim:/memorystage/SPControlSignal 1101 0
run
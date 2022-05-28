vsim -gui work.memorystage
add wave -position insertpoint  \
sim:/memorystage/Clk \
sim:/memorystage/Rst \
sim:/memorystage/SPControlSignal \
sim:/memorystage/address_Out \
sim:/memorystage/SP_Before
force -freeze sim:/memorystage/Rst 1 0
force -freeze sim:/memorystage/Clk 1 0, 0 {50 ps} -r 100
run
force -freeze sim:/memorystage/SPControlSignal 0000 0
run
force -freeze sim:/memorystage/SPControlSignal 1010 0
force -freeze sim:/memorystage/Rst 0 0
run
force -freeze sim:/memorystage/SPControlSignal 1000 0
run

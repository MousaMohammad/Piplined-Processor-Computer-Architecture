vsim -gui work.sp_module
# vsim -gui work.sp_module 
# Start time: 20:09:46 on May 28,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.sp_module(sparch)
add wave -position insertpoint  \
sim:/sp_module/SP_Out \
sim:/sp_module/SP_In \
sim:/sp_module/Rst \
sim:/sp_module/Enable \
sim:/sp_module/Clk
force -freeze sim:/sp_module/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/sp_module/Rst 1 0
force -freeze sim:/sp_module/SP_In 16#12345 0
force -freeze sim:/sp_module/Enable 1 0
run
force -freeze sim:/sp_module/Rst 0 0
run
run

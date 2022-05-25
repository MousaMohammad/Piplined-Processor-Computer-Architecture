vsim -gui work.flagcontrol
# vsim -gui work.flagcontrol 
# Start time: 10:31:15 on May 25,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.flagcontrol(flagarch)
# vsim -gui work.flagcontrol 
# Start time: 10:27:09 on May 25,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.flagcontrol(flagarch)
add wave -position insertpoint  \
sim:/flagcontrol/aluRes \
sim:/flagcontrol/carry \
sim:/flagcontrol/setc \
sim:/flagcontrol/CCR \
sim:/flagcontrol/F
force -freeze sim:/flagcontrol/aluRes 16#00000000 0
force -freeze sim:/flagcontrol/carry 0 0
run
force -freeze sim:/flagcontrol/aluRes 10000000000000000000000000000000 0
run
force -freeze sim:/flagcontrol/setc 1 0
run
force -freeze sim:/flagcontrol/aluRes 16#ffffffff 0
force -freeze sim:/flagcontrol/setc 0 0
run
force -freeze sim:/flagcontrol/carry 1 0
run
force -freeze sim:/flagcontrol/aluRes 16#00000000 0
run
force -freeze sim:/flagcontrol/carry 0 0
run
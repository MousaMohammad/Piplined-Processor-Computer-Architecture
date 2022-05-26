vsim -gui work.pc
# vsim -gui work.pc 
# Start time: 21:55:38 on May 26,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.pc(pcarch)
add wave -position insertpoint  \
sim:/pc/rst \
sim:/pc/en \
sim:/pc/newPC \
sim:/pc/mem0 \
sim:/pc/pc
force -freeze sim:/pc/rst 0 0
force -freeze sim:/pc/en 0 0
force -freeze sim:/pc/newPC 16#0f0f00a1 0
force -freeze sim:/pc/mem0 16#0000FFFF 0
run
force -freeze sim:/pc/rst 1 0
run
force -freeze sim:/pc/rst 0 0
run
run
force -freeze sim:/pc/en 1 0
run
force -freeze sim:/pc/newPC 16#0AA01234 0
run
force -freeze sim:/pc/en 0 0
run
force -freeze sim:/pc/newPC 16#0BBC1489 0
run
run
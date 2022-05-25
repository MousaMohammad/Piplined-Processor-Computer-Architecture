vsim -gui work.alu
# vsim -gui work.alu 
# Start time: 10:19:15 on May 25,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.alu(archb)
# Loading work.my_nadder(a_my_nadder)
# Loading work.my_adder(a_my_adder)
add wave -position insertpoint  \
sim:/alu/A \
sim:/alu/B \
sim:/alu/opCode \
sim:/alu/CCR \
sim:/alu/F \
sim:/alu/Cout \
sim:/alu/incRes \
sim:/alu/incCout \
sim:/alu/addRes \
sim:/alu/addCout \
sim:/alu/subRes \
sim:/alu/subSrc \
sim:/alu/subCout
force -freeze sim:/alu/A 16#00000000 0
force -freeze sim:/alu/opCode 000 0
force -freeze sim:/alu/CCR 000 0
run
force -freeze sim:/alu/opCode 001 0
run
force -freeze sim:/alu/opCode 010 0
run
force -freeze sim:/alu/B 16#11111111 0
run
force -freeze sim:/alu/B 16#FFFFFFFF 0
run
force -freeze sim:/alu/A 00000000000000000000000000000001 0
run
noforce sim:/alu/opCode
force -freeze sim:/alu/opCode 011 0
run
force -freeze sim:/alu/opCode 100 0
run

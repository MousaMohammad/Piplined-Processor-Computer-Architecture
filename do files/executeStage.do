vsim -gui work.executestage
# vsim -gui work.executestage 
# Start time: 10:55:37 on May 25,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.executestage(archex)
# Loading work.mux2_nbit(arch1)
# Loading work.alu(archb)
# Loading work.my_nadder(a_my_nadder)
# Loading work.my_adder(a_my_adder)
# Loading work.flagcontrol(flagarch)
# Loading work.reg(regarch)
add wave -position insertpoint  \
sim:/executestage/Rst \
sim:/executestage/Clk \
sim:/executestage/ExeSrc \
sim:/executestage/SETC \
sim:/executestage/AluOpCode \
sim:/executestage/Rsrc1 \
sim:/executestage/Rsrc2 \
sim:/executestage/Immediate \
sim:/executestage/PCin \
sim:/executestage/F \
sim:/executestage/PCout \
sim:/executestage/exeSrcSig \
sim:/executestage/ccrIn \
sim:/executestage/ccrOut \
sim:/executestage/cToflag \
sim:/executestage/aluResult
force -freeze sim:/executestage/Rst 1 0
force -freeze sim:/executestage/Clk 1 0
run
force -freeze sim:/executestage/Rst 0 0
force -freeze sim:/executestage/ExeSrc 0 0
force -freeze sim:/executestage/AluOpCode 001 0
force -freeze sim:/executestage/Rsrc1 16#00000000 0
run
force -freeze sim:/executestage/AluOpCode 010 0
force -freeze sim:/executestage/Rsrc2 16#FFFFFFFF 0
run
force -freeze sim:/executestage/Immediate 16#000000000 0
force -freeze sim:/executestage/AluOpCode 010 0
force -freeze sim:/executestage/ExeSrc 1 0
run
force -freeze sim:/executestage/Rsrc1 00000000000000000000000000000001 0
force -freeze sim:/executestage/ExeSrc 0 0
run
force -freeze sim:/executestage/AluOpCode 011 0
run
force -freeze sim:/executestage/Rsrc2 11111111111011111111111111111111 0
run
force -freeze sim:/executestage/SETC 1 0
run
force -freeze sim:/executestage/SETC 0 0
force -freeze sim:/executestage/AluOpCode 100 0
run
force -freeze sim:/executestage/ExeSrc 1 0
run
#testing PCin PCout
force -freeze sim:/executestage/PCin 16#AAAAACBA 0
force -freeze sim:/executestage/Immediate 00000000000000000000000000000001 0
run
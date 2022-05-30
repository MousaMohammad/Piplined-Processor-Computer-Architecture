vsim -gui work.executestage
add wave -position insertpoint  \
sim:/executestage/Clk \
sim:/executestage/Rst \
sim:/executestage/Rsrc1 \
sim:/executestage/Rsrc2 \
sim:/executestage/ALU_Output \
sim:/executestage/Memory_Output \
sim:/executestage/Operand1 \
sim:/executestage/Operand2 \
sim:/executestage/FU_ALU_Rs1_Sel \
sim:/executestage/FU_ALU_Rs2_Sel \
sim:/executestage/Immediate \
sim:/executestage/AluOpCode \
sim:/executestage/ExeSrc \
sim:/executestage/F
force -freeze sim:/executestage/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/executestage/Rst 1 0 0
force -freeze sim:/executestage/Rsrc1 16#12345678 0
force -freeze sim:/executestage/Rsrc2 16#87654321 0
force -freeze sim:/executestage/FU_ALU_Rs1_Sel 00 0
force -freeze sim:/executestage/FU_ALU_Rs2_Sel 00 0
force -freeze sim:/executestage/AluOpCode 010 0
force -freeze sim:/executestage/ExeSrc 0 0
force -freeze sim:/executestage/ALU_Output 16#45789610 0
force -freeze sim:/executestage/Memory_Output 16#78941563 0
run
force -freeze sim:/executestage/Rst 0 0
run
force -freeze sim:/executestage/FU_ALU_Rs1_Sel 01 0
force -freeze sim:/executestage/FU_ALU_Rs2_Sel 01 0
run
run
run
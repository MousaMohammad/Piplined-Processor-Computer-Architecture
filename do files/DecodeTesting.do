vsim -gui work.decoding
vsim -gui work.decoding
# vsim -gui work.decoding 
# Start time: 00:38:27 on May 28,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.decoding(decodefunc)
# Loading work.regfile(regfilearch)
# Loading work.reg(regarch)
# Loading work.decoder(decoderarch)
# Loading work.tristate(triarch)
# Loading work.controlunit(controlunitarch)
add wave -position insertpoint  \
sim:/decoding/instruction \
sim:/decoding/clk \
sim:/decoding/rst \
sim:/decoding/readEnable \
sim:/decoding/writeEnable \
sim:/decoding/writeData \
sim:/decoding/ImmValue \
sim:/decoding/readData1 \
sim:/decoding/readData2 \
sim:/decoding/dstAddress \
sim:/decoding/jumpControlSignals \
sim:/decoding/ALUcontrolSignals \
sim:/decoding/exSrc \
sim:/decoding/Set_C \
sim:/decoding/LoadStoreControlSignals \
sim:/decoding/writeBackSignal \
sim:/decoding/MemoryReadEnableSignal \
sim:/decoding/MemoryWriteEnableSignal \
sim:/decoding/SPcontrolSignals \
sim:/decoding/selSr1 \
sim:/decoding/selSr2 \
sim:/decoding/selDst
force -freeze sim:/decoding/clk 1 0, 0 {50 ps} -r 100
#R TYPE
#NOT
force -freeze sim:/decoding/instruction  00000000000000000000000000000000 
run
#INC
force -freeze sim:/decoding/instruction  00010000000000000000000000000000 
run
#ADD
force -freeze sim:/decoding/instruction  00100000000000000000000000000000 
run
#SUB
force -freeze sim:/decoding/instruction  00110000000000000000000000000000 
run
#AND
force -freeze sim:/decoding/instruction  01000000000000000000000000000000 
run
#MOV
force -freeze sim:/decoding/instruction  01010000000000000000000000000000 
run
#SETC
force -freeze sim:/decoding/instruction  01110000000000000000000000000000 
run
# I TYPE
force -freeze sim:/decoding/instruction  00010100000000000000000000000000
run
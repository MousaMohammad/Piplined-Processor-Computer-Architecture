vsim -gui work.decoding
# vsim -gui work.decoding 
# Start time: 21:55:56 on May 27,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.decoding(decodefunc)
# Loading work.regfile(regfilearch)
# Loading work.reg(regarch)
# Loading work.decoder(decoderarch)
# Loading work.tristate(triarch)
# Loading work.controlunit(controlunitarch)
# ** Warning: (vsim-8683) Uninitialized out port /decoding/CU/exSrc has no driver.
# This port will contribute value (U) to the signal network.
add wave -position insertpoint  \
sim:/decoding/instruction \
sim:/decoding/clk \
sim:/decoding/rst \
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
sim:/decoding/MemoryWriteReadSignal \
sim:/decoding/SPcontrolSignals
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: ahmed  Hostname: AHMED-DELL-SSD  ProcessID: 18212
#           Attempting to use alternate WLF file "./wlftzagznz".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlftzagznz
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
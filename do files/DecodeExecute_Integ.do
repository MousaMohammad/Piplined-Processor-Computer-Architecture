# vsim -gui work.exbufsinteg 
# Start time: 17:13:02 on May 28,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.exbufsinteg(arch)
# Loading work.decoding(decodefunc)
# Loading work.regfile(regfilearch)
# Loading work.reg(regarch)
# Loading work.decoder(decoderarch)
# Loading work.tristate(triarch)
# Loading work.controlunit(controlunitarch)
# Loading work.idex_buf(archbuf)
# Loading ieee.numeric_std(body)
# Loading work.executestage(archex)
# Loading work.mux2_nbit(arch1)
# Loading work.alu(archb)
# Loading work.my_nadder(a_my_nadder)
# Loading work.my_adder(a_my_adder)
# Loading work.flagcontrol(flagarch)
# Loading work.exmem_buf(arch)
add wave -position insertpoint  \
sim:/exbufsinteg/instruction \
sim:/exbufsinteg/clk \
sim:/exbufsinteg/rst \
sim:/exbufsinteg/readEnable \
sim:/exbufsinteg/writeEnable \
sim:/exbufsinteg/writeData_ToDecode \
sim:/exbufsinteg/PC_o \
sim:/exbufsinteg/CCR_o \
sim:/exbufsinteg/Alu_o \
sim:/exbufsinteg/WriteData_o \
sim:/exbufsinteg/jumpControlSignal_o \
sim:/exbufsinteg/memWriteControlSignal_o \
sim:/exbufsinteg/memReadControlSignal_o \
sim:/exbufsinteg/SPControlSignal_o \
sim:/exbufsinteg/writeBackControlSignal_o \
sim:/exbufsinteg/RegFileAddressWB_o \
sim:/exbufsinteg/ExeSrc_dec_IDEX \
sim:/exbufsinteg/SETC_dec_IDEX \
sim:/exbufsinteg/AluOpCode_dec_IDEX \
sim:/exbufsinteg/Rsrc1_dec_IDEX \
sim:/exbufsinteg/Rsrc2_dec_IDEX \
sim:/exbufsinteg/Immediate_dec_IDEX \
sim:/exbufsinteg/PC_dec_IDEX \
sim:/exbufsinteg/LDSTControlSig_dec_IDEX \
sim:/exbufsinteg/MemRead_dec_IDEX \
sim:/exbufsinteg/MemWrite_dec_IDEX \
sim:/exbufsinteg/dstAddress_dec_IDEX \
sim:/exbufsinteg/jumpControlSignals_dec_IDEX \
sim:/exbufsinteg/writeBackSignal_dec_IDEX \
sim:/exbufsinteg/SPcontrolSignals_dec_IDEX \
sim:/exbufsinteg/CCR_ENABLE_dec_IDEX \
sim:/exbufsinteg/ExeSrc_IDEX_EX \
sim:/exbufsinteg/SETC_IDEX_EX \
sim:/exbufsinteg/AluOpCode_IDEX_EX \
sim:/exbufsinteg/Rsrc1_IDEX_EX \
sim:/exbufsinteg/Rsrc2_IDEX_EX \
sim:/exbufsinteg/Immediate_IDEX_EX \
sim:/exbufsinteg/PC_IDEX_EX \
sim:/exbufsinteg/CCR_ENABLE_IDEX_EX \
sim:/exbufsinteg/CCR_Ex_EXMEM \
sim:/exbufsinteg/Alu_Ex_EXMEM \
sim:/exbufsinteg/PC_Ex_EXMEM \
sim:/exbufsinteg/WriteData_Ex_EXMEM \
sim:/exbufsinteg/MemRead_IDEX_EXMEM \
sim:/exbufsinteg/MemWrite_IDEX_EXMEM \
sim:/exbufsinteg/LDSTControlSig_IDEX_EXMEM \
sim:/exbufsinteg/jumpControlSignals_IDEX_EXMEM \
sim:/exbufsinteg/dstAddress_IDEX_EXMEM \
sim:/exbufsinteg/writeBackSignal_IDEX_EXMEM \
sim:/exbufsinteg/SPcontrolSignals_IDEX_EXMEM
force -freeze sim:/exbufsinteg/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/exbufsinteg/rst 1 0
run
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: mody7  Hostname: LAPTOP-07B90H95  ProcessID: 8860
#           Attempting to use alternate WLF file "./wlftrbzsia".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlftrbzsia
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: mody7  Hostname: LAPTOP-07B90H95  ProcessID: 8860
#           Attempting to use alternate WLF file "./wlftgysvfq".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlftgysvfq
force -freeze sim:/exbufsinteg/rst 0 0
force -freeze sim:/exbufsinteg/writeEnable 1 0
force -freeze sim:/exbufsinteg/readEnable 1 0
force -freeze sim:/exbufsinteg/writeData_ToDecode 16#AAAAAAAA 0
add wave -position insertpoint  \
sim:/exbufsinteg/writeAddress_ToDecode
force -freeze sim:/exbufsinteg/writeAddress_ToDecode 000 0
run
force -freeze sim:/exbufsinteg/writeAddress_ToDecode 001 0
force -freeze sim:/exbufsinteg/writeData_ToDecode 16#BBBBBBBB 0
run
#ADD
force -freeze sim:/exbufsinteg/writeEnable 0 0
force -freeze sim:/exbufsinteg/instruction 00100000000100000000000000000000 0
run
#IADD
force -freeze sim:/exbufsinteg/instruction 00000100000100000010000000000000 0
run
force -freeze sim:/exbufsinteg/instruction 01000000000100000010000000000000 0
run
run
run
force -freeze sim:/exbufsinteg/instruction 01010010000100000010000000000000 0
run
run
run
force -freeze sim:/exbufsinteg/instruction 00110000000100000010000000000000 0
run
run


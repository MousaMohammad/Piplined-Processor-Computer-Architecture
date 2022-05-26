vsim -gui work.regfile
add wave -position insertpoint  \
sim:/regfile/writeEnable \
sim:/regfile/writeData \
sim:/regfile/writeAddress \
sim:/regfile/Rst \
sim:/regfile/readEnable \
sim:/regfile/readData1 \
sim:/regfile/readAddress1 \
sim:/regfile/readData2 \
sim:/regfile/readAddress2 \
sim:/regfile/Clk
force -freeze sim:/regfile/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/regfile/Rst 1 0
force -freeze sim:/regfile/writeAddress 101 0
force -freeze sim:/regfile/writeData 16#12345678 0
force -freeze sim:/regfile/writeEnable 1 0
force -freeze sim:/regfile/readEnable 1 0
force -freeze sim:/regfile/readAddress1 101 0
run
force -freeze sim:/regfile/Rst 0 0
run
force -freeze sim:/regfile/writeAddress 110 0
force -freeze sim:/regfile/writeData 16#ABCD1234 0
force -freeze sim:/regfile/readAddress2 110 0
run

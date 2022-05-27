vsim -gui work.fetchstage
add wave -position insertpoint  \
sim:/fetchstage/freezePC \
sim:/fetchstage/jumpPC \
sim:/fetchstage/usejumpPC \
sim:/fetchstage/PC \
sim:/fetchstage/memData \
sim:/fetchstage/memAddr \
sim:/fetchstage/instruction \
sim:/fetchstage/readEnable \
sim:/fetchstage/PC_next \
sim:/fetchstage/PC_next_next
force -freeze sim:/fetchstage/freezePC 0 0
force -freeze sim:/fetchstage/jumpPC 16#12345 0
force -freeze sim:/fetchstage/usejumpPC 0 0
force -freeze sim:/fetchstage/PC 16#11111 0
force -freeze sim:/fetchstage/memData 16#abcedf12 0
run
run
force -freeze sim:/fetchstage/PC 00010001000100010010 0
run
force -freeze sim:/fetchstage/freezePC 1 0
force -freeze sim:/fetchstage/PC 00010001000100010011 0
run
run
run
force -freeze sim:/fetchstage/PC 00010001000100010100 0
run
force -freeze sim:/fetchstage/freezePC 0 0
run
force -freeze sim:/fetchstage/usejumpPC 1 0
run
force -freeze sim:/fetchstage/usejumpPC 0 0
run
run
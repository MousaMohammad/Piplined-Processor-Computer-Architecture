vsim -gui work.fetchstage
add wave -position insertpoint  \
sim:/fetchstage/clk \
sim:/fetchstage/freezePC \
sim:/fetchstage/reset \
sim:/fetchstage/jumpPC \
sim:/fetchstage/usejumpPC \
sim:/fetchstage/memData \
sim:/fetchstage/memAddr \
sim:/fetchstage/instruction \
sim:/fetchstage/readEnable \
sim:/fetchstage/PC_before \
sim:/fetchstage/PC_after
force -freeze sim:/fetchstage/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/fetchstage/freezePC 0 0
force -freeze sim:/fetchstage/reset 1 0
force -freeze sim:/fetchstage/usejumpPC 0 0
force -freeze sim:/fetchstage/jumpPC 16#12345 0
force -freeze sim:/fetchstage/memData 16#12345678 0
run
run
run
force -freeze sim:/fetchstage/reset 0 0
run
run
run
run
run
run
run
force -freeze sim:/fetchstage/freezePC 1 0
run
run
run
force -freeze sim:/fetchstage/freezePC 0 0
run
run
force -freeze sim:/fetchstage/usejumpPC 1 0
run
force -freeze sim:/fetchstage/usejumpPC 0 0
run
run
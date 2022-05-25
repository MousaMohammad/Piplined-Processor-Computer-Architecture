vsim -gui work.decoder
add wave -position insertpoint  \
sim:/decoder/S \
sim:/decoder/oupt \
sim:/decoder/enable
force -freeze sim:/decoder/S 000 0
force -freeze sim:/decoder/enable 0 0
run
force -freeze sim:/decoder/enable 1 0
run
force -freeze sim:/decoder/S 001 0
run
force -freeze sim:/decoder/S 010 0
run
force -freeze sim:/decoder/S 100 0
run
force -freeze sim:/decoder/S 101 0
run
force -freeze sim:/decoder/S 110 0
run
force -freeze sim:/decoder/S 111 0
run
force -freeze sim:/decoder/enable 0 0
run
run
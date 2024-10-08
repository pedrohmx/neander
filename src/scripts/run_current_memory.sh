#!/usr/bin/env sh

STOPTIME=2000ns
TARGET=tb_neander

ghdl -a *.vhdl && \
	ghdl -e $TARGET && \
	ghdl -r $TARGET \
		--vcd=$TARGET.vcd \
		--wave=$TARGET.ghw \
		--stop-time=$STOPTIME

#!/usr/bin/env sh

STIME=1100ns
NAME=tb_cur

ghdl -a *.vhdl && \
	ghdl -e $NAME && \
	ghdl -r $NAME \
		--vcd=$NAME.vcd \
		--wave=$NAME.ghw \
		--stop-time=$STIME

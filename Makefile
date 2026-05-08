# Sim 
SIM ?= xsim
MODULE ?= cam_comp
TB ?= tb_$(MODULE)

.PHONY: sim

compile:
	xvlog -sv rtl/$(MODULE).sv tb/$(TB).sv

elab: compile
	xelab $(TB) -s sim_$(MODULE)

sim: elab
	xsim sim_$(MODULE) -R

clean:
	rm -rf sim_$(MODULE) xsim* xvlog* xelab* .Xil
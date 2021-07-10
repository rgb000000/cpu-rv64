init:
	git submodule update --init

check_env:
	mill -i __.test.testOnly gcd.GCDSpec

bsp:
	mill -i mill.bsp.BSP/install

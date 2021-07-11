init:
	git submodule update --init

check_env:
	mill -i __.test.testOnly gcd.GCDSpec
	bazel run gcd:test

clean:
	bazel clean --expunge

bsp:
	mill -i mill.bsp.BSP/install

idea:
	mill mill.scalalib.GenIDEA/idea

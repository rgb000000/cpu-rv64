init:
	git submodule update --init

check_mill:
	mill -i gcd.test.testOnly gcd.GCDSpec

check_bazel:
	bazel run gcd:test

clean:
	bazel clean --expunge

bsp:
	mill -i mill.bsp.BSP/install

idea:
	mill mill.scalalib.GenIDEA/idea

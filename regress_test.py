from multiprocessing import Pool
import argparse
from glob import glob
import os

parser = argparse.ArgumentParser()
parser.add_argument("--EMU_PATH", action="store", required=True)
parser.add_argument("--OSCPU_ROOT", action="store", required=True)
parser.add_argument("--RISCVTEST_ROOT", action="store", required=True)
args = parser.parse_args()

def exe_bin(filename):
    cmd = "{} -i {} 2>/dev/null".format(args.EMU_PATH, filename)
    with os.popen(cmd) as f:
        if "HIT GOOD TRAP" in "\n".join(f.readlines()):
            print("[{:>30s}   \033[1;32mPASS!\033[0m]".format(os.path.basename(filename)))
        else:
            print("[{:>30s}   \033[1;31mFAIL!\033[0m]".format(os.path.basename(filename)))


def main():
    bin_files = glob(args.OSCPU_ROOT +  "/bin/non-output/microbench/microbench-test.bin")
    bin_files += glob(args.OSCPU_ROOT + "/bin/non-output/cpu-tests/*.bin")
    bin_files += glob(args.OSCPU_ROOT + "/bin/non-output/riscv-tests/*.bin")
    bin_files += glob(args.RISCVTEST_ROOT + "/build/*.bin")
    print(len(bin_files))

    with Pool(10) as p:
        list(p.imap(exe_bin, bin_files))


if __name__ == '__main__':
    main()
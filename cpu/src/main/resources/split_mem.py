import argparse

parser = argparse.ArgumentParser(description='Split a mem into serverl mems.')
parser.add_argument('--filename', type=str, required=True, help='mem initial file path')

def main(file):
    f = open(file, "r")
    res = []
    for line in f:
        line = line.strip()
        if line == '':
            continue
        line = line.rjust(16, "0")
        assert(len(line) == 16)
        array = [line[i:i+2] for i in range(0, 16, 2)]
        assert(len(array) == 8)
        res.append(array)
    f.close()
    files = [file[:-4] + "_" + str(i) + file[-4:] for i in range(8)]
    print(files)
    for i, f in enumerate(files):
        with open(f, "w") as f:
            for e in res:
                f.write(e[i] + "\n")
            f.write("\n")




if __name__ == '__main__':
    args = parser.parse_args()
    filename = args.filename
    main(filename)
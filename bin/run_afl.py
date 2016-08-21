#!/usr/bin/env python2

import argparse
import os
import sys

AFL_CMD = "~/dev/fuzzer/fafl/afl-fuzz -i input -o output -m 2048 "

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description = 'Run afl!')
    parser.add_argument('--cmdline', required = True, type=str)
    parser.add_argument('--instance', type = int, default = 1,
                        help='Number of instances')
    args = parser.parse_args()

    for i in xrange(args.instance):
        os.system("ln -s output/%d/.cur_input %d" % (i, i))
        if(i == 0):
            real_cmd = AFL_CMD + ("-M %d" % i)
        else:
            real_cmd = AFL_CMD + ("-S %d" % i)

        cmd = args.cmdline.split(" ")[0]
        real_cmd = "tmux new-window -n %s-%d '%s -- %s %d'" % (cmd, i, real_cmd, args.cmdline, i)

        os.system(real_cmd)

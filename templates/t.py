#!/usr/bin/env python

import commands
import copy
import glob
import multiprocessing as mp
import optparse
import os
import platform
import pprint
import shutil
import subprocess
import sys

SCRIPT_PATH = os.path.abspath(__file__)
SCRIPT_DIR = os.path.dirname(SCRIPT_PATH)

def get_opts():

    parser = optparse.OptionParser("[usage] XXX")
    parser.add_option("-i", "--iter", default='250', help="# iterations")
    parser.add_option("-M", "--m_threshold", default='0',
                        help="set Mapped threshold")
    parser.add_option("-X", "--x_threshold", default='0',
                        help="set eXecutable threshold")
    parser.add_option("-o", "--outfile", default="output",
                        help="Name of output file")
    parser.add_option("-l", "--loops", default=str(5),
                        help="Number of loops")
    parser.add_option("-d", "--data", default='modules_size.txt',
                        help="filename for module size data")

    (opts, args) = parser.parse_args()

    return (opts, args)



def main():
    pass

if __name__ == '__main__':
    main()

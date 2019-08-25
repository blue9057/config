#!/usr/bin/env python3

import subprocess

SERVER_LISTS = [
        'vm-ctf1',
        'vm-ctf2',
        'vm-ctf3',
        'vm-mpk',
        'vm-ctf5',
]


for server in SERVER_LISTS:
    o = subprocess.check_output('ssh %s.eecs.oregonstate.edu "sudo apt update; sudo apt -y upgrade"' % server, shell=True)
    print("%s: %s" % (server, o))

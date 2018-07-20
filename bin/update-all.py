#!/usr/bin/env python

import os
import subprocess
from threading import Thread

SERVERS = [
        'vm-ctf1',
        'vm-ctf2',
        'vm-ctf3',
        'vm-mpk',
        'vm-ctf5',
        'cs519.unexploitable.systems',
        'sgx-laptop:22',
        'sgx-laptop:2222',
        'sgx-laptop:3333',
]

def thread_run_cmd(cmd, addr, port):
    shell_command = "ssh %s -p %d '%s'" % (addr, port, cmd)
    o = subprocess.check_output(shell_command, shell=True)
    print("Updated %s:%d\n%s" % (addr, port, o))


def run_cmd(cmd, addr, port):
    th = Thread(target=thread_run_cmd, args=(cmd, addr, port))
    th.start()
    return th

threads = []
for server in SERVERS:
    s = server.split(':')
    if len(s) == 1:
        port = 22
    else:
        port = int(s[1])

    if '.' in s[0]:
        addr = s[0]
    else:
        addr = s[0] + '.eecs.oregonstate.edu'

    print "Connecting to %s:%d" % (addr, port)
    cmd = 'sudo apt update; sudo apt -y upgrade'
    threads.append(run_cmd(cmd, addr, port))

for t in threads:
    t.join()

#!/usr/bin/env python

import os
import socket

def readconf():
  fd = open("hosts.cfg", "rb")
  lines = fd.readlines()
  lines = [line.split() for line in lines if len(lines) > 3 and (not '#' in line)]
  d = {}
  for line in lines:
    d[line[0]] = line[1]
  return d

def readhost():
  fd = open("/etc/hosts", "r")
  d = {}
  lines = fd.readlines()
  lines = [line.split() for line in lines]
  lines = [line[1] for line in lines if len(line) > 1]
  for line in lines:
    d[line] = 0
  return d

def main():
  config = readconf();
  host = readhost()
  alias_ip_dict = {}

  update = False
  for key in config.keys():
    if not key in host:
      update = True
      print("%s is not in host" % key)

  if(update):

    for key in config.keys():
      domain = config[key]
      print("Querying %s" % domain)
      ip = socket.gethostbyname(domain)
      alias_ip_dict[key] = ip

    fdh = open("/etc/hosts", "rb")
    fd = open("/tmp/hosts_append", "wb")
    while True:
      line = fdh.readline()
      if (line == None) or (len(line) == 0) or  ("MY_HOSTS" in line):
        break
      fd.write(line)

    fd.write("### MY_HOSTS ###\n")
    for key in alias_ip_dict.keys():
      ip = alias_ip_dict[key]
      fd.write("%016s\t%s\n" % (ip, key))
    fd.close()

    os.system("sudo cp /tmp/hosts_append /etc/hosts")

if __name__ == '__main__':
  main()

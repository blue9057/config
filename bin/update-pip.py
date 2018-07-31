#!/usr/bin/env python
import subprocess


def run_update(pip_version):
    PIP = 'pip2'
    if pip_version == 3:
        PIP = 'pip3'

    o = subprocess.check_output("%s list --outdate | grep -v sdist" % PIP, shell=True)

    for line in o.split("\n"):
        if 'Package' in line or '----' in line:
            continue
        info = line.split()
        if len(info) < 3:
            continue
        pkg_name  = info[0]
        old_version = info[1]
        new_version = info[2]

        print("Updating %s from %s to %s" % (info[0], info[1], info[2]))
        try:
            p = subprocess.Popen("sudo %s install -U %s" % (PIP, pkg_name),
                shell=True, stdout=subprocess.stdout, stderr=subprocess.stdout)
            (output, err) = p.communicate()
            print output
        except:
            print 'Error updating %s' % pkg_name

def main():

    # do update 3 first to not to change pip to pip3.
    run_update(3)

    # this will update pip as pip2.
    run_update(2)

if __name__ == '__main__':
    main()

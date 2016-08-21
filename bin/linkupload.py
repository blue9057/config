#!/usr/bin/env python3

import argparse
import os
import sys
import tempfile



def parse_arguments():
    parser = argparse.ArgumentParser(description = 'Upload and get link')
    parser.add_argument('--outext', type = str, default='',
                        help='Set out extension')
    parser.add_argument('--host', default='bombshell.gtisc.gatech.edu',
                        help='A host for web server')
    parser.add_argument('--webroot', default='/webroot',
                        help='A webroot for webserver')
    parser.add_argument('filename', nargs='+',
                        help = 'A file to upload')
    args = parser.parse_args()
    return args


def main():
    args = parse_arguments()
    f_path = args.filename[0]

    fn = os.path.basename(f_path)
    fn_only, file_ext = os.path.splitext(f_path)

    if args.outext != '':
        file_ext = args.outext



    f = tempfile.NamedTemporaryFile(prefix='file_', suffix=file_ext,
                                    dir='/tmp', delete=False)
    temp_name = f.name
    random_name = os.path.basename(temp_name)
    f.close()
    os.remove(temp_name)
    cmd = "scp %s %s:%s/public/%s" % (f_path, args.host, args.webroot,
                                        random_name)
    os.system(cmd)
    url = "https://%s/public/%s" % (args.host, random_name)
    print(url)


if __name__ == '__main__':
    main()


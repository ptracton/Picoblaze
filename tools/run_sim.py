#! /usr/bin/env python3

import json
import os
import os.path
import shlex
import subprocess
import sys
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Picoblaze Simulation')
    parser.add_argument("-D", "--debug",
                        help="Debug this script",
                        action="store_true")
    parser.add_argument("--json_file",
                        default="simulate.json",
                        help="JSON configuration file",
                        action="store")

    args = parser.parse_args()
    if args.debug:
        print (args)

    json_file = "../configuration/" + args.json_file
    try:
        f = open(json_file, "r")
        json_data = json.load(f)
    except:
        print("Failed to open %s" % (json_file))
        sys.exit(-1)    

    steps = sorted(json_data['flow_steps'].items())
    print (steps)
        

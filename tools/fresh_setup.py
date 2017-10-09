#! python3
import os
import subprocess
import json


if __name__ == '__main__':
    try:
        with open('fresh_setup.config', 'r') as f:
            conf = json.loads(f.read())
    except:
        print('Error while reading config')

    # TODO: mandatory. optional?
    for x in conf['mandatory']:
        print('. %s' % x)
        cmd = 'sudo apt install %s -q -y' % x
        with open(os.devnull, 'w') as nl:
            proc = subprocess.Popen(cmd.split(), stdout=nl, stderr=nl)
    for x in conf['optional']:
        print('? %s' % x)



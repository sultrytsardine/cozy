#! python3
import os
import subprocess
import json


def execute(cmd):
	with open(os.devnull, 'w') as nl:
            _ = subprocess.Popen(cmd.split(), stdout=nl, stderr=nl)


if __name__ == '__main__':
    try:
        with open('fresh_setup.config', 'r') as f:
            conf = json.loads(f.read())
    except:
        print('Error while reading config')

    # TODO: mandatory. optional?
	exec('sudo apt install software-properties-common')
	for ppa in conf['ppa']:
		print('+ %s' % ppa)
		cmd = 'sudo apt-add-repository %s' % ppa
		execute(cmd)
		
    for package in conf['mandatory']:
        print('. %s' % package)
        cmd = 'sudo apt install %s -q -y' % package
        execute(cmd)
		
    for package in conf['optional']:
        print('? %s' % package)
		cmd = 'sudo apt install %s -q -y' % package
        execute(cmd)


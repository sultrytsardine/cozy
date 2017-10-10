#! python3
import os
import subprocess
import json


def execute(cmd):
    p = subprocess.Popen(cmd.split())
    p.wait()

if __name__ == '__main__':
    basher_home = os.environ.get('BASHER_HOME', '~/.basher')
    path = basher_home + '/tools/fresh_setup.config'
    print(path)
    try:
        with open(path, 'r') as f:
            conf = json.loads(f.read())
    except:
       print('Error while reading config')
       exit(1)
    
    # TODO: mandatory. optional?
    execute('sudo apt update')
    execute('sudo apt install software-properties-common -q -y')
    for ppa in conf['ppa']:
        print('+ %s' % ppa)
        cmd = 'sudo apt-add-repository %s -q -y' % ppa
        execute(cmd)
    execute('sudo apt update')

    for package in conf['mandatory']:
        print('. %s' % package)
        cmd = 'sudo apt install %s -q -y' % package
        execute(cmd)

    for package in conf['optional']:
        print('? %s' % package)
        cmd = 'sudo apt install %s -q -y' % package
        execute(cmd)
    execute('sudo apt upgrade')

#! python3
import os
import subprocess
import json


def execute(cmd, silent=True):
    if silent:
        with open(os.devnull, 'w') as nl:
            p = subprocess.Popen(cmd.split(), stdout=nl, stderr=nl)
    else:
        p = subprocess.Popen(cmd.split())
    p.wait()

if __name__ == '__main__':
    cozy_home = os.environ.get('COZY_HOME', '.cozy')
    path = cozy_home + '/tools/fresh_setup.config'
    print(path)
    try:
        with open(path, 'r') as f:
            conf = json.loads(f.read())
    except:
       print('Error while reading config')
       exit(1)


    # PPAs
    print('Installing PPAs...\n---')
    execute('sudo apt update', silent=False)   # has to ask for passwd
    # needed to enable ppas on elementary
    execute('sudo apt install software-properties-common -q -y')
    for ppa in conf['ppa']:
        print('\n\n+ %s' % ppa)
        cmd = 'sudo apt-add-repository %s' % ppa
        execute(cmd)
    execute('sudo apt update')


    # Mandatory packages
    print('\n\nInstalling mandatory packages...\n---')
    for package in conf['mandatory']:
        print('\n\n. %s' % package)
        cmd = 'sudo apt install %s -q -y' % package
        execute(cmd)


    # Optional packages
    print('\n\nInstalling optional packages...\n---')
    for package in conf['optional']:
        print('\n\n. %s' % package)
        while True:
            decision = input('install? [y/n]?')
            if decision in 'ynYN':
                break
        if decision in 'yY':
            cmd = 'sudo apt install %s -q -y' % package
            execute(cmd)
        else:
            continue


    # upgrade everything else
    print('\n\nUpgrading...\n---')
    execute('sudo apt upgrade')

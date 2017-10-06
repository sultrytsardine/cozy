#!/bin/bash

if [ -z $BASHER_HOME ]; then
    echo "Basher is not started! Could not upgrade"
    return
fi

echo "Upgrading basher..."
cd $BASHER_HOME
if [[ `git pull --rebase --stat origin master` ]] then
    echo "OK Upgrade complete"
else
    echo "! Upgrade failed"
fi

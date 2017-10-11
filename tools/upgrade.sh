#!/bin/bash

if [ -z $COZY_HOME ]; then
    echo "Cozy is not started! Could not upgrade"
    return
fi

echo "Upgrading cozy..."
cd $COZY_HOME
if [[ `git pull --rebase --stat origin master` ]] then
    vim +PluginUpdate +qall
    echo "OK Upgrade complete"
else
    echo "! Upgrade failed"
fi

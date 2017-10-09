#!/bin/bash

echo "Updating basher..."
cd $BASHER_HOME
git pull --rebase --stat origin master
echo
echo "basher has been updated"

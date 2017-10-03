#! /bin/bash

#
#   Basher
#   by wtty-fool
#

# BASHER_LOCATION is where Basher will be installed.
# The default is $HOME/.basher, but feel free to
# modify this to your liking.
BASHER_LOCATION="$HOME/.basher"

if [ -d $BASHER_LOCATION ]; then
    # TODO - prompt if user wants a pure reinstall to happen via git
    echo "Directory '$BASHER_LOCATION' already exists!"
    exit 1
else
    echo "Installing Basher at '$BASHER_LOCATION'..."
    # update packages & install necessary ones
    apt update &> /dev/null || (echo Error during apt update! && exit 1)
    apt install git &> /dev/null || (echo Error installing git! && exit 1)
    mkdir -p $BASHER_LOCATION
    git clone https://github.com/wtty-fool/basher $BASHER_LOCATION
    chmod +x $BASHER_LOCATION

    # if .vimrc exists, rename it
    if [ -f "$HOME/.vimrc"]; then
        echo 'Backing up .vimrc -> .vimrc.bak...'
        mv "$HOME/.vimrc" "$HOME/.vimrc.bak"
    fi


    # everything went smoothly, add new line to .bashrc
    echo "export BASHER=$BASHER_LOCATION" >> "$HOME/.bashrc"
    echo "source $BASHER/.basherrc" >> "$HOME/.bashrc"
fi



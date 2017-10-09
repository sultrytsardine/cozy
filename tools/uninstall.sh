#!/bin/bash

if [[ -d $HOME/.basher && ${#BASHER_HOME} -gt 0 ]]; then
    echo "Found basher at $BASHER_HOME"

    echo "Removing links..."
    if [ $(readlink $HOME/.bashrc) == $BASHER_HOME/bashrc ]; then
        rm $HOME/.bashrc
    fi
    if [ $(readlink $HOME/.vimrc) == $BASHER_HOME/vimrc ]; then
        rm $HOME/.vimrc
    fi
    if [ $(readlink $HOME/.gitconfig) == $BASHER_HOME/gitconfig ]; then
        rm $HOME/.gitconfig
    fi
    rm -rf $HOME/.vim

    echo "Restoring backups"
    if [ -f $HOME/.bashrc.backup ]; then
        mv $HOME/.bashrc $HOME/.bashrc
    fi
    if [ -f $HOME/.vimrc.backup ]; then
        mv $HOME/.vimrc.backup $HOME/.vimrc
    fi
    if [-f $HOME/.vim.backup ]; then
        mv $HOME/.vim.backup $HOME/.vim
    fi
    if [-f $HOME/.gitconfig.backup ]; then
        mv $HOME/.gitconfig.backup $HOME/.gitconfig
    fi

    echo "Restoring color scheme..."
    default_palette='#303030:#e1321a:#6ab017:#ffc005:#004f9e:#ec0048:#2aa7e7:#f2f2f2:#5d5d5d:#ff361e:#7bc91f:#ffd00a:#0071ff:#ff1d62:#4bb8fd:#a020f0'
    gsettings set org.pantheon.terminal.settings background 'rgba(10, 10, 10, .95)'
    gsettings set org.pantheon.terminal.settings foreground '#f2f2f2'
    gsettings set org.pantheon.terminal.settings cursor-color '#FFFFFF'
    gsettings set org.pantheon.terminal.settings palette $default_palette
    unset default_palette

    echo; echo; echo;
    echo "basher has been succesfully uininstalled!"
    echo "Goodbye ;_;"
    source $HOME/.bashrc
else
    echo "basher has not been found, cannot uninstall"
    echo "Make sure that BASHER_HOME variable is set and it points to basher's location"
    return
fi

#!/bin/bash

if [[ -d $HOME/.cozy && ${#COZY_HOME} -gt 0 ]]; then
    echo "Found cozy at $COZY_HOME"

    echo "Removing links..."
    if [ $(readlink $HOME/.bashrc) == $COZY_HOME/bashrc ]; then
        sudo rm $HOME/.bashrc
    fi
    if [ $(readlink $HOME/.vimrc) == $COZY_HOME/vimrc ]; then
        sudo rm $HOME/.vimrc
    fi
    if [ $(readlink $HOME/.gitconfig) == $COZY_HOME/gitconfig ]; then
        sudo rm $HOME/.gitconfig
    fi
    sudo rm -rf $HOME/.vim

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


    echo "Removing virtualenvs..."
    if [ -d $HOME/.virtualenvs ]; then
        rm -rf $HOME/.virtualenvs
        unset $WORKON_HOME
    fi


    echo "Restoring color scheme..."
    default_palette='#303030:#e1321a:#6ab017:#ffc005:#004f9e:#ec0048:#2aa7e7:#f2f2f2:#5d5d5d:#ff361e:#7bc91f:#ffd00a:#0071ff:#ff1d62:#4bb8fd:#a020f0'
    gsettings set org.pantheon.terminal.settings background 'rgba(10, 10, 10, .95)'
    gsettings set org.pantheon.terminal.settings foreground '#f2f2f2'
    gsettings set org.pantheon.terminal.settings cursor-color '#FFFFFF'
    gsettings set org.pantheon.terminal.settings palette $default_palette
    unset default_palette

    echo; echo; echo;
    echo "cozy has been succesfully uininstalled!"
    echo "Goodbye ;_;"
    source $HOME/.bashrc
else
    echo "cozy has not been found, cannot uninstall"
    echo "Make sure that COZY_HOME variable is set and it points to cozy's location"
    return
fi

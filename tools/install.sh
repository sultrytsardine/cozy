#!/bin/bash

if [[ -d $HOME/.cozy || ${#COZY_HOME} -gt 0 ]]; then
    echo "It looks like cozy is already installed at $COZY_HOME"
    exit 64
else
    echo "Installing..."
    sudo apt update || (echo "apt update failed!"; exit 64)
    # git gud
    if [[ $(hash git &> /dev/null || echo 'x') == 'x' ]]; then
        echo "Installing git"
        sudo apt install git -q -y || (echo "Failed to install git!"; exit 64)
    fi
    sudo apt install vim -q -y
    git clone https://github.com/wtty-fool/cozy "$HOME/.cozy"
    # mkdir --mode=0755 $HOME/.cozy
    chmod 0755 $HOME/.cozy

    clear; echo; echo; echo "Backing up .bashrc and vim and gitconfig..."
    if [ -f $HOME/.bashrc ]; then
        mv $HOME/.bashrc $HOME/.bashrc.backup
    fi
    if [ -f $HOME/.vimrc ]; then
        mv $HOME/.vimrc $HOME/.vimrc.backup
    fi
    if [ -f $HOME/.vim ]; then
        mv $HOME/.vim $HOME/.vim.backup
    fi
    if [ -f $HOME/.gitconfig ]; then
        mv $HOME/.gitconfig $HOME/.gitconfig.backup
    fi


    clear; echo; echo; echo "Linking cozy's scripts..."
    ln -s $HOME/.cozy/bashrc $HOME/.bashrc
    ln -s $HOME/.cozy/vimrc $HOME/.vimrc
    ln -s $HOME/.cozy/gitconfig $HOME/.gitconfig
    chmod 0755 $HOME/.bashrc
    chmod 0755 $HOME/.vimrc
    chmod 0755 $HOME/.gitconfig
    mkdir --mode=0755 $HOME/.vim


    clear; echo; echo; echo "Installing vim plugins..."
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
    echo "Recompiling YouCompleteMe's libraries..."
    sudo apt install cmake build-essential -q -y || (echo "Failed to install cmake!"; exit 64)
    python $HOME/.vim/bundle/YouCompleteMe/install.py &> /dev/null


    clear; echo; echo; echo "Setting up Python's virtual environments..."
    sudo apt install python python3 python-pip python3-pip -y -q || (echo "Failed to install Python!"; exit 64)
    pip3 install --user --ignore-installed virtualenv virtualenvwrapper
    py3_location=`which python3`
    echo "export VIRTUALENVWRAPPER_PYTHON=$py3_location" >> $HOME/.cozy/exports.sh
    unset py3_location
    echo "export WORKON_HOME=$HOME/.virtualenvs" >> $HOME/.cozy/exports.sh
    echo "source $HOME/.local/bin/virtualenvwrapper.sh" >> $HOME/.cozy/bashrc
    source $HOME/.local/bin/virtualenvwrapper.sh &> /dev/null
    mkdir --mode=0755 $HOME/.virtualenvs


    clear; echo; echo;
    until [[ $scheme -eq 1 ]] || [[ $scheme -eq 2 ]]; do
        echo "Pick a color scheme"
        echo "1) Gruvbox Dark (medium contrast)"
        echo "2) Pantheon Terminal default"
        read scheme
    done
    gruvbox_palette='#282828:#cc241d:#98971a:#d79921:#458588:#b16286:#689d6a:#a89984:#928374:#fb4934:#b8bb26:#fabd2f:#83a598:#d3869b:#8ec07c:#ebdbb2'
    default_palette='#303030:#e1321a:#6ab017:#ffc005:#004f9e:#ec0048:#2aa7e7:#f2f2f2:#5d5d5d:#ff361e:#7bc91f:#ffd00a:#0071ff:#ff1d62:#4bb8fd:#a020f0'
    case $scheme in
        1) # gruvbox
            gsettings set org.pantheon.terminal.settings background  'rgba(40, 40, 40, .95)'
            gsettings set org.pantheon.terminal.settings foreground '#ebdbb2'
            gsettings set org.pantheon.terminal.settings cursor-color '#ebdbb2'
            gsettings set org.pantheon.terminal.settings palette $gruvbox_palette
            ;;
        2) # default
            gsettings set org.pantheon.terminal.settings background 'rgba(10, 10, 10, .95)'
            gsettings set org.pantheon.terminal.settings foreground '#f2f2f2'
            gsettings set org.pantheon.terminal.settings cursor-color '#FFFFFF'
            gsettings set org.pantheon.terminal.settings palette $default_palette
    esac
    unset gruvbox_palette
    unset default_palette
    unset scheme


    clear;
    echo "------------------------"
    echo "-                      -"
    echo "-       cozy         -"
    echo "-                      -"
    echo "------------------------"
    echo
    echo cozy has been succesfully installed!
    echo Enjoy!
    source $HOME/.bashrc
fi

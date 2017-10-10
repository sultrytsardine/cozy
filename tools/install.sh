#!/bin/bash

if [[ -d $HOME/.basher || ${#BASHER_HOME} -gt 0 ]]; then
    echo "It looks like basher is already installed at $BASHER_HOME"
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
    git clone https://github.com/wtty-fool/basher "$HOME/.basher"


    echo "Backing up .bashrc and vim and gitconfig..."
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


    echo "Linking basher's scripts..."
    ln -s $HOME/.basher/bashrc $HOME/.bashrc
    ln -s $HOME/.basher/vimrc $HOME/.vimrc
    ln -s $HOME/.basher/gitconfig $HOME/.gitconfig
    mkdir $HOME/.vim


    echo "Installing vim plugins..."
    vim +PluginInstall +qall
    echo "Recompiling YouCompleteMe's libraries..."
    sudo apt install cmake build-essential -q -y || (echo "Failed to install cmake!"; exit 64)
    python $HOME/.vim/bundle/YouCompleteMe/install.py &> /dev/null


    echo "Setting up Python's virtual environments..."
    sudo apt install python python3 python-pip python3-pip -y -q || (echo "Failed to install Python!"; exit 64)
    sudo -H pip3 install --user --ignore-installed virtualenv virtualenvwrapper
    py3_location=`which python3`
    echo "export VIRTUALENVWRAPPER_PYTHON=$py3_location" >> $HOME/.basher/exports.sh
    unset py3_location
    echo "export WORKON_HOME=$HOME/.virtualnvs" >> $HOME/.basher/exports.sh
    echo "source $HOME/.local/bin/virtualenvwrapper.sh" >> $HOME/.basher/bashrc
    sudo -H mkdir --mode=0755 $HOME/.virtualenvs


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


    echo; echo; echo "\033[0;34m";  # blue
    echo "------------------------"
    echo "-                      -"
    echo "-       basher         -"
    echo "-                      -"
    echo "------------------------"
    echo "\033[0m"
    echo
    echo basher has been succesfully installed!
    echo Enjoy!
    source $HOME/.bashrc
fi

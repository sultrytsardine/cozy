#! /bin/bash

#
#   Basher
#   by wtty-fool
#

# TODO - provide uninstall capabilities via --uninstall or -u

# BASHER_LOCATION is where Basher will be installed.
# The default is $HOME/.basher, but feel free to
# modify this to your liking.
BASHER_LOCATION="$HOME/.basher"

if [ -d $BASHER_LOCATION ]; then
    # TODO - prompt if user wants a pure reinstall to happen via git
    echo "Directory '$BASHER_LOCATION' already exists!"
    exit 1
else
    #
    #   BASHER
    #
    echo "Installing Basher at '$BASHER_LOCATION'..."
    # update packages & install necessary ones
    apt update -y &> /dev/null || (echo Error during apt update! && exit 1)
    apt install -y git &> /dev/null || (echo Error installing git! && exit 1)
    mkdir -p $BASHER_LOCATION
    git clone https://github.com/wtty-fool/basher $BASHER_LOCATION
    chmod +x $BASHER_LOCATION


    #
    # VIM
    #
    echo "Installing vim..."
    # VIMRC setup
    apt install -i vim &> /dev/null || (echo Failed installing vim! && exit 1)
    # if .vimrc exists, rename it
    if [ -f "$HOME/.vimrc"]; then
        echo 'Backing up .vimrc -> .vimrc.bak...'
        mv "$HOME/.vimrc" "$HOME/.vimrc.bak"
    fi
    ln --symbolic "$BASHER_LOCATION/vimrc" "$HOME/.vimrc"
    # Vundle
    echo "Installing Vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
    vim +PluginInstall +qall $> /dev/null || (echo Failed installing vim plugins && exit 1)
    # if YouCompleteMe is installed, need to recompile
    if [ -d "$HOME/.vim/bundle/YouCompleteMe" ]; then;
        echo "Recompiling YouCompleteMe libraries..."
        apt install -y build-essential cmake &> /dev/null || (echo Failed installing cmake and build-essential! && exit 1)
        python "$HOME/.vim/bundle/YouCompleteMe/install.py" $> /dev/null || (echo Compilation failed! && exit 1)
    fi


    #
    # GitHub twofactor
    #
    echo Setting up GitHub two-factor access...
    apt install gcc libgnome-keyring-dev -y &> /dev/null || (echo Failed installing gnome-keyring! && exit 1)
    make --directory=/usr/share/doc/git/contrib/credential/gnome-keyring &> /dev/null || (echo Failed building gnome-keyring! && exit 1)
    git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring

    #
    # Git
    #
    echo Configuring git to your liking...
    git config --global user.name wtty-fool
    git config --global user.email wtty.fool@gmail.com
    git config --global core.editor vim
    echo Setting git aliases...
    git config --global alias.last 'log -1 --stat'
    git config --global alias.cp 'cherry-pick'
    git config --global alias.co 'checkout'
    git config --global alias.cl 'clone'
    git config --global alias.ci 'commit'
    git config --global alias.st 'status -sb'
    git config --global alias.br 'branch'
    git config --global alias.unstage 'reset HEAD --'
    git config --global alias.dc 'diff --cached'
    git config --global alias.lg 'log --graph --pretty format:"%Cred%h%Creset -%C(yel%Cblue<%an>%Creset" --abbrev-commit --date relative --all'


    #
    # THEME
    #
    # TODO
    # prompt user for terminal version
    # gnome-terminal | pantheon-terminal
    # make a copy of the default terminal profile
    # ask for theme preference: default, solarized-light, solarized-dark,
    # gruvbox-heavy, gruvbox-medium, gruvbox-soft
    # set terminal colors
    # TODO


    #
    # .BASHRC
    #
    # everything went smoothly, add new line to .bashrc
    echo "export BASHER=$BASHER_LOCATION" >> "$HOME/.bashrc"
    echo "source $BASHER/.basherrc" >> "$HOME/.bashrc"
fi

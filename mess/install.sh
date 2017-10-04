#! /bin/bash
source "./functions.sh"

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
    #exit 1
else
    #
    #   BASHER
    #
    echo "Installing Basher at '$BASHER_LOCATION'..."
    # update packages & install necessary ones
    #apt update -y &> /dev/null || (echo Error during apt update! && exit 1)
    #apt install -y git &> /dev/null || (echo Error installing git! && exit 1)
    #mkdir -p $BASHER_LOCATION
    #git clone https://github.com/wtty-fool/basher $BASHER_LOCATION
    #chmod +x $BASHER_LOCATION

    # Plugins
    echo Installing plugins...
    for path in plugins/*/; do
       plugin $path
    done

    # TODO - iterate all plugins, running installations for them
    # source "$BASHER_LOCATION/plugins/vim/install.sh"



    #
    # GitHub twofactor
    #


    #
    # Git
    #


    #
    # Colors
    #



    #
    # .BASHRC
    #
    # everything went smoothly, add new line to .bashrc
    #echo "export BASHER=$BASHER_LOCATION" >> "$HOME/.bashrc"
    #echo "source $BASHER/.basherrc" >> "$HOME/.bashrc"
fi

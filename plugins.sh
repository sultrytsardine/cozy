#!/bin/bash
plugin_home="$BASHER_HOME/plugins"

function plugin() {
    # activates plugin for current session
    # accepts 1 argument - plugin name
    local name=$1
    if [ ${#name} -eq 0 ]; then
        echo "No plugin name supplied!"
        exit 64
    fi

    local path="$plugin_home/$name"
    if [ -f $path ]; then
        source "$path/activate.sh" || echo "Could not activate $name!"
    else
        echo "Plugin $name does not exist!"
        exit 64
    fi
}


# function plugin_update()
# plugin_deactivate()
export -f plugin

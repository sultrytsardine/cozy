#!/bin/bash

function plugin() {
    if [ ! $1 ]; then
        echo Function called with no parameters!
    fi
    plugin_name=`basename $1`
    echo "   - $plugin_name"
    # plugin has valid structure
    if [[ -f "$1/install.sh" && -f "$1/uninstall.sh" ]]; then
        echo "     ok"
    else
        echo "     x"
    fi

}
# export function
export -f plugin

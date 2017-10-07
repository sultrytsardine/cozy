#!/bin/bash

function fl() {
    # [F]ind [l]ine in path
    # accepts two arguments:
    # 1 - path
    # 2 - pattern
    if [[ -z $1 || -z $2 ]]; then
        echo "Find line accepts 2 arguments:\n- a path to search\n- a pattern to search for"
        return
    fi
    grep -rnw $1 -e $2 --exclude-dir=.idea --exclude-dir=.git --exclude-dir=__pycache__
}

export -f fl



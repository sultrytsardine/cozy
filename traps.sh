#!/bin/bash

# precmd_functions is a list of functions called before each command
# they are supplied with a breakdown of $BASH_COMMAND
precmd_funcs=()

function before_command() {
    [ -n "$COMP_LINE" ] && return    # don't trap command completion
    [ "$BASH_COMMAND" ==  "$PROMPT_COMMAND" ] && return   # don't trap pre-commands
    # split into array
    local breakdown=($BASH_COMMAND)

    for f in $precmd_funcs; do
        # run command f
        # pass the 'breakdown' array as arguments
        # & - run it in background
        # 2>/dev/null silence '[1] Done...' message after f finishes
        ($f "${breakdown[@]}" &) 2>/dev/null
    done

}

function before_git_status() {
    # before `git st`
    if [[ $1 == "git" && $2 == "st" ]]; then
        echo "   You called me!"
    fi
}


# make sure every command goes through 'before_command' first
trap 'before_command' DEBUG
# this is how we register functions to be called
# before a command is executed
precmd_funcs+=(before_git_status)

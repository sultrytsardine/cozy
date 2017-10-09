#!/bin/bash

#
#   Basher
#   by wtty-fool
#


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [[ $(source linux.sh is_elementary) == "False" ]]; then
    echo "I only support ElementaryOS!"
    source $HOME/.bashrc
    return
fi


#
#   Execute other files
#
source 'exports.sh'
source 'history.sh'     # history file settings
source 'git.sh'         # git-related function definitions
source 'prompt.sh'      # customizes command prompt & prompt_command
source 'traps.sh'       # defines precmd_funcs - executed before some commands
source 'functions.sh'   # custom aliases, too big to be just aliases


#
#   Aliases
#
alias ls='ls -CF --color=auto'         # human-readable, group dirs first
alias ll='ls -alFhs'
alias la='ls -GA'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


#
#   Footer
#
# check window size after each command
shopt -s checkwinsize



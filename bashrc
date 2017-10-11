#!/bin/bash

#
#   Cozy
#   by wtty-fool
#


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export COZY_HOME="$HOME/.cozy"
if [[ $(source $COZY_HOME/linux.sh is_elementary) == "False" ]]; then
    echo "I only support ElementaryOS!"
    unset $COZY_HOME
    source $HOME/.bashrc
    return
fi


#
#   Execute other files
#
source "$COZY_HOME/exports.sh"
source "$COZY_HOME/history.sh"     # history file settings
source "$COZY_HOME/git.sh"         # git-related function definitions
source "$COZY_HOME/prompt.sh"      # customizes command prompt & prompt_command
source "$COZY_HOME/traps.sh"       # defines precmd_funcs - executed before some commands
source "$COZY_HOME/functions.sh"   # custom aliases, too big to be just aliases


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


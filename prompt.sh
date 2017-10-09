#!/bin/bash

#PROMPT_COMMAND+=" git_status 1> /dev/null;"
# $VIRRTUAL_ENV for python
# make sure to use export VIRTUAL_ENV_DISABLE_PROMPT=1
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


export no_color='\[\033[00m\]'
export black='\[\033[0;30m\]'
export blue='\[\033[0;34m\]'
export green='\[\033[0;32m\]'
export cyan='\[\033[0;36m\]'
export red='\[\033[0;31m\]'
export purple='\[\033[0;35m\]'
export brown='\[\033[0;33m\]'
export light_gray='\[\033[0;37m\]'
export dark_gray='\[\033[1;30m\]'
export light_blue='\[\033[1;34m\]'
export light_green='\[\033[1;32m\]'
export light_cyan='\[\033[1;36m\]'
export light_red='\[\033[1;31m\]'
export light_purple='\[\033[1;35m\]'
export yellow='\[\033[1;33m\]'
export white='\[\033[1;37m\]'

if [ "$color_prompt" = yes ]; then
    export _chroot="${debian_chroot:+($debian_chroot)}"
    export _user_host="$light_green\u@\h$no_color"
    export _pwd="$blue\w$no_color"
    export _git_br="\$(git_branch_name)${yellow}\$(git_branch_dirty)${no_color}"
    PS1="$_chroot\$$_user_host:$_pwd ($_git_br)\$ "
    unset _chroot
    unset _user_host
    unset _pwd
    unset _git_br
else
    PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "
fi
unset color_prompt

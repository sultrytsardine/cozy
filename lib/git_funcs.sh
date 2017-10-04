#!/bin/bash

function is_git_installed {
    local present=`git --version`
    local pattern='git version +([0-9\.])'
    if [[ $present =~ $pattern ]]; then
        echo "True"
    else
        echo "False"
    fi
}

function is_inside_git_repo {
    if [ -d ".git" ]; then
        echo "True"
    else
        echo "False"
    fi
}


function git_branch_name {
    local current_branch=`git symbolic-ref HEAD 2> /dev/null || echo "HEAD:$(git rev-parse --short HEAD)"`
    # remove 'refs/heads/' from result
    echo "${current_branch/refs\/heads\//}"
}


function git_has_changed() {
    if [ $1 ]; then
        local stats=$1
    else
        local stats=`git status --porcelain`
    fi
    if [ ${#stats} -gt 0 ]; then
        echo "True"
    else
        echo "False"
    fi
}

function git_has_untracked() {
    if [ $1 ]; then
        local stats=$1
    else
        local stats=`git status --porcelain`
    fi
    local stats=`git status --porcelain | grep '^?? .*$'`
    if [[ ${#stats} -gt 0 ]]; then
        echo "True"
    else
        echo "False"
    fi
}

function git_has_added() {
    if [ $1 ]; then
        local stats=$1
    else
        local stats=`git status --porcelain`
    fi
    local stats=`git status --porcelain | grep '^[ ]A[M] .*$'`
    if [[ ${#stats} -gt 0 ]]; then
        echo "True"
    else
        echo "False"
    fi
}


function git_has_modified() {
    if [ $1 ]; then
        local stats=$1
    else
        local stats=`git status --porcelain`
    fi
    local stats=`git status --porcelain | grep '^[ A]M .*$'`
    if [[ ${#stats} -gt 0 ]]; then
        echo "True"
    else
        echo "False"
    fi
}

function git_has_deleted() {
    if [ $1 ]; then
        local stats=$1
    else
        local stats=`git status --porcelain`
    fi
    local stats=`git status --porcelain | grep '^[ A]D .*$'`
    if [[ ${#stats} -gt 0 ]]; then
        echo "True"
    else
        echo "False"
    fi
}

function git_status {
    local stats=`git status --porcelain`
    if [[ $(git_has_changed $stats) == "False" ]]; then
        GIT_CURRENT_STATS=("False" "False" "False" "False")
    else
        untracked=$(git_has_untracked $stats)
        added="$(git_has_added $stats)"
        modified="$(git_has_modified $stats)"
        deleted="$(git_has_deleted $stats)"
        GIT_CURRENT_STATS=($untracked $added $modified $deleted)
    fi
    echo ${GIT_CURRENT_STATS[@]}
    unset $GIT_CURRENT_STATS
}


# export functions
export -f is_git_installed
export -f is_inside_git_repo
export -f git_branch_name
export -f git_has_changed
export -f git_has_untracked
export -f git_status
#echo "Git installed: $(is_git_installed)"
#echo "Is inside repo?: $(is_inside_git_repo)"
#echo "Current branch: $(git_branch_name)"
echo "Repo status (?? A M D): $(git_status)"


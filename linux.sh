#!/bin/bash

function recognize_distribution {
    local distrib_name=`cat /etc/*-release 2> /dev/null | grep -i "description"`

    if [ ${#distrib_name} -lt 3 ]; then
        echo "Could not recognize your distribution!"
        exit 64
    else
        # try to extract 'DISTRIB_DESCRIPTION="<extract_me>"'
        distrib_name=`expr match "$distrib_name" '.*="\(.*\)"'`

        local recognized=""
        if [[ $distrib_name =~ "Ubuntu" ]]; then
            recognized="ubuntu"
        elif [[ $distrib_name =~ "elementary" ]]; then
            recognized="elementary"
        else
            echo "Could not recognize your distribution!"
            exit 64
        fi

        echo $recognized
    fi
}


function is_elementary {
    if [ $(recognize_distribution) == "elementary" ]; then
       echo "True"
    else
       echo "False"
    fi
}




# function exports
# export -f recognize_distribution
# export -f is_elementary



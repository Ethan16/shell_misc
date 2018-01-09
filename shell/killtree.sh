#!/bin/bash
#功能：kill pid tree

if [ $# -ne 1 ]
then
    echo "Usage: killtree PID"
    exit
else
    root=$1
fi

function killtree()
{
    local father=$1

    # children
    childs=(`ps -ef | awk -v father=$father 'BEGIN{ ORS=" "; } $3==father{ print $2; }'`)
    if [ ${#childs[@]} -ne 0 ]
    then
        for child in ${childs[*]}
        do
            killtree $child
        done
    fi

    # father 
    echo -e "kill pid $father"
    kill -9 $father
}

killtree $root

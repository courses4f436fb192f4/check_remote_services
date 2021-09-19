#!/bin/bash

REMOTE_HOST="docker.qwe"
IP_LIST_FILE="$(dirname "$(realpath $0)")/ip_list"
PORT=""
IP=""
HOST_ADDR=""

if [ -n "$1" ]
then
    REMOTE_HOST="$1"
    echo "trying host"

    if ! ping -c 4 $REMOTE_HOST > /dev/null
    then
        exit 1
    fi
else
    echo "using host by default"
fi

if [ -f "$IP_LIST_FILE" ]
then
    while true;
    do    
        while IFS=: read IP PORT;
        do
            if ! nc -zvw 100ms "$IP" "$PORT"
            then
                HOST_ADDR="$IP:$PORT"
                curl -X post -d "{\"failed\": \"$HOST_ADDR\"}" http://"$REMOTE_HOST"/
            fi
        done < "$IP_LIST_FILE"

        echo "pause"
        sleep 60    
    done
fi

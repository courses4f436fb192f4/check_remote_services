#!/bin/bash

if [[ -n "$1" && -n "$2" && -n "$3" && -n "$4" ]]
then
    USER_NAME="$1"
    HOST="$2"
    SCRIPT="$3"
    ERR_SERVER="$4"
    
    echo "=== copying ==="
    scp -r ./check_services/ "$USER_NAME@$HOST:\/home\/$USER_NAME"
    echo "=== done copy ==="
    
    if [ "$SCRIPT" == "python" ]
    then
        ssh "$USER_NAME@$HOST" chmod +x /home/"$USER_NAME"/check_services/check_remote_services.py
        ssh "$USER_NAME@$HOST" python3 /home/"$USER_NAME"/check_services/check_remote_services.py "$ERR_SERVER" &
    elif [ "$SCRIPT" == "bash" ]
    then
        ssh "$USER_NAME@$HOST" chmod +x /home/"$USER_NAME"/check_services/check_remote_services.sh
        ssh "$USER_NAME@$HOST" /home/"$USER_NAME"/check_services/check_remote_services.sh "$ERR_SERVER" &
    fi
else
    echo "must be: bash copy_scr_to_remote.sh ssh_username hostname_for_copy_files python|bash server_for_errors"
fi

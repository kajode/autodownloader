#!/bin/bash

# IMPORTANT INFO
# run this script using 'bash run.bash'
# ! =================== !

echo "(system) please enter the following info to start downloading"
read -p 'IP: ' IP
read -p 'Username: ' USR
read -p 'Password: ' PW
read -p "Change download location? ($HOME) y/n: " CPTH

if [ "$CPTH" = "y" ] 
    then
        read -p 'Enter path:' PTH
    else
    PTH="$HOME"
fi

echo "(system) setting up login via ssh"
KEY="$HOME/.ssh/id_rsa_$IP_$USR"
if [ ! -e "$KEY" ]; then
     ssh-keygen -t rsa -N "" -f "$KEY" > /dev/null
     sshpass -p "$PW" ssh-copy-id -o StrictHostKeyChecking=no -i "${KEY}.pub" $USR@$IP
fi

echo "(system) starting sync. loop"
while true
do
    echo "(system) looking for files do download"
    FILE=`ssh -i ${KEY} $USR@$IP "ls *.plot | head -1"`
    scp -i ${KEY} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $USR@$IP:$FILE $PTH && ssh -i ${KEY} $USR@$IP "rm $FILE"
    echo "(system) pausing for 10sec."
    sleep 10
done

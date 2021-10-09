#!/bin/bash
echo "(system) checking that sshpass and rsync are installed"
apt install rsync sshpass

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


echo "(system) starting sync. loop"
while true
do
    echo "(system) looking for files do download"
    sshpass -p "$PW" rsync -avp -e "ssh -o StrictHostKeyChecking=no" --remove-source-files $USR@$IP:*.plot $PTH
    echo "(system) pausing for 10sec."
    sleep 10
done

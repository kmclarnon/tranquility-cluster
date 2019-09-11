#!/bin/bash

set -e

# read user name and password for ssh session
read -p "Enter remote user: " USER
echo -n "Enter remote password: "
unset PASSWORD;
while IFS= read -r -s -n1 pass; do
  if [[ -z $pass ]]; then
    echo
    break
  else
    echo -n '*'
    PASSWORD+=$pass
  fi
done

read -p "Enter master host: " MASTER

chmod +x setup-scripts/setup-master.sh
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$MASTER 'bash -s' < setup-scripts/setup-master.sh

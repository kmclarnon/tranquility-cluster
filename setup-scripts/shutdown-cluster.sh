#!/bin/bash

set -e

declare NODEARRAY
declare NAMEARRAY

# Get configuration
read -p "How many worker nodes do you wish to decomission" NODECOUNT

for i in $(seq 1 $NODECOUNT)
do
  read -p "Enter worker address: " TMPNODE
  read -p "Enter worker node name: " TMPNAME

  NODEARRAY[i]=$TMPNODE
  NAMEARRAY[i]=$TMPNAME
done

read -p "Decomission master? [y/n]:" MASTER
if [[ ! $MASTER =~ ^[Yy]$ ]]; then
  read -p "Enter master address: " MASTER_ADDRESS
  read -p "Enter master node name: " MASTER_NAME
fi

# Execute shutdown on nodes
for i in ${NODEARRAY[*]}; do
  echo "Decomissioning ${NAMEARRAY[$i]} - ${NODEARRAY[$i]}"
  ssh root@${NODEARRAY[$i]} ARG1="0" ARG2="${NAMEARRAY[$i]}" 'bash -s' < ./shutdown-node.sh
done

# Execute shutdown on master
if [[ ! $MASTER =~ ^[Yy]$ ]]; then
  echo "Decomissioning master"
  ssh root@$MASTER_ADDRESS ARG1="1" ARG2="${MASTER_NAME}" 'bash -s' < ./shutdown-node.sh
fi

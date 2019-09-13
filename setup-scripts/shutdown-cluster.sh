#!/bin/bash

set -e
cd "$(dirname "${BASH_SOURCE[0]}")"

declare NODE_ARRAY
declare NAME_ARRAY

chmod +x shutdown-node.sh

# Get configuration
read -p "How many worker nodes do you wish to decomission: " NODE_COUNT

for i in $(seq 1 $NODE_COUNT)
do
  read -p "Enter node $i address: " TMP_NODE
  read -p "Enter node $i node name: " TMP_NAME

  NODE_ARRAY[i]=$TMP_NODE
  NAME_ARRAY[i]=$TMP_NAME
done

read -p "Decomission master? [y/n]: " MASTER
if [[ $MASTER =~ ^[Yy]$ ]]; then
  read -p "Enter master address: " MASTER_ADDRESS
  read -p "Enter master node name: " MASTER_NAME
fi

# Execute shutdown on nodes
for i in "${!NODE_ARRAY[@]}"; do
  HOST="${NODE_ARRAY[$i]}"
  NAME="${NAME_ARRAY[$i]}"
  ./shutdown-node.sh 0 "$HOST" "$NAME"
done

# Execute shutdown on master
if [[ $MASTER =~ ^[Yy]$ ]]; then
  ./shutdown-node.sh 1 "$MASTER_ADDRESS" "$MASTER_NAME"
fi

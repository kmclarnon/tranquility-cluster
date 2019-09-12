#!/bin/bash

set -e

# Execute setup on master host
read -p "Enter master host: " MASTER
ssh root@$MASTER ARG1="1" ARG2="$MASTER" 'bash -s' < ./setup-scripts/init-node.sh

# capture our join command
JOIN_CMD=$(ssh root@$MASTER 'bash -s' < ./setup-scripts/print-token.sh)
echo $JOIN_CMD

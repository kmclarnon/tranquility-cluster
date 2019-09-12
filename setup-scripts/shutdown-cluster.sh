#!/bin/bash

set -e

# Execute shutdown on node
read -p "Enter host: " HOST
read -p "Enter node name: " NODE
ssh root@$HOST ARG1="0" ARG2="$NODE" 'bash -s' < ./shutdown-node.sh

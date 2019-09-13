#!/bin/bash

set -e

echo "What would you like to do?"
echo "1. Bootstrap cluster"
echo "2. Add node to cluster"
echo "3. Decomission part of all of the cluster"

read OPTION

if [ "$OPTION" -eq "1" ]; then
  setup-scripts/init-cluster.sh
elif [ "$OPTION" -eq "2" ]; then
  echo "Not supported yet"
elif [ "$OPTION" -eq "3" ]; then
  setup-scripts/shutdown-cluster.sh
fi

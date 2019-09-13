#!/bin/bash

set -ex

cd "$(dirname "${BASH_SOURCE[0]}")"

IS_MASTER=$1
HOST=$2
NAME=$3

drain_node() {
  kubectl drain "$NAME" --delete-local-data --force --ignore-daemonsets
  kubectl delete node "$NAME"
}

if [ "$IS_MASTER" -eq "1" ]; then
  echo "Shutting down master node $NAME"
  ssh root@$HOST 'bash -s' < reset.sh
else
  echo "Shutting down worker node $NAME"
  drain_node
  ssh root@$HOST 'bash -s' < reset.sh
fi


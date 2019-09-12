#!/bin/bash

set -e

drain_node() {
  kubectl drain $ARG2 --delete-local-data --force --ignore-daemonsets
  kubectl delete node $ARG2
}

remove_kubeadm() {
  kubeadm reset -f
  apt-get purge kubeadm kubectl kubelet kubernetes-cni kube*
  apt-get auto-remove
  rm -rf ~/.kube
}

if [ "$ARG1" -eq "1" ]; then
  echo "Shutting down master node $ARG2"
  remove_kubeadm
else
  echo "Shutting down worker node $ARG2"
  drain_node
  remove_kubeadm
fi


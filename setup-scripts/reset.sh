#!/bin/bash

set -e

kubeadm reset -f
apt-get purge --yes kubeadm kubectl kubelet kubernetes-cni kube*
apt-get autoremove --yes
rm -rf ~/.kube
rm -f /usr/local/bin/helm

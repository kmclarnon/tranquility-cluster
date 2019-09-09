#!/bin/sh

set -e

# enable kubelet service
systemctl enable kubelet
systemctl start kubelet

# setup config for kubectl
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# enable flannel network
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

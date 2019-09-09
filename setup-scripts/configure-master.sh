#!/bin/sh

set -e

# enable kubelet service
echo "Enable kubelet service"
systemctl enable kubelet
systemctl start kubelet

# initialize kubernetes
echo "Initializing kubernetes api server"
kubeadm init --apiserver-advertise-address=192.168.1.10 --pod-network-cidr=10.244.0.0/16

# setup config for kubectl
echo "Setting up kubectl on this node"
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# enable flannel network
echo "Enabling pod network"
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

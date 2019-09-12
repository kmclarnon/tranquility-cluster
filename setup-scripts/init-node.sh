#!/bin/bash

set -e

install_kubernetes() {
  # check if kubeadm is already installed
  echo "Checking if kubeadm is installed"
  if dpkg-query -W -f='${Status}' kubeadm | grep "ok installed"; then
    echo "Kubeadm is already installed, skipping setup"
    return
  fi

  # Add kubernetes packages to apt-get
  echo "Preparing to install kubeadm"
  FILE=apt-key.gpg
  if test -f "$FILE"; then
    echo "Found $FILE, removing before continuing"
    rm $FILE
  fi

  echo "Downloading google cloud gpg key"
  wget https://packages.cloud.google.com/apt/doc/apt-key.gpg
  echo "Installing key into package manager"
  apt-key add apt-key.gpg
  echo "Adding kubernetes repository to package manager"
  apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
  echo "Updating packages"
  apt-get update

  # Install kubeadm
  apt-get install kubeadm -y
}

install_docker() {
  # check if docker is installed
  echo "Checking if Docker is installed"
  if dpkg-query -W -f='${Status}' docker.io | grep "ok installed"; then
    echo "Docker is already installed, enabling Docker service"
    # ensure it's started
    systemctl enable docker
    systemctl start docker
    return
  fi

  # install docker
  echo "Installing Docker"
  apt-get install docker.io -y

  # start it up
  echo "Enabling Docker service"
  systemctl enable docker
  systemctl start docker
}

configure_master() {
  # enable kubelet service
  echo "Enable kubelet service"
  systemctl enable kubelet
  systemctl start kubelet

  # initialize kubernetes
  echo "Initializing kubernetes api server"
  kubeadm init --apiserver-advertise-address=$ARG2 --pod-network-cidr=10.244.0.0/16

  # setup config for kubectl
  echo "Setting up kubectl on this node"
  mkdir -p $HOME/.kube
  cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  chown $(id -u):$(id -g) $HOME/.kube/config

  # enable flannel network
  echo "Enabling pod network"
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
}

if [ "$ARG1" -eq "1" ]; then
  echo "Initializing node $ARG2 as master"
  install_kubernetes
  install_docker
  configure_master
else
  echo "Initialize node $ARG2 as a worker"
  install_kubernetes
  install_docker
fi

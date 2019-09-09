#!/bin/bash

set -e

# check if kubeadm is already installed
echo "Checking if kubeadm is installed"
if dpkg-query -W -f='${Status}' kubeadm | grep "ok installed"; then
  echo "Kubeadm is already installed, skipping setup"
  exit 0
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

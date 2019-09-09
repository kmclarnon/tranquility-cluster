#!/bin/sh

set -e

# check if docker is installed
echo "Checking if Docker is installed"
if dpkg-query -W -f='${Status}' docker.io | grep "ok installed"; then
  echo "Docker is already installed, enabling Docker service"
  # ensure it's started
  systemctl enable docker
  systemctl start docker
  exit 0
fi

# install docker
echo "Installing Docker"
apt-get install docker.io -y

# start it up
echo "Enabling Docker service"
systemctl enable docker
systemctl start docker

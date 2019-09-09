#!/bin/sh

set -e

# check if docker is installed
if dpkg-query -W -f='${Status}' docker.io | grep "ok installed"; then
  echo "Docker is already installed, skipping"
  # ensure it's started
  systemctl enable docker
  systemctl start docker
  exit 0
fi

# install docker
apt-get install docker.io -y

# start it up
systemctl enable docker
systemctl start docker

#!/bin/sh

set -e

# check if docker is installed
IS_INSTALLED=$(dpkg-query -f='${Status}' docker.io 2>/dev/null | grep -c "ok installed")
if $IS_INSTALLEd -eq 1 then
  echo "Docker is already installed, skipping setup"
  exit 0
fi

# install docker
apt-get install docker.io -y

# start it up
systemctl enable docker
systemctl start docker

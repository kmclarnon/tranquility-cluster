#!/bin/bash

set -e

chmod +x ./install-kubernetes.sh
chmod +x ./install-docker.sh
chmod +x ./configure-master.sh

./install-kubernetes.sh
./install-docker.sh
./configure-masher.sh

#!/bin/bash

set -e

echo "Making install scripts executable"
chmod +x ./install-kubernetes.sh
chmod +x ./install-docker.sh

echo "Installing requirements"
./install-kubernetes.sh
./install-docker.sh

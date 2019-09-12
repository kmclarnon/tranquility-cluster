#!/bin/bash

set -e

# Install metallb
echo "Installing metallb"
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.1/manifests/metallb.yaml

# Install the config for metallb
echo "Configuring metallb in layer2 mode for 192.168.2.1 - 192.168.2.255"
kubectl apply -f ../custom-objects/metallb-config-map.yaml

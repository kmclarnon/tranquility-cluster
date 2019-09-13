#!/bin/bash

set -e

cd "$(dirname "${BASH_SOURCE[0]}")"

# Install metallb
echo "Installing metallb"
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.1/manifests/metallb.yaml

# Install the config for metallb
echo "Configuring metallb in layer2 mode for nginx-ingress"
kubectl apply -f ../custom-objects/config-map-metallb.yaml

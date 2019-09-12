#!/bin/bash

set -e

# Install MetalLb
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.1/manifests/metallb.yaml


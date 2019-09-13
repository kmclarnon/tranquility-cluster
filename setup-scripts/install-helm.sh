#!/bin/bash

set -e

# Fectching helm tarball
wget https://get.helm.sh/helm-v2.14.3-linux-amd64.tar.gz

# Unpacking helm
tar -zxvf helm-v2.14.3-linux-amd64.tar.gz
rm helm-v2.14.3-linux-amd64.tar.gz

# Installing on local machine
mv -f linux-amd64/helm /usr/local/bin/helm
rm -rf linux-amd64

# Installing tiller into cluster
kubectl apply -f ../custom-objects/serviceaccount-tiller.yaml
kubectl apply -f ../custom-objects/clusterrole-tiller.yaml
kubectl apply -f ../custom-objects/clusterrolebinding-tiller.yaml

helm init --history-max 200 --service-account tiller

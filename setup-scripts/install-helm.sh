#!/bin/bash

set -e

# Fectching helm tarball
wget https://get.helm.sh/helm-v2.14.3-linux-amd64.tar.gz

# Unpacking helm
tar -zxvf helm-v2.14.3-linux-amd64.tar.gz
rm helm-v2.14.3-linux-amd64.tar.gz

# Installing on local machine
mv -f linux-amd64/helm $HOME/bin
rm -rf linux-amd64

# Installing tiller into cluster
kubectl apply -f ../custom-objects/tiller/serviceaccount-tiller.yaml
kubectl apply -f ../custom-objects/tiller/clusterrole-tiller.yaml
kubectl apply -f ../custom-objects/tiller/clusterrolebinding-tiller.yaml

helm init --history-max 200 --service-account tiller

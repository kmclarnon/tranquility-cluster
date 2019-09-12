#!/bin/bash

set -e

# Fectching helm tarball
wget https://get.helm.sh/helm-v2.14.3-linux-amd64.tar.gz

# Unpacking helm
tar -zxvf helm-v2.14.3-linux-amd64.tar.gz
rm helm-v2.14.3-linux-amd64.tar.gz

# Installing
mv linux-amd64/helm /usr/local/bin/helm
helm init
rm -rf linux-amd64

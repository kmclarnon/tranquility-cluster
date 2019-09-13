#!/bin/bash

set -e

# Install our ingress
helm install stable/nginx-ingress --name nginx-ingress --namespace nginx-system --set rbac.create=true

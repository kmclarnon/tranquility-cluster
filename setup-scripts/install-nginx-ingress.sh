#!/bin/bash

set -e

# Install our ingress
helm install stable/nginx-ingress --set rbac.create=true

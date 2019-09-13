#!/bin/bash

set -e

declare NODEARRAY

# Get our configuration
read -p "Enter master host: " MASTER
read -p "How many worker nodes do you wish to set up: " NODECOUNT

for i in $(seq 1 $NODECOUNT)
do
  read -p "Enter worker host: " TMP
  NODEARRAY[i]=$TMP
done

# Execute setup of our master node
echo "Executing setup on master node: $MASTER"
ssh root@$MASTER ARG1="1" ARG2="$MASTER" 'bash -s' < ./init-node.sh

# capture our join command
JOIN_CMD=$(ssh root@$MASTER 'bash -s' < ./setup-scripts/print-token.sh)

# setup this computer for access to the cluster via kubectl
mkdir -p $HOME/.kube
scp root@$MASTER:/etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# Execute setup on node
for i in "${NODEARRAY[@]}"
do
  echo "Executing setup on worker node: $i"
  ssh root@$i ARG1="0" ARG2="$i" 'bash -s' < ./init-node.sh
  ssh root@$i "$JOIN_CMD"
done

echo "*************************************"
echo "*                                   *"
echo "*  Cluster Initialization Complete  *"
echo "*                                   *"
echo "*************************************"

kubectl get nodes

# Now that we have a cluster, lets do something with it
./install-helm.sh
./install-metallb.sh
./install-nginx-ingress.sh

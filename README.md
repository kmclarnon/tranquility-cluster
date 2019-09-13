# tranquility-cluster

This contains all of the configurations and automation necessary to install, manage and shutdown the kubernetes cluster that I run at home.  This cluster uses metallb to expose nginx-ingress to the public internet via layer2 routing. BGP Peering is also possible, but not supported out of the box.


### Quickstart 
In order to start, simply clone the repo and run
```bash
chmod +x start.sh && ./start.sh
```

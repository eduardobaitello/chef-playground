# kubernetes-hardway

**WIP**

Installs 1 Kubernetes masters and 2 nodes.

# Vagrant Environment

## Virtual Machines
Use `vagrant up` to start the following VMs:
- master
  - Private IP: 192.168.10.100
  - Forwarded Port: 6443 --> 6443
- node1
  - Private IP: 192.168.10.10
- node2
  - Private IP: 192.168.10.20


## Provisioning Script

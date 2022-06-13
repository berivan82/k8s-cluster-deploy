#!/bin/bash

set -x -v
ansible -m command -i inventory all -v -a"apt update"
ansible -m command -i inventory all -v -a"apt remove kubectl kubeadm kubelet -y"
ansible -m command -i inventory all -v -a"apt install -f -y"
ansible -m command -i inventory all -v -a"apt autoremove -y"
ansible -m command -i inventory all -v -a"apt install kubectl=1.23.7-00 kubeadm=1.23.7-00 kubelet=1.23.7-00 -y"

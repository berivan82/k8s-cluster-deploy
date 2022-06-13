#!/bin/bash
set -x -v
ansible-playbook -i inventory -v 01-balancer.yaml
ansible-playbook -i inventory -v 02-pcs.yaml
ssh etcd02 "service haproxy restart"
service haproxy restart
ansible-playbook -i inventory -v 03-kubelet.yaml
ansible-playbook -i inventory -v 04-certs.yaml
ansible-playbook -i inventory -v 05-kmasters.yaml



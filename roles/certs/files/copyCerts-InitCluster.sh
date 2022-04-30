#!/bin/bash
set -x -v
USER=root

kubeadm init phase etcd local --config=/tmp/192.168.234.112/kubeadmcfg.yaml
for HOST in 192.168.234.113 192.168.234.114;
  do  scp -r /tmp/${HOST}/* ${USER}@${HOST}:
  ssh ${USER}@${HOST} "chown -R root:root pki; mv pki /etc/kubernetes; kubeadm init phase etcd local --config=/root/kubeadmcfg.yaml"
done


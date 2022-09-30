#!/bin/bash
set -x -v

cat /etc/passwd|grep hacluster
if [ $? == 0 ]
  then
    echo "hacluster:hacluster" | chpasswd
  else
    useradd hacluster -p hacluster
fi

pcs property|grep failed
if [ $? != 0 ]
  then
    pcs cluster destroy
fi

ssh -T etcd02 /bin/bash << "EOF"
cat /etc/passwd|grep hacluster
if [ $? == 0 ]
  then
    echo "hacluster:hacluster" | chpasswd
  else
    useradd hacluster -p hacluster
fi
pcs property|grep failed
if [ $? != 0 ]
  then
    pcs cluster destroy
fi
EOF

pcs host auth etcd01 addr=192.168.234.112 etcd02 addr=192.168.234.113 -u hacluster -p hacluster
pcs cluster --debug setup haproxycluster etcd01 addr=192.168.234.112 etcd02 addr=192.168.234.113 # --force
pcs cluster start --all
pcs cluster config show --output-format text
pcs resource create virtual_ip ocf:heartbeat:IPaddr2 ip=192.168.234.111 cidr_netmask=32 op monitor interval=30s
pcs property set stonith-enabled=false
pcs property set no-quorum-policy=ignore
pcs property
pcs status cluster
pcs status resources
crm_verify -L -V

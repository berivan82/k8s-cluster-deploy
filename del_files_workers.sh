#!/bin/bash
ansible -m command -i inventory/ workers -a"losetup -D"
ansible -m command -i inventory/ workers -a"rm /home/gluster/image"
ansible -m command -i inventory/ workers -a"rm -rf /root/heketi"

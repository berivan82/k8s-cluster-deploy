#!/bin/bash
set -x -v

sed -i '/cdrom/d' /etc/apt/sources.list
apt update
apt install sudo atop htop telnet lsof open-vm-tools* apt-file git tree sudo nmap net-tools dnsutils apt-file \
vim wget curl mc openssh-server openssh-client locate traceroute tcptraceroute strace tcpdump make links lynx smem gcc g++ \
nano psmisc lvm2 coreutils vim coreutils sysstat jq passwd tilix terminator netcat -y
apt-file update
chmod 700 /etc/sudoers
sed -i '/^root/ a admins ALL=(ALL) NOPASSWD:ALL' /etc/sudoers
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart sshd
updatedb
cp /home/admins/.bashrc /root/.bashrc
echo -e "PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin\nHISTFILE=500000\nHISTFILESIZE=500000\nHISTTIMEFORMAT='%d/%m/%y %T  '" >> /root/.bashrc

###INSTALL DOCKER###
apt update
apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install docker-ce docker-ce-cli containerd.io -y
apt-cache madison docker-ce


###INSTALL KUBERNETES###
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt update
apt install -y kubectl kubelet kubeadm
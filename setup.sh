#!/bin/bash

# Update some applications
sudo yum update -y
sudo yum install -y yum-utils device-mapper-persistent-data lvm2 vim python3 lsof git

# Install Docker
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo systemctl start docker
sudo systemctl enable docker

# Config SSH port
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bk
sudo sed -e 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config > /etc/ssh/sshd_config
sudo semanage port -a -t ssh_port_t -p tcp 2222
sudo systemctl reload sshd.service

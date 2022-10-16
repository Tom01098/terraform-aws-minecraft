#!/bin/bash
sudo yum update -y
sudo yum install -y java

sudo mkdir /minecraft
cd /minecraft
wget ${download_url} -O server.jar
echo "eula=true" > eula.txt
sudo chown -R ec2-user /minecraft/

sudo echo "${service}" > /etc/systemd/system/minecraft.service
sudo systemctl daemon-reload
sudo systemctl enable minecraft.service
sudo systemctl start minecraft.service

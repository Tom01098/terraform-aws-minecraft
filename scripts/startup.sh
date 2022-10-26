#!/bin/bash
sudo yum update -y
sudo yum install -y java amazon-cloudwatch-agent

sudo mkdir /minecraft
cd /minecraft
wget ${download_url} -O server.jar
echo "eula=true" > eula.txt

sudo useradd mc
sudo chown -R mc /minecraft/

sudo echo '${agent_config}' > /opt/aws/amazon-cloudwatch-agent/bin/config.json
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json

sudo echo "${service}" > /etc/systemd/system/minecraft.service
sudo systemctl daemon-reload
sudo systemctl enable minecraft.service
sudo systemctl start minecraft.service

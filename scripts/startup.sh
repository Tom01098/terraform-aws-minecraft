#!/bin/bash
yum update -y
yum install -y java amazon-cloudwatch-agent

mkdir /minecraft
cd /minecraft
wget ${download_url} -O server.jar
echo "eula=true" > eula.txt

useradd mc
chown -R mc /minecraft/

echo '${agent_config}' > /opt/aws/amazon-cloudwatch-agent/bin/config.json
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json

echo "${service}" > /etc/systemd/system/minecraft.service
systemctl daemon-reload
systemctl enable minecraft.service
systemctl start minecraft.service

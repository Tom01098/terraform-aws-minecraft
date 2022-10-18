#!/bin/bash
sudo yum update -y
sudo yum install -y java amazon-cloudwatch-agent

sudo mkdir /minecraft
cd /minecraft
wget ${download_url} -O server.jar
echo "eula=true" > eula.txt

sudo useradd mc
sudo chown -R mc /minecraft/

# TODO Move to a separate file.
sudo echo '{
    "agent": {
        "run_as_user": "cwagent"
    },
    "logs": {
        "logs_collected": {
            "files": {
                "collect_list": [
                    {
                        "file_path": "/minecraft/logs/*.log",
                        "log_group_name": "/minecraft",
                        "log_stream_name": "{instance_id}",
                        "retention_in_days": 1
                    }
                ]
            }
        }
    }
}' > /opt/aws/amazon-cloudwatch-agent/bin/config.json
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json

sudo echo "${service}" > /etc/systemd/system/minecraft.service
sudo systemctl daemon-reload
sudo systemctl enable minecraft.service
sudo systemctl start minecraft.service

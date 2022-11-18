terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.33"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_iam_policy" "cloud_watch_agent" {
  name = "CloudWatchAgentServerPolicy"
}

resource "aws_iam_role" "role" {
  name                = "Minecraft"
  managed_policy_arns = [data.aws_iam_policy.cloud_watch_agent.arn]
  assume_role_policy  = file("scripts/assume_role_policy.json")
}

resource "aws_iam_instance_profile" "profile" {
  name = "Minecraft"
  role = aws_iam_role.role.name
}

data "aws_ami" "amazon_linux_2" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.*"]
  }
}

resource "aws_security_group" "minecraft" {
  name        = "Minecraft"
  description = "Minecraft server traffic"
}

resource "aws_security_group_rule" "minecraft" {
  type              = "ingress"
  from_port         = 25565
  to_port           = 25565
  protocol          = "tcp"
  security_group_id = aws_security_group.minecraft.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh" {
  count             = var.ec2_instance_connect ? 1 : 0
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.minecraft.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  security_group_id = aws_security_group.minecraft.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_instance" "minecraft" {
  ami                  = data.aws_ami.amazon_linux_2.id
  iam_instance_profile = aws_iam_instance_profile.profile.name
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.minecraft.name]
  tags = {
    Name = "Minecraft"
  }
  user_data = templatefile(
    "scripts/startup.sh",
    {
      agent_config = templatefile("scripts/cloudwatch_agent_config.json", { log_group_name = aws_cloudwatch_log_group.minecraft.name })
      download_url = var.download_url,
      service      = file("scripts/minecraft.service")
    }
  )
}

resource "aws_cloudwatch_log_group" "minecraft" {
  name              = "minecraft"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_stream" "minecraft" {
  name           = aws_instance.minecraft.id
  log_group_name = aws_cloudwatch_log_group.minecraft.name
}

resource "aws_eip" "minecraft" {
  instance = aws_instance.minecraft.id
}

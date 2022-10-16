terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.33.0"
    }
  }
}
 
provider "aws" {
  region = var.region
}

data "aws_ami" "amazon_linux_2" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.*"]
  }
}

resource "aws_security_group" "everything" {
  name = "everything"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "minecraft" {
  ami             = data.aws_ami.amazon_linux_2.id
  instance_type   = "t2.medium"
  security_groups = [aws_security_group.everything.name]
  tags = {
    Name = "Minecraft"
  }
  user_data = templatefile("scripts/startup.sh", { service = file("scripts/minecraft.service"), download_url = var.download_url })
}

resource "aws_eip" "minecraft" {
  instance = aws_instance.minecraft.id
}

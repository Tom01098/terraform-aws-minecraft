# A Minecraft Server on AWS
Easily deploy a Minecraft server on AWS EC2.

Features:
- Specify a URL to download the Minecraft server jar. By default, this is 1.19.3.
- Choose an AWS region to deploy to. Defaults to eu-west-2 (London).
- Choose an EC2 instance type. Defaults to `t2.medium`, which is the smallest type that can support the server. Charges apply.
- EC2 instance connect support for SSH access.
- Static IP address support.
- Logging and metrics to CloudWatch.
- Hardened networking rules.

# EULA
This module automatically agrees to the [Minecraft EULA](https://www.minecraft.net/en-us/eula). By deploying this module, you agree to the terms in it.

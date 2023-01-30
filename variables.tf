variable "ec2_instance_connect" {
  type        = bool
  default     = false
  description = "Keep SSH (port 22) open to allow connections via EC2 Instance Connect."
}

variable "download_url" {
  type        = map
  default = {
    "1.19.3" = "https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar"
    "1.19.2" = "next url"
  }
  description = "Minecraft server versions and download links in a map"
}

variable "server_version" {
  type        = string
  default = "1.19.3"
  description = "Minecraft server version"
}

variable "instance_type" {
  type        = string
  default     = "t2.medium"
  description = "The EC2 instance type of the server. Requires at least t2.medium."
}

variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "AWS region to deploy to"
}

variable "static_ip" {
  type        = bool
  default     = false
  description = "Should the instance retain its IPv4 address after being stopped? Charges apply while the server is stopped."
}

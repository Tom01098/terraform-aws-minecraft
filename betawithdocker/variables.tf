variable "ec2_instance_connect" {
  type        = bool
  description = "Keep SSH (port 22) open to allow connections via EC2 Instance Connect."
}

variable "download_url" {
  type        = map(any)
  description = "Minecraft server versions and download links in a map"
}

variable "server_version" {
  type        = string
  description = "Minecraft server version"
}

variable "instance_type" {
  type        = string
  description = "The EC2 instance type of the server. Requires at least t2.medium."
}

variable "region" {
  type        = string
  description = "AWS region to deploy to"
}

variable "static_ip" {
  type        = bool
  description = "Should the instance retain its IPv4 address after being stopped? Charges apply while the server is stopped."
}

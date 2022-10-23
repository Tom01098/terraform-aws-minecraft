variable "ec2_instance_connect" {
  type        = bool
  default     = false
  description = "Keep SSH (port 22) open to allow connections via EC2 Instance Connect."
}

variable "download_url" {
  type        = string
  default     = "https://piston-data.mojang.com/v1/objects/f69c284232d7c7580bd89a5a4931c3581eae1378/server.jar"
  description = "Minecraft server download URL"
}

variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "AWS region to deploy to"
}

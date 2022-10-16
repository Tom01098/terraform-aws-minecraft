variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "AWS region to deploy to"
}

variable "download_url" {
  type        = string
  default     = "https://piston-data.mojang.com/v1/objects/f69c284232d7c7580bd89a5a4931c3581eae1378/server.jar"
  description = "Minecraft server download URL"
}

resource "aws_key_pair" "main_auth" {
  key_name   = "main_key_name"
  public_key = file("~/.ssh/terra.pub") #should be replaced with your own (ssh-keygen)


}
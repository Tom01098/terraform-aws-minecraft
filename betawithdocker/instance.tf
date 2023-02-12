resource "aws_instance" "main_instance" {
  instance_type = "t2.medium"
  ami           = data.aws_ami.main_server_ami.id
  tags = {
    Name = "main_server_instance"
  }
  key_name = aws_key_pair.main_auth.id

  vpc_security_group_ids = [aws_security_group.main_sg.id]

  subnet_id = aws_subnet.main_subnet.id

  user_data = file("commands.sh")
}
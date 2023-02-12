
resource "aws_vpc" "main_vpc" {
  cidr_block           = "192.168.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tag of main vpc"
  }

}

resource "aws_subnet" "main_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "192.168.0.0/25"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2a"


  tags = {
    Name = "tag of main subnet"
  }
}

resource "aws_internet_gateway" "main_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "tag of main gateway"
  }
}

resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "tag of main route table"
  }
}

resource "aws_route" "main_default_route" {
  route_table_id         = aws_route_table.main_route_table.id
  gateway_id             = aws_internet_gateway.main_gateway.id
  destination_cidr_block = "0.0.0.0/0"

}

resource "aws_route_table_association" "main_assoc" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.main_route_table.id
}

resource "aws_security_group" "main_sg" {
  name        = "name_main_sg"
  description = "Allow any traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}























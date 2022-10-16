output "ip" {
  value = aws_eip.minecraft.public_ip
  description = "The elastic IPv4 address assigned to the server"
}

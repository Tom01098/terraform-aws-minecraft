output "ip" {
  value       = aws_eip.minecraft.public_ip
  description = "The elastic IPv4 address assigned to the server"
}

output "logs" {
  value       = "https://${var.region}.console.aws.amazon.com/cloudwatch/home#logsV2:log-groups/log-group/${local.log_group_name}/log-events/${aws_instance.minecraft.id}"
  description = "URL to the CloudWatch log stream from the server"
}

output "ssh" {
  value       = var.ec2_instance_connect ? "https://${var.region}.console.aws.amazon.com/ec2-instance-connect/ssh?connType=standard&instanceId=${aws_instance.minecraft.id}&osUser=ec2-user&sshPort=22" : null
  description = "URL to SSH into the server"
}

output "ip" {
  value       = aws_eip.minecraft.public_ip
  description = "The elastic IPv4 address assigned to the server"
}

output "logs" {
  value       = "https://${var.region}.console.aws.amazon.com/cloudwatch/home#logsV2:log-groups/log-group/${aws_cloudwatch_log_group.minecraft.name}/log-events/${aws_instance.minecraft.id}"
  description = "URL to the CloudWatch log stream from the server"
}

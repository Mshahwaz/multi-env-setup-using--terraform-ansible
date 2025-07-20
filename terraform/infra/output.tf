output "ec2_public_ips" {
  value = aws_instance.my-instance[*].public_ip
    description = "Public ips of instances"
}
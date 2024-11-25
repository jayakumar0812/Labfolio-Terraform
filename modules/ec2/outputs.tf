output "public_ip" {
  value = aws_instance.Publicec2instance.public_ip
  description = "Public IP of the EC2 instance"
}

output "public_sg" {
  value = aws_security_group.public_sg.id
  description = "Security group ID of the public EC2 instance"
}

output "private_sg" {
  value = aws_security_group.private_sg.id
  description = "Security group ID of the private EC2 instance"
}

output "jumpbox_sg" {
  value = aws_security_group.jumpbox_sg.id
  description = "Security group ID of the jumpbox EC2 instance"
}
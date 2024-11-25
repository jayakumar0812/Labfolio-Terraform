output "vpc_id" {
  value = aws_vpc.vpc_main.id
}

output "PublicSubnet1_id" {
  value = aws_subnet.PublicSubnet1.id
}

output "PrivateSubnet1_id" {
  value = aws_subnet.PrivateSubnet1.id
}



data "aws_availability_zones" "available_zones" {
    state = "available"
}

resource "aws_vpc" "vpc_main" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "ec2_vpc"
    }
}

resource "aws_subnet" "PublicSubnet1" {
    vpc_id = aws_vpc.vpc_main.id
    cidr_block = var.Publicsubnet1_cidr_block
    availability_zone = data.aws_availability_zones.available_zones.names[0]
    map_public_ip_on_launch = true
    tags = {
        Name = "PublicSubnet1"
    }
}

resource "aws_subnet" "PrivateSubnet1" {
    vpc_id = aws_vpc.vpc_main.id
    cidr_block = var.Privatesubnet1_cidr_block
    availability_zone = data.aws_availability_zones.available_zones.names[0]
    map_public_ip_on_launch = false
    tags = {
        Name = "PrivateSubnet1"
    }
}

resource "aws_internet_gateway" "igw_ec2" {
    vpc_id = aws_vpc.vpc_main.id
    tags = {
        Name = "ec2_igw"
    }
}

resource "aws_route_table" "Publicrt" {
    vpc_id = aws_vpc.vpc_main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw_ec2.id
}
}

resource "aws_route_table_association" "publicrouteassoc" {
    subnet_id = aws_subnet.PublicSubnet1.id
    route_table_id = aws_route_table.Publicrt.id
}

resource "aws_route_table" "Privatert" {
    vpc_id = aws_vpc.vpc_main.id
}

resource "aws_route_table_association" "privaterouteassoc" {
    subnet_id = aws_subnet.PrivateSubnet1.id
    route_table_id = aws_route_table.Privatert.id
}
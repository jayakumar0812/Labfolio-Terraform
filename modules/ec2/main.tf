#creating ec2 instances in terraform
resource "aws_instance" "Publicec2instance" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.subidpub
    vpc_security_group_ids = [aws_security_group.public_sg.id]
    tags = {
        Name = "Publicec2instance"
    }
  
}
#Private ec2 instance creation
resource "aws_instance" "Privateec2instance" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.subidpriv
    vpc_security_group_ids = [aws_security_group.private_sg.id]
    tags = {
        Name = "Privateec2instance"
    }
  
}
#Jumpbox ec2 instance creation
resource "aws_instance" "Jumpboxec2instance" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.subidpub
    vpc_security_group_ids = [aws_security_group.jumpbox_sg.id]
    tags = {
        Name = "Jumpboxec2instance"
    }
  
}

#creating security group for public ec2 instance
resource "aws_security_group" "public_sg" {
    name = "public_sg"
    vpc_id = var.vpc_id
    #traffic for public ec2 instance http
    ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    }
    #traffic for public ec2 instance https
    ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
    }
    #traffic for public ec2 instance ssh via jumpbox
    ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    security_groups = [aws_security_group.jumpbox_sg.id]
    }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

#creating security group for private ec2 instance
resource "aws_security_group" "private_sg" {
    name = "private_sg"
    vpc_id = var.vpc_id

    #traffic for private ec2 instance ssh via jumpbox
    ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    security_groups = [aws_security_group.jumpbox_sg.id]
    }
}

#creating security group for jumpbox ec2 instance
resource "aws_security_group" "jumpbox_sg" {
    name = "jumpbox_sg"
    vpc_id = var.vpc_id
    #traffic for jumpbox ec2 instance ssh
    ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
   }
    egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}





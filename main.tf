terraform {
  backend "s3" {
    bucket = "terraform-statefile-atu"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}


module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  Publicsubnet1_cidr_block = var.Publicsubnet1_cidr_block
  Privatesubnet1_cidr_block = var.Privatesubnet1_cidr_block
}

module "ec2" {
  source = "./modules/ec2"
  ami_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  subidpriv = module.vpc.PrivateSubnet1_id
  subidpub = module.vpc.PublicSubnet1_id
  vpc_id = module.vpc.vpc_id
}

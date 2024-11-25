variable "vpc_cidr" {
}

variable "Publicsubnet1_cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "Privatesubnet1_cidr_block" {
  description = "The CIDR block for the private subnet"
  type        = string
}

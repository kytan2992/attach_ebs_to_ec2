data "aws_vpc" "vpc" {
  id = var.vpc
}

data "aws_subnet" "public_subnet" {
  id = var.public_subnet
}

data "aws_ami" "ami_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_security_group" "sg" {
  name        = "${local.resource_prefix}-ebs-SG"
  description = "Security Group created for EC2 to attach EBS"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allowssh" {
  security_group_id = aws_security_group.sg.id

  cidr_ipv4   = local.ip_range_all
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "outgoing" {
  security_group_id = aws_security_group.sg.id

  cidr_ipv4   = local.ip_range_all
  from_port   = -1
  ip_protocol = "-1"
  to_port     = -1
}
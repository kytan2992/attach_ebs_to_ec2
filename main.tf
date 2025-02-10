locals {
  resource_prefix = "ky-tf"
  ip_range_all    = "0.0.0.0/0"
}

resource "aws_instance" "my_instance" {
  ami                         = data.aws_ami.ami_linux.id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.public_subnet.id
  associate_public_ip_address = true
  key_name                    = var.keypair
  vpc_security_group_ids      = [aws_security_group.sg.id]

  tags = {
    Name = "${local.resource_prefix}-ebs-ec2"
  }
}

resource "aws_ebs_volume" "my_volume" {
  availability_zone = aws_instance.my_instance.availability_zone
  type              = "gp3"
  size              = 1
  iops              = 3000
  throughput        = 125

  tags = {
    Name = "${local.resource_prefix}-ebs-volume"
  }
}

resource "aws_volume_attachment" "my_attachment" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.my_volume.id
  instance_id = aws_instance.my_instance.id
}
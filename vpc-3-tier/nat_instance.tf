locals {
  nat_instance_name = "com-web-ec2inst-natinstance"
}

data "aws_ssm_parameters_by_path" "com_web_subnet" {
  path = "/${var.project_code}/subnet/com/web"
  depends_on = [
    aws_ssm_parameter.web_subnets
  ]
}

resource "aws_instance" "nat" {
  instance_type = "t3.micro"
  ami           = data.aws_ami.nat.id
  subnet_id     = data.aws_ssm_parameters_by_path.com_web_subnet.values[0]
  security_groups = [
    aws_security_group.nat_instance.id
  ]

  associate_public_ip_address = true
  source_dest_check           = false

  tags = {
    Name = local.nat_instance_name
    Zone = "web"
  }

  lifecycle {
    ignore_changes = [security_groups]
  }
}

data "aws_ami" "nat" {
  most_recent = true
  name_regex  = "^amzn-ami-vpc-nat-2018.*"

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "image-type"
    values = ["machine"]
  }


  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

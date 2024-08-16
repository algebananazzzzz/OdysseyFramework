locals {
  nat_instance_sg_name                    = "com-web-sg-natinst"
  allow_traffic_from_nat_instance_sg_name = "com-app-sg-allownatinst"
}


resource "aws_security_group" "nat_instance" {
  name        = local.nat_instance_sg_name
  vpc_id      = aws_vpc.common.id
  description = "Allow inbound HTTP/HTTPS traffic from VPC subnets and IGW to nat instance"

  ingress {
    description = "Allow inbound HTTP traffic from VPC subnets"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.common.cidr_block]
  }

  ingress {
    description = "Allow inbound HTTPS traffic from VPC subnets"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.common.cidr_block]
  }

  ingress {
    description = "Allow inbound ICMP diagnostics from VPC subnets"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.common.cidr_block]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = local.nat_instance_sg_name
    Zone = "web"
  }
}

resource "aws_security_group" "allow_nat_instance" {
  name        = local.allow_traffic_from_nat_instance_sg_name
  vpc_id      = aws_vpc.common.id
  description = "Allow inbound HTTP/HTTPS traffic from NAT instance"

  ingress {
    description     = "Allow inbound HTTP traffic from NAT instance"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.nat_instance.id]
  }

  ingress {
    description     = "Allow inbound HTTPS traffic from NAT instance"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.nat_instance.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = local.allow_traffic_from_nat_instance_sg_name
    Zone = "app"
  }
}

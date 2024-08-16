resource "aws_ec2_instance_connect_endpoint" "instance_connect" {
  subnet_id          = data.aws_ssm_parameters_by_path.com_web_subnet.values[0]
  security_group_ids = [aws_security_group.nat_instance.id]
}

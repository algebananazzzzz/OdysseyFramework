variable "aws_region" {
  default = "ap-southeast-1"
}

variable "project_code" {
  default = "vpcsg"
}

variable "subnet_configuration_file" {
  type = string
}

variable "exclude_stg_environment" {
  type = bool
}

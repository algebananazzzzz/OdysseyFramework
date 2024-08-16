# Required Variables
# -------------------------
# The target region to which the resources will be deployed.
aws_region = "{{.GlobalConfig.Region}}"
# The code name of the project used for naming convention.
project_code = "{{.Code}}"
# The location of configuration file for subnet configuration
subnet_configuration_file = "config/vpc-config.json"

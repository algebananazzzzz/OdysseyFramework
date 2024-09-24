# Required Variables
# -------------------------
# The target region to which the resources will be deployed.
aws_region = "{{.GlobalConfig.Region}}"
# The target environment to which the resources will be deployed.
env = "{{.Env}}"
# The code name of the project used for naming convention.
project_code = "{{.Code}}"
# The location of the deployment package containing the Lambda code.
deployment_package_location = "../upload/build.zip"

# Custom Domain Configuration (Optional)
# --------------------------------------
# Specify these variables to create a custom domain mapping for the API gateway.

# The custom domain name for the API.
custom_domain_name = "prd.yourdomain.com"
# The domain name associated with the regional certificate.
regional_certificate_domain = "*.yourdomain.com"
# The name of the Route 53 hosted zone to create DNS record for custom domain name.
route53_zone_name = "yourdomain.com"

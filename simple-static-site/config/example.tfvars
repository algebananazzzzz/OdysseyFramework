# Required Variables
# -------------------------
# The target environment to which the resources will be deployed.
env = "prd"
# The code name of the project used for naming convention.
project_code = "{{.Code}}"

# Custom Domain Configuration (Optional)
# --------------------------------------
# Specify these variables to create a custom domain for the Cloudfront Distribution.

# The custom aliases for the cloudfront distribution.
custom_aliases = ["www.yourdomain.com", "yourdomain.com"]
# The domain name associated with the acm certificate.
acm_certificate_domain = "yourdomain.com"
# The name of the Route 53 hosted zone to create DNS record for custom domain name.
route53_zone_name = "yourdomain.com"

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.4.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>5.31.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.31.0 |
| <a name="provider_aws.us-east-1"></a> [aws.us-east-1](#provider\_aws.us-east-1) | 5.31.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront_s3_origin"></a> [cloudfront\_s3\_origin](#module\_cloudfront\_s3\_origin) | ../../modules/cloudfront_s3_origin | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_route53_zone.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_domain"></a> [acm\_certificate\_domain](#input\_acm\_certificate\_domain) | The domain name associated with the acm certificate. Specify this only if `custom_aliases` is specified. | `any` | `null` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region where resources will be deployed. | `string` | `"ap-southeast-1"` | no |
| <a name="input_custom_aliases"></a> [custom\_aliases](#input\_custom\_aliases) | The custom aliases for the cloudfront distribution. Specify this variable to use a custom domain with the cloudfront distribution. | `any` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | The target environment to which the resources will be deployed. | `any` | n/a | yes |
| <a name="input_project_code"></a> [project\_code](#input\_project\_code) | The code name of the project used for naming convention. | `any` | n/a | yes |
| <a name="input_route53_zone_name"></a> [route53\_zone\_name](#input\_route53\_zone\_name) | The name of the Route 53 hosted zone to create DNS record for custom domain name(s). Specify this only if `custom_aliases` is specified. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_origin_bucket_name"></a> [origin\_bucket\_name](#output\_origin\_bucket\_name) | n/a |

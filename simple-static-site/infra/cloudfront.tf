locals {
  use_custom_aliases = var.custom_aliases != null
  origin_bucket_name = "${var.env}-app-s3-${var.project_code}"
}

resource "aws_s3_bucket" "origin" {
  bucket = var.origin_bucket_name
}

module "cloudfront_s3_origin" {
  source = "../../modules/cloudfront_s3_origin"
  origin_bucket_use_existing = {
    arn                         = aws_s3_bucket.origin.arn
    bucket_regional_domain_name = aws_s3_bucket.origin.bucket_regional_domain_name
    create_bucket_policy        = true
    id                          = aws_s3_bucket.origin.id
  }

  cloudfront_aliases = var.custom_aliases
  cloudfront_viewer_certificate = local.use_custom_aliases ? {
    acm_certificate_arn = data.aws_acm_certificate.this[0].arn
    ssl_support_method  = "sni-only"
  } : null
  route53_create_records = local.use_custom_aliases ? true : false
  route53_zone_id        = local.use_custom_aliases ? data.aws_route53_zone.public[0].id : null
}

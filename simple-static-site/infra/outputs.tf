output "origin_bucket_name" {
  value = module.cloudfront_s3_origin.new_bucket.bucket
}

output "site_domain_name" {
  value = module.cloudfront_s3_origin.domain_name
}

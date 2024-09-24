output "function_name" {
  value = module.lambda_function.function.function_name
}

output "function_arn" {
  value = module.lambda_function.function.arn
}

output "api_default_stage_invoke_url" {
  value = module.api.stage.invoke_url
}

output "domain_name" {
  value = local.use_custom_domain ? module.api_domain_integration[0].record.name : null
}

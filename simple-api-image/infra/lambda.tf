locals {
  execution_role_name = "${var.env}-mgmt-iamrole-${var.project_code}"
}


module "function_execution_role" {
  source = "../../modules/iam_role"
  name   = local.execution_role_name
  policy_attachments = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}

module "lambda_function" {
  source             = "../../modules/lambda_function"
  function_name      = var.function_name
  execution_role_arn = module.function_execution_role.role.arn
  deployment_package = {
    image_uri = var.ecr_image_uri
  }
  ignore_deployment_package_changes = true
  handler                           = "lambda_function.lambda_handler"
}

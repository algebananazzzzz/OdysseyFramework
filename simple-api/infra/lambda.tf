locals {
  execution_role_name = "${var.env}-mgmt-iamrole-${var.project_code}"
  function_name       = "${var.env}-app-func-${var.project_code}"
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
  function_name      = local.function_name
  execution_role_arn = module.function_execution_role.role.arn
  deployment_package = {
    filename = "${path.module}/${var.deployment_package_location}"
  }
  runtime = "provided.al2"
  handler = "bootstrap"
}

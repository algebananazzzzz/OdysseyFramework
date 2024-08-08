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
    filename = "${path.module}/${var.deployment_package_location}"
  }
  ignore_deployment_package_changes = true
  runtime                           = "python3.12"
  handler                           = "lambda_function.lambda_handler"
}

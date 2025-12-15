module "dynamodb" {
  source = "../../modules/dynamodb"
  env    = var.env
  tags   = local.common_tags
}

module "iam" {
  source       = "../../modules/iam"
  env          = var.env
  dynamodb_arn = module.dynamodb.arn
  tags         = local.common_tags
}

module "lambda" {
  source     = "../../modules/lambda"
  env        = var.env
  role_arn   = module.iam.role_arn
  table_name = module.dynamodb.name
  package    = "../../lambda/lambda.zip"
  tags       = local.common_tags
}
module "lambda_logs" {
  source        = "../../modules/cloudwatch_log_group"
  function_name = module.lambda.name
  env           = var.env
  tags          = local.common_tags
}
module "api" {
  source            = "../../modules/apigateway"
  env               = var.env
  lambda_invoke_arn = module.lambda.invoke_arn
  lambda_name       = module.lambda.name
  tags              = local.common_tags
}

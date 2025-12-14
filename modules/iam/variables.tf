variable "env" {
  type        = string
  description = "Deployment environment (e.g. staging, prod)"
}

variable "app_name" {
  type        = string
  description = "Application name"
}

variable "dynamodb_arn" {
  type        = string
  description = "ARN of the DynamoDB table"
}

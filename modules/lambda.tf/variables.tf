
variable "env" {
  description = "Deployment environment"
  type        = string
}

variable "role_arn" {
  description = "IAM role ARN for the Lambda function"
  type        = string
}

variable "table_name" {
  description = "DynamoDB table name"
  type        = string
}

variable "package" {
  description = "Path to Lambda deployment package"
  type        = string
}

variable "tags" {
  description = "Tags to apply to Lambda resources"
  type        = map(string)
  default     = {}
}

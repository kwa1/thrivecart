variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "env" {
  description = "Deployment environment"
  type        = string
}

variable "tags" {
  description = "Map of tags to apply to the resource"
  type        = map(string)
  default     = {}
}

variable "env" {
  description = "Deployment environment"
  type        = string
}

variable "tags" {
  description = "Map of tags to apply to the DynamoDB table"
  type        = map(string)
  default     = {}
}

variable "table_name_suffix" {
  description = "Optional suffix for the table name"
  type        = string
  default     = "requests-db"
}

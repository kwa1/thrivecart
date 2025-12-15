variable "env" {
  description = "Deployment environment"
  type        = string
  default     = "staging"

  validation {
    condition     = contains(["staging", "production", "dev"], var.env)
    error_message = "Environment must be one of: staging, production, dev."
  }
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

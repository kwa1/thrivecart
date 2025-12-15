# Define common tags
locals {
  common_tags = {
    Environment = var.env
    Application = var.app_name
  }
}

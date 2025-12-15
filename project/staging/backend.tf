terraform {
  backend "s3" {
    bucket         = "thrivecart-terraform-state-bucket"
    key            = "staging/terraform.tfstate"   # You can change to workspaces or .tfvars per env
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

# Thrivecart
##########################################################################################
# Thrivecart – Thrive Application
# Serverless Health Check API with Terraform & CI/CD
############################################################################################
This repository contains a production-ready, AWS serverless project for the Thrivecart platform. The application, named Thrive, 
exposes a /health endpoint that logs incoming requests and persists them to DynamoDB. All infrastructure is managed using Terraform,
and deployments are automated using GitHub Actions with environment-based promotion and manual approval for production.

# High-Level Architecture

API Gateway (HTTP API) exposes /health

AWS Lambda (Python) processes requests

Amazon DynamoDB stores request payloads

Terraform defines and manages all infrastructure

GitHub Actions automates CI/CD

Staging deploys automatically

Production deploys only after manual approval

# Repository Structure

The repository is intentionally segmented by environment to ensure strict isolation and safe deployments.

.
├── staging/
│   ├── backend.tf
│   ├── main.tf
│   └── terraform.tfvars
├── production/
│   ├── backend.tf
│   ├── main.tf
│   └── terraform.tfvars
├── modules/
│   ├── dynamodb/
│   ├── iam/
│   ├── lambda/
│   └── apigateway/
├── lambda/
│   └── app.py
├── .github/workflows/
│   └── deploy.yml
└── README.md
Naming Convention

# All AWS resources follow a strict naming convention:

<environment>-thrive-<resource-name>

Examples:

staging-thrive-health-check

prod-thrive-health-api

staging-thrive-requests-db

This ensures clarity, cost attribution, and operational visibility.

# Terraform Design
# Modular Infrastructure

Terraform is structured using reusable modules:

dynamodb – Request persistence

iam – Least-privilege Lambda execution role

lambda – Versioned Lambda function with aliases

apigateway – HTTP API and routing

Each environment composes these modules independently.

# Remote State

Terraform state is stored remotely using:

S3 for state storage (encrypted)

DynamoDB for state locking

Each environment uses a separate state file:

staging/terraform.tfstate
production/terraform.tfstate
Lambda Function Behavior

# When the /health endpoint is invoked, the Lambda function:

Logs the full request event to CloudWatch

Generates a unique request ID

Stores the request payload in DynamoDB

Returns a 200 OK response

Sample Response
{
  "status": "healthy",
  "message": "Request processed and saved."
}

# CI/CD Pipeline (GitHub Actions)
# Pipeline Overview

# The CI/CD pipeline is fully automated and environment-aware:

Triggered on push to main

Lambda function is packaged automatically

Terraform deploys staging environment

Production deployment waits for manual approval

Terraform deploys production environment

# Lambda Packaging & Versioning

Lambda is zipped during CI

source_code_hash ensures updates only when code changes

publish = true creates immutable Lambda versions

Environment-based Lambda aliases (staging, prod) are used

# Manual Approval for Production

Production deployments are protected using GitHub Environments:

The prod environment requires reviewer approval

CI/CD cannot proceed without explicit human approval

This enforces safe promotion from staging to production

# Prerequisites

To run or deploy this project, you need:

An AWS account

An IAM user or role with permissions for:

Lambda

API Gateway

DynamoDB

IAM

S3 (Terraform state)

DynamoDB (Terraform locks)

Terraform >= 1.5

GitHub repository secrets:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

Local Deployment (Optional)

Deploy the staging environment locally:

cd staging
terraform init
terraform apply
Testing the API

After deployment, test the endpoint:

curl https://<api-id>.execute-api.eu-west-1.amazonaws.com/health
Design Decisions & Assumptions

HTTP API Gateway was chosen for simplicity and cost efficiency

Environment folders were preferred over workspaces for safety

Least-privilege IAM limits blast radius

Immutable Lambda versions enable safe rollbacks

Manual production approval aligns with real-world governance

Final Notes

This repository reflects real-world AWS DevOps best practices and is intentionally designed to demonstrate senior-level capability in:

Infrastructure as Code

CI/CD automation

Environment isolation

Security and governance

Maintainable Terraform design

Project: Thrivecart
Application: Thrive

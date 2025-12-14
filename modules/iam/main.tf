
# IAM Role for Lambda with inline policy
resource "aws_iam_role" "lambda" {
  name = "${var.env}-${var.app_name}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = local.common_tags

  inline_policy {
    name = "${var.env}-${var.app_name}-lambda-inline-policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = "Allow"
          Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
          Resource = "*"
        },
        {
          Effect   = "Allow"
          Action   = ["dynamodb:PutItem"]
          Resource = var.dynamodb_arn
        }
      ]
    })
  }
}




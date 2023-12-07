terraform {
  required_version = "1.6.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.29.0"
    }
  }

  backend "s3" {
    bucket = "674283423467-terraform-state"
    key    = "arithmetic-lambda"
    region = "eu-north-1"
  }
}

provider "aws" {
  allowed_account_ids = ["674283423467"]
  region              = "eu-north-1"

  default_tags {
    tags = {
      application = "arithmetic-lambda"
      terraform   = true
    }
  }
}

locals {
  application_name          = "arithmetic-lambda"
  lambda_artifact_file_name = "lambda-artifact.zip"
}

resource "aws_lambda_function" "this" {
  function_name    = "arithmetic"
  filename         = local.lambda_artifact_file_name
  role             = aws_iam_role.this.arn
  runtime          = "nodejs20.x"
  handler          = "index.handler"
  source_code_hash = data.archive_file.this.output_base64sha256
}

resource "aws_lambda_function_url" "this" {
  function_name      = aws_lambda_function.this.function_name
  authorization_type = "NONE"
}

data "archive_file" "this" {
  type        = "zip"
  source_file = "${path.module}/../index.js"
  output_path = local.lambda_artifact_file_name
}

resource "aws_iam_role" "this" {
  name               = local.application_name
  assume_role_policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = data.aws_iam_policy.lambda_basic_execution_role.arn
}

data "aws_iam_policy" "lambda_basic_execution_role" {
  name = "AWSLambdaBasicExecutionRole"
}

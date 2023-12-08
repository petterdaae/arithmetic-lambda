locals {
  lambda_artifact_file_name = "lambda-artifact.zip"
}

resource "aws_lambda_function" "this" {
  function_name    = "arithmetic"
  filename         = local.lambda_artifact_file_name
  role             = aws_iam_role.lambda_execution.arn
  runtime          = "nodejs20.x"
  handler          = "lambda.handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
}

resource "aws_lambda_function_url" "this" {
  function_name      = aws_lambda_function.this.function_name
  authorization_type = "NONE"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/../lambda.js"
  output_path = local.lambda_artifact_file_name
}

resource "aws_iam_role" "lambda_execution" {
  name               = "arithmetic-lambda-execution"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_execution.name
  policy_arn = data.aws_iam_policy.lambda_basic_execution_role.arn
}

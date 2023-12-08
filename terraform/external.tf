data "aws_iam_policy" "lambda_basic_execution_role" {
  name = "AWSLambdaBasicExecutionRole"
}

data "aws_cloudfront_cache_policy" "caching_disabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_origin_request_policy" "all_viewer" {
  name = "Managed-AllViewer"
}

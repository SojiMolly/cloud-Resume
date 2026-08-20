resource "aws_dynamodb_table" "visitor_count" {
  name         = "resume-visitor-count"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_lambda_function" "visitor_counter" {
  function_name = "resume-visitor-counter"

  role = "arn:aws:iam::253490748362:role/service-role/resume-visitor-counter-role-3twbkc41"

  runtime       = "python3.14"
  handler       = "lambda_function.lambda_handler"
  architectures = ["x86_64"]

  filename         = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")

  memory_size = 128
  timeout     = 3
}

resource "aws_api_gateway_rest_api" "visitor_api" {
  name = "resume-visitor-api"
}

resource "aws_s3_bucket" "resume" {
  bucket = "soji-cloudresume-2026"
}

resource "aws_cloudfront_distribution" "resume" {
  enabled             = true
  default_root_object = "index.html"
  is_ipv6_enabled     = true

  origin {
    domain_name = "soji-cloudresume-2026.s3.us-east-1.amazonaws.com"
    origin_id   = "soji-cloudresume-2026.s3.us-east-1.amazonaws.com-mszy3iggqvk"

    origin_access_control_id = "E2PF9UG5XW8UST"
  }
  default_cache_behavior {
    target_origin_id       = "soji-cloudresume-2026.s3.us-east-1.amazonaws.com-mszy3iggqvk"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    allowed_methods = [
      "GET",
      "HEAD",
    ]

    cached_methods = [
      "GET",
      "HEAD",
    ]

    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  web_acl_id = "arn:aws:wafv2:us-east-1:253490748362:global/webacl/CreatedByCloudFront-8e57295c/37b549da-4b36-4fcb-bb68-32ca5a1fed6e"

  tags = {
    Name = "soji-cloud-resume"
  }
}

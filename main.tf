resource "aws_dynamodb_table" "visitor_count" {
  name = "resume-visitor-count"

  # We will fill in the remaining configuration after importing.
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
resource "aws_lambda_function" "visitor_counter" {
  function_name = "resume-visitor-counter"

  role = "arn:aws:iam::253490748362:role/service-role/resume-visitor-counter-role-3twbkc41"

  runtime = "python3.14"
  handler = "lambda_function.lambda_handler"

  architectures = ["x86_64"]

  filename         = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")

  memory_size = 128
  timeout     = 3
}
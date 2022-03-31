resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "webhook_lambda" {
  # filename      = "lambda_function_payload.zip"
  function_name = "miaomiaochatbot_webhook"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"

  # source_code_hash = filebase64sha256("lambda_function_payload.zip")

  runtime = "go1.x"

  environment {
    variables = {
      BOT_API_TOKEN = var.bot_api_token
    }
  }
}

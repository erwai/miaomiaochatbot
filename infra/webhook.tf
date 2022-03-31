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

data "archive_file" "webhook_zip" {
  type        = "zip"
  source_file = "../webhook/dist/main"
  output_path = "dist/lambda_function.zip"
}

resource "aws_lambda_function" "webhook_lambda" {
  filename      = "dist/lambda_function.zip"
  function_name = "miaomiaochatbot_webhook"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "main"

  source_code_hash = data.archive_file.webhook_zip.output_base64sha256

  runtime = "go1.x"

  environment {
    variables = {
      BOT_API_TOKEN = var.bot_api_token
    }
  }
}

output "webhook_lambda_arn" {
  value = aws_lambda_function.webhook_lambda.arn
}

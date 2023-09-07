
data "aws_iam_policy_document" "m-lambda" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole", "dynamodb:*"]
  }
}

resource "aws_iam_role" "LambdaIAM" {
  name               = "LambdaIAM"
  assume_role_policy = data.aws_iam_policy_document.m-lambda.json
}

variable "PayloadName" {
  default = "Payload.zip"
}

variable "FileName" {
  default = "LambdaFunction"
}

variable "Function" {
  default = "Execute"
}

data "archive_file" "Archive" {
  type        = "zip"
  source_file = "Source/Python/${var.FileName}.py"
  output_path = var.PayloadName
}

resource "aws_lambda_function" "m" {
  function_name = "IncrementVisitorMetric"
  filename      = var.PayloadName
  role          = aws_iam_role.LambdaIAM.arn

  source_code_hash = data.archive_file.Archive.output_base64sha256

  handler = "${var.FileName}.${var.Function}"
  runtime = "python3.9"
}
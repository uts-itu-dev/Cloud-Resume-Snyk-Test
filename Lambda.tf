
data "aws_iam_policy_document" "m" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "LambdaIAM" {
  name               = "IAM for Lambda"
  assume_role_policy = data.aws_iam_policy_document.m.json
}

variable "PayloadName" {
  default = "Payload.zip"
}

data "SourceArchive" "Archive" {
  type        = "zip"
  source_file = "Source/Python/LambdaFunction.py"
  output_path = var.PayloadName
}

resource "aws_lambda_function" "m" {
  function_name = "IncrementVisitorMetric"
  filename      = var.PayloadName
  role          = aws_iam_role.LambdaIAM.arn

  source_code_hash = data.SourceArchive.lambda.output_base64sha256

  runtime = "python3.11"
}
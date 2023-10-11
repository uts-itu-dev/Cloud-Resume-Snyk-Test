
data "aws_iam_policy_document" "m-lambda" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "m-lambda-dynamodb" {
  statement {
    effect    = "Allow"
    actions   = ["dynamodb:*"]
    resources = ["*"]
  }
}

resource "aws_iam_role" "LambdaIAM" {
  name               = "LambdaIAM"
  assume_role_policy = data.aws_iam_policy_document.m-lambda.json

  inline_policy {
    name   = "Lambda-DynamoDB"
    policy = data.aws_iam_policy_document.m-lambda-dynamodb.json
  }
}

variable "PayloadName" {
  default = "Payload.zip"
}

variable "FileName" {
  default = "GetMetric"
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

  environment {
    variables = {
      SECRET_DEPLOY_KEY = "sd8fn<3#_SDF_IM)#SDFN$#{}S:DFSD>?F<?>#<se"
      SECRET_API_KEY = "a9nsdy9sndyf9DS__9ndysf-9sNF_Ndf-s97fn_DNF"
      SECRET_URL = "https://secretutsdatabase.com/"
      SECRET_USERNAME = "WichaelMu"
      SECRET_PASSWORD = "WichaelMu's Very Secure #Password"
    }
  }
}

resource "aws_lambda_function_url" "m" {
  function_name      = aws_lambda_function.m.arn
  authorization_type = "NONE"

  cors {
    allow_methods = ["GET", "POST"]
    allow_origins = ["https://${var.R53DomainName}", "https://www.${var.R53DomainName}"]
  }
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.m.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

resource "aws_api_gateway_rest_api" "api" {
  name        = "ServerlessCount"
  description = "Terraform made api gateway for count user lambda function"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_resource.proxy.id}"
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  resource_id = "${aws_api_gateway_method.proxy.resource_id}"
  http_method = "${aws_api_gateway_method.proxy.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.m.invoke_arn}"
}

resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  resource_id = "${aws_api_gateway_method.proxy_root.resource_id}"
  http_method = "${aws_api_gateway_method.proxy_root.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.m.invoke_arn}"
}

resource "aws_api_gateway_deployment" "example" {
  depends_on = [
    "aws_api_gateway_integration.lambda",
    "aws_api_gateway_integration.lambda_root",
  ]

  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name  = "test"
}

resource "aws_apigatewayv2_api" "v2api" {
  name = "MJ-http-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_methods = ["GET", "POST"]
    allow_origins = ["https://${var.R53DomainName}", "https://www.${var.R53DomainName}"]
  }
}
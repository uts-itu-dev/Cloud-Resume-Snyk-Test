data "aws_iam_policy_document" "snyk" {
  statement {
    sid = "1"

    actions = [
      "sts:AssumeRole",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "snyk" {
  name   = "Policy-Snyk"
  path   = "/"
  policy = data.aws_iam_policy_document.snyk.json
}
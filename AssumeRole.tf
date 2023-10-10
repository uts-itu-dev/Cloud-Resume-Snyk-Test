

resource "aws_iam_policy" "snyk" {
  name   = "Policy-Snyk"
  path   = "/"
  policy = <<__TERMINATE__
{
"Version": "2012-10-17",
"Statement": [
        {
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
                "sts:AssumeRole"
        ],
        "Resource": [
                "*"
        ]
        }
]
}
    __TERMINATE__
}

resource "aws_iam_policy" "snyk-2" {
  name   = "Policy-Snyk"
  path   = "/"
  policy = jsonencode({
        actions = ["sts:AssumeRole"]
        resources = ["*"]
  })
}
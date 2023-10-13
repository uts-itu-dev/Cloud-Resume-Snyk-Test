resource "aws_ecr_repository" "m_inline" {
  name = "m_ecr_inline"
}

resource "aws_ecr_repository_policy" "ecr_inline" {
  repository = aws_ecr_repository.m_inline.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "new policy",
            "Effect": "Allow",
            "Principal": {
              "AWS": "arn:aws:iam::*"
            },
            "Action": [
                "ecr:ListImages"
            ]
        }
    ]
}
EOF
}

resource "aws_ecr_repository" "m_external" {
  name = "m_ecr_external"
}

resource "aws_ecr_repository_policy" "ecr_external" {
  repository = aws_ecr_repository.m_external.name

  policy = file("ECRPolicy.json")
}
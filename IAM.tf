

provider "aws" {
  alias   = "Source"
  profile = "Source"
  region  = "ap-southeast-2"
}

provider "aws" {
  alias   = "Destination"
  profile = "Destination"
  region  = "ap-southeast-2"
}

data "aws_caller_identity" "Source" {
  provider = aws.Source
}

data "aws_iam_policy_document" "AR" {
  provider = aws.Destination
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::*"]
    }
  }
}

data "aws_iam_policy" "EC2" {
  provider = aws.Destination
  name     = "AmazonEC2FullAccess"
}

resource "aws_iam_role" "AR" {
  provider            = aws.Destination
  name                = "AR"
  assume_role_policy  = data.aws_iam_policy_document.AR.json
  managed_policy_arns = [data.aws_iam_policy.EC2.arn]
}

resource "aws_iam_account_password_policy" "Lenient" {
  require_lowercase_characters   = false
  require_numbers                = false
  require_uppercase_characters   = false
  require_symbols                = false
  allow_users_to_change_password = false
}

data "aws_iam_policy_document" "m_wildcard" {
  statement {
    effect = "Allow"
    actions = [
      "s3:*",
    ]
  }
}

data "aws_iam_policy_document" "AllActions" {
  provider = aws.Destination
  statement {
    actions = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::*"]
    }
  }
}

data "aws_iam_policy_document" "AllIdentifiers" {
  provider = aws.Destination
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

data "aws_iam_policy_document" "Unrestricted" {
  provider = aws.Destination
  statement {
    actions = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

data "aws_iam_policy_document" "AnyoneInAccount" {
  provider = aws.Destination
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::796770149148:role/*"]
    }
  }
}
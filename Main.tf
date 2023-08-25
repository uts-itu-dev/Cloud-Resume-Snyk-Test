

resource "aws_s3_bucket" "b" {
  bucket = "terror-mw"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "blocks" {
  bucket = aws_s3_bucket.b.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "m" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.b.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.m.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "m" {
  bucket = aws_s3_bucket.b.id
  policy = data.aws_iam_policy_document.m.json
}
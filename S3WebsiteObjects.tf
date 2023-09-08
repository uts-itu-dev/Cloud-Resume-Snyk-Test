# S3 Bucket is defined in main.tf

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.b.id
  key          = "index.html"
  source       = "Source/index.html"
  etag         = filemd5("Source/index.html")
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.b.id
  key          = "error.html"
  source       = "Source/error.html"
  etag         = filemd5("Source/error.html")
  content_type = "text/html"
}

resource "aws_s3_object" "JavaScript" {
  bucket       = aws_s3_bucket.b.id
  key          = "error.html"
  source       = "Source/error.html"
  etag         = filemd5("Source/JavaScript/Metrics.js")
  content_type = "text/javascript"
}
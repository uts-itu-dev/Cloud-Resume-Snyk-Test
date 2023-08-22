# S3 Bucket is defined in main.tf

resource "aws_s3_bucket_website_configuration" "m" {
  bucket = aws_s3_bucket.b.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.b.id
  key    = "index.html"
  source = "Source/index.html"
  etag   = filemd5("Source/index.html")
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.b.id
  key    = "error.html"
  source = "Source/error.html"
  etag   = filemd5("Source/error.html")
}
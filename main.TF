

resource "aws_s3_bucket" "b" {
    bucket = "terror-mw"
    acl = "private"
}
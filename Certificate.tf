

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

resource "aws_acm_certificate" "m" {
  provider = aws.virginia

  domain_name       = var.R53DomainName
  validation_method = "DNS"

  subject_alternative_names = ["*.${var.R53DomainName}"]

  key_algorithm = "RSA_2048"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Certificate for ${var.R53DomainName}.",
    Misc = "Made with Terraform."
  }
}
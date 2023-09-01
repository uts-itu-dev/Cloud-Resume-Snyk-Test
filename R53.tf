# This R53 Hosted Zone was automatically created with the registration
# of WichaelMu.com.

data "aws_route53_zone" "m" {
  name = var.R53DomainName
}
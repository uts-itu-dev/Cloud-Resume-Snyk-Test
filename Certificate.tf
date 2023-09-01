module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name = var.R53DomainName

  subject_alternative_names = [
    "*.${var.R53DomainName}",
  ]

  wait_for_validation = true
  create_route53_records = true

  tags = {
    Name = "Certificate for ${var.R53DomainName}.",
    Misc = "Made with Terraform."
  }
}
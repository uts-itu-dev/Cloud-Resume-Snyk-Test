module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name  = "${var.R53DomainName}"
  zone_id      = "${var.R53ZoneID}"

  subject_alternative_names = [
    "*.${var.R53DomainName}",
  ]

  wait_for_validation = true

  tags = {
    Name = "Certificate for ${var.R53DomainName}.",
    Misc = "Made with Terraform."
  }
}
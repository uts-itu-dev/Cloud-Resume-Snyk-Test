

provider "aws" {
    region = "ap-southeast-2"

    assume_role {
        role_arn = "arn:aws:iam::350357692482:role/GH-A"
        session_name = "Cloud-Resume"
        external_id = "WichaelMu@github"
    }
}

terraform {
    required_version = ">= 1.0.0,< 2.0.0"

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "-> 4.0"
        }
    }

    backend "s3" {
        bucket = "arn:aws:s3:::terror-aws-mw-cloudresume"
        key = "terraform.tfstate"
        region = "ap-southeast-2"
        encrypt = true
        # dynamodb_table = "terraform-locks"
        # role_arn = "arn:aws:iam::350357692482:role/GH-A"
    }
}
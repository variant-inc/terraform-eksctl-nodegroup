
terraform {
  required_version = ">=1.0.0"
  required_providers {
    eksctl = {
      source  = "mumoshu/eksctl"
      version = "0.16.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

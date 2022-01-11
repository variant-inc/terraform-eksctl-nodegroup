
terraform {
  required_version = ">=1.0.0"
  required_providers {
    eksctl = {
      source  = "mumoshu/eksctl"
      version = "0.16.2"
    }
  }
}

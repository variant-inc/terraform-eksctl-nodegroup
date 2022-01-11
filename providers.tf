provider "eksctl" {
}

provider "aws" {
  profile = "dpl"
  region = "us-east-1"
}
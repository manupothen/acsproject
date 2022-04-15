terraform {
  backend "s3" {
    bucket = "staging-acsproject"
    key    = "staging-network/terraform.tfstate"
    region = "us-east-1"
  }
}

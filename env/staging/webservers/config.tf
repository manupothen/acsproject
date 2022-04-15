terraform {
  backend "s3" {
    bucket = "staging-acsproject"
    key    = "staging-project/terraform.tfstate"
    region = "us-east-1"
  }
}

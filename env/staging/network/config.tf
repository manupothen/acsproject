terraform {
  backend "s3" {
    bucket = "staging-acsproject-group25"
    key    = "staging-network/terraform.tfstate"
    region = "us-east-1"
  }
}

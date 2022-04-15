terraform {
  backend "s3" {
    bucket = "staging-acsproject-group25"
    key    = "staging-project/terraform.tfstate"
    region = "us-east-1"
  }
}

terraform {
  backend "s3" {
    bucket = "prod-acsproject-group25"
    key    = "prod-network/terraform.tfstate"
    region = "us-east-1"
  }
}

terraform {
  backend "s3" {
    bucket = "dev-acsproject-group25"
    key    = "dev-network/terraform.tfstate"
    region = "us-east-1"
  }
}

terraform {
  backend "s3" {
    bucket = "prod-acsproject"
    key    = "prod-network/terraform.tfstate"
    region = "us-east-1"
  }
}

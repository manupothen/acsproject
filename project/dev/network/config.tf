terraform {
  backend "s3" {
    bucket = "dev-acsproject"
    key    = "dev-network/terraform.tfstate"
    region = "us-east-1"
  }
}

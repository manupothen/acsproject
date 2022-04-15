terraform {
  backend "s3" {
    bucket = "prod-acsproject"
    key    = "prod-project/terraform.tfstate"
    region = "us-east-1"
  }
}

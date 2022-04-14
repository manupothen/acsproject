terraform {
  backend "s3" {
    bucket = "dev-acsproject"
    key    = "dev-project/terraform.tfstate"
    region = "us-east-1"
  }
}

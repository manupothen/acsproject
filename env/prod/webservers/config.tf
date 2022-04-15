terraform {
  backend "s3" {
    bucket = "prod-acsproject-group25"
    key    = "prod-project/terraform.tfstate"
    region = "us-east-1"
  }
}

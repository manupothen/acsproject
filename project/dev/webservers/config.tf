terraform {
  backend "s3" {
    bucket = "dev-acsproject-group25"
    key    = "dev-project/terraform.tfstate"
    region = "us-east-1"
  }
}

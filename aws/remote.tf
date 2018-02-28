terraform {
  backend "s3" {
    bucket = "acobaugh-dev-tfstate"
    key    = "dev/terraform.tfstate"
    region = "us-east-2"
  }
}

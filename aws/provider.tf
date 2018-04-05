# AWS provider settings. Most of these will be back-filled by terragrunt.

terraform {
  backend "s3" {}
}

variable "region" {}

provider "aws" {
  region = "${var.region}"
}

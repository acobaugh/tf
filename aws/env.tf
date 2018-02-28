## Providers for DEV
provider "aws" {
  region = "${var.region}"
}

## Environment vars for DEV
variable "region" {
  default = "us-east-2"
}

variable "env" {
  default = "dev"
}

variable "bucket_prefix" {
  default = "acobaugh-dev"
}

variable "route53_zone_id" {
  default = "Z2BTYN2R4K3E67"
}

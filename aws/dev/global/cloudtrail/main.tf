variable "s3_bucket_prefix" {}
variable "account_name" {}

module "cloudtrail" {
  source = "git::github.com/acobaugh/tf-aws-cloudtrail"

  s3_bucket_name = "${var.s3_bucket_prefix}-cloudtrail"
	region = "${var.region}"

  glacier_transition_days = 7
  expiration_days         = 90

  tags = {
    Terraform = true
  }
}

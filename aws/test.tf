resource "aws_s3_bucket" "k8s-dev-config" {
  bucket = "${var.bucket_prefix}-k8s-dev-config"
	acl = "private"
	tags {
		Environment = "${var.env}"
		Terraform = true
	}
}

module "k8s" {
  source = "/home/acobaugh/code.d/tf-k8s-aws"

  cluster_name = "k8s-dev"
  cluster_fqdn = "k8s-dev.aws.cobaugh.io"

  vpc_id           = "${module.vpc.vpc_id}"
  vpc_ig_id        = "${module.vpc.igw_id}"
  vpc_subnet_cidrs = ["10.0.253.0/24", "10.0.254.0/24", "10.0.255.0/24"]
	azs = [ "us-east-2a", "us-east-2b", "us-east-2c" ]

  config_s3_bucket = "${aws_s3_bucket.k8s-dev-config.id}"

  route53_zone_id = "${var.route53_zone_id}"
}

resource "aws_s3_bucket" "k8s-dev-config" {
  bucket = "${var.bucket_prefix}-k8s-dev-config"
	acl = "private"
	tags {
		Environment = "${var.env}"
		Terraform = true
	}
}

module "k8s" {
  source = "../../tf-k8s-aws"

  cluster_name = "k8s-dev"
  cluster_fqdn = "k8s-dev.aws.cobaugh.io"

  vpc_id           = "${module.vpc.vpc_id}"
  vpc_ig_id        = "${module.vpc.igw_id}"
  vpc_subnet_cidrs = ["10.0.253.0/24", "10.0.254.0/24", "10.0.255.0/24"]
	azs = [ "us-east-2a", "us-east-2b", "us-east-2c" ]

  config_s3_bucket = "${aws_s3_bucket.k8s-dev-config.id}"

  route53_zone_id = "${var.route53_zone_id}"

	ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC42lZedNWOZF2EXouJVzZ4kolnsW/9gi10KZITWGnw9f32Pq7Z7GjPLoy21FdLZhyROjSom4CoP6/fN408TzDHqtAkmBCsFPsg2ozUBPcdm3tDOT10M+F5KphGUDn1zGCwKR9px57Y6Us/XGxC3Iy2QCVKQomeE96MCXpmUZDRMrvUC9mJyvKbP2DUTADhSqsgnY6hCLMwT74u7pNf6IYL6/bDxK/6dICvZFL3LGv3ckmS4AcT8Xq6uGgMSyVVdYE/JBRcQF5/bsXBUZl5jeGeGjvCN3VYCexbXESGuaS3VIRzuPUuJivxFtBLZVKyjBImT5vz+oN9DlDwBwa46Ul5 phalenor@zirzla"

}

resource "aws_s3_bucket" "k8s-dev-config" {
  bucket = "${var.bucket_prefix}-k8s-dev-config"
  acl    = "private"

  tags {
    Terraform   = true
  }
}

module "k8s" {
  source = "/home/acobaugh/code.d/tf-aws-k8s"

  cluster_name = "k8s-dev"
  cluster_fqdn = "k8s-dev.aws.cobaugh.io"

  pod_cidr     = "10.128.0.0/18"
  service_cidr = "10.128.64.0/18"

  vpc_id           = "${module.vpc.vpc_id}"
  vpc_ig_id        = "${module.vpc.igw_id}"
  vpc_subnet_cidrs = ["10.0.253.0/24", "10.0.254.0/24", "10.0.255.0/24"]
  azs              = ["us-east-2a", "us-east-2b", "us-east-2c"]

  vpc_ipv6_cidr_block = "${module.vpc.vpc_ipv6_cidr_block}"
  ipv6_subnet_offset  = 100

  config_s3_bucket = "${aws_s3_bucket.k8s-dev-config.id}"

  route53_zone_id = "${var.route53_zone_id}"

  ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC42lZedNWOZF2EXouJVzZ4kolnsW/9gi10KZITWGnw9f32Pq7Z7GjPLoy21FdLZhyROjSom4CoP6/fN408TzDHqtAkmBCsFPsg2ozUBPcdm3tDOT10M+F5KphGUDn1zGCwKR9px57Y6Us/XGxC3Iy2QCVKQomeE96MCXpmUZDRMrvUC9mJyvKbP2DUTADhSqsgnY6hCLMwT74u7pNf6IYL6/bDxK/6dICvZFL3LGv3ckmS4AcT8Xq6uGgMSyVVdYE/JBRcQF5/bsXBUZl5jeGeGjvCN3VYCexbXESGuaS3VIRzuPUuJivxFtBLZVKyjBImT5vz+oN9DlDwBwa46Ul5 phalenor@zirzla"
}

output "user-kubeconfig" {
  value = "${module.k8s.user-kubeconfig}"
}

output "cluster_name" {
  value = "${module.k8s.cluster_name}"
}

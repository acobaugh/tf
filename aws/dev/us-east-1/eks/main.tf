locals {
  cluster_name = "test"
}

module "vpc" {
  source = "git::https://github.com/acobaugh/terraform-aws-vpc.git?ref=feature/ipv6"

  name = "k8s-dev"
  cidr = "10.1.0.0/16"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = ["10.1.128.0/24", "10.1.129.0/24", "10.1.130.0/24"]
  public_subnets  = ["10.1.0.0/24", "10.1.1.0/24", "10.1.2.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true

  tags = {
    Terraform                                     = "true"
    Environment                                   = "dev"
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = "${local.cluster_name}"
  subnets      = "${module.vpc.public_subnets}"

  tags = {
    Environment = "dev"
    Terraform = true
  }

  vpc_id = "${module.vpc.vpc_id}"
}

output "kubeconfig" {
  value = "${module.eks.kubeconfig}"
}

output "cluster_id" {
  value = "${module.eks.cluster_id}"
}

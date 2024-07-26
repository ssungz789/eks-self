locals {
  vpc_name = "ssungz-self-vpc"
  vpc_cidr = "10.110.0.0/16"
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.vpc_name
  cidr = local.vpc_cidr
  azs = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

   private_subnet_tags = {
    "karpenter.sh/discovery" = var.cluster_name,
    "karpenter.sh/discovery/${var.cluster_name}" = var.cluster_name
   }

}
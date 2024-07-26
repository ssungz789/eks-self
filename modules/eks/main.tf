locals {
  cluster_name = var.cluster_name
  cluster_version = var.cluster_version
  node_name = "worknode-group"
  region = var.region
  public_subnets = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
  vpc_id = var.vpc_id

  tags = {
    Env = "test"
    Terraform = "true"
    Study = "t101"
    Name = "ssungz"
  }
}

#########################################################################
# EKS Cluster
#########################################################################

module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 20.11"
  
  cluster_name = local.cluster_name
  cluster_version = local.cluster_version
  cluster_endpoint_public_access = true

  vpc_id = local.vpc_id
  subnet_ids = local.private_subnets

  enable_irsa = true

  # node_security_group_additional_rules = {
  #   ingress_nodes_karpenter_port = {
  #     description = "cluster API Kapenter webhook"
  #     from_port   = 8443
  #     to_port     = 8443
  #     protocol    = "tcp"
  #     type        = "ingress"
  #     source_cluster_security_group = true
  #   }
  # }

  # node_security_group_tags = {
  #   "karpenter.sh/discovery" = local.cluster_name
  # }

  eks_managed_node_groups = {
    initial = {
      instance_type = ["t3.large"]
      name = local.node_name

      min_size = 2
      max_size = 3
      desired_size = 2

      iam_role_additional_policies = {
        policy1 = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      }
    }
  }

}





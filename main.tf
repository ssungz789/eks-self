module "eks" {
  source = "./modules/eks"
  cluster_name = "ssungz-cluster"
  cluster_version = "1.30"
  region = "ap-northeast-2"
  vpc_id = module.eks.vpc_id
}
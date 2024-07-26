output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_primary_security_group_id" {
  value = module.eks.cluster_primary_security_group_id
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
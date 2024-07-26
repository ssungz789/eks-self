output "cluster_id" {
  value = module.eks.cluster_id
}

output "source_cluster_security_group" {
  value = module.eks.cluster_primary_security_group_id
}
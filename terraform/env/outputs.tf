# terraform/env/outputs.tf

output "vpc_id" {
  description = "Created VPC ID."
  value       = module.network.vpc_id
}

output "public_subnets" {
  description = "Created Public Subnet IDs."
  value       = module.network.public_subnet_ids
}

output "eks_private_subnets" {
  description = "Created Private Subnet IDs for EKS."
  value       = module.network.private_eks_subnet_ids
}

output "rds_db_subnet_group" {
  description = "Created DB Subnet Group Name for RDS."
  value       = module.network.db_subnet_group_name
}

output "eks_cluster_role_arn" {
  description = "Created EKS Cluster Role ARN."
  value       = module.iam.eks_cluster_role_arn
}

output "eks_node_group_sg_id" {
  description = "Created EKS Node Group Security Group ID."
  value       = module.sg.eks_node_group_sg_id
}

output "rds_sg_id" {
  description = "Created RDS Security Group ID."
  value       = module.sg.rds_sg_id
}

output "eks_cluster_name" {
  description = "EKS Cluster Name."
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster Endpoint."
  value       = module.eks.cluster_endpoint
}

output "rds_instance_endpoint" {
  description = "RDS Instance Endpoint."
  value       = module.rds.db_instance_endpoint
}

output "master_user_secret_arn" {
  description = "The ARN of the secret automatically created by RDS."
  value       = module.rds.master_user_secret_arn
  sensitive   = true
}

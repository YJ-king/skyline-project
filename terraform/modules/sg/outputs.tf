# modules/sg/outputs.tf

output "eks_cluster_sg_id" {
  description = "The ID of the EKS cluster security group."
  value       = aws_security_group.eks_cluster.id
}

output "eks_node_group_sg_id" {
  description = "The ID of the EKS node group security group."
  value       = aws_security_group.eks_node_group.id
}

output "rds_sg_id" {
  description = "The ID of the RDS security group."
  value       = aws_security_group.rds.id
}

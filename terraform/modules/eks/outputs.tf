# modules/eks/outputs.tf

output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster's Kubernetes API server."
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_ca_certificate" {
  description = "The CA certificate for the EKS cluster."
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "node_group_actual_sg_id" {
  description = "The ID of the security group actually attached to the nodes by EKS."
  value       = aws_eks_node_group.main.resources[0].remote_access_security_group_id
}

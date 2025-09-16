# modules/network/outputs.tf

output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of Public Subnet IDs."
  value       = aws_subnet.public[*].id
}

output "private_mgmt_subnet_ids" {
  description = "List of Private MGMT Subnet IDs."
  value       = aws_subnet.private_mgmt[*].id
}

output "private_eks_subnet_ids" {
  description = "List of Private EKS Subnet IDs."
  value       = aws_subnet.private_eks[*].id
}

output "private_rds_subnet_ids" {
  description = "List of Private RDS Subnet IDs."
  value       = aws_subnet.private_rds[*].id
}

output "db_subnet_group_name" {
  description = "The name of the DB Subnet Group."
  value       = aws_db_subnet_group.rds.name
}

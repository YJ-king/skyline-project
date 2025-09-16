# modules/eks/variables.tf

variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "cluster_version" {
  description = "The Kubernetes version for the EKS cluster."
  type        = string
  default     = "1.28" # 최신 버전에 맞게 조절 가능
}

variable "cluster_role_arn" {
  description = "The ARN of the IAM role for the EKS cluster."
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the EKS cluster."
  type        = list(string)
}

variable "cluster_sg_id" {
  description = "The ID of the security group for the EKS cluster."
  type        = string
}

variable "node_group_role_arn" {
  description = "The ARN of the IAM role for the EKS node group."
  type        = string
}

variable "node_group_sg_id" {
  description = "The ID of the security group for the EKS node group."
  type        = string
}

variable "ec2_key_name" {
  description = "The name of the EC2 key pair for SSH access to nodes."
  type        = string
}

# modules/sg/variables.tf

variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the security groups will be created."
  type        = string
}

variable "eks_node_actual_sg_id" {
  description = "The actual security group ID attached to EKS nodes."
  type        = string
}

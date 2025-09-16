# terraform/env/variables.tf

variable "project_name" {
  description = "The name for the project."
  type        = string
}

variable "region" {
  description = "The AWS region."
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets."
  type        = list(string)
}

variable "private_mgmt_subnet_cidrs" {
  description = "List of CIDR blocks for private MGMT subnets."
  type        = list(string)
}

variable "private_eks_subnet_cidrs" {
  description = "List of CIDR blocks for private EKS subnets."
  type        = list(string)
}

variable "private_rds_subnet_cidrs" {
  description = "List of CIDR blocks for private RDS subnets."
  type        = list(string)
}

variable "ec2_key_name" {
  description = "The name of the EC2 key pair for SSH access to EKS nodes."
  type        = string
}

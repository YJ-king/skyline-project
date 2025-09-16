# modules/network/variables.tf

variable "project_name" {
  description = "The name of the project. Used for tagging resources."
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "ap-northeast-2"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones to use."
  type        = list(string)
  # 예: ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets."
  type        = list(string)
  # 예: ["10.0.0.0/20", "10.0.16.0/20"]
}

variable "private_mgmt_subnet_cidrs" {
  description = "List of CIDR blocks for private MGMT subnets."
  type        = list(string)
  # 예: ["10.0.32.0/20", "10.0.48.0/20"]
}

variable "private_eks_subnet_cidrs" {
  description = "List of CIDR blocks for private EKS subnets."
  type        = list(string)
  # 예: ["10.0.64.0/20", "10.0.80.0/20"]
}

variable "private_rds_subnet_cidrs" {
  description = "List of CIDR blocks for private RDS subnets."
  type        = list(string)
  # 예: ["10.0.96.0/20", "10.0.112.0/20"]
}

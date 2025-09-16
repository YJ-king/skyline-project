# modules/rds/variables.tf

variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "db_instance_class" {
  description = "The instance class for the RDS instance."
  type        = string
  default     = "db.t3.micro"
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs for the RDS instance."
  type        = list(string)
}

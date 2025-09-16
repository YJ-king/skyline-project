# modules/rds/outputs.tf

output "db_instance_endpoint" {
  description = "The endpoint of the RDS instance."
  value       = aws_db_instance.main.endpoint
}

output "db_instance_name" {
  description = "The name of the RDS database."
  value       = aws_db_instance.main.db_name
}

output "master_user_secret_arn" {
  description = "The ARN of the secret containing the master user password."
  value       = aws_db_instance.main.master_user_secret[0].secret_arn
  sensitive   = true
}

# RDS MySQL 인스턴스가 직접 Secrets Manager를 관리하도록 설정
resource "aws_db_instance" "main" {
  identifier             = "${var.project_name}-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class
  allocated_storage      = 20

  db_name                = "${replace(var.project_name, "_", "")}db"
  username               = "admin"
  manage_master_user_password = true

  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids

  multi_az               = true
  skip_final_snapshot    = true

  tags = {
    Name = "${var.project_name}-db"
  }
}

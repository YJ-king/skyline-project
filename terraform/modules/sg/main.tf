# modules/sg/main.tf

# 1. EKS Cluster 보안 그룹
resource "aws_security_group" "eks_cluster" {
  name        = "${var.project_name}-eks-cluster-sg"
  description = "Security group for the EKS cluster control plane."
  vpc_id      = var.vpc_id

  # 모든 아웃바운드 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-eks-cluster-sg"
  }
}

# 2. EKS Node Group 보안 그룹
resource "aws_security_group" "eks_node_group" {
  name        = "${var.project_name}-eks-node-sg"
  description = "Security group for the EKS node group."
  vpc_id      = var.vpc_id

  # Cluster SG로부터의 모든 트래픽을 허용 (상호 통신)
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.eks_cluster.id]
  }
  
  # 자기 자신으로부터의 모든 트래픽 허용 (노드 간 통신)
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  # 모든 아웃바운드 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-eks-node-sg"
  }
}

# Cluster SG가 Node SG로 아웃바운드 트래픽을 보낼 수 있도록 규칙 추가
resource "aws_security_group_rule" "cluster_to_node_egress" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.eks_node_group.id
  security_group_id        = aws_security_group.eks_cluster.id
}


# 3. RDS 보안 그룹
resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Security group for the RDS instance."
  vpc_id      = var.vpc_id

  # EKS Node Group SG로부터의 MySQL 포트(3306) 접근만 허용
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.eks_node_actual_sg_id]
  }

  # 모든 아웃바운드 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}

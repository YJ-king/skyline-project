# modules/eks/main.tf

resource "aws_eks_cluster" "main" {
  name     = "${var.project_name}-cluster"
  role_arn = var.cluster_role_arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [var.cluster_sg_id]
    # Public Access를 켜야 kubectl로 로컬에서 접근 가능
    endpoint_public_access = true 
  }

  tags = {
    Name = "${var.project_name}-cluster"
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-node-group"
  node_role_arn   = var.node_group_role_arn
  subnet_ids      = var.private_subnet_ids

  # 인스턴스 타입 및 스케일링 설정
  instance_types = ["t3.medium"]
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  # 노드 그룹에 보안 그룹 연결
  remote_access {
    ec2_ssh_key               = var.ec2_key_name
    source_security_group_ids = [var.node_group_sg_id]
  }

  tags = {
    Name = "${var.project_name}-node-group"
  }
}

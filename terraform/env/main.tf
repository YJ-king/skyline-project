# terraform/env/main.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "network" {
  source = "../modules/network" # 상위 폴더의 modules/network 를 바라봄

  # env/variables.tf 의 변수들을 모듈로 전달
  project_name              = var.project_name
  region                    = var.region
  availability_zones        = var.availability_zones
  public_subnet_cidrs       = var.public_subnet_cidrs
  private_mgmt_subnet_cidrs = var.private_mgmt_subnet_cidrs
  private_eks_subnet_cidrs  = var.private_eks_subnet_cidrs
  private_rds_subnet_cidrs  = var.private_rds_subnet_cidrs
}

module "iam" {
  source = "../modules/iam"

  project_name = var.project_name
}

module "sg" {
  source = "../modules/sg"

  project_name = var.project_name
  vpc_id       = module.network.vpc_id # network 모듈의 vpc_id를 입력값으로 전달
  eks_node_actual_sg_id = module.eks.node_group_actual_sg_id
}

module "eks" {
  source = "../modules/eks"

  project_name        = var.project_name
  cluster_role_arn    = module.iam.eks_cluster_role_arn
  private_subnet_ids  = module.network.private_eks_subnet_ids
  cluster_sg_id       = module.sg.eks_cluster_sg_id
  node_group_role_arn = module.iam.eks_node_group_role_arn
  node_group_sg_id    = module.sg.eks_node_group_sg_id
  ec2_key_name        = var.ec2_key_name
}

module "rds" {
  source = "../modules/rds"

  project_name           = var.project_name
  db_subnet_group_name   = module.network.db_subnet_group_name
  vpc_security_group_ids = [module.sg.rds_sg_id]
}

# modules/network/main.tf

# 1. VPC 생성
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# 2. Internet Gateway 생성
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.project_name}-igw" }
}

# 3. Subnets 생성 (변수 기반 동적 생성)
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-${element(split("", var.availability_zones[count.index]), 12)}" # AZ 끝 글자 (a, c) 추출
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "private_mgmt" {
  count = length(var.private_mgmt_subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_mgmt_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = { Name = "${var.project_name}-private-mgmt-${element(split("", var.availability_zones[count.index]), 12)}" }
}

resource "aws_subnet" "private_eks" {
  count = length(var.private_eks_subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_eks_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name                              = "${var.project_name}-private-eks-${element(split("", var.availability_zones[count.index]), 12)}"
    "kubernetes.io/role/internal-elb" = "1" # EKS Load Balancer용 태그
  }
}

resource "aws_subnet" "private_rds" {
  count = length(var.private_rds_subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_rds_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = { Name = "${var.project_name}-private-rds-${element(split("", var.availability_zones[count.index]), 12)}" }
}

# 4. NAT Gateway 생성
resource "aws_eip" "nat" {
  domain = "vpc"
  tags   = { Name = "${var.project_name}-eip-nat-a" }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
  tags          = { Name = "${var.project_name}-nat-a" }
  depends_on    = [aws_internet_gateway.main]
}

# 5. Route Tables 생성
# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = { Name = "${var.project_name}-rt-public" }
}

# Private Route Tables (AZ별로 생성)
resource "aws_route_table" "private" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
  tags = { Name = "${var.project_name}-rt-private-${element(split("", var.availability_zones[count.index]), 12)}" }
}

# 6. Route Table Associations
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# 각 AZ의 Private Subnet들을 해당 AZ의 Private Route Table에 연결
resource "aws_route_table_association" "private_mgmt" {
  count          = length(var.private_mgmt_subnet_cidrs)
  subnet_id      = aws_subnet.private_mgmt[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "private_eks" {
  count          = length(var.private_eks_subnet_cidrs)
  subnet_id      = aws_subnet.private_eks[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "private_rds" {
  count          = length(var.private_rds_subnet_cidrs)
  subnet_id      = aws_subnet.private_rds[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

# 7. RDS DB Subnet Group
resource "aws_db_subnet_group" "rds" {
  name       = "${var.project_name}-rds-sng"
  subnet_ids = aws_subnet.private_rds[*].id

  tags = {
    Name = "${var.project_name}-rds-sng"
  }
}

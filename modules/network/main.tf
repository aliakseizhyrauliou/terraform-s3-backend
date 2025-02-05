resource "aws_vpc" "main" {
  cidr_block           = var.vpc.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.env_name}-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.vpc.public_subnet.public_subnet_cidr_block
  map_public_ip_on_launch = var.vpc.public_subnet.public_subnet_map_public_ip_on_launch
  availability_zone       = var.vpc.public_subnet.public_subnet_availability_zone
  tags = {
    Name = var.vpc.public_subnet.public_subnet_name
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc.private_subnet.private_subnet_cidr_block
  availability_zone = var.vpc.private_subnet.private_subnet_availability_zone
  tags = {
    Name = var.vpc.private_subnet.private_subnet_name
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.vpc.internet_gateway.name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = var.vpc.aws_route_table_public_subnet.name
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
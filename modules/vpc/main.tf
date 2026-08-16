resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-public-${count.index + 1}"
  }
}
resource "aws_subnet" "private_backend" {
  count             = length(var.private_subnet_cidr_blocks_backend)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_blocks_backend[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.vpc_name}-private-backend-${count.index + 1}"
  }
}
resource "aws_subnet" "private_database" {
  count             = length(var.private_subnet_cidr_blocks_database)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_blocks_database[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.vpc_name}-private-database-${count.index + 1}"
  }
}
resource "aws_eip" "nat" {
  tags = {
    Name = "${var.vpc_name}-nat-eip"
  }
}
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
  depends_on    = [aws_internet_gateway.main]
  tags = {
    Name = "${var.vpc_name}-nat-gateway"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id   
  }
    tags = {
        Name = "${var.vpc_name}-public-rt"
    }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id    
  }
    tags = {
        Name = "${var.vpc_name}-private-rt"
    }
}
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private_backend" {
  count          = length(var.private_subnet_cidr_blocks_backend)
  subnet_id      = aws_subnet.private_backend[count.index].id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_database" {
  count          = length(var.private_subnet_cidr_blocks_database)
  subnet_id      = aws_subnet.private_database[count.index].id
  route_table_id = aws_route_table.private.id
}
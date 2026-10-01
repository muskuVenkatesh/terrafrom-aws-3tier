data "aws_availability_zones" "available" {
    state = "available"
}

locals {
    azs = slice(data.aws_availability_zones.available.names, 0, var.az_count)

    public_subnets = {
    for index, az in local.azs :
    az => cidrsubnet(var.vpc_cidr, 8, index + 1)
  }

  app_subnets = {
    for index, az in local.azs :
    az => cidrsubnet(var.vpc_cidr, 8, index + 11)
  }

  db_subnets = {
    for index, az in local.azs :
    az => cidrsubnet(var.vpc_cidr, 8, index + 21)
  }
}

resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Name = "${var.project_name}-vpc"

    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.project_name}-igw"
    }
}

resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-${each.key}"
    Tier = "public"
  }


}

#  public route table association
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.project_name}-public-rt"
    }
}

resource "aws_route" "public" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}

# associate public subnets with the public route table
resource "aws_route_table_association" "public" {
  for_each       = local.public_subnets
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

# Single NAT Gateway (Uses 1 Elastic IP)
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public)[0].id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.project_name}-nat-gw"
  }
}

resource "aws_subnet" "app" {
  for_each          = local.app_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = "${var.project_name}-app-${each.key}"
    Tier = "app"
  }
}

resource "aws_route_table" "app" {
  for_each = local.app_subnets
  vpc_id   = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-app-rt-${each.key}"
  }
}

resource "aws_route" "app_nat" {
  for_each = aws_route_table.app

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "app" {
  for_each       = local.app_subnets
  subnet_id      = aws_subnet.app[each.key].id
  route_table_id = aws_route_table.app[each.key].id
}

# DB subnets 
resource "aws_subnet" "db" {
  for_each          = local.db_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = "${var.project_name}-db-${each.key}"
    Tier = "db"
  }
}

resource "aws_route_table" "db" {
  for_each = local.db_subnets
  vpc_id   = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-db-rt-${each.key}"
  }
}

resource "aws_route_table_association" "db" {
  for_each = local.db_subnets

  subnet_id      = aws_subnet.db[each.key].id
  route_table_id = aws_route_table.db[each.key].id
}




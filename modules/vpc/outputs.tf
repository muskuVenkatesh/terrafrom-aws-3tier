output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = [
    for subnet in aws_subnet.public : subnet.id
  ]
}

output "app_subnet_ids" {
  value = [
    for subnet in aws_subnet.app : subnet.id
  ]
}

output "db_subnet_ids" {
  value = [
    for subnet in aws_subnet.db : subnet.id
  ]
}

output "public_subnet_map" {
  value = {
    for az, subnet in aws_subnet.public :
    az => subnet.id
  }
}

output "app_subnet_map" {
  value = {
    for az, subnet in aws_subnet.app :
    az => subnet.id
  }
}

output "db_subnet_map" {
  value = {
    for az, subnet in aws_subnet.db :
    az => subnet.id
  }
}
output "endpoint" {
  value       = aws_db_instance.rds.endpoint
  description = "RDS connection endpoint"
}

output "db_instance_id" {
  value       = aws_db_instance.rds.id
  description = "RDS instance ID"
}

output "alb_arn" {
  value       = aws_lb.alb.arn
  description = "ALB ARN"
}

output "alb_dns_name" {
  value       = aws_lb.alb.dns_name
  description = "ALB DNS Name"
}

output "target_group_arn" {
  value       = aws_lb_target_group.app.arn
  description = "Target Group ARN"
}

output "autoscaling_group_id" {
  value       = aws_autoscaling_group.app.id
  description = "Auto Scaling Group ID"
}

output "launch_template_id" {
  value       = aws_launch_template.app.id
  description = "Launch Template ID"
}

output "instance_profile_name" {
  value       = aws_iam_instance_profile.ec2.name
  description = "IAM instance profile name"
}

output "role_name" {
  value       = aws_iam_role.ec2.name
  description = "IAM role name"
}

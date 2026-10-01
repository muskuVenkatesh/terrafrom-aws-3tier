variable "project_name" {
  type    = string
  default = "three-tier-app"
}

variable "vpc_cidr" {
  type = string
}

variable "az_count" {
  type    = number
  default = 2
}
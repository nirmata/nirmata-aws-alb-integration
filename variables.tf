variable "lb_name" {
  description = "Name for the AWS Load Balancer"
}

variable "region" {
  description = "AWS region"
  default     = "us-west-1"  # Set your default AWS region
}

variable "target_group_name" {
  description = "Name for the AWS Target Group"
}

variable "subnets" {
  description = "List of subnets for the AWS Load Balancer"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "ssl_certificate_arn" {
  description = "SSL/TLS certificate ARN"
}

variable "asg_names" {
  description = "List of Auto Scaling Group names"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the AWS Load Balancer"
  type        = list(string)
}

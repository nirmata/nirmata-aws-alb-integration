# AWS Load Balancer Setup with Terraform

This Terraform configuration sets up an AWS Application Load Balancer (ALB) with a listener rule, target group, and associated resources.

## Prerequisites

Before you begin, ensure you have the following:

- [Terraform](https://www.terraform.io/) installed on your local machine.
- AWS credentials configured with the necessary permissions.

## Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/nirmata/nirmata-aws-alb-integration.git
    cd nirmata-aws-alb-integration
    ```

2. Update the `variables.tf` file with your configurations:

    ```hcl
    variable "region" {
      description = "AWS region"
      default     = "us-west-1"  # Set your desired AWS region
    }

    variable "lb_name" {
      description = "Name for the AWS Load Balancer"
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
    ```
3. Update the `provider.tf` file with your aws sso profile:

    profile = "dev-test"


4. Run Terraform commands to deploy the infrastructure:

    ```bash
    terraform init
    terraform apply
    ```

5. Confirm the changes and apply them.

6. The ALB DNS name will be displayed as an output. Access your application using this DNS name.

## Clean Up

When you are done, clean up the resources:

```bash
terraform destroy
```

Enter `yes` when prompted to confirm the destruction of resources.


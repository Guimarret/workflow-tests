resource "aws_subnet" "main"{
    vpc_id     = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"

    tags = {
    Name = "Main"
  }
}

resource "aws_security_group" "sg" {
    name        = "cluster"
    description = "Cluster config for SC"
    vpc_id      = aws_vpc.main.id

    tags = {
        Name = "cluster_config"
  }
}

resource "aws_iam_instance_profile" "emr_profile" {
    name = "cluster"
    role = aws_iam_role.iam_emr_service_role.name
}

resource "aws_vpc" "main" {
  cidr_block = "102.0.0.0/16"
  tags = {
    Name = "cluster_vpc"
  }
}

resource "aws_iam_role" "iam_emr_service_role" {
  name = "test_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}
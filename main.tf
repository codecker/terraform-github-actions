terraform {
  # Define required Terraform version
  required_version = "1.0.11"
}

resource "aws_vpc" "actions_vpc" {
   cidr_block       = "10.10.0.0/16"
   instance_tenancy = "default"

  tags = {
    Name = "action-vpc"
  }
}

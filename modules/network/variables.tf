variable "env_name" {
  description = "The name of envinroment"
  type        = string
}

variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
}

variable "vpc" {
  description = "Configuration for the VPC."
  type = object({
    vpc_cidr_block = string
    vpc_name       = string

    public_subnet = object({
      public_subnet_cidr_block           = string
      public_subnet_map_public_ip_on_launch = bool
      public_subnet_availability_zone    = string
      public_subnet_name                 = string
    })

    private_subnet = object({
      private_subnet_cidr_block        = string
      private_subnet_availability_zone = string
      private_subnet_name              = string
    })

    internet_gateway = object({
      name = string
    })

    aws_route_table_public_subnet = object({
      name = string
    })
  })
}
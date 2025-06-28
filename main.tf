terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.azs[0] != "" ? substr(var.azs[0], 0, 9) : "us-west-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name                 = var.vpc_name
  cidr                 = var.vpc_cidr
  azs                  = var.azs
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.8.3"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  eks_managed_node_groups = {
    default = {
      desired_capacity = var.desired_capacity
      max_capacity     = var.max_size
      min_capacity     = var.min_size

      instance_types = ["t3.medium"]
      ami_type       = "AL2_x86_64"
    }
  }
}

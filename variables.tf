variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "eks-vpc"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1c"]
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
  default     = "eks-cluster"
}

variable "desired_capacity" {
  description = "Desired number of nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Max number of nodes"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Min number of nodes"
  type        = number
  default     = 1
}

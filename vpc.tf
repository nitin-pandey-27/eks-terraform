locals {
  sre_candidate = "${var.candidate_name}"
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"
  # For module detail. Please refer - https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

  name = "eks-vpc" 
  cidr = "10.0.0.0/16"
  #Name of VPC and CODR

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  #AZ with 4 subnets, 2 subnet each for Private Network and Public Network

  enable_nat_gateway = false
  enable_vpn_gateway = false
  #No need to enable any Gateway
  
  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }

  tags = {
    sre_candidate = "${var.candidate_name}"
    #Tag 
  }
}

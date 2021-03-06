module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"
  # For module detail. Please refer - https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

  name = "eks-vpc" 
  cidr = "10.0.0.0/16"
  #Name of VPC and CODR

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  #AZ with 6 subnets, 3 subnet each for Private Network and Public Network

  enable_nat_gateway = true
  enable_vpn_gateway = false
  enable_dns_hostnames = true

  
  tags = {
    "kubernetes.io/cluster/${var.user_name}" = "shared"
  }
  
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.user_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.user_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }

}

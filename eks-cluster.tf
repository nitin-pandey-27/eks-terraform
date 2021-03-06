module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.1.0"                    #Module Version
  cluster_name    = "${var.user_name}"          #K8s Cluster Name
  cluster_version = "1.20"                      #K8s Versoin
  subnets         = module.vpc.private_subnets  #Subnet where EKS Cluster will be deployed
    #For more details about EKS Module please refer 
    #https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest

  tags = {
    Environment = "training"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
    user_name   = "${var.user_name}"
  }
    #A map of tags to add to all resources. 

  vpc_id = module.vpc.vpc_id
    #VPC where the cluster and workers will be deployed.

  workers_group_defaults = {
    root_volume_type = "gp2"
    #worker group configurations to be defined
    #Refer this page - https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest#input_workers_group_defaults
  }

    
  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 1
      asg_max_size                  = 2
      #Autoscaling group 
      spot_price                    = "0.20"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      kubelet_extra_args            = "--node-labels=node.kubernetes.io/lifecycle=spot"
      suspended_processes           = ["AZRebalance"]
      #How to use spot instance - https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/docs/spot-instances.md
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 1
      asg_max_size                  = 2
      #Autoscaling group 
      spot_price                    = "0.20"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      kubelet_extra_args            = "--node-labels=node.kubernetes.io/lifecycle=spot"
      suspended_processes           = ["AZRebalance"]
      #How to use spot instance - https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/docs/spot-instances.md
    },
  ]
}
    #worker group configurations to be defined
    #Refer this page - https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest#input_workers_group_defaults
    

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}
  #Manages an EKS Cluster.
  #For details please refer - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster

  
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
  #Get an authentication token to communicate with an EKS cluster.
  #Please refer - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth

resource "aws_iam_role" "eks_cluster" {
  name = "eksClusterRole"
  
  # resource name = eks_cluster
  # IAM Role Name = eksClusterRole
  # Creating a Cluster -- https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html
  # Resource Detail - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
  # Role Creation - https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html#create-service-role
  # Role Policy - https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html
  
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  
  tags = {
    sre_candidate = "${var.candidate_name}"
    #Tag 
  }
  
}
 
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.eks_cluster.name
  # Bind the role with the Policy "AmazonEKSClusterPolicy"
  # Policy Binding - https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster.name
  # This policy is mentioned in Terraform 
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
}


resource "aws_iam_role" "eks_nodes" {
  name = "eksNodeRole"
  
  # resource name = eks_nodes
  # IAM Role Name = eksNodeRole
  # Creating a Node - https://docs.aws.amazon.com/eks/latest/userguide/create-managed-node-group.html
  # Resource Detail - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
  # Role Creation - https://docs.aws.amazon.com/eks/latest/userguide/create-node-role.html#create-worker-node-role
  # Policy Attach - https://docs.aws.amazon.com/eks/latest/userguide/create-node-role.html#create-worker-node-role
  
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  
  tags = {
    sre_candidate = "${var.candidate_name}"
    #Tag 
  }
  
}
 
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.eks_nodes.name
  # Bind the role with the Policy "AmazonEKSWorkerNodePolicy"
  # Refer - https://docs.aws.amazon.com/eks/latest/userguide/create-node-role.html#create-worker-node-role
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.eks_nodes.name
  # Bind the role with the Policy "AmazonEC2ContainerRegistryReadOnly"
  # Refer - https://docs.aws.amazon.com/eks/latest/userguide/create-node-role.html#create-worker-node-role
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.eks_nodes.name
  # This policy is mentioned in Terraform 
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group
}



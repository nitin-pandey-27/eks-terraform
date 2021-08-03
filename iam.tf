resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster"
  
  # resource name = eks_cluster
  # IAM Role Name = eks-cluster
  # Resource Detail - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  name = "AmazonEKSClusterPolicy"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  roles = aws_iam_role.eks_cluster.name
  # Bind the role with the Policy "AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServiceRolePolicy" {
  name = "AmazonEKSServiceRolePolicy"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServiceRolePolicy"
  roles       = aws_iam_role.eks_cluster.name
  # Bind the role with the Policy "AmazonEKSServiceRolePolicy"
}

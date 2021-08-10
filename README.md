# Steps to Install Required Packages - 

Please refer this page - https://learn.hashicorp.com/tutorials/terraform/eks

Warning! AWS charges $0.10 per hour for each EKS cluster. As a result, you may be charged to run these examples. The most you should be charged should only be a few dollars, but we're not responsible for any charges that may incur.

Please execute below command - 

#terraform init
#terraform plan
#terraform apply 

Configure kubeconfig file for kubectl 
#aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)

#kubectl get nodes
#kubect get pods -n kube-system



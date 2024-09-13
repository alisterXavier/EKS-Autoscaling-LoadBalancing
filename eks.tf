resource "aws_eks_cluster" "CloudOpsBlend" {
  name     = "CloudOpsBlend"
  role_arn = aws_iam_role.eks_cluster_role.arn
  vpc_config {
    subnet_ids              = concat(aws_subnet.private_subnets[*].id, aws_subnet.public_subnets[*].id)
    endpoint_public_access  = true
    endpoint_private_access = true
    public_access_cidrs     = ["0.0.0.0/0"]
  }

}

resource "aws_eks_node_group" "name" {
  cluster_name  = aws_eks_cluster.CloudOpsBlend.name
  # node_group_name = "private-nodes"
  node_role_arn = aws_iam_role.eks_node_role.arn
  subnet_ids    = aws_subnet.private_subnets[*].id
  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 5
  }
  ami_type       = "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
  capacity_type  = "ON_DEMAND"  # ON_DEMAND, SPOT
  disk_size      = 20
  instance_types = ["m5.large"]
  labels = {
    role = "general"
  }
}
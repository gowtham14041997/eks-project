output "eks_asg_id" {
  value = aws_eks_node_group.opstree_eks_node_group.resources[0].autoscaling_groups[0].name
}

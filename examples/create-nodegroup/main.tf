
module "node_group" {
  #source = "git::https://github.com/variant-inc/terraform-eksctl-nodegroup.git?ref=v1"
  #For branch
  source           = "git::https://github.com/variant-inc/terraform-eksctl-nodegroup.git?ref=feature/CLOUD-1161-add-node-group"
  name             = var.name
  cluster_region   = var.cluster_region
  cluster_name     = var.cluster_name
  managed          = var.managed
  nodes_min        = var.nodes_min
  nodes_max        = var.nodes_max
  nodes            = var.nodes
  instance_types   = var.instance_types
  node_volume_size = var.node_volume_size
  node_labels      = var.node_labels
  user_tags        = var.user_tags
  octopus_tags     = var.octopus_tags
}

module "node_group" {
  source           = "../../"
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
  node_taints      = var.node_taints
}

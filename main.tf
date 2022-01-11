module "tags" {
  source       = "github.com/variant-inc/lazy-terraform//submodules/tags?ref=v1"
  name         = var.name
  user_tags    = var.user_tags
  octopus_tags = var.octopus_tags
}

resource "eksctl_nodegroup" "ng" {
  name                    = var.name
  region                  = var.region
  cluster                 = var.cluster_name
  nodes_min               = var.nodes_min
  nodes                   = var.nodes
  instance_types          = var.instance_types
  node_volume_size        = var.node_volume_size
  node_private_networking = true
  disable_pod_imds        = true
  tags                    = module.tags.tags
}
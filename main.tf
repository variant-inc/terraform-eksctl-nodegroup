module "tags" {
  source       = "github.com/variant-inc/lazy-terraform//submodules/tags?ref=v1"
  name         = var.name
  user_tags    = var.user_tags
  octopus_tags = var.octopus_tags
}

resource "eksctl_nodegroup" "ng" {
  name                    = var.name
  region                  = var.cluster_region
  cluster                 = var.cluster_name
  managed                 = var.managed
  nodes_min               = var.nodes_min
  nodes_max               = var.nodes_max
  nodes                   = var.nodes
  instance_types          = var.instance_types
  node_volume_size        = var.node_volume_size
  node_private_networking = true
  asg_access              = true
  external_dns_access     = true
  appmesh_access          = true
  appmesh_preview_access  = true
  alb_ingress_access      = true
  node_labels             = var.node_labels
  tags                    = module.tags.tags

  lifecycle {
    create_before_destroy = true
  }
}

locals {
  node_taints = jsonencode(var.node_taints)
}

resource "null_resource" "node_group_taints" {
  triggers = {
    nodegroup_name = eksctl_nodegroup.ng.name
    cluster_name   = eksctl_nodegroup.ng.cluster
    taints         = local.node_taints
  }
  provisioner "local-exec" {
    working_dir = path.module
    command     = "pwsh taints.ps1 -clusterName ${eksctl_nodegroup.ng.cluster} -nodegroupName ${eksctl_nodegroup.ng.name} -taints '${local.node_taints}'"
  }
}
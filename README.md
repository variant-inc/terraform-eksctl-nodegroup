# Terraform eksctl node group

Terraform module to create cluster node group

## Table of Contents

- [Terraform eksctl node group](#terraform-eksctl-node-group)
  - [Table of Contents](#table-of-contents)
  - [Usage](#usage)
  - [Pre-requisite](#pre-requisite)
  - [Requirements](#requirements)
  - [Providers](#providers)
  - [Modules](#modules)
  - [Resources](#resources)
  - [Inputs](#inputs)
  - [Outputs](#outputs)

## Usage

```terraform
  source = "github.com/variant-inc/terraform-eksctl-nodegroup?ref=v1"
```

## Pre-requisite

Run below command before running the module

```bash
export AWS_PROFILE=dpl
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0.0 |
| <a name="requirement_eksctl"></a> [eksctl](#requirement\_eksctl) | >=0.16.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >=3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_eksctl"></a> [eksctl](#provider\_eksctl) | 0.16.2 |
| <a name="provider_null"></a> [null](#provider\_null) | >=3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | github.com/variant-inc/lazy-terraform//submodules/tags | v1 |

## Resources

| Name | Type |
|------|------|
| [eksctl_nodegroup.ng](https://registry.terraform.io/providers/mumoshu/eksctl/latest/docs/resources/nodegroup) | resource |
| [null_resource.node_group_taints](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name | `string` | n/a | yes |
| <a name="input_cluster_region"></a> [cluster\_region](#input\_cluster\_region) | AWS cluster region | `string` | n/a | yes |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | AWS EC2 instance type for cluster nodes | `list(any)` | <pre>[<br>  "c6i.2xlarge"<br>]</pre> | no |
| <a name="input_managed"></a> [managed](#input\_managed) | Create EKS-managed nodegroup | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Node Group name | `string` | n/a | yes |
| <a name="input_node_labels"></a> [node\_labels](#input\_node\_labels) | Node labels | `map(string)` | n/a | yes |
| <a name="input_node_taints"></a> [node\_taints](#input\_node\_taints) | Taints to add to the nodegroup | <pre>list(object({<br>    key    = string<br>    value  = string<br>    effect = string<br>  }))</pre> | n/a | yes |
| <a name="input_node_volume_size"></a> [node\_volume\_size](#input\_node\_volume\_size) | Node volume size | `number` | `100` | no |
| <a name="input_nodes"></a> [nodes](#input\_nodes) | Total number of nodes | `number` | `1` | no |
| <a name="input_nodes_max"></a> [nodes\_max](#input\_nodes\_max) | Maximum number of nodes | `number` | `10` | no |
| <a name="input_nodes_min"></a> [nodes\_min](#input\_nodes\_min) | Minimum number of nodes | `number` | `1` | no |
| <a name="input_octopus_tags"></a> [octopus\_tags](#input\_octopus\_tags) | Octopus Tags | `map(string)` | n/a | yes |
| <a name="input_user_tags"></a> [user\_tags](#input\_user\_tags) | User tags | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nodegroup_config"></a> [nodegroup\_config](#output\_nodegroup\_config) | Outputs the node group configurations |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

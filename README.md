# terraform-eksctl-nodegroup
Terraform module for creating aws kubernetes node groups


## Resources

* Tags

## Input Variables

| Name             | Type           | Description                             | Default | Example                                                                                                                                                                                                           |
|------------------|----------------|-----------------------------------------|---------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| name             | string         | Node Group name                         |         |                                                                                                                                                                                                                   |
| region           | string         | AWS region                              |         |                                                                                                                                                                                                                   |
| cluster_name     | string         | Cluster name                            |         |                                                                                                                                                                                                                   |
| nodes_min        | number         | Minimum number of nodes                 |         |                                                                                                                                                                                                                   |
| nodes_max        | number         | Maximum number of nodes                 |         |                                                                                                                                                                                                                   |
| instance_types   | list           | AWS EC2 instance type for cluster nodes |         | [ "t3.micro" ]                                                                                                                                                                                                    |
| node_volume_size | number         | Node volume size                        |         |                                                                                                                                                                                                                   |
| nodes            | number         | Total number of nodes                   |         |                                                                                                                                                                                                                   |
| user_tags        | map ( string ) | User tags                               |         | "user_tags" :{        "team" : "devops" ,        "purpose" : "node group test" ,        "owner" : "devops"    }                                                                                                   |
| octopus_tags     | map ( string ) | Octopus Tags                            |         | "octopus_tags" :{        "project" : "test" ,        "space" : "Default" ,        "environment" :  "development" ,        "project_group" :  "Default Project Group" ,        "release_channel" :  "release"    } |


For `user_tags` , refer <https://github.com/variant-inc/lazy-terraform/tree/master/submodules/tags>

`octopus_tags` are auto set at octopus. Set the variable as

```bash
variable "octopus_tags" {
  description = "Octopus Tags"
  type = map(string)
}
```

## Examples

To test as a module

Set AWS profile as below before running the module

```bash
export AWS_PROFILE=dpl
```

versions.tf

```bash
terraform {
  required_version = ">=1.0.0"
  required_providers {
    eksctl = {
      source  = "mumoshu/eksctl"
      version = "0.16.2"
    }
  }
}
```

provider.tf

```bash
provider "eksctl" {
}

provider "aws" {
  profile = "dpl"
  region  = "us-east-1"
}
```

main.tf

```bash

module "node_group" {
  #source = "git::https://github.com/variant-inc/terraform-eksctl-nodegroup.git?ref=v1"
  #For branch
  source           = "git::https://github.com/variant-inc/terraform-eksctl-nodegroup.git?ref=feature/CLOUD-1161-add-node-group"
  name             = "ng1"
  region           = "us-east-1"
  cluster_name     = "devops-playground"
  nodes_min        = 1
  nodes_max        = 1
  nodes            = 1
  instance_types   = ["t3.micro"]
  node_volume_size = 10
  user_tags = {
    "team" : "devops",
    "purpose" : "node group test",
    "owner" : "devops"
  }
  octopus_tags = {
    "project" : "test",
    "space" : "Default",
    "environment" : "development",
    "project_group" : "Default Project Group",
    "release_channel" : "release"
  }

}

```

.tfvars.json

```json
{
    "name": "ng-1",
    "region": "us-east-1",
    "cluster_name":"devops-playground",
    "nodes_min": 1,
    "nodes_max": 1,
    "nodes":1,
    "instance_types": ["t3.micro"],
    "node_volume_size": 10,
    "user_tags":{
      "team":"devops",
      "purpose":"node group test",
      "owner":"devops"
   },
   "octopus_tags":{
      "project":"test",
      "space":"Default",
      "environment": "development",
      "project_group": "Default Project Group",
      "release_channel": "release"
   }

  }
```

## Output Variables

| Name                      | Type   |
|---------------------------|--------|
| kubeconfig_path           | string |

## References

Refer <https://github.com/mumoshu/terraform-provider-eksctl#add-and-remove-nodegroups> which seems to be the best one

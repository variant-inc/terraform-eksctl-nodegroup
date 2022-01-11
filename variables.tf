variable "name" {
  type        = string
  description = "Node Group name"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "cluster_name" {
  type        = string
  description = "Cluster name"
}

variable "nodes_min" {
  type        = string
  description = "Minimum number of worker nodes"
}

variable "nodes_max" {
  type        = string
  description = "Maximum number of worker nodes"
}

variable "instance_types" {
  type        = list
  description = "AWS EC2 instance type for cluster nodes"
}

variable "node_volume_size" {
  type        = number
  description = "Node volume size"
}

variable "nodes" {
  type        = number
  description = "total number of nodes"
}

variable "user_tags" {
  description = "User tags"
  type        = map(string)
}

variable "octopus_tags" {
  description = "Octopus Tags"
  type        = map(string)
}
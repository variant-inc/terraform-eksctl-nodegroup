variable "name" {
  type        = string
  description = "Node Group name"
}

variable "cluster_region" {
  type        = string
  description = "AWS region"
}

variable "cluster_name" {
  type        = string
  description = "Cluster name"
}

variable "managed" {
  type        = bool
  default     = true
  description = "Create EKS-managed nodegroup"
}

variable "nodes_min" {
  type        = number
  description = "Minimum number of nodes"
}

variable "nodes_max" {
  type        = number
  description = "Maximum number of nodes"
}

variable "instance_types" {
  type        = list(any)
  description = "AWS EC2 instance type for cluster nodes"
}

variable "node_volume_size" {
  type        = number
  description = "Node volume size"
}

variable "nodes" {
  type        = number
  description = "Total number of nodes"
}

variable "user_tags" {
  description = "User tags"
  type        = map(string)
}

variable "octopus_tags" {
  description = "Octopus Tags"
  type        = map(string)
}

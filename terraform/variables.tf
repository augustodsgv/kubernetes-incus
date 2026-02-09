variable "incus_token" {
  type        = string
  description = "Token to auth into Incus"
  sensitive   = true
}

variable "incus_remote_name" {
  type        = string
  description = "Name of the incus remote"
}

variable "incus_project" {
  type        = string
  description = "Incus project to deploy stuff"
}

variable "incus_public_network" {
  type        = string
  description = "Name of a incus network to provide IPs"
}

variable "incus_lb_address" {
  type        = string
  description = "IP address of the incus loadbalancer"
}

variable "pool_a_replica_count" {
  type        = number
  description = "Number of nodes in worker a pool"
  default     = 1
}

variable "pool_b_replica_count" {
  type        = number
  description = "Number of nodes in worker b pool"
  default     = 1
}

variable "pool_c_replica_count" {
  type        = number
  description = "Number of nodes in worker c pool"
  default     = 1
}

variable "node_image" {
  type        = string
  description = "Image of the nodes"
  default     = "images:ubuntu/22.04"
}
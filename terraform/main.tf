terraform {
  required_providers {
    incus = {
      source  = "lxc/incus"
      version = "1.0.2"
    }
  }
}

provider "incus" {
  remote {
    name  = var.incus_remote_name
    token = var.incus_token
  }
}

resource "incus_instance" "rke2-proxy" {
  name    = "rke2-proxy"
  image   = var.node_image
  type    = "virtual-machine"
  project = var.incus_project
  config = {
    "limits.cpu"    = 1
    "limits.memory" = "2GB"
  }
}

resource "incus_instance" "rke2-cpa" {
  name    = "rke2-cpa"
  image   = var.node_image
  target  = "inc1"
  type    = "virtual-machine"
  project = var.incus_project
  config = {
    "limits.cpu"    = 2
    "limits.memory" = "4GB"
  }
}

resource "incus_instance" "rke2-cpb" {
  name    = "rke2-cpb"
  image   = var.node_image
  target  = "inc2"
  type    = "virtual-machine"
  project = var.incus_project
  config = {
    "limits.cpu"    = 2
    "limits.memory" = "4GB"
  }
}

resource "incus_instance" "rke2-cpc" {
  name    = "rke2-cpc"
  image   = var.node_image
  target  = "inc3"
  type    = "virtual-machine"
  project = var.incus_project
  config = {
    "limits.cpu"    = 2
    "limits.memory" = "4GB"
  }
}

resource "incus_instance" "rke2-worker-a-pool" {
  name    = "rke2-worker-a-${count.index}"
  count   = var.pool_a_replica_count
  image   = var.node_image
  target  = "inc1"
  type    = "virtual-machine"
  project = var.incus_project
  config = {
    "limits.cpu"    = 2
    "limits.memory" = "4GB"
  }
}

resource "incus_instance" "rke2-worker-b-pool" {
  name    = "rke2-worker-b-${count.index}"
  count   = var.pool_a_replica_count
  image   = var.node_image
  target  = "inc2"
  type    = "virtual-machine"
  project = var.incus_project
  config = {
    "limits.cpu"    = 2
    "limits.memory" = "4GB"
  }
}

resource "incus_instance" "rke2-worker-c-pool" {
  name    = "rke2-worker-c-${count.index}"
  count   = var.pool_a_replica_count
  image   = var.node_image
  target  = "inc1"
  type    = "virtual-machine"
  project = var.incus_project
  config = {
    "limits.cpu"    = 2
    "limits.memory" = "4GB"
  }
}
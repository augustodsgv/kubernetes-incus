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

# Nodes
## Proxy
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

## Control plane
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

## Worker nodes
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

# Load Balancers
## Apiserver loadbalancer
resource "incus_network_lb" "rke2-apiserver" {
  network        = var.incus_public_network
  listen_address = var.incus_lb_address
  backend {
    name           = "rke2-cpa"
    target_address = incus_instance.rke2-cpa.ipv4_address
    target_port    = 6443
  }

  backend {
    name           = "rke2-cpb"
    target_address = incus_instance.rke2-cpb.ipv4_address
    target_port    = 6443
  }

  backend {
    name           = "rke2-cpc"
    target_address = incus_instance.rke2-cpc.ipv4_address
    target_port    = 6443
  }

  port {
    protocol    = "tcp"
    listen_port = 6443
    target_backend = [
      "rke2-cpa",
      "rke2-cpb",
      "rke2-cpc",
    ]
  }
}
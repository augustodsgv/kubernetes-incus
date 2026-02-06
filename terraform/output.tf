resource "local_file" "inventory_template" {
  filename = "../ansible/inventory.yaml"
  content = templatefile("${path.module}/inventory.yaml.tmpl", {
    incus_remote_name   = var.incus_remote_name
    incus_project       = var.incus_project
    rke2-proxy          = incus_instance.rke2-proxy
    rke2-cpa            = incus_instance.rke2-cpa
    rke2-cpb            = incus_instance.rke2-cpb
    rke2-cpc            = incus_instance.rke2-cpc
    rke2-workers-a-pool = incus_instance.rke2-worker-a-pool
    rke2-workers-b-pool = incus_instance.rke2-worker-b-pool
    rke2-workers-c-pool = incus_instance.rke2-worker-c-pool
  })
}
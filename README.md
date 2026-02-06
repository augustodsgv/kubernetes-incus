# Kubernetes Incus
IAC for deploying a highly available Rke2 Kubernetes cluster

## Usage
Fist, make sure  [Incus client](https://linuxcontainers.org/incus/docs/main/installing/#installing) installed.
Them, you need to autenticate into the Incus cluster. To do so, create an Incus trust token for your client on the cluster
```sh
incus config trust add YOUR_CLIENT
```
and add the remote cluster to you machine. Use the token you've created to autenticate to the cluster
```sh
incus remote add cloud-labs https://INCUS_CLUSTER_HOST:8443
```

Now, create the `terraform.tfvars` file with your Incus credentials
```tf
incus_token       = "INCUS_TOKEN"
incus_project     = "INCUS_PROJECT"
incus_remote_name = "INCUS_REMOTE"
```

and check if the Terraform project is ready
```sh
cd terraform
terraform plan
```
and create the resources
```sh
terraform plan apply
```
This terraform will create an inventory that will be used by Ansible. To run the playbook

```sh
cd ../ansible
ansible-playbook playbooks/deploy-cluster.yaml
```
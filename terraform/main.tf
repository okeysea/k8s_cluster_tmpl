locals {
  ssh_config_file = "/root/ssh_config/config"
}

# SSH KEY
resource "vultr_ssh_key" "k8s_ssh_key" {
  name    = "k8s_cluster_ssh_key"
  ssh_key = tls_private_key.keygen.public_key_openssh
}

# VPC
resource "vultr_vpc" "k8s_network" {
  description    = "k8s_cluster_vpc"
  region         = var.vultr_region
  v4_subnet      = "10.0.0.0"
  v4_subnet_mask = 24
}

resource "vultr_instance" "k8s_masters" {
  count       = var.k8s_masters_count
  plan        = var.vultr_k8s_master_plan
  region      = var.vultr_region
  os_id       = var.vultr_k8s_os_id
  label       = "k8s-master-node-${count.index}"
  tags        = ["k8s", "k8s_master"]
  hostname    = "k8s-master-host-${count.index}"
  ssh_key_ids = [vultr_ssh_key.k8s_ssh_key.id]
  vpc_ids     = [vultr_vpc.k8s_network.id]
}

resource "vultr_instance" "k8s_workers" {
  count       = var.k8s_workers_count
  plan        = var.vultr_k8s_worker_plan
  region      = var.vultr_region
  os_id       = var.vultr_k8s_os_id
  label       = "k8s-worker-node-${count.index}"
  tags        = ["k8s", "k8s_worker"]
  hostname    = "k8s-worker-host-${count.index}"
  ssh_key_ids = [vultr_ssh_key.k8s_ssh_key.id]
  vpc_ids     = [vultr_vpc.k8s_network.id]
}

resource "local_file" "ssh_config" {
  filename = local.ssh_config_file
  content  = <<-EOF
  # k8s masters
  %{for ins in vultr_instance.k8s_masters.*}
  Host ${ins.label} ${ins.main_ip}
    User root
    Hostname ${ins.main_ip}
    IdentityFile ${local.private_key_file}
    StrictHostCheking no
    UserKnownHostsFile /dev/null
    Port 22
  %{endfor}
  
  # k8s workers
  %{for ins in vultr_instance.k8s_workers.*}
  Host ${ins.label} ${ins.main_ip}
    User root
    Hostname ${ins.main_ip}
    IdentityFile ${local.private_key_file}
    StrictHostCheking no
    UserKnownHostsFile /dev/null
    Port 22
  %{endfor}
  EOF

  provisioner "local-exec" {
    command = "chmod 600 ${local.ssh_config_file}"
  }
}

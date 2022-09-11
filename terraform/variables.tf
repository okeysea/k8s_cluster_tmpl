terraform {
  required_version = "= 1.2.9"

  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "2.11.4"
    }
  }
}

provider "vultr" {
  api_key     = var.CLOUD_VENDOR_API_KEY
  rate_limit  = 700
  retry_limit = 3
}

variable "SSH_KEY_NAME" {}
variable "CLOUD_VENDOR_API_KEY" {}
variable "k8s_masters_count" {}
variable "k8s_workers_count" {}
variable "vultr_region" {}
variable "vultr_k8s_master_plan" {}
variable "vultr_k8s_worker_plan" {}
variable "vultr_k8s_os_id" {}

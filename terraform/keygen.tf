locals {
  public_key_file  = "/root/.ssh/${var.SSH_KEY_NAME}.id_rsa.pub"
  private_key_file = "/root/.ssh/${var.SSH_KEY_NAME}.id_rsa"
}

# key pair
resource "tls_private_key" "keygen" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

# file
resource "local_file" "private_key_pem" {
  filename = local.private_key_file
  content  = tls_private_key.keygen.private_key_pem

  provisioner "local-exec" {
    command = "chmod 600 ${local.private_key_file}"
  }
}

resource "local_file" "public_key_openssh" {
  filename = local.public_key_file
  content  = tls_private_key.keygen.public_key_openssh

  provisioner "local-exec" {
    command = "chmod 600 ${local.public_key_file}"
  }
}

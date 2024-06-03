resource "oci_load_balancer_certificate" "certificate" {
  ca_certificate     = file(var.ca_certificate_path)
  certificate_name   = var.certificate_name
  load_balancer_id   = var.load_balancer_id
  passphrase         = var.passphrase
  private_key        = file(var.private_key_path)
  public_certificate = file(var.public_certificate_path)

  lifecycle {
    create_before_destroy = true
  }
}

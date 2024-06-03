resource "oci_core_public_ip" "public_ip" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  lifetime       = "RESERVED"
  defined_tags   = var.defined_tags

  lifecycle {
    ignore_changes = [
      private_ip_id,
    ]
  }
}

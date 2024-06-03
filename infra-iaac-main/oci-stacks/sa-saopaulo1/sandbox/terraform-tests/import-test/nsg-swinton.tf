module "nsg-swinton" {
  source         = "./modules/new-nsg"
  compartment_id = var.cs-compartment_ocid
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-swinton"
  nsg_rules = [
    {
      direction        = "EGRESS"
      protocol         = "all"        // ICMP ("1"), TCP ("6"), UDP ("17") all
      destination_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      destination      = "0.0.0.0/0"
      min_port         = null // These are not actually used in the EGRESS rule but need to be provided.
      max_port         = null
    }
  ]
}

output "nsg_id_swinton" {
  value = module.nsg-swinton.nsg_id
}

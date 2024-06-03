module "nsg-cachoeirinha" {
  source         = "./modules/new-nsg"
  compartment_id = var.bryancloud-compartment_ocid
  vnc_id         = module.vcn-oci-spo1p.vcn_id
  nsg_name       = "nsg-cachoeirinha"
  nsg_rules = [
    {
      direction        = "EGRESS"
      protocol         = "all"        // ICMP ("1"), TCP ("6"), UDP ("17") all
      destination_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      destination      = "0.0.0.0/0"
      min_port         = null // These are not actually used in the EGRESS rule but need to be provided.
      max_port         = null
      description      = "Default Egress Rule"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"
      min_port    = 22
      max_port    = 443
      description = "Ingress Teste Default"
    },
    {
      direction   = "INGRESS"
      protocol    = "1"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.2.0.0/16"
      min_port    = null
      max_port    = null
      description = "Ingress ICMP for VCN spo1i Default"
    }
  ]
}

output "nsg_id_cachoeirinha" {
  value = module.nsg-cachoeirinha.nsg_id
}

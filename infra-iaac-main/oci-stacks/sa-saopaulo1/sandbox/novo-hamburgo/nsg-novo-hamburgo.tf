module "nsg-novo-hamburgo" {
  source         = "./new-nsg"
  compartment_id = var.BU-Corp-compartment_ocid
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-novo-hamburgo"
  nsg_rules = [
    {
      direction        = "EGRESS"
      protocol         = "all"        // ICMP ("1"), TCP ("6"), UDP ("17") all
      destination_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      destination      = "0.0.0.0/0"
      min_port         = null // These are not actually used in the EGRESS rule but need to be provided.
      max_port         = null
      description      = "default egress"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-versalhes
      min_port    = null
      max_port    = null
      description = "All Ports From Versalhes"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.4.1.20/32"
      min_port    = 22
      max_port    = 22
      description = "SSH from AWX"
    }
  ]
}

output "nsg_id_novo-hamburgo" {
  value = module.nsg-novo-hamburgo.nsg_id
}

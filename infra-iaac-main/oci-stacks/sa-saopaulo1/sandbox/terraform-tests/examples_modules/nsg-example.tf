/*

module "oci_nsg" {
  source         = "./modules/new-nsg"
  compartment_id = var.cs-compartment_ocid
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "cs-nsg-terraform-test"
  nsg_rules = [
    {
      id               = "rule1"
      direction        = "EGRESS"
      protocol         = "all"        // ICMP ("1"), TCP ("6"), UDP ("17") all
      destination_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      destination      = "0.0.0.0/0"
      min_port         = null // These are not actually used in the EGRESS rule but need to be provided.
      max_port         = null
    },
    {
      id               = "rule2"
      direction        = "INGRESS"
      protocol         = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type      = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source           = "0.0.0.0/0"
      min_port         = 80
      max_port         = 80
    },
    {
      id               = "rule3"
      direction        = "INGRESS"
      protocol         = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type      = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source           = "0.0.0.0/0"
      min_port         = 443
      max_port         = 448
    }
  ]
}




*/

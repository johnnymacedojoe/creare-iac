module "nsg-mt-docker-repo" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.BU-corp
  vnc_id         = var.vcn-oci-oke-iad1p
  nsg_name       = "nsg-mt-docker-repo"
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
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.1.1.121/32"
      min_port    = null
      max_port    = null
      description = "VPN acess"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.10.2.0/24"
      min_port    = 2048
      max_port    = 2050
      description = "NFS-sn-oci-oke-iad1p"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.10.2.0/24"
      min_port    = 111
      max_port    = 111
      description = "NFS-sn-oci-oke-iad1p"
    },
    {
      direction   = "INGRESS"
      protocol    = "17"         // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.10.2.0/24"
      min_port    = 2048
      max_port    = 2048
      description = "NFS-sn-oci-oke-iad1p"
    },
    {
      direction   = "INGRESS"
      protocol    = "17"         // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.10.2.0/24"
      min_port    = 111
      max_port    = 111
      description = "NFS-sn-oci-oke-iad1p"
    }
  ]
}
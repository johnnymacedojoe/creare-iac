module "nsg-hunderton" {
  source         = "./modules/new-nsg"
  compartment_id = var.BU-Corp-compartment_ocid
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-hunderton"
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
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-versalhes
      min_port    = 19187
      max_port    = 19187
      description = "Prometheus Pgsql Port Versalhes"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-versalhes
      min_port    = 19100
      max_port    = 19100
      description = "Prometheus Node Port Versalhes"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-versalhes
      min_port    = 15430
      max_port    = 15599
      description = "730"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-versalhes
      min_port    = 40016
      max_port    = 40016
      description = "737"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-malaga
      min_port    = 15475
      max_port    = 15475
      description = "743"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.4.1.20/32"
      min_port    = 19187
      max_port    = 19187
      description = "Prometheus Pgsql Port Versalhes"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.4.1.20/32"
      min_port    = 19100
      max_port    = 19100
      description = "Prometheus Pgsql Port Versalhes"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-cannes
      min_port    = 40016
      max_port    = 40016
      description = "737"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                        // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"   // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-hereford.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = null
      max_port    = null
      description = "Opening all ports from hereford instance"
    }
  ]
}

output "nsg_id_hunderton" {
  value = module.nsg-hunderton.nsg_id
}
